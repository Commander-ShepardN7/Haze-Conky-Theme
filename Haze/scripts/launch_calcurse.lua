-- CommanderShepardN7 - Script to launch a gnome-terminal window with Calcurse running. Requires, unsurprisingly, Calcurse (sudo apt install calcurse)
-- X and Y coordinates are NOT global, they are relative to the conky window drawn
-- If you're on another desktop environment, change line 23 to the name of the terminal of your DE.
--Change line 24 to an actual sound of your PCs sound profile - tested on Pop!_OS 22.04

function conky_mouse_handler(event)
    local button_map = {
        left = 1,
        right = 2,
        middle = 3,
        scroll_up = 4,
        scroll_down = 5
    }

    local button_value = button_map[event.button] or -1

    if event.type == "button_down" then
        print(string.format("Mouse button %d down at: %d, %d", button_value, event.x, event.y))

        if button_value == 1 then
            -- Play/Pause button
            if event.x >= 210 and event.x <= 400 and event.y >= 0 and event.y <= 150 then
                os.execute("gnome-terminal -- bash -c 'calcurse; exec bash' &")
--		os.execute("paplay /usr/share/sounds/Pop/stereo/notification/message-new-email.oga &")
            end
            
        end

        if event.mods then
            for k, v in pairs(event.mods) do
                if v then print("Modifier held:\t" .. k) end
            end
        end
    elseif event.type == "button_up" then
        print(string.format("Mouse button released at: %d, %d", event.x, event.y))
    elseif event.type == "mouse_move" then
        print(string.format("Mouse moved to: %d, %d (abs: %d, %d) at time %d",
            event.x, event.y, event.x_abs, event.y_abs, event.time))
    end
end

