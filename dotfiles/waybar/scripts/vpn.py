import subprocess
import json

def get_mullvad_status():
    args = ["mullvad", "status", "--json"]
    vpn_info = subprocess.check_output(args).decode().strip()
    return json.loads(vpn_info)

def main():
    mullvad_status = get_mullvad_status()
    vpn_state = mullvad_status["state"]

    out = {}
    out["class"] = vpn_state
    tooltip_text = vpn_state.capitalize()
    if vpn_state == "connected":
        vpn_country = mullvad_status["details"]["location"]["country"]
        tooltip_text += f" | {vpn_country}"
    out["tooltip"] = tooltip_text

    print(json.dumps(out))

main()
