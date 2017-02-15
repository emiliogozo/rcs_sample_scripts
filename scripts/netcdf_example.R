###########################################################
# Sample R script to read, process, plot and write netcdf #
#                                                         #
#                                                         #
# Required libraries:                                     #
#     ncdf4, rgeos, raster, rasterVis, maptools, maps     #
#                                                         #
#                                                         #
# Author:                                                 #
#     Emilio Gozo <emil.gozo@gmail.com>                   #
#                                                         #
#                                                         #
# Changelog:                                              #
#     15/02/2017  -  File created.                        #
###########################################################

library(raster)
library(rasterVis)
library(maptools)
library(maps)

nc_file = 'input/trmm/WP262012_BOPHA.nc'
start_date = ISOdate(2012, 11, 27, tz = 'UTC')
end_date = ISOdate(2012, 11, 29, tz = 'UTC')
lon1 = 110
lon2 = 140
lat1 = 0
lat2 = 30

get_date <- function(dt) {
    format(as.Date(dt), '%Y-%m-%d')
}

## read variable 'r' from the nc file ##
pr <- stack(nc_file, varname='r')

## crop raster based on bounding box ##
bbox <- extent(lon1, lon2, lat1, lat2)
pr <- crop(pr, bbox)
## get only specified date ##
pr <- subset(pr, which(getZ(pr) >= start_date & getZ(pr) <= end_date))

## get daily sum ##
pr.daily <- zApply(pr, by=get_date, fun=sum)
pr.daily <- setZ(pr.daily, as.Date(getZ(pr.daily)))

## get world outline ##
world.outlines <- map("world", plot=FALSE)
world.outlines.sp <- map2SpatialLines(world.outlines, proj4string = CRS("+proj=longlat"))

## color scheme ##
mapTheme <- rasterTheme(region = brewer.pal(7, "Blues"))
## color levels ##
cutpts <- c(0, 5, 10, 15, 20, 25, 30, 35)
## plot variable ##
plt <- levelplot(raster(pr.daily,2), margin = F, at=cutpts, cuts=8, pretty=TRUE, par.settings = mapTheme,
  main="Rainfall[mm] Nov 28")
plt + layer(sp.lines(world.outlines.sp, col = "black", lwd = 1))


## save plot as image ##
dev.print(png, 'img/rain_nov_28.png', width=618, height=800)

## save as netcdf, overwrite if file exists ##
writeRaster(pr.daily, filename="output/pr_daily.nc", format="CDF", overwrite=TRUE)
