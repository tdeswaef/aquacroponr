#' @import magrittr
#' @import dplyr
#' @import tibble

Digit_settings <- function(params){
  Digit_requirements <- Digit_requirements_fun()
  digitvalues <- tibble::tibble(names = names(params), values = params %>% unlist() %>% unname()) %>%
    dplyr::left_join(tibble::tibble(names = names(Digit_requirements), digits = Digit_requirements %>% unlist() %>% unname()),
              by = "names") %>%
    dplyr::rowwise() %>%
    dplyr::mutate(digitvalues = format(values, digits = 1, nsmall = digits, scientific = F, quote=F)) %>% .$digitvalues

  return(digitvalues)
}

Digit_requirements_fun <- function(){
  Digit_requirements <- list(
    version_AC = 1,       # AquaCrop Version (June 2021)
    file_prot = 0,          # File protected
    crop_type = 0,          # fruit/grain producing crop = 2
    sow_type = 0,           # Crop is sown
    crop_cycle = 0,         # Determination of crop cycle # by calendar days (1) or by growing degree days (0)
    p_factors = 0,          # Soil water depletion factors (p) are adjusted by ETo
    T_base = 1,           # Base temperature (degC) below which crop development does not progress
    T_max = 1,           # Maximum temperature (degC) above which crop development no longer increases with an increase in temperature
    cycle_len_gdd = 0,     # Total length of crop cycle in growing degree-days
    pexp_up = 2,         # Soil water depletion factor for canopy expansion (p-exp) - Upper threshold
    pexp_lo = 2,         # Soil water depletion factor for canopy expansion (p-exp) - Lower threshold
    pexp_sh = 1,          # Shape factor for water stress coefficient for canopy expansion (0.0 = straight line)
    psto_up = 2,         # Soil water depletion fraction for stomatal control (p - sto) - Upper threshold
    psto_sh = 1,          # Shape factor for water stress coefficient for stomatal control (0.0 = straight line)
    psen_up = 2,         # Soil water depletion factor for canopy senescence (p - sen) - Upper threshold
    psen_sh = 1,          # Shape factor for water stress coefficient for canopy senescence (0.0 = straight line)
    sen_ET = 0,           # Sum(ETo) during stress period to be exceeded before senescence is triggered
    ppol_up = 2,         # Soil water depletion factor for pollination (p - pol) - Upper threshold
    vwc_anaer = 0,         # Vol% for Anaerobiotic point (* (SAT - [vol%]) at which deficient aeration occurs *)
    calib_fert = 0,        # Considered soil fertility stress for calibration of stress response (%)
    resp_exp = 2,       # Response of canopy expansion is not considered
    resp_max = 2,       # Response of maximum canopy cover is not considered
    resp_wp = 2,        # Response of crop Water Productivity is not considered
    resp_sen = 0,       # Response of decline of canopy cover is not considered
    dummy_1 = 0,           # dummy - Parameter no Longer required
    Tpol_lo = 0,           # Cold (air temperature) stress affecting pollination - not considered
    Tpol_up = 0,           # Heat (air temperature) stress affecting pollination - not considered
    Ttra_lo = 1,         # Cold (air temperature) stress on crop transpiration not considered
    ec_lo = 0,              # Electrical Conductivity of soil saturation extract at which crop starts to be affected by soil salinity (dS/m)
    ec_up = 0,             # Electrical Conductivity of soil saturation extract at which crop can no longer grow (dS/m)
    dummy_2 = 0,           # Dummy - no longer applicable
    salexp = 0,            # Calibrated distortion (%) of CC due to salinity stress (Range# 0 (none) to +100 (very strong))
    salsto = 0,           # Calibrated response (%) of stomata stress to ECsw (Range# 0 (none) to +200 (extreme))
    kc_max = 2,          # Crop coefficient when canopy is complete but prior to senescence (KcTr,x)
    kc_dec = 3,         # Decline of crop coefficient (%/day) as a result of ageing, nitrogen deficiency, etc.
    rt_min = 2,          # Minimum effective rooting depth (m)
    rt_max = 2,          # Maximum effective rooting depth (m)
    rt_sh = 0,             # Shape factor describing root zone expansion
    rtex_up = 3,        # Maximum root water extraction (m3water/m3soil.day) in top quarter of root zone
    rtex_lo = 3,        # Maximum root water extraction (m3water/m3soil.day) in bottom quarter of root zone
    eva_rdc = 0,           # Effect of canopy cover in reducing soil evaporation in late season stage
    ccs_1 = 2,           # Soil surface covered by an individual seedling at 90 % emergence (cm2)
    ccs_2 = 2,           # Canopy size of individual plant (re-growth) at 1st day (cm2)
    plant_dens = 0,    # Number of plants per hectare
    cgc = 5,          # Canopy growth coefficient (CGC)# Increase in canopy cover (fraction soil cover per day)
    cgc_dec = 0,           # Number of years at which CCx declines to 90 % of its value due to self-thinning - Not Applicable
    cgc_decx = 2,          # Shape factor of the decline of CCx over the years due to self-thinning - Not Applicable
    cgc_dec_sh = 0,      # dummy - Parameter no Longer required
    ccx = 2,             # Maximum canopy cover (CCx) in fraction soil cover
    cdc = 5,          # Canopy decline coefficient (CDC)# Decrease in canopy cover (in fraction per day)
    eme_d = 0,              # Calendar Days# from sowing to emergence
    root_d = 0,            # Calendar Days# from sowing to maximum rooting depth
    sen_d = 0,            # Calendar Days# from sowing to start senescence
    cyc_d = 0,            # Calendar Days# from sowing to maturity (length of crop cycle)
    flo_d = 0,             # Calendar Days# from sowing to flowering
    flolen_d = 0,          # Length of the flowering stage (days)
    deter = 0,              # Crop determinancy unlinked with flowering
    fruit_exc = 0,         # Excess of potential fruits (%)
    hilen_d = 0,           # Building up of Harvest Index starting at flowering (days)
    wp_ref = 1,          # Water Productivity normalized for ETo and CO2 (WP*) (gram/m2)
    wp_yld = 0,            # Water Productivity normalized for ETo and CO2 during yield formation (as % WP*)
    perf_co2 = 0,          # Crop performance under elevated atmospheric CO2 concentration (%)
    hi_ref = 0,            # Reference Harvest Index (HIo) (%)
    hi_stress = 0,          # Possible increase (%) of HI due to water stress before flowering
    hi_veget = 1,        # No impact on HI of restricted vegetative growth during yield formation
    hi_sto = 1,           # Coefficient describing negative impact on HI of stomatal closure during yield formation
    hi_max = 0,            # Allowable maximum increase (%) of specified HI
    eme_gdd = 0,           # GDDays# from sowing to emergence
    root_gdd = 0,          # GDDays# from sowing to maximum rooting depth
    sen_gdd = 0,           # GDDays# from sowing to start senescence
    mat_gdd = 0,           # GDDays# from sowing to maturity (length of crop cycle)
    flo_gdd = 0,           # GDDays# from sowing to flowering
    flolen_gdd = 0,        # Length of the flowering stage (growing degree days)
    cgc_gdd = 6,    # CGC for GGDays# Increase in canopy cover (in fraction soil cover per growing-degree day)
    cdc_gdd = 6,    # CDC for GGDays# Decrease in canopy cover (in fraction per growing-degree day)
    hilen_gdd = 0,         # GDDays# building-up of Harvest Index during yield formation
    dmc_yld = 0,           # dry matter content (%) of fresh yield
    regr_rt_min = 2,     # Minimum effective rooting depth (m) in first year - required only in case of regrowth
    regr_plant = 0,         # Crop is transplanted in 1st year - required only in case of regrowth
    sh_rt = 0,              # Transfer of assimilates from above ground parts to root system is NOT considered
    storage_d = 0,          # Number of days at end of season during which assimilates are stored in root system
    perc_toroot = 0,        # Percentage of assimilates transferred to root system at last day of season
    perc_toshoot = 0       # Percentage of stored assimilates transferred to above ground parts in next season
  )

  return(Digit_requirements)
}



