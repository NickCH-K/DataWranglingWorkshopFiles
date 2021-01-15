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