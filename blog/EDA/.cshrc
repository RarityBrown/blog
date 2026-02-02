##################### Cadence ####################
setenv CDS_USE_XVFB                             1
setenv LBS_CLUSTER_MASTER                       your_lbs_master
setenv CDS_2DFORM_FONT_SCALING                  1
# https://tuersi.space/eda-config/virtuoso-font-size-display
# setenv QT_SCALE_FACTOR                          1.5


#################### Siemens ####################
setenv MGC_CALIBRE_REALTIME_VIRTUOSO_ENABLED   1
setenv OA_PLUGIN_PATH                          $MGC_HOME/shared/pkgs/icv/tools/queryskl
setenv LD_LIBRARY_PATH                         $MGC_HOME/shared/pkgs/icv/tools/calibre_client/lib/64:${LD_LIBRARY_PATH}
