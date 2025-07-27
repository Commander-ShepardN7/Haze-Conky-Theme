-- Script to control playerctl, launching Geary and Spotify (flatpak). Requires Geary, Playerctl and Flatpak Spotify.
-- Uncomment lines 40 & 46 and change paths to an actual sound if you want sounds

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
        print(string.format("Mouse button %d down at: %d, %d", button_value, event.x, event.y)) --debugging

        if button_value == 1 then
            -- Play/Pause
            if event.x >= 60 and event.x <= 80 and event.y >= 170 and event.y <= 190 then
                print("Toggling music playback!") --debug
                os.execute("playerctl play-pause &")
            end

            -- Previous Track 
            if event.x >= 25 and event.x <= 45 and event.y >= 170 and event.y <= 190 then
                print("Previous track!") --debugging
                os.execute("playerctl previous &")
            end

            -- Next Track 
            if event.x >= 95 and event.x <= 115 and event.y >= 170 and event.y <= 190 then
                print("Next track!") --debugging
                os.execute("playerctl next &")
            end
             -- Mail Client (geary)
            if event.x >= 25 and event.x <= 50 and event.y >= 377 and event.y <= 402 then
                print("Opening Geary!") --debug
                os.execute("geary &")
--		os.execute("paplay /usr/share/sounds/Pop/stereo/notification/message-new-email.oga &")
            end
             -- Spotify
            if event.x >= 25 and event.x <= 115 and event.y >= 70 and event.y <= 160 then
                print("Opening Spotify!") --debug
                os.execute("flatpak run com.spotify.Client &")
--                os.execute("paplay /usr/share/sounds/Pop/stereo/notification/message-new-email.oga &")
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
