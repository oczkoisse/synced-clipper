local mp = require "mp"

starts, ends = {}, {}
state = nil

function display_start()
    local time_pos = mp.get_property_number("time-pos")
    if state == nil or state == ']' then
        table.insert(starts, time_pos)
        mp.osd_message(string.format('Begin %f', time_pos))
        state = '['
    elseif state == '[' then
        table.remove(starts)
        table.insert(starts, time_pos)
        mp.osd_message(string.format('Reset begin %f', time_pos))
    end
end

function display_end()
    local time_pos = mp.get_property_number("time-pos")
    if state == '[' then
        table.insert(ends, time_pos)
        mp.osd_message(string.format('End %f', time_pos))
        state = ']'
    elseif state == ']' then
        table.remove(ends)
        table.insert(ends, time_pos)
        mp.osd_message(string.format('Reset end %f', time_pos))
    end
end

function write_marks()
    local file = io.open('marks.txt', 'w')
    for i=1,math.min(#starts, #ends),1 do
        file:write(string.format('%f,%f\n', starts[i], ends[i]))
    end
    file:close()
end

mp.add_key_binding("[", "display_start", display_start)
mp.add_key_binding("]", "display_end", display_end)

mp.register_event("shutdown", write_marks)
