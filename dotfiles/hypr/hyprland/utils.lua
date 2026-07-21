M = {}

function M.accel_profile(sensitivity)
    local expo = 0.5
    local limit = 3.0
    local num_segments = 8

    local interval = limit / num_segments

    local points = {}
    for i = 0, num_segments do
        local x = i * interval
        local y = (math.exp(expo * x) - 1) / expo
        table.insert(points, y)
    end

    local sensitivity_inv = string.format("%.3f ", interval / sensitivity)
    local points_str = table.concat(points, " ")
    return "custom " .. sensitivity_inv .. points_str
end

return M
