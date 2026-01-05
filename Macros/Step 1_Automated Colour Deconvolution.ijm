// --- Macro for Automated Colour Deconvolution ---

// This macro performs automated color deconvolution across an entire image set. Specifically, it extracts and saves the DAB layer from each image (labeled as 'Colour_2') into a user-specified output directory. The macro first prompts the user to select the destination folder for the deconvolved images, followed by the selection of the folder containing the original image files. 

// IMPORTANT: Change the file extension to .ijm to use this as an ImageJ macro.

//Script

deconvolution_preset = "H DAB"; // Current preset for deconvolution. Modify this line to use a different preset (e.g.,"H & E DAB", "FastRed").
output_folder = getDirectory("Please choose a folder to save the deconvolved images.");


function deconvolve_and_save_all(image_path, save_path) {
    open(image_path);
    title = getTitle();
    print("Performing Deconvolution and Saving: " + title);

run("Colour Deconvolution2", "vectors=[" + deconvolution_preset + "] output=8bit_Transmittance simulated cross hide"); /// IMPORTANT: If you're using the 'Colour Deconvolution' plugin instead of 'Colour Deconvolution2', change the function name here.


    colour2_title = title + "-(Colour_2)";
    selectWindow(colour2_title);
    if (isOpen(colour2_title)) {
        saveAs("Tiff", save_path + File.separator + title + "-(Colour_2).tif");
        close(colour2_title);
    } else {
        print("Window " + colour2_title + " not found for " + title + ".");
    }


    close(title);
    if (isOpen(title + "-(Colour_1)")) close(title + "-(Colour_1)");
    if (isOpen(title + "-(Colour_3)")) close(title + "-(Colour_3)");
}


setBatchMode(true);
input_folder = getDirectory("Please select the folder containing the original images for deconvolution.");
fileList = getFileList(input_folder);

for (i = 0; i < fileList.length; i++) {
    input_path = input_folder + fileList[i];
    deconvolve_and_save_all(input_path, output_folder);
}
setBatchMode(false); 

/ Now all your selected images have been deconvolved to the DAB layer.
// You can ignore any warning messages that appear when the process finishes.
// Please check the output directory to confirm all images were successfully deconvolved and saved.