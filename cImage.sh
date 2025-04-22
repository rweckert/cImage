#!/bin/bash
# cImage.sh Created: 11/22/2024 Updated: 04/21/2025
# Robert W. Eckert - rweckert@gmail.com
#        .___                               
#   ____ |   | _____ _____     ____   ____  
# _/ ___\|   |/     \\__  \   / ___\_/ __ \ 
# \  \___|   |  Y Y  \/ __ \_/ /_/  >  ___/ 
#  \___  >___|__|_|  (____  /\___  / \___  >
#      \/          \/     \//_____/      \/ v:1.2
# A small image to color value listing utiliy.

fcall="export -f"
bcall="bash -c"
afp=$(dirname "$(realpath "$0")")
export app="$afp/cImage.sh"
export td="/tmp"
export tf="$td/cImage.txt"
export ti="$td/cImage.ini"
export tt="$td/cImage.tmp"
export ts="$td/cImage.fle"
export th="$td/cImage.html"
export t1="$td/cImage1.tmp"
export t2="$td/cImage2.tmp"

# Main Menu: ===========================
function mMenu {
if [ ! -f "$tf" ]; then
echo "" > "$tf"
else
read sf < "$tf"
fi
vi='@sh -c "echo %1 > $tf & $app iView"'
pi='@sh -c "echo %1 > $tf & $app mProcess"'
is='@sh -c "echo %1 > $tf & $app iStat"'
yad --form --css="$tp" --posx=20 --posy=20 --fixed --title="cImage-Menu" --name="mMenu" --window-icon="text-x-script" --f1-action="$app mHelp" --no-buttons --columns=8 \
--field="Image:FL" "$sf" \
--field="View":fbtn "$vi" \
--field="Extract":fbtn "$pi" \
--field="Results":fbtn "$bcall vResult" \
--field "Palette":fbtn "$bcall vPalette" \
--field="Stats":fbtn "$is" \
--field="Options":fbtn "$bcall mTheme" \
--field="Exit":fbtn "$bcall mExit" 2> /dev/null
}
$fcall mMenu

# Image View: ==========================
function iView {
read si < "$tf"
if [ -z "$si" ]; then
yad --text="No Image has been selected. Please open a image to then view." --css="$tp" --center --fixed --on-top --title="Error" --text-align=left --window-icon="dialog-error" --button="OK":0
return 1
fi
ydo=$(yad --picture --css="$tp" --width=700 --height=500 --center --title="cImage-View" --name="iView" --window-icon="text-x-script" --size=fit --filename="$si" --button="Open New Image":2 --button="Close":1)
ydo=$?
if [ $ydo -eq 2 ]; then fOpen; fi
}
$fcall iView

# Process Menu: ========================
function mProcess {
read si < "$tf"
if [ -z "$si" ]; then
yad --text="No Image has been selected. Please open a image to then view." --css="$tp" --center --fixed --on-top --title="Error" --text-align=left --window-icon="dialog-error" --button="OK":0
return 1
fi
ec='@sh -c "echo %1,%2 > $tt & $app iProcess"'
cn=$(echo "10,20,30,40,50,60,70,80,90,100,150,200,250,300")
cf=$(echo "All Colors,Light Colors,Dark Colors")
yad --form --css="$tp" --posx=20 --posy=115 --fixed --title="cImage-Process" --name="mProcess" --window-icon="text-x-script" --f1-action="$app mHelp" --separator="," --item-separator="," --no-buttons --columns=2 \
--field="Number of Colors:CBE" "$cn" \
--field="Color Frequncy:CBE" "$cf" \
--field "Extract Colors":fbtn "$ec" \
--field="Close":fbtn "wmctrl -c 'cImage-Process'" 2> /dev/null
}
$fcall mProcess

# Image Process: =======================
function iProcess {
read si < "$tf"
nc=$(cat $tt | awk 'BEGIN {FS="," } { print $1 }')
cf=$(cat $tt | awk 'BEGIN {FS="," } { print $2 }')
convert "$si" -colorspace RGB -format "%c" histogram:info:- | sort -nr | uniq -u | awk '{print $3}' | head -n "$nc" > "$tt"

if [ "$cf" == "All Colors" ]; then pAllColors; fi
if [ "$cf" == "Light Colors" ]; then pLightColors; fi
if [ "$cf" == "Dark Colors" ]; then pDarkColors; fi
}
$fcall iProcess

# Process All Colors: ======================
function pAllColors {
echo -n "" > "$t1"
while read -r line; do
ghx="${line}"
hx=$(echo "$ghx" | sed 's/#//g')
ha=$(echo $hx | cut -c-2)
hb=$(echo $hx | cut -c3-4)
hc=$(echo $hx | cut -c5-6)
rc=$(echo "ibase=16; $ha" | bc)
gc=$(echo "ibase=16; $hb" | bc)
bc=$(echo "ibase=16; $hc" | bc)
lm=$(( ($rc*299 + $gc*587 + $bc*114) / 1000 ))
rgb="$rc $gc $bc"
if (( "$lm" > 128 )); then
fc="#000000"
else
fc="#ffffff"
fi
echo -e "#$hx,$fc,#$hx,$rgb" >> "$t1"
done < "$tt"
vResult
}
$fcall pAllColors

# Process Light Colors: ======================
function pLightColors {
echo -n "" > "$t1"
while read -r line; do
ghx="${line}"
hx=$(echo "$ghx" | sed 's/#//g')
ha=$(echo $hx | cut -c-2)
hb=$(echo $hx | cut -c3-4)
hc=$(echo $hx | cut -c5-6)
rc=$(echo "ibase=16; $ha" | bc)
gc=$(echo "ibase=16; $hb" | bc)
bc=$(echo "ibase=16; $hc" | bc)
lm=$(( ($rc*299 + $gc*587 + $bc*114) / 1000 ))
rgb="$rc $gc $bc"
if (( "$lm" > 128 )); then
fc="#000000"
echo -e "#$hx,$fc,#$hx,$rgb" >> "$t1"
fi
done < "$tt"
vResult
}
$fcall pLightColors

# Process Light Colors: ======================
function pDarkColors {
echo -n "" > "$t1"
while read -r line; do
ghx="${line}"
hx=$(echo "$ghx" | sed 's/#//g')
ha=$(echo $hx | cut -c-2)
hb=$(echo $hx | cut -c3-4)
hc=$(echo $hx | cut -c5-6)
rc=$(echo "ibase=16; $ha" | bc)
gc=$(echo "ibase=16; $hb" | bc)
bc=$(echo "ibase=16; $hc" | bc)
lm=$(( ($rc*299 + $gc*587 + $bc*114) / 1000 ))
rgb="$rc $gc $bc"
if (( "$lm" < 128 )); then
fc="#ffffff"
echo -e "#$hx,$fc,#$hx,$rgb" >> "$t1"
fi
done < "$tt"
vResult
}
$fcall pDarkColors

# View Result: =========================
function vResult {
if [ ! -f "$t1" ]; then
yad --text="Please first select a image and extract colors to then see results." --css="$tp" --title="Saved" --center --text-align=left --fixed --on-top --window-icon="text-x-script" --button="OK":0
return 1
fi
wmctrl -c 'cImage-Process'
sed -i 's/,/\n/g' "$t1"
cp='@sh -c "echo %s > $tf & $app sPalette"'
ydo=$(yad --list --css="$tp" --posx=50 --posy=160 --width=500 --height=430 --title="cImage-Result" --name="vResult" --window-icon="text-x-script" --dclick-action="$cp" --button="Export As Text":3 --button="Export As HTML":4 --button="Close":1 --column=@back@ --column=@fore@ --column="Hexidecimal" --column="Red Green Blue" < $t1)
ydo=$?
if [[ $ydo -eq 1 ]]; then wmctrl -c 'cImage-Result'; fi
if [[ $ydo -eq 3 ]]; then expText; fi
if [[ $ydo -eq 4 ]]; then expHTML; fi
}
$fcall vResult

# View Palette: ========================
function vPalette {
if [ ! -e "/tmp/cImagePalette.txt" ]; then
yad --text="There are no saved colors in the palette to view." --css="$tp" --title="Info" --window-icon="dialog-info" --center --text-align=left --fixed --on-top --button="OK":0
fi
ydo=$(yad --list --css="$tp" --posx=340 --posy=115 --width=500 --height=430 --title="cImage-Palette" --name="vPalette" --window-icon="text-x-script" --button="Refresh":5 --button="Export As HTML":4 --button="Export As Text":3 --button="Clear Palette":2 --column=@back@ --column=@fore@ --column="Hexidecimal" --column="Red Green Blue" < /tmp/cImagePalette.txt)
ydo=$?
if [[ $ydo -eq 2 ]]; then
cPalette
fi
if [[ $ydo -eq 3 ]]; then
cp /tmp/cImagePalette.txt "$t1"
expText
fi
if [[ $ydo -eq 4 ]]; then
cp /tmp/cImagePalette.txt "$t1"
expHTML
fi
if [[ $ydo -eq 5 ]]; then
wmctrl -c 'cImage-Palette'
vPalette
fi
}
$fcall vPalette

# Save Palette: ========================
function sPalette {
read gcv < "$tf"
bgc=$(echo $gcv | awk 'BEGIN {FS=" " } { print $1 }')
fgc=$(echo $gcv | awk 'BEGIN {FS=" " } { print $2 }')
hxv=$(echo $gcv | awk 'BEGIN {FS=" " } { print $3 }')
cvr=$(echo $gcv | awk 'BEGIN {FS=" " } { print $4 }')
cvg=$(echo $gcv | awk 'BEGIN {FS=" " } { print $5 }')
cvb=$(echo $gcv | awk 'BEGIN {FS=" " } { print $6 }')
rgb="$cvr,$cvg,$cvb"
echo -e "$bgc\n$fgc\n$hxv\n$rgb" >> "/tmp/cImagePalette.txt"
yad --text="Color $hxv $rgb has been saved to the color palette." --css="$tp" --title="Info" --window-icon="dialog-info" --center --text-align=left --fixed --on-top --button="OK":0
}
$fcall sPalette

# Clear Palette: =======================
function cPalette {
echo -n "" >/tmp/cImagePalette.txt
yad --text="Color palette has been cleared." --css="$tp" --title="Info" --window-icon="dialog-info" --center --text-align=left --fixed --on-top --button="OK":0
vPalette
}
$fcall cPalette

# Export Text: =========================
function expText {
echo "Hex     R  G  B" > /tmp/cImage-Export.txt
echo "------------------" >> /tmp/cImage-Export.txt
sed '$!N;$!N;$!N;s/\n/ /g' "$t1" | cut -d ' ' -f 3,4,5,6 >> "/tmp/cImage-Export.txt"
xdg-open "/tmp/cImage-Export.txt"
vResult
}
$fcall expText

# Export HTML: =========================
function expHTML {
sed '$!N;$!N;$!N;s/\n/ /g' "$t1" | cut -d ' ' -f 1,3,4,5,6 > "$t2"
echo "<html><body><table cellpadding='3' cellspacing='0' style='width:30%;margin-left:6px;border: 0px solid #ffffff;'><th>Color</th><th>Hexidecimal</th><th>Red</th><th>Green</th><th>Blue</th>" > "$th"
while read -r line; do
hcv=$(echo ${line} | awk 'BEGIN {FS=" " } { print $2 }')
rcv=$(echo ${line} | awk 'BEGIN {FS=" " } { print $3 }')
gcv=$(echo ${line} | awk 'BEGIN {FS=" " } { print $4 }')
bcv=$(echo ${line} | awk 'BEGIN {FS=" " } { print $5 }')
echo "<tr><td style='width:80px;'><div style='width:80px;height:19px;background-color:$hcv'></div></td><td>" >> "$th"
echo "$hcv</td><td>" >> "$th"
echo "$rcv</td><td>" >> "$th"
echo "$gcv</td><td>" >> "$th"
echo "$bcv</td></tr>" >> "$th"
done < "$t2"
echo "</tbody></table></div>" >> "$th"
ydo=$(yad --html --browser --css="$tp" --width=700 --height=500 --center --title="cImage-Export" --name="expHTML" --window-icon="text-html" --uri=""$th"" --button="Save As":4 --button="Close":1 --file-op)
ydo=$?
if [[ $ydo -eq 4 ]]; then fSave; fi
if [[ $ydo -eq 1 ]]; then wmctrl -c 'cImage-Export'; fi
vResult
}
$fcall expHTML

# Image Stats: ========================
function iStat {
read si < "$tf"
identify -verbose "$si" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' > /tmp/ciStats.txt
fsize=$(grep "Filesize" /tmp/ciStats.txt | awk 'BEGIN {FS=":" } { print $2 }')
npixels=$(grep "Number pixels" /tmp/ciStats.txt | awk 'BEGIN {FS=":" } { print $2 }')
iformat=$(grep "Format" /tmp/ciStats.txt | awk 'BEGIN {FS=":" } { print $2 }')
iquality=$(grep "Quality" /tmp/ciStats.txt | awk 'BEGIN {FS=":" } { print $2 }')
igeo=$(grep "Geometry" /tmp/ciStats.txt | awk 'BEGIN {FS=":" } { print $2 }')
idepth=$(grep "Depth" /tmp/ciStats.txt | awk 'BEGIN {FS=":" } { print $2 }')
ncolors=$(identify -format "%k" "$si")
ydo=$(yad --form --css="$tp" --posx=20 --posy=115 --width=300 --fixed --title="cImage-Stats" --name="iStat" --window-icon="text-x-script" --f1-action="$app mHelp" --button="All Stats":2 --button="Close":1 --columns=1 \
--field="File Name" "$si" \
--field="File Size" "$fsize" \
--field="Format" "$iformat" \
--field="Pixel Number" "$npixels" \
--field="Color Number" "$ncolors" \
--field="Quality" "$iquality" \
--field="Width Height" "$igeo" \
--field="Color Depth" "$idepth" 2> /dev/null)
ydo=$?
if [ $ydo -eq 1 ]; then wmctrl -c 'cImage-Stats'; fi
if [ $ydo -eq 2 ]; then aStat; fi
}
$fcall iStat

# Image All Stats: =====================
function aStat {
read si < "$tf"
identify -verbose "$si" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' > /tmp/ciStats.txt
ydo=$(yad --text-info="" --css="$tp" --width=600 --height=400 --center --title="cImage-All-Stats" --name="aStat" --window-icon="text-x-script" --f1-action="$app mHelp" --button="Save As":3 --button="Edit Stats":2 --button="Close":1 < /tmp/ciStats.txt)
ydo=$?
if [ $ydo -eq 1 ]; then wmctrl -c 'cImage-All-Stats'; fi
if [ $ydo -eq 2 ]; then xdg-open /tmp/ciStats.txt; aStat; fi
if [ $ydo -eq 3 ]; then fSave; aStat; fi
}
$fcall aStat

# File Open: ===========================
function fOpen {
ydo=$(yad --file --save --css="$tp" --width=400 --height=300 --center --title="cImage Save File:" --name="fSave" --window-icon="document-save" --on-top > $tf)
ydo=$?
if [[ $ydo -eq 252 ]]; then iView; fi
if [[ $ydo -eq 1 ]]; then iView; fi
if [[ $ydo -eq 0 ]]; then
wmctrl -c 'cImage-Menu'
iView & mMenu
fi
}
$fcall fOpen

# File Save: ===========================
function fSave {
ydo=$(yad --file --save --css="$tp" --width=400 --height=300 --center --title="cImage Save File:" --name="fSave" --window-icon="document-save" --on-top > $ts)
ydo=$?
if [[ $ydo -eq 252 ]]; then aStat; fi
if [[ $ydo -eq 1 ]]; then aStat; fi
if [[ $ydo -eq 0 ]]; then
cp "/tmp/ciStats.txt" "$ts"
aStat
fi
}
$fcall fSave

# Menu Theme: ==========================
function mTheme {
gut='@sh -c "echo %2 > $tf & $app tUser"'
gst='@sh -c "echo %5 > $tf & $app tSystem"'
ydo=$(yad --form --css="$tp" --posx=40 --posy=135 --width=300 --fixed --title="cImage-Theme" --name="mTheme" --window-icon="text-x-script" --f1-action="$app mHelp" --button="Help":3 --button="About":2 --button="Close":1 \
--field="Custom Theme"::LBL "" \
--field="Load Theme:FL" "/usr/share/themes/" \
--field="Apply Custom Theme":fbtn "$gut" \
--field="System Default"::LBL "" \
--field="Mode:CB" "Light Theme\!Dark Theme" \
--field="Apply System Theme":fbtn "$gst" \
--field="Browse Themes Folder":fbtn "$app tBrowse" 2> /dev/null)
ydo=$?
if [[ $ydo -eq 1 ]]; then wmctrl -c 'cImage-Theme'; fi
if [[ $ydo -eq 2 ]]; then mAbout; fi
if [[ $ydo -eq 3 ]]; then mHelp; fi
}
$fcall mTheme

# User Selected Theme: =================
function tUser {
read gut < "$tf"
sed -i '/stheme:/d' $ti
echo "stheme:$gut" >> "$ti"
tApply
}
$fcall tUser

# System Theme: ========================
function tSystem {
read gst < "$tf"
if [ "$gst" = "Dark Theme" ]; then
sed -i '/stheme:/d' "$ti"
echo "stheme:/usr/share/themes/Breeze-Dark/gtk-4.0/gtk.css" >> "$ti"
fi
if [ "$gst" = "Light Theme" ]; then
sed -i '/stheme:/d' "$ti"
echo "stheme:/usr/share/themes/Breeze/gtk-4.0/gtk.css" >> "$ti"
fi
tApply
}
$fcall tSystem

# Apply Theme: =========================
function tApply {
stheme=$(grep "stheme" $ti | awk 'BEGIN {FS=":" } { print $2 }')
export tp="$stheme"
wmctrl -c 'cImage-Menu'
wmctrl -c 'cImage-Theme'
mMenu
}
$fcall tApply

# Browse Theme: ========================
function tBrowse {
xdg-open "/usr/share/themes/"
}
$fcall tBrowse

# Main Help: ===========================
function mHelp {
yad --html --browser --css="$tp" --width=900 --height=500 --posx=20 --posy=115 --title="yColor-Documentation" --name="mHelp" --window-icon="text-html" --uri="/home/rweckert/WinXBin/Source/cImage/readme-cImage.txt" --file-op
}
$fcall mHelp

# About ================================
function mAbout {
yad --about --css="$tp" \
--window-icon="text-x-script" \
--image="text-x-script" \
--authors="Robert W Eckert - rweckert@gmail.com" \
--license="GPL3" \
--comments="A small image to color value listing utiliy." \
--copyright="Updated 04/21/2025 by Robert W Eckert" \
--pversion="Version: 1.2" \
--pname="cImage" \
--button="Close!gtk-close":1
}
$fcall mAbout

# Load Menu: ===========================
function mLoad {
if test -f "$ti"; then
stheme=$(grep "stheme" $ti | awk 'BEGIN {FS=":" } { print $2 }')
export tp="$stheme"
mMenu
else
export tp=""
mMenu
fi
}
$fcall mLoad

# Exit and Cleanup =====================
function mExit {
wmctrl -c 'cImage-Menu'
wmctrl -c 'cImage-View'
wmctrl -c 'cImage-Process'
wmctrl -c 'cImage-Result'
wmctrl -c 'cImage-Export'
wmctrl -c 'cImage-Palette'
wmctrl -c 'cImage-Stats'
wmctrl -c 'cImage-All-Stats'
wmctrl -c 'cImage-Theme'
wmctrl -c 'cImage-Documentation'
rm -f "/tmp/ciStats.txt"
rm -f "$tt"
rm -f "$tf"
rm -f "$t1"
rm -f "$t2"
}
$fcall mExit

if [ -z "$1" ]; then mLoad; else $1; fi
