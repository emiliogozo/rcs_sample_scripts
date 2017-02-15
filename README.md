# Sample scripts

Contains sample R and grads scripts to process csv, binary and netcdf files.

## Scripts:
1. **csv_ggplot_example.R** - An R script that reads a csv file and uses ggplot2 to visualize the data. Requires _ggplot2_ and _dplyr_.
2. **trmm_example.gs** - A grads script using TRMM data.
3. **netcdf_example.gs** - A grads script using netcdf data.
4. **netcdf_example.R** - An R script that reads netcdf data. Demonstrates reading, processing and writing netcdf. Also shows data visualization. Requires _ncdf4, rgeos, raster, rasterVis, maptools, maps_.

## Running the scripts:
Always run the scripts on the root directory i.e.:

          Rscript scripts/<Rscript.R>

for R scripts or,

          grads -pbc scripts/<grads_script.gs>

Make sure that the required libraries are installed properly first.