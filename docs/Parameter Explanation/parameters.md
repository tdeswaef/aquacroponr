# Model parameter explanation


This file lists the crop parameters that can be adjusted in the `aquacrop_wrapper` function.
Please refer to the AquaCrop manual for a better understanding of conservative parameters.

| Parameter | Explanation |
| --------- | ----------- |
| `crop_type` | fruit/grain producing crop = 2 |
| `sow_type` | Crop is sown |
|    `crop_cycle` | Determination of crop cycle # by calendar days (1) or by growing degree days (0) |
|    `p_factors` | Soil water depletion factors (p) are adjusted by ETo |
|    `T_base` | Base temperature (degC) below which crop development does not progress |
|    `T_max` | Maximum temperature (degC) above which crop development no longer increases with an increase in temperature |
|    `cycle_len_gdd` |Total length of crop cycle in growing degree-days |
|    `pexp_up` | Soil water depletion factor for canopy expansion (p-exp) - Upper threshold |
|    `pexp_lo` | Soil water depletion factor for canopy expansion (p-exp) - Lower threshold |
|    `pexp_sh` | Shape factor for water stress coefficient for canopy expansion (0.0 = straight line) |
|    `psto_up` | Soil water depletion fraction for stomatal control (p - sto) - Upper threshold |
|    `psto_sh` | Shape factor for water stress coefficient for stomatal control (0.0 = straight line) |
|    `psen_up` | Soil water depletion factor for canopy senescence (p - sen) - Upper threshold |
|    `psen_sh` | Shape factor for water stress coefficient for canopy senescence (0.0 = straight line) |
|    `sen_ET` | Sum(ETo) during stress period to be exceeded before senescence is triggered |
|    `ppol_up` | Soil water depletion factor for pollination (p - pol) - Upper threshold |
|    `vwc_anaer` |  Vol% for Anaerobiotic point (* (SAT - [vol%]) at which deficient aeration occurs *) |
|    `calib_fert` | Considered soil fertility stress for calibration of stress response (%) |
|    `resp_exp` | Response of canopy expansion is not considered |
|    `resp_max` | Response of maximum canopy cover is not considered |
|    `resp_wp` | Response of crop Water Productivity is not considered |
|    `resp_sen` | Response of decline of canopy cover is not considered | 
|    `dummy_1` | dummy - Parameter no Longer required |
|    `Tpol_lo` | Cold (air temperature) stress affecting pollination - not considered |
|    `Tpol_up` | Heat (air temperature) stress affecting pollination - not considered |
|    `Ttra_lo` | Cold (air temperature) stress on crop transpiration not considered |
|    `ec_lo` | Electrical Conductivity of soil saturation extract at which crop starts to be affected by soil salinity (dS/m) |
|    `ec_up`| Electrical Conductivity of soil saturation extract at which crop can no longer grow (dS/m) |
|    `dummy_2` | Dummy - no longer applicable |
|    `salexp` | Calibrated distortion (%) of CC due to salinity stress (Range# 0 (none) to +100 (very strong)) |
|    `salsto` | Calibrated response (%) of stomata stress to ECsw (Range# 0 (none) to +200 (extreme)) |
|    `kc_max` | Crop coefficient when canopy is complete but prior to senescence (KcTr,x) |
|    `kc_dec` | Decline of crop coefficient (%/day) as a result of ageing, nitrogen deficiency, etc. |
|    `rt_min` | Minimum effective rooting depth (m) |
|   `rt_max` | Maximum effective rooting depth (m) |
|    `rt_sh` | Shape factor describing root zone expansion |
|    `rtex_up` | Maximum root water extraction (m3water/m3soil.day) in top quarter of root zone |
|    `rtex_lo` | Maximum root water extraction (m3water/m3soil.day) in bottom quarter of root zone |
|    `eva_rdc` | Effect of canopy cover in reducing soil evaporation in late season stage | 
|    `ccs_1` | Soil surface covered by an individual seedling at 90 % emergence (cm2) |
|    `ccs_2` | Canopy size of individual plant (re-growth) at 1st day (cm2) |
|    `plant_dens` | Number of plants per hectare |
|    `cgc` | Canopy growth coefficient (CGC)# Increase in canopy cover (fraction soil cover per day) |
|    `cgc_dec` | Number of years at which CCx declines to 90 % of its value due to self-thinning - Not Applicable |
|    `cgc_decx` | Shape factor of the decline of CCx over the years due to self-thinning - Not Applicable |
|    `cgc_dec_sh` | dummy - Parameter no Longer required |
|    `ccx` | Maximum canopy cover (CCx) in fraction soil cover |
|    `cdc` | Canopy decline coefficient (CDC)# Decrease in canopy cover (in fraction per day) |
|    `eme_d` | Calendar Days# from sowing to emergence |
|    `root_d` | Calendar Days# from sowing to maximum rooting depth |
|    `sen_d` | Calendar Days# from sowing to start senescence |
|    `cyc_d` | Calendar Days# from sowing to maturity (length of crop cycle) |
|    `flo_d` | Calendar Days# from sowing to flowering |
|    `flolen_d` | Length of the flowering stage (days) |
|    `deter` | Crop determinancy unlinked with flowering |
|    `fruit_exc` | Excess of potential fruits (%) |
|    `hilen_d` | Building up of Harvest Index starting at flowering (days) |
|    `wp_ref` | Water Productivity normalized for ETo and CO2 (WP*) (gram/m2) |
|    `wp_yld` | Water Productivity normalized for ETo and CO2 during yield formation (as % WP*) |
|    `perf_co2` | Crop performance under elevated atmospheric CO2 concentration (%) |
|    `hi_ref` | Reference Harvest Index (HIo) (%) |
|    `hi_stress` | Possible increase (%) of HI due to water stress before flowering |
|    `hi_veget` | No impact on HI of restricted vegetative growth during yield formation |
|    `hi_sto` | Coefficient describing negative impact on HI of stomatal closure during yield formation|
|    `hi_max` | Allowable maximum increase (%) of specified HI |
|    `eme_gdd` | GDDays# from sowing to emergence |
|    `root_gdd` | GDDays# from sowing to maximum rooting depth |
|    `sen_gdd` | GDDays# from sowing to start senescence |
|    `mat_gdd` | GDDays# from sowing to maturity (length of crop cycle) |
|    `flo_gdd` | GDDays# from sowing to flowering |
|    `flolen_gdd` | Length of the flowering stage (growing degree days) |
|    `cgc_gdd` | CGC for GGDays# Increase in canopy cover (in fraction soil cover per growing-degree day) |
|    `cdc_gdd` | CDC for GGDays# Decrease in canopy cover (in fraction per growing-degree day) |
|    `hilen_gdd` | GDDays# building-up of Harvest Index during yield formation |
|    `dmc_yld` | dry matter content (%) of fresh yield |
|    `regr_rt_min` | Minimum effective rooting depth (m) in first year - required only in case of regrowth |
|    `regr_plant` | Crop is transplanted in 1st year - required only in case of regrowth |
|    `sh_rt` | Transfer of assimilates from above ground parts to root system is NOT considered |
|    `storage_d` | Number of days at end of season during which assimilates are stored in root system |
|    `perc_toroot` | Percentage of assimilates transferred to root system at last day of season |
|    `perc_toshoot` | Percentage of stored assimilates transferred to above ground parts in next season |
