God.load "/etc/god/conf.d/*.god"

God.contact(:campfire) do |c|
    c.name = "campfire-room"
    c.subdomain = "your-subdomain"
    c.token = "your-api-token"
    c.room = "The Room"
end
