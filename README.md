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
- [ ] set ncar_boundary_scaling_read=.false.? see https://arccss.slack.com/archives/C6PP0GU9Y/p1508905387000065
- [ ] TEOS10: Russ says we're using eos_preteos10=.true. for performance. GFDL do this too. Bob: NEMO's polynomial TEOS-10 approx is equally accurate and much faster - see Fabian paper - ask Kial
- [ ] use do_bitwise_exact_sum in ocean_barotropic_nml (GFDL do), ocean_blob_nml, ocean_density_nml, ocean_grids_nml (GFDL do), ocean_rivermix_nml, ocean_sbc_nml, ocean_tracer_diag_nml, ocean_velocity_diag_nml ? Code doc says "Set true to do bitwise exact global sum. When it is false, the global
!  sum will be non-bitwise_exact, but will significantly increase efficiency. 
!  Default do_bitwise_exact_sum=.false." but is this out of date? Bob says the exact order-independent summation has been put into latest FMS - so check whether it's in the version we use. 
- [ ] use bitwise_reproduction in ocean_blob_nml?
- [ ] GFDL use smooth_eta_t_biharmonic=.true. but we have .false.. This is used only for depth-based coords (eg z*). We could have .true. but it may introduce noise and isn't recommended. Default is .false. so best to leave it .false.? But why do GFDL turn it on?
- [ ] smooth_eta_diag_laplacian=.true. in all cases and default, even though this is used only for pressure-based coords.
- [ ] GFDL and old ACCESS use smooth_eta_t_laplacian=.false. but we have .true. which is the default. This is used only for depth-based coords (eg z*).
- [ ] GFDL have smooth_pbot_t_biharmonic=.true. but we have .false. (the default). Not used in depth based coords anyway.
- [ ] GFDL have smooth_pbot_t_laplacian=.false. but we have .true. (the default). Not used in depth based coords anyway.
- [ ] We have vel_micom_lap_diag=0.2 (the default) but GFDL use 1.0
- [ ] We use cdbot=0.001; GFDL use 0.002
- [ ] We use cdbot_hi=0.007; efault is 0.003
- [ ] We use cdbot_roughness_uamp=.true.; GFDL use .false. (default). "This approach is more relevant for coarse models
!  than the constant roughness length used in the cdbot_law_of_wall option"
- [ ] We have use_geothermal_heating=.false. (default); GFDL have .true.
- [ ] GFDL use bottom_5point in &ocean bihgen_friction_nml; don't turn this on unless we need it. our vel_micom_bottom also differs from GFDL but is presumably ignored.
- [ ] our  vel_micom_iso and visc_crit_scale in &ocean bihgen_friction_nml differ from GFDL
- [ ] gotcha: GFDL radiation requires a chl file
- [ ] in &ocean_density_nml our neutralrho_max, neutralrho_min differ from GFDL & ACCESS. They look like they were mistakenly copied from potrho_max, potrho_min - **FIXED**
- [ ] **FIX THESE** in &ocean_lapgen_friction_nml ?
    - [ ] we (& old ACCESS) have ncar_only_equatorial=.true. at 1deg but GFDL has .false. (the default).
    - [ ] we have viscosity_ncar=.true. at 1deg but GFDL & old ACCESS have .false. (the default).
    - [ ] vconst1,3,4,6 differ from default
    - [ ] GFDL have viscosity_ncar_2000 unspecified and default is true. We have false at 1deg.
    - [ ] GFDL have viscosity_ncar_2007 unspecified and default is false. We have true at 1deg.
- [ ] GFDL use a mask in &ocean_mixdownslope_nml; we don't.
- [ ] GFDL have frazil_only_in_surface, freezing_temp_simple true; we have false.
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
- [ ] ocean_albedo_option = 2 looks dodgy? or is this not used anyway? (handled by coupler/CICE?) GFDL uses ocean_albedo_option = 5 - but Steve says "Also note that "ocean_albedo" is set for a coupled model, and it is different for ocean/ice simulations.  That is a major "gotcha" that Spence can share with you if interested.'"
- [x] changed clock_grain from 'LOOP' to 'COMPONENT' (as used by GFDL) - may give better performance?
- [ ] delete ocean_polar_filter and ocean_vert_kpp_iow? apparently not in MOM5 code
- [ ] try barotropic_split > 80 to get dt>1800 at 0.25deg (2160s is very nearly OK) - would need to be >84 to pass startup check - but none of the models use >80 - why not? - see COSIMA-TODO.md and run-025deg_jra55_ryf_broadwell_test.md and Ch11 of Griffies2012a-mom-elements-5-updated.pdf
- [ ] Bob suggests paying close attention to tuning ocean_nphysics*. Also check for consistency across resolutions.
- [ ] Russ: set river_insertion_thickness=10.0 in 0.1deg? Bob: check code - may need to set to 10m for all resolutions if we refine vertical resolution
- [ ] Nic: is 600 OK for dt_cpld at 0.1deg? was 150.
- [ ] check ocean_submesoscale_nml at 1deg - don't use submeso_diffusion_biharmonic?
- [ ] check ocean_vert_tidal_nml with Steve - use Hogg 1deg settings for background_diffusivity, decay_scale and shelf_depth_cutoff for all resolutions? (nb: shelf_depth_cutoff=-1000 turns this off)
- [ ] check xgrid_nml settings with Marshall
- [ ] should we be more precise than `grav = 9.8`?
- [ ] bbc namelist changes now require a roughness_cdbot file - revert this?
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
- [ ] make CICE namelists consistent (see end of <https://www.overleaf.com/11449164wmwcrxynvgpx>)
    - [ ] Bob recommends mushy layer physics in CICE, with variable ice salinity
    - [ ] lcdf64 in setup_nml in cice_in.nml
- [ ] make MATM namelist consistent

#### CHECKED UP TO &ocean_mixdownslope_nml IN SEC 5 (original/GFDL_ESM2M_input-cut.nml    original/MOM_SIS_TOPAZ_input.nml    original/russ-accessom-mom4p1-input.nml    original/hogg_accessom2_1deg_jra55_ryf_input.nml    new_accessom2_1deg_jra55_ryf_input.nml    original/kiss_accessom2_025deg_jra55_ryf_logfile.000000.out        new_accessom2_025deg_jra55_ryf_input.nml    original/hogg_accessom2_01deg_jra55_ryf_input.nml    new_accessom2_01deg_jra55_ryf_input.nml )


also see Aidan's namelist recommendations (email 2017-10-26):
1. You've got debugging turned on for the ocean_tracer_advect module, which is fine if you want to debug tracer advection, but otherwise just takes extra time
 
&ocean_tracer_advect_nml
      debug_this_module=.false.
      advect_sweby_all=.false.
/
 
2. The minimum salt is negative, but the model will blow up with salinity < 0. Probably not important, but I see this a lot in MOM namelists and often wonder why it is
 
&ocean_tempsalt_nml
      s_min = -1.0
/
 
3. You have barotropic smoothing instead of laplacian. This is not recommended explicitly in the code
 
&ocean_barotropic_nml
      smooth_eta_t_laplacian=.false.
      smooth_eta_t_biharmonic=.true.
/
 
4. Russ advised me that kbl_standard_method and smooth_blmc should always be set to false
 
&ocean_vert_kpp_nml
      smooth_blmc=.true.
      kbl_standard_method=.true.
/
 
 
5. All your diag_step variables are set to 120. For your 1800s time step this is every 60 hours. If you're in production mode and don't need to monitor these then the GFDL people typically set them to a month, or even the entire runtime (1 year?).
