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
- [ ] red sea fix - make generic and also apply to bering str? or just fix both with topg changes and set `redsea_gulfbay_fix=.false.`
- [x] Deleted this from 1deg: not in MOM5 code; no other configs other than old 1deg access use it
```
&bg_diff_lat_dependence_nml
    bg_diff_eq = 1e-06
    lat_low_bgdiff = 20.0
/
```
- [ ] check: do we want this at 0.25 and 0.1 deg?
```
&fms_nml
    domains_stack_size = 115200
/
```
- [ ] check: Russ said Matt C found `neutral=.false.` is better? False is default. or is this not used anyway? Looks like it's for atmosphere not ocean?
```
&monin_obukhov_nml
    neutral = .true.
/
```
- [ ] TEOS10: Russ says we're using pre-TEOS10 for performance. Bob: NEMO's polynomial TEOS-10 approx is equally accurate and much faster - see Fabian paper - ask Kial
- [ ] use do_bitwise_exact_sum in ocean_barotropic_nml, ocean_blob_nml, ocean_density_nml, ocean_grids_nml, ocean_rivermix_nml, ocean_sbc_nml, ocean_tracer_diag_nml, ocean_velocity_diag_nml
- [ ] use bitwise_reproduction in ocean_blob_nml?
- [ ] is fms_io_layout overridden by io_layout and therefore redundant?
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
- [x] checked ocean_frazil_nml is used by ACCESS
- [ ] should frazil_factor=0.5 ?
- [x] viscosity_scale_by_rossby_power: Bob said GFDL uses 100 but GFDL namelist actually uses 4 and default is 2. So set to 4
- [x] many nml groups (eg &ocean_lap_friction_nml) don't include `use_this_module` - how many have `use_this_module = .false.` by default and are therefore disabled? - checked - all ok
- [ ] ocean_albedo_option = 2 looks dodgy? or is this not used anyway? (handled by coupler/CICE?)
- [ ] delete ocean_polar_filter and ocean_vert_kpp_iow? apparently not in MOM5 code
- [ ] try barotropic_split > 80 to get dt>1800 at 0.25deg (2160s is very nearly OK) - would need to be >84 to pass startup check - but none of the models use >80 - why not? - see COSIMA-TODO.md and run-025deg_jra55_ryf_broadwell_test.md and Ch11 of Griffies2012a-mom-elements-5-updated.pdf
- [ ] Bob suggests paying close attention to tuning ocean_nphysics*. Also check for consistency across resolutions.
- [ ] Russ: set river_insertion_thickness=10.0 in 0.1deg? Bob: check code - may need to set to 10m for all resolutions if we refine vertical resolution
- [ ] Nic: is 600 OK for dt_cpld at 0.1deg? was 150.
- [ ] check ocean_submesoscale_nml at 1deg - don't use submeso_diffusion_biharmonic?
- [ ] check ocean_vert_tidal_nml with Steve - use Hogg 1deg settings for background_diffusivity, decay_scale and shelf_depth_cutoff for all resolutions? (nb: shelf_depth_cutoff=-1000 turns this off)
- [ ] check xgrid_nml settings with Marshall
- [ ] should we be more precise than `grav = 9.8`?
- [ ] enable these?
    - [ ] ocean_overexchange_nml (Griffies et al 2015: "None of the CM2-O ocean configurations make use of an overflow parameterization.")
    - [ ] ocean_overflow_nml
    - [ ] ocean_overflow_ofp_nml
    - [ ] ocean_mixdownslope_nml
    - [ ] ocean_sigma_transport_nml (GFDL use it)
    - [ ] remove do_alltoall (already default) and do_alltoallv (NOT default)? what do they do?
    - [ ] make_exchange_reproduce (doc says "This option has a considerable performance impact" but Bob says it won't slow it down in recent versions of MOM)
    - [x] we should go with massless ice for all cases
    - [x] SSS restoring is quite strong (15days) at 1 deg. Should be 60 days
    - [ ] the tracer advection scheme sweby was changed by the multi-dimensional piecewise (MDPPM) method since recommendations from Steve to the ACCESS team back to 2010 (access_ocean_notes attached). - check MDPPM is enabled (is it default?) 
    - [x] Also following Steve’s suggestion from last year, the truncate_velocity in ocean_velocity_nml should be set to FALSE.
- [ ] make CICE namelists consistent
    - [ ] Bob recommends mushy layer physics in CICE, with variable ice salinity
    - [ ] lcdf64 in setup_nml in cice_in.nml
- [ ] make MATM namelist consistent
