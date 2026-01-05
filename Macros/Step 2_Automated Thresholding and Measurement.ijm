// --- Macro for Automated Thresholding and Measurement ---

// This macro performs automated thresholding and subsequent measurement across an entire image set. It allows the user to select images from a specified input folder (e.g., the folder containing deconvolved images). The macro then applies a user-selected threshold and performs measurements on all images. Finally, a results window will open, displaying all collected measurements. Before running the macro, ensure your desired measurement settings in ImageJ are pre-configured, specifically, if the 'Display label' option is selected, to label the analyzed images in the results table.

// IMPORTANT: Change the file extension to .ijm to use this as an ImageJ macro.

// Script

threshold_value = getNumber("Enter the threshold value:", 0);
function process_and_measure(image_path) {
    open(image_path);
    originalTitle = getTitle();
    print("Performing Processing and Measurement: " + originalTitle);

    selectWindow(originalTitle);

    run("8-bit");
    setThreshold(0, threshold_value);
    setOption("BlackBackground", false);

    run("Measure");

    close();
}

setBatchMode(true);
input_folder = getDirectory("Choose the folder containing images for thresholding");
fileList = getFileList(input_folder);
for (i = 0; i < fileList.length; i++) {
    input_path = input_folder + fileList[i];
    process_and_measure(input_path);
}
setBatchMode(false);
