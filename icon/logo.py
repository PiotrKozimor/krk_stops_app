from cairosvg import svg2png

# Indigo theme color
sizes = {
    48: "mdpi",
    72: "hdpi",
    96: "xhdpi",
    144:  "xxhdpi",
    192:  "xxxhdpi",
}
for size, name in sizes.items():
    svg2png(url='bus-clock.svg', write_to=f'/home/piotr/repos/krk_stops_app/android/app/src/main/res/mipmap-{name}/ic_launcher.png', output_height=size, output_width=size)
svg2png(url='bus-clock.svg', write_to=f'logo.png', output_height=512, output_width=512)