# Question ---------------------------------------------------------------------
# Which urban centers are closest to each site location?
# maps::us.cities has a list of all cities larger than 40,000 residents as
# of 2006
rm(list=ls())
library(tidyverse)
library(maps)
library(sp)

# Functions
get.minimum.dist <- function(df,
                             x='field_longitude', # decimalLongitude
                             y='field_latitude', # decimalLatitude
                             m=0, # minimum population size of a city
                             returnDistance=T # return distance or city name?
                             ){
  
  # List of cities with 2006 era populations
  # maps::us.cities
  
  df[,x] = as.numeric(df[,x])
  df[,y] = as.numeric(df[,y])
  
  # determine closest city to points in the supplied dataframe
  #  in kilometers (if longlat=TRUE)
  res = sapply(1:nrow(df),function(n){
    loc = filter(maps::us.cities,
                 pop>m)
    dist = sp::spDistsN1(pts = as.matrix(select(loc,long,lat)),
                         pt = as.matrix(df[n,c(x,y)]),
                         longlat = T)
    ifelse(returnDistance,min(dist),
           loc[which(dist%in%min(dist)),])
  })
  return(res)
}

# List of sites from NEON website
sites = read.csv(url(paste0('https://www.neonscience.org/sites/default/files/',
                            'NEON_Field_Site_Metadata_20201204.csv'))) 

names(sites)[grepl('domain',names(sites))] = 'domainID'
names(sites)[grepl('site_id',names(sites))] = 'siteID'
names(sites)[grepl('colocated',names(sites))] = 'colocatedSiteID'

sites = sites %>% 
  mutate(minDistToCityInKM = get.minimum.dist(df=sites),
         closestCity = unlist(get.minimum.dist(df=sites,
                                               returnDistance = F))
  ) %>% 
  select(domainID,siteID,colocatedSiteID,closestCity,minDistToCityInKM) %>% 
  left_join(select(maps::us.cities,name,pop),
            by=c('closestCity'='name')) 

sites[sites$domainID%in%'D04',
      c("closestCity","minDistToCityInKM","pop")] = ''

write.csv(sites,'NEON_sites_and_colocated_cities.csv',
          row.names = F,na = '',fileEncoding = 'UTF-8')