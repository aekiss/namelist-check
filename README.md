# namelist-check: ACCESS-OM2 namelist check
The commit history of this repo tracks the changes made in developing namelists for [ACCESS-OM2](https://github.com/OceansAus/access-om2). Contact me if you want write access.

See namelist-check.pdf for an overview of namelists.

New namelists are:

new_accessom2_1deg_jra55_ryf_input.nml

new_accessom2_025deg_jra55_ryf_input.nml

new_accessom2_01deg_jra55_ryf_input.nml

You may find [nmltab](https://github.com/aekiss/nmltab) useful for comparing namelists.

## To do
- [x] make agreed nml changes
- [ ] cf. Griffies et al. (2015) p973
- [ ] cf. GFDL_ESM2M_input-cut.nml
- [ ] cf. MOM_SIS_TOPAZ_input.nml
- [ ] is this needed at 1 deg? no other configs other than old access use it
```&bg_diff_lat_dependence_nml
    bg_diff_eq = 1e-06
    lat_low_bgdiff = 20.0
/
```
- [ ] check: sigma_2 or sigma_0 for
```
&ocean_density_nml
    eos_linear = .false.
    eos_preteos10 = .true.
    layer_nk = 80
    neutralrho_max = 1038.0
    neutralrho_min = 1028.0
    potrho_max = 1038.0
    potrho_min = 1028.0
/
```
- [ ] many groups (eg &ocean_lap_friction_nml) don't include use_this_module - how many have use_this_module = .false. by default?
- [ ] ocean_albedo_option = 2 looks dodgy
- [ ] enable these?
    - [ ] ocean_overexchange_nml
    - [ ] ocean_overflow_nml
    - [ ] ocean_overflow_ofp_nml
    - [ ] ocean_mixdownslope_nml
    - [ ] ocean_sigma_transport_nml (sounds dodgy in docs but GFDL use it)
