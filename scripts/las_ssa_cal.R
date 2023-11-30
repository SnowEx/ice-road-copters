install.packages('raster')
install.packages('lidR')
install.packages('dplyr')
install.packages('readr')
install.packages('terra')
library(raster)
library(lidR)
library(dplyr)
library(readr)
library(terra)


# Uses the buffer shape to clip only road points and where abs(ScanAngleRank) < 5
# Return csv of all points for computing histogram and median

# MY SHAPE: /Users/brent/Code/ice-road-copters/transform_area/Eagle/eagle_res_buffered.shp
# layer = eagle_res_buffered
# dsn = /Users/brent/Code/ice-road-copters/transform_area/Eagle/

# Assumes this pandas df is reasonable size and can be saved

las <- readLAS(cal_las)

spdf <- st_read(file.path(shp_fp_rfl))

las <- lasclip(las, spdf)

df <- payload(las)

df <- filter(df, abs(ScanAngleRank) <= 5)

# COMPUTE RFL
df <- df %>%
    mutate( 
      rfl = 10^(Reflectance/10)
        )

write.csv(df, output_csv)

