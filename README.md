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
- [x] cf. GFDL_ESM2M_input-cut.nml
- [x] cf. MOM_SIS_TOPAZ_input.nml
- [x] cf. MOM output file to show defaults for unspecified values
- [ ] is this needed at 1 deg? no other configs other than old access use it
```
&bg_diff_lat_dependence_nml
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
- [ ] many nml groups (eg &ocean_lap_friction_nml) don't include `use_this_module` - how many have `use_this_module = .false.` by default?
- [ ] ocean_albedo_option = 2 looks dodgy
- [ ] try barotropic_split > 80 to get dt>1800 at 0.25deg (2160s is very nearly OK) - would need to be >84 to pass startup check - but none of the models use >80 - why not? - see COSIMA-TODO.md and run-025deg_jra55_ryf_broadwell_test.md and Ch11 of Griffies2012a-mom-elements-5-updated.pdf
- [ ] enable these?
    - [ ] ocean_overexchange_nml (Griffies et al 2015: "None of the CM2-O ocean configurations make use of an overflow parameterization.")
    - [ ] ocean_overflow_nml
    - [ ] ocean_overflow_ofp_nml
    - [ ] ocean_mixdownslope_nml
    - [ ] ocean_sigma_transport_nml (GFDL use it)
    - [ ] remove do_alltoall (already default) and do_alltoallv (NOT default)? what do they do?
    - [ ] make_exchange_reproduce (doc says "This option has a considerable performance impact" but Bob says it won't slow it down in recent versions of MOM)
    - [ ] Bob recommends mushy layer physics in CICE, with variable ice salinity
    - [x] we should go with massless ice for all cases
    - [x] SSS restoring is quite strong (15days) at 1 deg. Should be 60 days
    - [ ] the tracer advection scheme sweby was changed by the multi-dimensional piecewise (MDPPM) method since recommendations from Steve to the ACCESS team back to 2010 (access_ocean_notes attached).
    - [ ] Also following Steve’s suggestion from last year, the truncate_velocity in ocean_velocity_nml should be set to FALSE.
- [ ] make CICE namelists consistent
- [ ] make MATM namelist consistent
