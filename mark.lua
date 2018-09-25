local mp = require "mp"

starts, ends = {}, {}
state = nil
osd_duration = 500

function display_start()
    local time_pos = mp.get_property_number("time-pos")
    if state == nil or state == ']' then
        table.insert(starts, time_pos)
        mp.osd_message(string.format('%.2f -', time_pos), osd_duration)
        state = '['
    elseif state == '[' then
        table.remove(starts)
        table.insert(starts, time_pos)
        mp.osd_message(string.format('%.2f -', time_pos), osd_duration)
    end
end

function display_end()
    local time_pos = mp.get_property_number("time-pos")
    if state == '[' then
        table.insert(ends, time_pos)
        mp.osd_message(string.format('%.2f - %.2f', starts[#starts], time_pos), osd_duration)
        state = ']'
    elseif state == ']' then
        table.remove(ends)
        table.insert(ends, time_pos)
        mp.osd_message(string.format('%.2f - %.2f', starts[#starts], time_pos), osd_duration)
    end
end

function write_marks()
    if math.min(#starts, #ends) > 0 then
        local file = io.open('endpoints.txt', 'w')
        for i=1,math.min(#starts, #ends),1 do
            file:write(string.format('%f,%f\n', starts[i], ends[i]))
        end
        file:close()
    end
end

function forget_last()
    if state == '[' then
        table.remove(starts)
    elseif state == ']' then
        table.remove(starts)
        table.remove(ends)
    end
    if #starts == 0 then
        state = nil
        mp.osd_message('Reset')
    else
        state = ']'
        mp.osd_message(string.format('%.2f - %.2f', starts[#starts], ends[#ends]), osd_duration)
    end
end

mp.add_key_binding(";", "display_start", display_start)
mp.add_key_binding("'", "display_end", display_end)
mp.add_key_binding(":", "forget_last", forget_last)

mp.register_event("shutdown", write_marks)
