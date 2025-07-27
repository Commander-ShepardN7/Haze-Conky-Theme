--[[
Ring Meters by londonali1010 (2009), modified with vertical bar graph and text functionality.

This script draws percentage meters as rings, vertical bars, or text. It is fully customizable.

To call this script in Conky, use the following:
	ua_load = os.getenv("HOME") .. '/.config/conky/Haze/scripts/bars.lua',
	lua_draw_hook_pre ring_stats
]]

settings_table = {
-- Network Download Bar
{
    type = 'bar',
    name = 'downspeedf',
    arg = 'esp01', -- Change to your interface
    max = 300000, -- Max speed in KB/s
    bg_colour = 0xFFFFFF,
    bg_alpha = 0.2,
    fg_colour = 0x00FF00,
    fg_alpha = 1,
    gradient_start = 0x00FF00,
    gradient_end = 0x008800,
    x = 30, y = 540,
    bar_width = 100,
    bar_height = 10,
},
{
    type = 'text',
    text = 'Down: ${downspeedf esp01} KB/s', -- Adjust if needed
    x = 140, y = 550,
    font = 'Offside',
    font_size = 12,
    fg_colour = 0xF6ECBE,
    fg_alpha = 1,
},

-- Network Upload Bar
{
    type = 'bar',
    name = 'upspeedf',
    arg = 'esp01', -- Change to your interface
    max = 300000, -- Max speed in KB/s
    bg_colour = 0xFFFFFF,
    bg_alpha = 0.2,
    fg_colour = 0xFF8800,
    fg_alpha = 1,
    gradient_start = 0xFF8800,
    gradient_end = 0xFF2200,
    x = 30, y = 570,
    bar_width = 100,
    bar_height = 10,
},
{
    type = 'text',
    text = 'Up: ${upspeedf esp01} KB/s',
    x = 140, y = 580,
    font = 'Offside',
    font_size = 12,
    fg_colour = 0xF6ECBE,
    fg_alpha = 1,
},
    -- Bars
    {
        type = 'bar',
        name = 'cpu',
        arg = 'cpu0',
        max = 100,
        bg_colour = 0xFFFFFF,
        bg_alpha = 0.2,
        fg_colour = 0x3062C4,
        fg_alpha = 1,
        gradient_start = 0x3062C4,
        gradient_end = 0x00FFFF,
        x = 30, y = 420, 
        bar_width = 100, 
        bar_height = 10, 
    },
        {
        type = 'bar', 
        name = 'memperc',
        arg = '/',
        max = 100,
        bg_colour = 0xFFFFFF,
        bg_alpha = 0.2,
        fg_colour = 0x3062C4,
        fg_alpha = 1,
        gradient_start = 0x3062C4,
        gradient_end = 0x00FFFF,
        x = 30, y = 450,
        bar_width = 100, 
        bar_height = 10, 
    },
       {
        type = 'bar', 
        name = 'fs_used_perc',
        arg = '/',
        max = 100,
        bg_colour = 0xFFFFFF,
        bg_alpha = 0.2,
        fg_colour = 0x3062C4,
        fg_alpha = 1,
        gradient_start = 0x3062C4,
        gradient_end = 0x00FFFF,
        x = 30, y = 480,
        bar_width = 100,
        bar_height = 10, 
    },
       {
        type = 'bar',
        name = 'fs_used_perc',
        arg = '/home,
        max = 100,
        bg_colour = 0xFFFFFF,
        bg_alpha = 0.2,
        fg_colour = 0x3062C4,
        fg_alpha = 1,
        gradient_start = 0x3062C4,
        gradient_end = 0x00FFFF,
        x = 30, y = 510,
        bar_width = 100,
        bar_height = 10,
    },
            {
        type = 'text', 
        text = 'CPU: ${cpu cpu0}% | ${hwmon 1 temp 1}°C', 
        x = 140, y = 430, 
        font = 'Offside', 
        font_size = 12, 
        fg_colour = 0xF6ECBE,
        fg_alpha = 1,
    },   
                {
        type = 'text', 
        text = "RAM: ${memperc}%", 
        x = 140, y = 460, 
        font = 'Offside', 
        font_size = 12, 
        fg_colour = 0xF6ECBE, 
        fg_alpha = 1, 
    },

    {
        type = 'text', 
        text = 'Root: ${fs_used_perc /}%', 
        x = 140, y = 490, 
        font = 'Offside', 
        font_size = 12, 
        fg_colour = 0xF6ECBE, 
        fg_alpha = 1, 
    },
        {
        type = 'text', 
        text = 'Home: ${fs_used_perc /home}%', 
        x = 140, y = 520, 
        font = 'Offside', 
        font_size = 12, 
        fg_colour = 0xF6ECBE, 
        fg_alpha = 1, 
    },
            {
        type = 'glow', 
        text = 'Home: ${fs_used_perc /home}%', 
        x = 140, y = 520, 
        font = 'Offside', 
        font_size = 12, 
        fg_colour = 0xF6ECBE, 
        fg_alpha = 1, 
    },
           
}

require 'cairo'

-- Convert RGB to RGBA
function rgb_to_r_g_b(colour, alpha)
    return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

-- Function to draw a ring meter
function draw_ring(cr, t, pt)
    local xc, yc, ring_r, ring_w, sa, ea = pt['x'], pt['y'], pt['radius'], pt['thickness'], pt['start_angle'], pt['end_angle']
    local bgc, bga, fgc, fga = pt['bg_colour'], pt['bg_alpha'], pt['fg_colour'], pt['fg_alpha']

    local angle_0 = sa * (2 * math.pi / 360) - math.pi / 2
    local angle_f = ea * (2 * math.pi / 360) - math.pi / 2
    local t_arc = t * (angle_f - angle_0)

    -- Draw background ring
    cairo_arc(cr, xc, yc, ring_r, angle_0, angle_f)
    cairo_set_source_rgba(cr, rgb_to_r_g_b(bgc, bga))
    cairo_set_line_width(cr, ring_w)
    cairo_stroke(cr)

    -- Draw indicator ring
    cairo_arc(cr, xc, yc, ring_r, angle_0, angle_0 + t_arc)
    cairo_set_source_rgba(cr, rgb_to_r_g_b(fgc, fga))
    cairo_stroke(cr)
end

-- Function to display text
function draw_text(cr, pt, text)
    local x, y = pt['x'], pt['y']
    local font = pt['font'] or "Sans"
    local font_size = pt['font_size'] or 12
    local fg_colour = pt['fg_colour']
    local fg_alpha = pt['fg_alpha']
    

    -- Set font and size
    cairo_select_font_face(cr, font, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL)
    cairo_set_font_size(cr, font_size)

  -- Set the color for the text explicitly
    cairo_set_source_rgba(cr, rgb_to_r_g_b(fg_colour, fg_alpha))
    
    -- Save the current transformation matrix
    cairo_save(cr)

    -- Move to position and rotate the text
    cairo_translate(cr, x, y)  -- Translate to the text position

    -- Draw the text at the new position
    cairo_move_to(cr, 0, 0)  -- After rotation, the origin will be at (0, 0)
    cairo_show_text(cr, text)

    -- Restore the original transformation matrix
    cairo_restore(cr)

    -- Stroke the text to apply the changes
    cairo_stroke(cr)
end

-- function to draw a rounded rectangle path
function rounded_rectangle(cr, x, y, width, height, radius)
    local r = radius
    if r > width / 2 then r = width / 2 end
    if r > height / 2 then r = height / 2 end

    cairo_new_sub_path(cr)
    -- Top-right corner
    cairo_arc(cr, x + width - r, y + r, r, -math.pi/2, 0)
    -- Bottom-right corner
    cairo_arc(cr, x + width - r, y + height - r, r, 0, math.pi/2)
    -- Bottom-left corner
    cairo_arc(cr, x + r, y + height - r, r, math.pi/2, math.pi)
    -- Top-left corner
    cairo_arc(cr, x + r, y + r, r, math.pi, 3*math.pi/2)
    cairo_close_path(cr)
end

-- Modified draw_bar function with rounded edges
function draw_bar(cr, t, pt)
    local x, y = pt['x'], pt['y']
    local bar_w, bar_h = pt['bar_width'], pt['bar_height']
    local bgc, bga = pt['bg_colour'], pt['bg_alpha']
    local fgc = pt['fg_colour'] or 0x3062C4
    local fga = pt['fg_alpha'] or 1
    local gradient_start = pt['gradient_start'] or fgc
    local gradient_end = pt['gradient_end'] or fgc
    local radius = pt['radius'] or (bar_h / 2)

    local filled_w = bar_w * t

    -- Draw background bar
    cairo_set_source_rgba(cr, rgb_to_r_g_b(bgc, bga))
    rounded_rectangle(cr, x, y, bar_w, bar_h, radius)
    cairo_fill(cr)

    -- Clip to bar shape, then draw glow (behind the fill)
    cairo_save(cr)
    rounded_rectangle(cr, x, y, bar_w, bar_h, radius)
    cairo_clip(cr)

    if filled_w > 0 then
        draw_glow(cr, x, y, filled_w, bar_h, radius, fgc, fga, 3.5, 1.1)
    end

    cairo_restore(cr) -- End glow clip

    -- Draw gradient fill bar
    if filled_w > 0 then
        cairo_save(cr)
        cairo_rectangle(cr, x, y, filled_w, bar_h)
        cairo_clip(cr)

        local pat = cairo_pattern_create_linear(x, y, x + bar_w, y)
        local r1, g1, b1 = rgb_to_r_g_b(gradient_start, fga)
        local r2, g2, b2 = rgb_to_r_g_b(gradient_end, fga)
        cairo_pattern_add_color_stop_rgba(pat, 0, r1, g1, b1, fga)
        cairo_pattern_add_color_stop_rgba(pat, 1, r2, g2, b2, fga)
        cairo_set_source(cr, pat)

        rounded_rectangle(cr, x, y, bar_w, bar_h, radius)
        cairo_fill(cr)
        cairo_pattern_destroy(pat)

        cairo_restore(cr)
    end
end

-- Glowing bar function BROKEN
function draw_glow(cr, x, y, w, h, radius, color, alpha, glow_size, intensity)
    local r, g, b = rgb_to_r_g_b(color, 1)
    for i = 1, intensity do
        local glow_alpha = alpha * (1 - i / (intensity + 1))
        cairo_set_source_rgba(cr, r, g, b, glow_alpha)
        local grow = i * (glow_size / intensity)
        rounded_rectangle(cr, x - grow / 2, y - grow / 2, w + grow, h + grow, radius + grow / 2)
        cairo_fill(cr)
    end
end

-- Main function to draw rings, bars, or text
function conky_ring_stats()
    local function setup_rings_bars(cr, pt)
        local str = ''
        local value = 0
        
        if pt['type'] == 'ring' or pt['type'] == 'bar' then
            str = string.format('${%s %s}', pt['name'], pt['arg'])
            str = conky_parse(str)
            value = tonumber(str)
            if value == nil then value = 0 end
            local pct = value / pt['max']

            if pt['type'] == 'ring' then
                draw_ring(cr, pct, pt)
            elseif pt['type'] == 'bar' then
                draw_bar(cr, pct, pt)
            end
        elseif pt['type'] == 'text' then
            str = conky_parse(pt['text'])
            draw_text(cr, pt, str)
        end
    end

    if conky_window == nil then return end
    local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
    local cr = cairo_create(cs)

    local updates = conky_parse('${updates}')
    update_num = tonumber(updates)

    if update_num > 5 then
        for i in pairs(settings_table) do
            setup_rings_bars(cr, settings_table[i])
        end
    end


    cairo_surface_destroy(cs)
    cairo_destroy(cr)
end

