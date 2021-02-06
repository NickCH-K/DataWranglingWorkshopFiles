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

library(haven)
library(data.table)
library(readxl)
library(lubridate)

ipeds2018 <- read_stata('IPEDS/cdsfile_all_STATA_RV_942020-662.dta') %>%
  as.data.table()

ipeds2018 <- ipeds2018[, .(unitid, instnm, pctdesom)]

ipeds2019 <- read_stata('IPEDS/cdsfile_all_STATA_RV_942020-417.dta') %>%
  as.data.table()
ipeds2019 <- ipeds2019[, .(unitid, instnm, countycd, private = sector %in% c(2,5,8))]
setnames(ipeds2019, 'countycd', 'fips')
ipeds2019[, fips := as.integer(fips)]

eada <- read_excel('EADA/Schools.xlsx') %>%
  as.data.table()

table(eada$ClassificationCode, eada$classification_name)
classnames <- eada[, classification_name] %>%
  unique()
classnames <- classnames[!str_detect(classnames, 'Division II')]
classnames <- classnames[str_detect(classnames, 'Division I')]

eada[, div_1 := classification_name %in% classnames]
setnames(eada, 'institution_name', 'instnm')
eada <- eada[, .(unitid, instnm, div_1)]
eada[, unitid := as.numeric(unitid)]

nyt <- fread('NYT/us-counties_cases.csv')[date == ymd('2020-07-31')]
nyt <- nyt[!is.na(fips)]

census <- fread('Census/co-est2019-annres.csv', skip = 1)
census <- census[, .(V1, V13)]
setnames(census, c('V1','V13'), c('countyname', 'pop2019'))
census <- census[2:nrow(census)]
census[, pop2019 := str_replace_all(pop2019, ',', '')]
census[, pop2019 := as.numeric(pop2019)]
census[str_sub(countyname, 1, 1) == '.', countyname := str_sub(countyname, 2)]

census[, county := str_sub(countyname, 1, str_locate(countyname, ',')[,1]-1)]
census[, county := str_replace_all(county, 'County','')]
census[, county := str_trim(county)]

census[, state := str_sub(countyname, str_locate(countyname, ',')[,1]+1)]
census[, state := str_trim(state)]
census[, countyname := NULL]

fulldata <- merge(ipeds2018, ipeds2019, by = c('unitid', 'instnm'), all = TRUE) %>%
  merge(eada, by = c('unitid', 'instnm'), all = TRUE) %>%
  merge(nyt, by = 'fips', all = TRUE) %>%
  merge(census, by = c('county', 'state'), all = TRUE)
fulldata[is.na(private)] %>% nrow()
fulldata[is.na(pctdesom)] %>% nrow()
