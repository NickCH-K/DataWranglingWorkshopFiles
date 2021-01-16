# GOAL:
# Do a simplified version of the data-cleaning necessary for my most recent project.
# Create data with one observation *per college per day*
# incorporating data from:
# IPEDS 2018: IPEDS/cdsfile_all_STATA_RV_942020-662.dta -> get percent in distance ed, and tuition share (f1tufeft/(f1stapft+f1lcapft+f1gvgcft+f1pggcft+f1invrft+f1otrvft+f1endmft))
# IPEDS 2019: IPEDS/cdsfile_all_STATA_RV_942020-417.dta -> get whether the college is private
# EADA: EADA/InstLevel.xlsx -> get whether hte college is Division I in sports (ClassificationCode is 1 through 3)
# NY Times: NYT/us-counties_cases.csv -> Get by-county information on COVID cases on July 31
# Census: Census/co-est2019-annres.csv -> Get by-county population in 2019
# politicaldata house_116 data -> Get 2018 congressoinal DW-Nominate scores
# foot_traffic_panel.Rdata -> Pre-prepared college-day file of foot traffic visits to nearby locations


# IPEDS -> college-level data (unitid)
# EADA -> college-level data (unitid?)
# NY Times -> county / day data
# Census -> county (textual county-level data, and skip first row)
# politicaldata -> congressional district  (link to ipeds with congressional district)

# One observation per college 

# NEED: college -> county link to link up IPEDS and EADA with NY Times nad Census
# NEED: colllege -> congressional district to linkup IPEDS/EADA with congressional distict

library(tidyverse)
library(haven)
library(politicaldata)
library(readxl)
library(lubridate)
library(tidylog)

ipeds2018 <- read_dta('IPEDS/cdsfile_all_STATA_RV_942020-662.dta') %>%
  mutate(tuition_share = f1tufeft/(f1stapft+f1lcapft+f1gvgcft+f1pggcft+f1invrft+f1otrvft+f1endmft),
         distance_share = pctdeexc + pctdesom) %>%
  select(unitid, tuition_share, distance_share)

ipeds2019 <- read_dta('IPEDS/cdsfile_all_STATA_RV_942020-417.dta') %>%
  mutate(private = sector == 2) %>%
  select(unitid, cngdstcd, fips, countycd)

eada <- read_excel('EADA/InstLevel.xlsx') %>%
  mutate(DivisionI = ClassificationCode %in% 1:3) %>%
  select(unitid, DivisionI)

NYT <- read_csv('NYT/us-counties_cases.csv') %>%
  filter(date == ymd('2020-07-31')) %>%
  mutate(CountyandState = paste0(county, ' ',
                                 case_when(
                                   state == 'Alaska' ~ ', ',
                                   state == 'Louisiana' ~ 'Parish, ',
                                   TRUE ~ 'County, '
                                 ),
                                 state))

Census <- read_csv('Census/co-est2019-annres.csv', skip = 1) %>%
  mutate(County = str_sub(County, 2)) %>%
  rename(CountyandState = County) %>%
  select(CountyandState, `2019`) %>%
  rename(Population = `2019`)

# Check if unitid is key
check_dupes <- function(data, vars) {
  data %>% 
    select(vars) %>%
    duplicated() %>%
    max()
}
check_dupes(ipeds2018, 'unitid')
check_dupes(ipeds2019, 'unitid')
check_dupes(eada, 'unitid')
check_dupes(NYT, 'CountyandState')
check_dupes(Census, 'CountyandState')

# Check the countyandstate values
NYT %>% filter(!(CountyandState %in% Census$CountyandState)) %>% pull(CountyandState) %>% table()

# FIX THE COUNTYANDSTATE THING

# Merge!

our_data <- ipeds2018 %>%
  inner_join(ipeds2019) %>%
  left_join(eada) %>%
  left_join(NYT %>% rename(countycd = fips) %>% mutate(countycd = as.numeric(countycd))) %>%
  left_join(Census)
  

data("house_116")


# str_pad example

str_pad()

'2020/01/01/sales.csv'

yr <- 2020
mon <- 1
da <- 1

str_pad(mon, 2, 'left', '0')

paste0(yr, '/',
       str_pad(mon, 2, 'left', '0'), '/',
       str_pad(da, 2, 'left', '0'), '/sales.csv')
