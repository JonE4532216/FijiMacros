run("Bio-Formats Macro Extensions");
input_directory = getDirectory("Choose an input Directory ");
output_directory = getDirectory("Choose an output Directory ");
file_list = getFileList(input_directory);
filesep = File.separator;
suf = "_Composite.ome.tiff";

print("input directory: " + input_directory);
print("output directory: " + output_directory);
print("Number of files: " + file_list.length);

for (i = 0; i < file_list.length; i++) {
	filename = file_list[i];
	print("Processing file:  " + filename);
	if(endsWith(filename, ".tiff")) {
		print("Successfully recognising tiff file format");
		sampleID = substring(filename, indexOf(filename, "CA_") + 3, lastIndexOf(filename, "_Composite.ome.tif"));
		fullpath = input_directory + filename;
		print("Opening file: " + fullpath);
		
		run("Bio-Formats Importer", "open=[" + fullpath + "] autoscale color_mode=Default view=Hyperstack stack_order=XYCZT");
		
		selectImage(filename);
		run("Split Channels");
		selectImage("C1-CA_" + sampleID + suf);
		run("Blue");
		selectImage("C2-CA_" + sampleID + suf);
		run("Green");
		selectImage("C3-CA_" + sampleID + suf);
		run("Yellow");
		selectImage("C4-CA_" + sampleID + suf);
		run("Magenta");
		run("Merge Channels...", "c1=[C1-CA_" + sampleID + suf + "] c2=[C2-CA_" + sampleID + suf + "] c3=[C3-CA_" + sampleID + suf + "] c4=[C4-CA_" + sampleID + suf + "] create");
		saveAs("Tiff", output_directory + filesep + filename);
		run("Z Project...", "projection=[Max Intensity]");
		saveAs("Tiff", output_directory + filesep + "MAX_" + filename);
		run("Close All");
	}
}
print("Processing complete");