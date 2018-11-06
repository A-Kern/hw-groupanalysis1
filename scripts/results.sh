3dmask_tool \
-input subjects/*-retest.results/mask_group+tlrc.HEAD \
-frac 1.0 \
-prefix group_results/mask

3dttest++ -mask group_results/mask+tlrc \
-prefix group_results/foot-lips \
-setA 'subjects/*-retest.results/stats.*-retest+tlrc.HEAD[foot-lips_GLT#0_Coef]'

3dClustSim \
-mask group_results/mask+tlrc \
-acf `scripts/average_blur.py subjects/*-retest.results/blur.errts.1D` \
-both -pthr .05 .01 .001 \
-athr .1 .05 .025 .01 \
-iter 2000 \
-prefix group_results/cluster \
-cmd group_results/refit.cmd 

`cat group_results/refit.cmd` \
group_results/foot-lips+tlrc 

cd group_results

3dcalc -a foot-lips+tlrc \
-b mask+tlrc \
-expr 'a*b' \
-prefix foot-lips_masked

3dmerge -1zscore -prefix foot-lips_zstat \
'foot-lips_masked+tlrc[1]'

3dAttribute AFNI_CLUSTERSIM_NN3_1sided \
foot-lips+tlrc

3dclust -1Dformat -nosum \
-prefix foot-lips_clusters \
-savemask foot-lips_cluster_mask \
-inmask -1noneg \
-1clip 3 \
-dxyz=1 \
1.74 17 \
foot-lips_zstat+tlrc > results.txt
