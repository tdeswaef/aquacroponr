###Create model input files
createfiles <- function (Exp_list, cycle_length, GWT) {
  Exp_list %>%
    purrr::walk(~write_PRO(Scenario_ = .x, cycle_length)) %>%
    purrr::walk(~write_CAL(Scenario_ = .x)) %>%
    purrr::walk(~write_CLI(Scenario_ = .x)) %>%
    purrr::walk(~write_Tnx(Scenario_ = .x)) %>%
    purrr::walk(~write_ETo(Scenario_ = .x)) %>%
    purrr::walk(~write_Plu(Scenario_ = .x)) %>%
    purrr::walk(~write_IRR_ev(Scenario_ = .x)) %>%
    purrr::walk(~write_SOL(Scenario_ = .x)) %>%
    purrr::walk(~write_GWT(Scenario_ = .x, GWT = GWT)) %>%
    purrr::walk(~write_SW0(Scenario_ = .x))
}
