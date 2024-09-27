source(lessons/setup.R)

#colorado counties
counties <- counties(state = "CO")

# Larimer county roads
roads <- roads(state = "CO", county = "Larimer")

#interactive more
tmap_mode("view")

qtm(counties)+
  qtm(roads)

# more customized map
tm_shape(counties)+
  tm_polygons()

# look at the class of counties
class(counties)

# point data
poudre_points <- data.frame (name = c ("Mishawaka","Rustic", "Blue Lake Trailhead"),
                             long = c(-105.35634,-105.58159, -105.85563),
                             lat = c(40.68752, 40.69687, 40.57960))|

# convert to spatial 
poudre_points_sf <- st_as_sf(poudre_points, coords = c("long", "lat"), crs = 4326)


# in console > class(poudre_points_sf)
# in console > poudre_points_sf

# raster data
elevation <- get_elev_raster(counties, z = 7)
# 7 = ~ 1km resolution (rough resoltuion, but quick import and analysis for tutorial)


#quick plot
qtm(elevation)

tm_shape (elevation)+
  tm_raster (style ="cont", title = "Elevation (m) ")

# the terra package
elevation <- rast(elevation)

names(elevation) <- "Elevation"

# check projections
st_crs(counties)
crs(counties) == crs(elevation)

# project elevation layer
elevation_prj <- terra::project(elevation, ext(counties))

#crop elevation to counties extent
elevation_crop <- crop(elevation,counties)
qtm(elevation_crop)


# read and write spatial data

# save sf/vector data
write_sf(counties, data/counties.shp)

# save raster data
writeRaster(elevation_crop, "data/elevation.tif")

#save .Rdata
save(counties, roads, file="data/spatial_objects.rData")




