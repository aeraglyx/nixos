import bpy
from bpy.app.handlers import persistent

import os
import io
import shutil
import zipfile
import requests


def get_font_path():
    fonts_to_try = [
        "CaskaydiaCoveNerdFont-Regular.ttf",
        "CaskaydiaMonoNerdFont-Regular.ttf",
        "CaskaydiaCove-Regular.ttf",
        "CaskaydiaMono-Regular.ttf",
        "CascadiaCode-Regular.ttf",
        "CascadiaMono-Regular.ttf",
    ]

    fonts_base_dir = None
    if os.name == "posix":
        fonts_base_dir = "/run/current-system/sw/share/X11/fonts"
    if os.name == "nt":
        fonts_base_dir = os.path.expandvars("%WINDIR%\\Fonts")

    assert fonts_base_dir is not None

    for font in fonts_to_try:
        font_path = os.path.join(fonts_base_dir, font)
        if os.path.isfile(font_path):
            print(f"Startup: Font found - {font}")
            return font_path

    print("Startup: Font not found :(")


def setup_preferences():
    prefs = bpy.context.preferences
    prefs.use_preferences_save = False

    prefs.view.show_tooltips_python = True
    prefs.view.show_navigate_ui = False
    prefs.view.show_developer_ui = True
    prefs.view.show_statusbar_memory = True
    prefs.view.show_statusbar_vram = True
    prefs.view.ui_scale = 1.1
    prefs.view.menu_close_leave = True
    prefs.view.use_weight_color_range = True

    font_path = get_font_path()
    if font_path:
        prefs.view.font_path_ui = font_path
        prefs.view.font_path_ui_mono = font_path

    prefs.edit.node_use_insert_offset = False
    prefs.edit.undo_steps = 64
    prefs.edit.grease_pencil_default_color = [0.588, 0.776, 0.867, 0.900]

    prefs.filepaths.save_version = 0
    prefs.filepaths.recent_files = 128

    prefs.addons['cycles'].preferences.compute_device_type = 'OPTIX'

    prefs.inputs.use_zoom_to_mouse = True


def setup_render(render):
    # TODO: what about new scenes
    render.engine = 'CYCLES'
    render.use_motion_blur = True
    render.film_transparent = True
    render.fps = 25
    render.use_persistent_data = True


def setup_cycles(cycles):
    cycles.use_preview_adaptive_sampling = False
    cycles.use_adaptive_sampling = False
    cycles.device = 'GPU'
    cycles.samples = 256
    cycles.preview_samples = 256
    cycles.sample_clamp_indirect = 0.0
    cycles.use_preview_denoising = True
    cycles.film_transparent_glass = True


def setup_view(view_settings):
    view_settings.look = 'AgX - Medium High Contrast'


def setup_scene(scene):
    setup_render(scene.render)
    setup_cycles(scene.cycles)
    setup_view(scene.view_settings)
    scene.tool_settings.use_snap_node = True


def setup_camera():
    cam_obj = bpy.data.objects["Camera"]
    cam_obj.rotation_euler = [1.570796, 0.0, 0.0]
    cam_obj.location = [0.0, -10.0, 0.0]

    cam_data = cam_obj.data
    cam_data.dof.aperture_fstop = 2.8
    cam_data.passepartout_alpha = 0.9


def setup_theme():
    blender_scripts_dir = bpy.utils.user_resource('SCRIPTS')
    blender_ext_dir = bpy.utils.user_resource('EXTENSIONS')

    onyx_path_local = os.path.join(blender_scripts_dir, "presets", "interface_theme", "onyx.xml")
    onyx_path_ext = os.path.join(blender_ext_dir, "blender_org", "onyx", "onyx.xml")

    def set_theme_path(filepath):
        bpy.ops.script.execute_preset(filepath=filepath, menu_idname="USERPREF_MT_interface_theme_presets")

    def download_onyx():
        try:
            bpy.context.preferences.system.use_online_access = True
            bpy.ops.extensions.repo_sync_all(use_active_only=True)
            bpy.ops.extensions.package_install(repo_index=0, pkg_id="onyx")
        except:
            print("Startup: Couldn't download onyx")

    if os.path.isfile(onyx_path_local):
        set_theme_path(onyx_path_local)
    elif os.path.isfile(onyx_path_ext):
        set_theme_path(onyx_path_ext)
    else:
        download_onyx()


def setup_keymaps():
    kc = bpy.context.window_manager.keyconfigs.default

    kc_prefs = kc.preferences
    kc_prefs.use_file_single_click = True
    kc_prefs.use_use_region_toggle_pie = True

    kmi = kc.keymaps['Node Editor'].keymap_items
    if "node.options_toggle" not in kmi:
        kmi.new(idname="node.options_toggle", type='H', value='PRESS', alt=True)


def get_ext_from_gh(repo, branch="main"):
    archive_link = f"https://github.com/{repo}/archive/refs/heads/{branch}.zip"
    extension_name = repo.split("/")[-1]
    extensions_path = bpy.utils.user_resource('EXTENSIONS')
    extension_path = os.path.join(extensions_path, "user_default", extension_name)

    if not os.path.isdir(extension_path):
        os.makedirs(extension_path, exist_ok=True)
        nested_path = os.path.join(extension_path, f"{extension_name}-{branch}")
        shutil.rmtree(extension_path, ignore_errors=True)

        r = requests.get(archive_link)
        z = zipfile.ZipFile(io.BytesIO(r.content))
        z.extractall(extension_path)

        for filename in os.listdir(nested_path):
            src = os.path.join(nested_path, filename)
            dst = os.path.join(extension_path, filename)
            shutil.move(src, dst)

        os.rmdir(nested_path)

    bpy.ops.preferences.addon_enable(module=f"bl_ext.user_default.{extension_name}")


def setup_extensions():
    bpy.ops.preferences.addon_enable(module="node_wrangler")
    get_ext_from_gh(repo="aeraglyx/fulcrum", branch="master")
    get_ext_from_gh(repo="aeraglyx/blueshift")


@persistent
def load_handler_preferences(_):
    setup_preferences()
    setup_theme()
    setup_keymaps()
    setup_extensions()


@persistent
def load_handler_startup(_):
    setup_scene(bpy.context.scene)
    setup_camera()
    bpy.data.worlds["World"].node_tree.nodes["Background"].inputs[0].default_value = [0, 0, 0, 1]
    bpy.data.objects.remove(bpy.data.objects["Light"])
    bpy.data.screens["Layout"].areas[3].spaces[0].overlay.show_face_orientation = True

    ws_to_keep = ("Layout", "Compositing", "Scripting")
    for ws in bpy.data.workspaces:
        if ws.name not in ws_to_keep:
            bpy.data.batch_remove(ids=(ws,))

    bpy.ops.outliner.orphans_purge()


def register():
    bpy.app.handlers.load_factory_preferences_post.append(load_handler_preferences)
    bpy.app.handlers.load_factory_startup_post.append(load_handler_startup)


def unregister():
    bpy.app.handlers.load_factory_preferences_post.remove(load_handler_preferences)
    bpy.app.handlers.load_factory_startup_post.remove(load_handler_startup)
