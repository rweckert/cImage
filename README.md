# cImage
A small image to color value listing utility.

### Script Purpose as a Tool:
Easily extract colors from a image. Options include to vary the amount of colors extracted, export to text or HTML, as well as saving selected colors into a palette that can also be exported.

![cImage Screenshot](https://github.com/rweckert/cImage/blob/e3d411394b61fa4bb2371f546556f9923e48ea0f/screenshot-cImage.jpg)

### Setup:
1. Save the cImage.sh file to a directory. <br/>
2. Make the cImage.sh script executable by running the following command in the same directory as the cImage.sh file: <br/>
_chmod +x cImage.sh_

### Features:
- Extract colors from a image file. <br/>
- View the image file that is loaded for color extraction. <br/>
- Change the amount of colors extracted from a image file. <br/>
- Choose to extract all colors, or specifically light or dark colors. <br/>
- Sort extracted colors by hexadecimal or RGB values. <br/>
- Export extracted colors to a text file or HTML file. <br/>
- Save any color extracted to a color palette. <br/>
- Extract saved color palette to a text file or HTML file. <br/>
- Use image statistics in basic or detail views. <br/>
- Change theme to system provided or custom. <br/>
- Use the 'F1' key for documentation from any main window.

### Typical Usage:
Opening the cImage script, the first item to do will be to load a image file. Click inside the field for "Image" and browse your local storage device for a image file. Once a image file is loaded, click on the "View" option to view the image loaded. Select the option for "Extract" to extract colors from the loaded image. Inside the "cImage Extract" window select options for the amount of colors to extract and select color frequency of "All Colors", "Light Colors" or "Dark Colors". Select "Extract Colors" to have a list of colors appear that have been extracted from the selected image. More details on options and selections are listed below.

### Detailed Options and Usage:
When opening cImage, you will have the following options from the main menu: <br/>
**- Image:** Clicking inside this field will allow you to browse for a file to extract colors from. <br/>
**- View:** Opens the selected image for viewing. <br/>
**- Extract:** Options to extract color from the selected image. Extract in greater detail listed below in the section "Extract Colors". <br/>
**- Results:** Opens the results of the color extract window. This can only be opened if a color extract was performed. <br/>
**- Palette:** Opens the "cImage Palette" window showing colors selected and saved. <br/>
**- Stats:** Opens the basic image stats window that contains a option for viewing all image stats. <br/>
**- Options:** Options will allow you to select a theme for cImage. <br/>
**- Exit:** Closes all menus and windows related to the cImage script. <br/>

### View Image:
Views the selected image from the main menu. Options are as follows: <br/>
**- Open Image:** This option allows the user to select a different image to view and process. <br/>
**- Close:** Closes the image view window. <br/>

### Extract Colors:
Provides options on extracting colors from the selected image: <br/>
**- Number of Colors:** Select or type in the amount of colors to be extracted from the selected image file. The larger the number, the more colors extracted from the image. <br/>
**- Color Frequency:** Select from "All Colors" to extract all colors from the image. The option "Light Colors" will only extract lighter colors from the selected image. The option for "Dark Colors" will only extract darker colors from the selected image. <br/>
**- Close:** Closes the color extraction window. <br/>

### Result Window:
After choosing to extract colors from a image, a results window will appear with the following options: <br/>
**- Double Click:** A double click on listed color to save the color to the color palette. A message will apear stating that the selected color was saved to the color palette. <br/>
**- Sort:** Sort the color listing by double clicking on a column header by hexadecimal or RGB. <br/>
**- Export as Text:** Allows to export the extracted color listing to a text file on local storage device. <br/>
**- Export as HTML:** Allows to export the extracted color listing to a HTML file on local storage device. <br/>
**- Close:** Closes the "cImage Result" window.

### Color Palette:
Displays selected colors from the color extraction list window: <br/>
**- Refresh:** Updates the color palette window showing any changes. <br/>
**- Export as HTML:** Exports the color palette window to a HTML file that can be saved. <br/>
**- Export as Text:** Exports the color palette window to a text file that can be saved. <br/>
**- Clear Palette:** Clears the color palette window of all saved colors. <br/>

### Stats:
Displays basic image file statistics for reference. Options are as follows: <br/>
**- All Stats:** Opens a window showing all image statistics in detail. <br/>
**- Close:** Closes the file statistics window. <br/>

### All Stats:
Displays detailed image file statistics for reference. Options are as follows: <br/>
**- Save As:** Save detailed image statistics as a text file on your local storage device. <br/>
**- Edit Stats:** Opens the detailed image statistics in default text editor for editing. <br/>
**- Close:** Closes the detailed file statistics window. <br/>

### Theme Options:
The "Theme" main menu option allows the user to change settings for the theme being used, as well as access to "Help" and "About" options: <br/>
**- Load Theme:** Allows the user to browse their system for a theme to use. <br/>
**- Apply Loaded Theme:** Applies the loaded theme. Once selected the Options window will close and re-open showing the theme selected in use. <br/>
**- Mode:** Select basic system theme available in the system for "Light Theme" or "Dark Theme". This default uses the "Breeze" theme package located in the "/usr/share/themes/" folder. <br/>
**- Apply System Theme:** Applies the Mode selected for either "Light Theme" or "Dark Theme". Once selected the Options window will close and re-open showing the theme selected in use. <br/>
**- Browse Themes Folder:** Browse the default themes folder "/usr/share/themes/". <br/>
**- Help:** Opens mRunner help documentation. <br/>
**- About:** Opens the about window showing script credits. <br/>
**- Close:** Closes the "Options" window. <br/>

### Notes:
- cImage can be ran from any directory. <br/>
- cImage uses the /tmp/ folder for temporary and .ini files. <br/>
- Use the 'F1' key for documentation from any main window. <br/>
- The temporary files "/tmp/cImagePalette.txt" and "/tmp/cImage-Export.txt" are not removed on exit to preserve color palette and HTML export. <br/>

### cImage Shortcut File:
Save the following as a file named "cImage.desktop" in creating a shortcut to this utility. Update the path for "Exec" to where the script is stored: <br/>
[Desktop Entry] <br/>
Name=cImage <br/>
GenericName=cImage <br/>
Comment=A small image to color value listing utiliy. <br/>
Exec=/PathToScript/cImage.sh <br/>
Type=Application <br/>
Icon=gtk-select-color <br/>
Terminal=false <br/>

### Common System Requirements:
	The following applications are in general use of most Linux systems and are used in having cImage deliver output: <br/>
- awk <br/>
- print <br/>
- read <br/>
- rm <br/>
- sed <br/>
- while <br/>
- wmctrl <br/>
- xdg-open <br/>

### Critical System Requirements:
The most important requirement is the yad (yet another dialog) application which allows for the use of custom dialog, menu, and window options.

yad 14.0+ (GTK+ 3.24.41) [https://github.com/v1cont/yad]([url](https://github.com/v1cont/yad))
The mRunner script uses features of yad that do require version 14.0+ and built with GTK+ 3.24.41 or higher. Full setup instructions are available for either Linux or Microsoft Windows Subsystem for Linux (WSL) using a Debian base: [https://github.com/rweckert/yad-14.0-Setup-From-Scratch](https://github.com/rweckert/yad-14.0-Setup-From-Scratch) <br/>

**- yad (Yet Another Dialog):** A tool for developing graphical user interfaces in Linux, is written by Victor Ananjevsky. Installation instructions: https://github.com/rweckert/yad-14.0-Setup-From-Scratch <br/>
**- convert:** The convert-im6.q16 program is a member of the ImageMagick-ims6.q16 suite of tools. More information regarding this package can be found at: [https://www.imagemagick.org/script/convert.php](https://www.imagemagick.org/script/convert.php) 

Script interface written by: Robert W. Eckert - rweckert@gmail.com Please feel free to email to submit bugs, changes or requests.

### Project Contents:
**Project Page:** <br/>

**Source File:** <br/>

**Documentation File:** <br/>

**Project Screenshot:** <br/>

