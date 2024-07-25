run("Bio-Formats Macro Extensions");

input_directory = getDirectory("Choose an input Directory");

output_directory = getDirectory("Choose an output Directory");

file_list = getFileList(input_directory);
filesep = File.separator;
suf = "_Composite.ome.tiff";

for (i = 0; i < file_list.length; i++) {
	filename = file_list[i];
	print("Processing file: " + filename);
	if(endsWith(filename, ".tiff")) {
		print("Successfully recognised tiff file format");
		sampleID = substring(filename, indexOf(filename, "CA_") +3, lastIndexOf(filename, "_Composite.ome.tif"));
		fullpath = input_directory + filename;
		print("Opening file: " + fullpath);
		
		run("Bio-Formats Importer", "open=[" + fullpath + "] autoscale color_mode=Default view=Hyperstack stack_order=XYCZT");
		selectImage(filename);
		if(sampleID == "B1876Ds2") {
			run("Rotate...", "angle=218 grid=1 interpolation=Bilinear");
		} else {
			if(sampleID == "G1967As2") {
				run("Rotate...", "angle=168 grid=1 interpolation=Bilinear");
			} else {
				if(sampleID == "G1967Cs2") {
					run("Rotate...", "angle=145 grid=1 interpolation=Bilinear");
				} else {
					if(sampleID == "Y2052Ds1") {
						run("Rotate...", "angle=210 grid=1 interpolation=Bilinear");
					}
				}
			}
		}
		saveAs("Tiff", output_directory + filesep + "CA_" + sampleID + "_Composite_rotated.ome.tif");
		run("Close All");
	}
	
}



run("Rotate... ", "angle=218 grid=1 interpolation=Bilinear");
