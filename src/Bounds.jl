include("Types.jl")
using GLPK
# ----------------------------------------------------------------------------------- #
# Copyright (c) 2016 Varnerlab
# School of Chemical Engineering Purdue University
# W. Lafayette IN 46907 USA

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
# ----------------------------------------------------------------------------------- #

# Species vector -
# 1	M_pep_c
# 2	M_glc_D_c
# 3	M_g6p_c
# 4	M_pyr_c
# 5	M_atp_c
# 6	M_adp_c
# 7	M_h_c
# 8	M_utp_c
# 9	M_udp_c
# 10	M_ctp_c
# 11	M_cdp_c
# 12	M_gtp_c
# 13	M_gdp_c
# 14	M_f6p_c
# 15	M_fdp_c
# 16	M_h2o_c
# 17	M_pi_c
# 18	M_dhap_c
# 19	M_g3p_c
# 20	M_nad_c
# 21	M_13dpg_c
# 22	M_nadh_c
# 23	M_3pg_c
# 24	M_2pg_c
# 25	M_oaa_c
# 26	M_co2_c
# 27	M_coa_c
# 28	M_accoa_c
# 29	M_amp_c
# 30	M_nadp_c
# 31	M_6pgl_c
# 32	M_nadph_c
# 33	M_6pgc_c
# 34	M_ru5p_D_c
# 35	M_xu5p_D_c
# 36	M_r5p_c
# 37	M_s7p_c
# 38	M_e4p_c
# 39	M_2ddg6p_c
# 40	M_cit_c
# 41	M_icit_c
# 42	M_akg_c
# 43	M_succoa_c
# 44	M_succ_c
# 45	M_q8_c
# 46	M_fum_c
# 47	M_q8h2_c
# 48	M_mql8_c
# 49	M_mqn8_c
# 50	M_mal_L_c
# 51	M_glx_c
# 52	M_actp_c
# 53	M_ac_c
# 54	M_ppi_c
# 55	M_etoh_c
# 56	M_lac_D_c
# 57	M_for_c
# 58	M_o2_c
# 59	M_h_e
# 60	M_chor_c
# 61	M_gln_L_c
# 62	M_gly_L_c
# 63	M_gar_c
# 64	M_glu_L_c
# 65	M_10fthf_c
# 66	M_air_c
# 67	M_thf_c
# 68	M_asp_L_c
# 69	M_hco3_c
# 70	M_aicar_c
# 71	M_imp_c
# 72	M_methf_c
# 73	M_mlthf_c
# 74	M_5mthf_c
# 75	M_gmp_c
# 76	M_ump_c
# 77	M_cmp_c
# 78	M_ala_L_c
# 79	M_arg_L_c
# 80	M_asn_L_c
# 81	M_nh4_c
# 82	M_ser_L_c
# 83	M_h2s_c
# 84	M_cys_L_c
# 85	M_his_L_c
# 86	M_thr_L_c
# 87	M_ile_L_c
# 88	M_leu_L_c
# 89	M_lys_L_c
# 90	M_met_L_c
# 91	M_phe_L_c
# 92	M_pro_L_c
# 93	M_trp_L_c
# 94	M_tyr_L_c
# 95	M_val_L_c
# 96	GENE
# 97	RNAP
# 98	OPEN_GENE
# 99	mRNA
# 100	RIBOSOME
# 101	RIBOSOME_START
# 102	M_ala_L_c_tRNA
# 103	M_arg_L_c_tRNA
# 104	M_asn_L_c_tRNA
# 105	M_asp_L_c_tRNA
# 106	M_cys_L_c_tRNA
# 107	M_glu_L_c_tRNA
# 108	M_gln_L_c_tRNA
# 109	M_gly_L_c_tRNA
# 110	M_his_L_c_tRNA
# 111	M_ile_L_c_tRNA
# 112	M_leu_L_c_tRNA
# 113	M_lys_L_c_tRNA
# 114	M_met_L_c_tRNA
# 115	M_phe_L_c_tRNA
# 116	M_pro_L_c_tRNA
# 117	M_ser_L_c_tRNA
# 118	M_thr_L_c_tRNA
# 119	M_trp_L_c_tRNA
# 120	M_tyr_L_c_tRNA
# 121	M_val_L_c_tRNA
# 122	PROTEIN
# 123	tRNA
# 124	M_succ_D_c

# Reaction model vector -
# 1	R_PTS	 => 	R_PTS: M_pep_c+M_glc_D_c -([])-> M_g6p_c+M_pyr_c
# 2	R_glk_atp	 => 	R_glk_atp: M_atp_c+M_glc_D_c -([])-> M_adp_c+M_g6p_c+M_h_c
# 3	R_glk_utp	 => 	R_glk_utp: M_utp_c+M_glc_D_c -([])-> M_udp_c+M_g6p_c+M_h_c
# 4	R_glk_ctp	 => 	R_glk_ctp: M_ctp_c+M_glc_D_c -([])-> M_cdp_c+M_g6p_c+M_h_c
# 5	R_glk_gtp	 => 	R_glk_gtp: M_gtp_c+M_glc_D_c -([])-> M_gdp_c+M_g6p_c+M_h_c
# 6	R_pgi	 => 	R_pgi: M_g6p_c -([])-> M_f6p_c
# 7	R_pgi_reverse	 => 	-1*(R_pgi: M_g6p_c -([])-> M_f6p_c)
# 8	R_pfk	 => 	R_pfk: M_atp_c+M_f6p_c -([])-> M_adp_c+M_fdp_c+M_h_c
# 9	R_fdp	 => 	R_fdp: M_fdp_c+M_h2o_c -([])-> M_f6p_c+M_pi_c
# 10	R_fbaA	 => 	R_fbaA: M_fdp_c -([])-> M_dhap_c+M_g3p_c
# 11	R_fbaA_reverse	 => 	-1*(R_fbaA: M_fdp_c -([])-> M_dhap_c+M_g3p_c)
# 12	R_tpiA	 => 	R_tpiA: M_dhap_c -([])-> M_g3p_c
# 13	R_tpiA_reverse	 => 	-1*(R_tpiA: M_dhap_c -([])-> M_g3p_c)
# 14	R_gapA	 => 	R_gapA: M_g3p_c+M_nad_c+M_pi_c -([])-> M_13dpg_c+M_h_c+M_nadh_c
# 15	R_gapA_reverse	 => 	-1*(R_gapA: M_g3p_c+M_nad_c+M_pi_c -([])-> M_13dpg_c+M_h_c+M_nadh_c)
# 16	R_pgk	 => 	R_pgk: M_13dpg_c+M_adp_c -([])-> M_3pg_c+M_atp_c
# 17	R_pgk_reverse	 => 	-1*(R_pgk: M_13dpg_c+M_adp_c -([])-> M_3pg_c+M_atp_c)
# 18	R_gpm	 => 	R_gpm: M_3pg_c -([])-> M_2pg_c
# 19	R_gpm_reverse	 => 	-1*(R_gpm: M_3pg_c -([])-> M_2pg_c)
# 20	R_eno	 => 	R_eno: M_2pg_c -([])-> M_h2o_c+M_pep_c
# 21	R_eno_reverse	 => 	-1*(R_eno: M_2pg_c -([])-> M_h2o_c+M_pep_c)
# 22	R_pyk	 => 	R_pyk: M_adp_c+M_h_c+M_pep_c -([])-> M_atp_c+M_pyr_c
# 23	R_pck	 => 	R_pck: M_atp_c+M_oaa_c -([])-> M_adp_c+M_co2_c+M_pep_c
# 24	R_ppc	 => 	R_ppc: M_co2_c+M_h2o_c+M_pep_c -([])-> M_h_c+M_oaa_c+M_pi_c
# 25	R_pdh	 => 	R_pdh: M_coa_c+M_nad_c+M_pyr_c -([])-> M_accoa_c+M_co2_c+M_nadh_c
# 26	R_pps	 => 	R_pps: M_atp_c+M_h2o_c+M_pyr_c -([])-> M_amp_c+2*M_h_c+M_pep_c+M_pi_c
# 27	R_zwf	 => 	R_zwf: M_g6p_c+M_nadp_c -([])-> M_6pgl_c+M_h_c+M_nadph_c
# 28	R_zwf_reverse	 => 	-1*(R_zwf: M_g6p_c+M_nadp_c -([])-> M_6pgl_c+M_h_c+M_nadph_c)
# 29	R_pgl	 => 	R_pgl: M_6pgl_c+M_h2o_c -([])-> M_6pgc_c+M_h_c
# 30	R_gnd	 => 	R_gnd: M_6pgc_c+M_nadp_c -([])-> M_co2_c+M_nadph_c+M_ru5p_D_c
# 31	R_rpe	 => 	R_rpe: M_ru5p_D_c -([])-> M_xu5p_D_c
# 32	R_rpe_reverse	 => 	-1*(R_rpe: M_ru5p_D_c -([])-> M_xu5p_D_c)
# 33	R_rpi	 => 	R_rpi: M_r5p_c -([])-> M_ru5p_D_c
# 34	R_rpi_reverse	 => 	-1*(R_rpi: M_r5p_c -([])-> M_ru5p_D_c)
# 35	R_talAB	 => 	R_talAB: M_g3p_c+M_s7p_c -([])-> M_e4p_c+M_f6p_c
# 36	R_talAB_reverse	 => 	-1*(R_talAB: M_g3p_c+M_s7p_c -([])-> M_e4p_c+M_f6p_c)
# 37	R_tkt1	 => 	R_tkt1: M_r5p_c+M_xu5p_D_c -([])-> M_g3p_c+M_s7p_c
# 38	R_tkt1_reverse	 => 	-1*(R_tkt1: M_r5p_c+M_xu5p_D_c -([])-> M_g3p_c+M_s7p_c)
# 39	R_tkt2	 => 	R_tkt2: M_e4p_c+M_xu5p_D_c -([])-> M_f6p_c+M_g3p_c
# 40	R_tkt2_reverse	 => 	-1*(R_tkt2: M_e4p_c+M_xu5p_D_c -([])-> M_f6p_c+M_g3p_c)
# 41	R_edd	 => 	R_edd: M_6pgc_c -([])-> M_2ddg6p_c+M_h2o_c
# 42	R_eda	 => 	R_eda: M_2ddg6p_c -([])-> M_g3p_c+M_pyr_c
# 43	R_gltA	 => 	R_gltA: M_accoa_c+M_h2o_c+M_oaa_c -([])-> M_cit_c+M_coa_c+M_h_c
# 44	R_acn	 => 	R_acn: M_cit_c -([])-> M_icit_c
# 45	R_acn_reverse	 => 	-1*(R_acn: M_cit_c -([])-> M_icit_c)
# 46	R_icd	 => 	R_icd: M_icit_c+M_nadp_c -([])-> M_akg_c+M_co2_c+M_nadph_c
# 47	R_icd_reverse	 => 	-1*(R_icd: M_icit_c+M_nadp_c -([])-> M_akg_c+M_co2_c+M_nadph_c)
# 48	R_sucAB	 => 	R_sucAB: M_akg_c+M_coa_c+M_nad_c -([])-> M_co2_c+M_nadh_c+M_succoa_c
# 49	R_sucCD	 => 	R_sucCD: M_atp_c+M_coa_c+M_succ_c -([])-> M_adp_c+M_pi_c+M_succoa_c
# 50	R_sucCD_reverse	 => 	-1*(R_sucCD: M_atp_c+M_coa_c+M_succ_c -([])-> M_adp_c+M_pi_c+M_succoa_c)
# 51	R_sdh	 => 	R_sdh: M_q8_c+M_succ_c -([])-> M_fum_c+M_q8h2_c
# 52	R_frd	 => 	R_frd: M_fum_c+M_mql8_c -([])-> M_mqn8_c+M_succ_c
# 53	R_fum	 => 	R_fum: M_fum_c+M_h2o_c -([])-> M_mal_L_c
# 54	R_fum_reverse	 => 	-1*(R_fum: M_fum_c+M_h2o_c -([])-> M_mal_L_c)
# 55	R_mdh	 => 	R_mdh: M_mal_L_c+M_nad_c -([])-> M_oaa_c+M_h_c+M_nadh_c
# 56	R_mdh_reverse	 => 	-1*(R_mdh: M_mal_L_c+M_nad_c -([])-> M_oaa_c+M_h_c+M_nadh_c)
# 57	R_aceA	 => 	R_aceA: M_icit_c -([])-> M_glx_c+M_succ_c
# 58	R_aceB	 => 	R_aceB: M_accoa_c+M_glx_c+M_h2o_c -([])-> M_coa_c+M_h_c+M_mal_L_c
# 59	R_maeA	 => 	R_maeA: M_mal_L_c+M_nad_c -([])-> M_co2_c+M_nadh_c+M_pyr_c
# 60	R_maeB	 => 	R_maeB: M_mal_L_c+M_nadp_c -([])-> M_co2_c+M_nadph_c+M_pyr_c
# 61	R_pta	 => 	R_pta: M_accoa_c+M_pi_c -([])-> M_actp_c+M_coa_c
# 62	R_pta_reverse	 => 	-1*(R_pta: M_accoa_c+M_pi_c -([])-> M_actp_c+M_coa_c)
# 63	R_ackA	 => 	R_ackA: M_actp_c+M_adp_c -([])-> M_ac_c+M_atp_c
# 64	R_ackA_reverse	 => 	-1*(R_ackA: M_actp_c+M_adp_c -([])-> M_ac_c+M_atp_c)
# 65	R_acs	 => 	R_acs: M_ac_c+M_atp_c+M_coa_c -([])-> M_accoa_c+M_amp_c+M_ppi_c
# 66	R_adhE	 => 	R_adhE: M_accoa_c+2*M_h_c+2*M_nadh_c -([])-> M_coa_c+M_etoh_c+2*M_nad_c
# 67	R_adhE_reverse	 => 	-1*(R_adhE: M_accoa_c+2*M_h_c+2*M_nadh_c -([])-> M_coa_c+M_etoh_c+2*M_nad_c)
# 68	R_ldh_f	 => 	R_ldh_f: M_pyr_c+M_nadh_c+M_h_c -([])-> M_lac_D_c+M_nad_c
# 69	R_ldh_r	 => 	R_ldh_r: M_lac_D_c+M_nad_c -([])-> M_pyr_c+M_nadh_c+M_h_c
# 70	R_pflAB	 => 	R_pflAB: M_coa_c+M_pyr_c -([])-> M_accoa_c+M_for_c
# 71	R_cyd	 => 	R_cyd: 2*M_h_c+0.5*M_o2_c+M_q8h2_c -([])-> M_h2o_c+M_q8_c+2*M_h_e
# 72	R_app	 => 	R_app: 2*M_h_c+M_mql8_c+0.5*M_o2_c -([])-> M_h2o_c+M_mqn8_c+2*M_h_e
# 73	R_atp	 => 	R_atp: M_adp_c+M_pi_c+4*M_h_e -([])-> M_atp_c+3*M_h_c+M_h2o_c
# 74	R_nuo	 => 	R_nuo: 3*M_h_c+M_nadh_c+M_q8_c -([])-> M_nad_c+M_q8h2_c+2*M_h_e
# 75	R_pnt1	 => 	R_pnt1: M_nad_c+M_nadph_c -([])-> M_nadh_c+M_nadp_c
# 76	R_pnt2	 => 	R_pnt2: M_nadh_c+M_nadp_c+2*M_h_e -([])-> 2*M_h_c+M_nad_c+M_nadph_c
# 77	R_ndh1	 => 	R_ndh1: M_h_c+M_nadh_c+M_q8_c -([])-> M_nad_c+M_q8h2_c
# 78	R_ndh2	 => 	R_ndh2: M_h_c+M_mqn8_c+M_nadh_c -([])-> M_mql8_c+M_nad_c
# 79	R_hack1	 => 	R_hack1: M_atp_c+M_h2o_c -([])-> M_adp_c+M_h_c+M_pi_c
# 80	R_ppk	 => 	R_ppk: M_atp_c+M_pi_c -([])-> M_adp_c+M_ppi_c
# 81	R_ppa	 => 	R_ppa: M_ppi_c+M_h2o_c -([])-> 2*M_pi_c+M_h_c
# 82	R_chor	 => 	R_chor: M_e4p_c+2*M_pep_c+M_nadph_c+M_atp_c -([])-> M_chor_c+M_nadp_c+M_adp_c+4*M_pi_c
# 83	R_gar	 => 	R_gar: M_r5p_c+M_gln_L_c+M_gly_L_c+2*M_atp_c+M_h2o_c -([])-> M_gar_c+M_glu_L_c+M_adp_c+M_amp_c+M_pi_c+M_ppi_c+7*M_h_c
# 84	R_air	 => 	R_air: M_gar_c+M_10fthf_c+M_gln_L_c+2*M_atp_c+M_h2o_c -([])-> M_air_c+M_thf_c+M_glu_L_c+2*M_adp_c+2*M_pi_c+3*M_h_c
# 85	R_aicar	 => 	R_aicar: M_air_c+M_asp_L_c+2*M_atp_c+M_hco3_c -([])-> M_aicar_c+M_fum_c+2*M_adp_c+2*M_h_c+2*M_pi_c
# 86	R_imp	 => 	R_imp: M_aicar_c+M_10fthf_c -([])-> M_imp_c+M_thf_c+M_h2o_c
# 87	R_mthfc	 => 	R_mthfc: M_h2o_c+M_methf_c -([])-> M_10fthf_c
# 88	R_mthfc_reverse	 => 	-1*(R_mthfc: M_h2o_c+M_methf_c -([])-> M_10fthf_c)
# 89	R_mthfd	 => 	R_mthfd: M_mlthf_c+M_nadp_c -([])-> M_h_c+M_methf_c+M_nadph_c
# 90	R_mthfd_reverse	 => 	-1*(R_mthfd: M_mlthf_c+M_nadp_c -([])-> M_h_c+M_methf_c+M_nadph_c)
# 91	R_mthfr2	 => 	R_mthfr2: M_mlthf_c+M_h_c+M_nadh_c -([])-> M_5mthf_c+M_nad_c
# 92	R_gmp	 => 	R_gmp: M_imp_c+M_atp_c+M_gln_L_c+M_nad_c+2*M_h2o_c -([])-> M_gmp_c+M_amp_c+M_glu_L_c+M_nadh_c+3*M_h_c+M_ppi_c
# 93	R_gdp	 => 	R_gdp: M_gmp_c+M_atp_c -([])-> M_gdp_c+M_adp_c
# 94	R_gtp	 => 	R_gtp: M_gdp_c+M_atp_c -([])-> M_gtp_c+M_adp_c
# 95	R_amp	 => 	R_amp: M_asp_L_c+M_imp_c+M_gtp_c -([])-> M_amp_c+M_gdp_c+M_pi_c+2*M_h_c+M_fum_c
# 96	R_adk	 => 	R_adk: M_amp_c+M_atp_c -([])-> 2*M_adp_c
# 97	R_adk_reverse	 => 	-1*(R_adk: M_amp_c+M_atp_c -([])-> 2*M_adp_c)
# 98	R_ump	 => 	R_ump: M_gln_L_c+M_asp_L_c+M_r5p_c+M_q8_c+3*M_atp_c+M_hco3_c -([])-> M_ump_c+M_glu_L_c+M_q8h2_c+2*M_h_c+2*M_adp_c+M_amp_c+2*M_pi_c+M_ppi_c+M_co2_c
# 99	R_udp	 => 	R_udp: M_ump_c+M_atp_c -([])-> M_udp_c+M_adp_c
# 100	R_utp	 => 	R_utp: M_udp_c+M_atp_c -([])-> M_utp_c+M_adp_c
# 101	R_ctp	 => 	R_ctp: M_utp_c+M_gln_L_c+M_atp_c+M_h2o_c -([])-> M_ctp_c+M_glu_L_c+M_adp_c+M_pi_c+3*M_h_c
# 102	R_cdp	 => 	R_cdp: M_ctp_c+M_h2o_c -([])-> M_cdp_c+M_pi_c+M_h_c
# 103	R_cmp	 => 	R_cmp: M_cdp_c+M_h2o_c -([])-> M_cmp_c+M_pi_c+M_h_c
# 104	R_alaAC	 => 	R_alaAC: M_pyr_c+M_glu_L_c -([])-> M_ala_L_c+M_akg_c
# 105	R_arg	 => 	R_arg: M_glu_L_c+M_accoa_c+4*M_atp_c+M_nadph_c+3*M_h2o_c+M_gln_L_c+M_asp_L_c+M_co2_c -([])-> M_arg_L_c+M_coa_c+5*M_h_c+3*M_adp_c+3*M_pi_c+M_nadp_c+M_akg_c+M_ac_c+M_amp_c+M_ppi_c+M_fum_c
# 106	R_aspC	 => 	R_aspC: M_glu_L_c+M_oaa_c -([])-> M_asp_L_c+M_akg_c
# 107	R_asnB	 => 	R_asnB: M_asp_L_c+M_gln_L_c+M_h2o_c+M_atp_c -([])-> M_asn_L_c+M_glu_L_c+M_h_c+M_ppi_c+M_amp_c
# 108	R_asnA	 => 	R_asnA: M_asp_L_c+M_atp_c+M_nh4_c -([])-> M_asn_L_c+M_h_c+M_ppi_c+M_amp_c
# 109	R_cysEMK	 => 	R_cysEMK: M_ser_L_c+M_accoa_c+M_h2s_c -([])-> M_cys_L_c+M_coa_c+M_h_c+M_ac_c
# 110	R_gltBD	 => 	R_gltBD: M_gln_L_c+M_akg_c+M_nadph_c+M_h_c -([])-> 2*M_glu_L_c+M_nadp_c
# 111	R_gdhA	 => 	R_gdhA: M_akg_c+M_nadph_c+M_nh4_c+M_h_c -([])-> M_glu_L_c+M_h2o_c+M_nadp_c
# 112	R_glnA	 => 	R_glnA: M_glu_L_c+M_atp_c+M_nh4_c -([])-> M_gln_L_c+M_h_c+M_adp_c+M_pi_c
# 113	R_glyA	 => 	R_glyA: M_ser_L_c+M_thf_c -([])-> M_gly_L_c+M_h2o_c+M_mlthf_c
# 114	R_his	 => 	R_his: M_gln_L_c+M_r5p_c+3*M_atp_c+2*M_nad_c+3*M_h2o_c -([])-> M_his_L_c+M_akg_c+M_aicar_c+2*M_adp_c+2*M_nadh_c+M_pi_c+2*M_ppi_c+6*M_h_c
# 115	R_ile	 => 	R_ile: M_thr_L_c+2*M_h_c+M_pyr_c+M_nadph_c+M_glu_L_c -([])-> M_ile_L_c+M_h2o_c+M_nh4_c+M_co2_c+M_nadp_c+M_akg_c
# 116	R_leu	 => 	R_leu: 2*M_pyr_c+M_glu_L_c+M_h_c+M_nad_c+M_nadph_c+M_accoa_c -([])-> M_leu_L_c+2*M_co2_c+M_nadp_c+M_coa_c+M_nadh_c+M_akg_c
# 117	R_lys	 => 	R_lys: M_asp_L_c+M_atp_c+2*M_nadph_c+2*M_h_c+M_pyr_c+M_succoa_c+M_glu_L_c -([])-> M_lys_L_c+M_adp_c+M_pi_c+2*M_nadp_c+M_coa_c+M_akg_c+M_succ_c+M_co2_c
# 118	R_met	 => 	R_met: M_asp_L_c+M_cys_L_c+M_succoa_c+M_atp_c+2*M_nadph_c+M_5mthf_c -([])-> M_met_L_c+M_coa_c+M_succ_c+M_adp_c+M_pi_c+2*M_nadp_c+M_thf_c+M_nh4_c+M_pyr_c
# 119	R_phe	 => 	R_phe: M_chor_c+M_h_c+M_glu_L_c -([])-> M_phe_L_c+M_co2_c+M_h2o_c+M_akg_c
# 120	R_pro	 => 	R_pro: M_glu_L_c+M_atp_c+2*M_h_c+2*M_nadph_c -([])-> M_pro_L_c+M_adp_c+2*M_nadp_c+M_pi_c+M_h2o_c
# 121	R_serABC	 => 	R_serABC: M_3pg_c+M_nad_c+M_glu_L_c+M_h2o_c -([])-> M_ser_L_c+M_nadh_c+M_h_c+M_akg_c+M_pi_c
# 122	R_thr	 => 	R_thr: M_asp_L_c+2*M_atp_c+2*M_nadph_c+M_h_c+M_h2o_c -([])-> M_thr_L_c+2*M_adp_c+2*M_pi_c+2*M_nadp_c
# 123	R_trp	 => 	R_trp: M_chor_c+M_gln_L_c+M_ser_L_c+M_r5p_c+2*M_atp_c -([])-> M_trp_L_c+M_glu_L_c+M_pyr_c+M_ppi_c+2*M_h2o_c+M_co2_c+M_g3p_c+2*M_adp_c+M_h_c
# 124	R_tyr	 => 	R_tyr: M_chor_c+M_glu_L_c+M_nad_c -([])-> M_tyr_L_c+M_akg_c+M_nadh_c+M_co2_c
# 125	R_val	 => 	R_val: 2*M_pyr_c+2*M_h_c+M_nadph_c+M_glu_L_c -([])-> M_val_L_c+M_co2_c+M_nadp_c+M_h2o_c+M_akg_c
# 126	R_amp_ppi	 => 	R_amp_ppi: M_amp_c+M_ppi_c+4*M_h_c -([])-> M_atp_c+M_h2o_c
# 127	R_amp_pi	 => 	R_amp_pi: M_amp_c+2*M_pi_c+6*M_h_c -([])-> M_atp_c+2*M_h2o_c
# 128	R_gmp_ppi	 => 	R_gmp_ppi: M_gmp_c+M_ppi_c+4*M_h_c -([])-> M_gtp_c+M_h2o_c
# 129	R_gmp_pi	 => 	R_gmp_pi: M_gmp_c+2*M_pi_c+6*M_h_c -([])-> M_gtp_c+2*M_h2o_c
# 130	R_cmp_ppi	 => 	R_cmp_ppi: M_cmp_c+M_ppi_c+4*M_h_c -([])-> M_ctp_c+M_h2o_c
# 131	R_cmp_pi	 => 	R_cmp_pi: M_cmp_c+2*M_pi_c+6*M_h_c -([])-> M_ctp_c+2*M_h2o_c
# 132	R_ump_ppi	 => 	R_ump_ppi: M_ump_c+M_ppi_c+4*M_h_c -([])-> M_utp_c+M_h2o_c
# 133	R_ump_pi	 => 	R_ump_pi: M_ump_c+2*M_pi_c+6*M_h_c -([])-> M_utp_c+2*M_h2o_c
# 134	transcriptional_initiation	 => 	transcriptional_initiation: GENE+RNAP -([])-> OPEN_GENE
# 135	transcription	 => 	transcription: OPEN_GENE+144*M_ctp_c+151*M_gtp_c+189*M_utp_c+176*M_atp_c -([])-> mRNA+GENE+RNAP+1320*M_pi_c
# 136	translation_initiation	 => 	translation_initiation: mRNA+RIBOSOME -([])-> RIBOSOME_START
# 137	translation	 => 	translation: RIBOSOME_START+438*M_gtp_c+15.0*M_ala_L_c_tRNA+5.0*M_arg_L_c_tRNA+10.0*M_asn_L_c_tRNA+12.0*M_asp_L_c_tRNA+5.0*M_cys_L_c_tRNA+12.0*M_glu_L_c_tRNA+13.0*M_gln_L_c_tRNA+10.0*M_gly_L_c_tRNA+12.0*M_his_L_c_tRNA+9.0*M_ile_L_c_tRNA+13.0*M_leu_L_c_tRNA+12.0*M_lys_L_c_tRNA+9.0*M_met_L_c_tRNA+20.0*M_phe_L_c_tRNA+7.0*M_pro_L_c_tRNA+10.0*M_ser_L_c_tRNA+13.0*M_thr_L_c_tRNA+5.0*M_trp_L_c_tRNA+11.0*M_tyr_L_c_tRNA+16.0*M_val_L_c_tRNA -([])-> RIBOSOME+mRNA+PROTEIN+438*M_gdp_c+438*M_pi_c+219*tRNA
# 138	tRNA_charging_M_ala_L_c	 => 	tRNA_charging_M_ala_L_c: 15.0*M_ala_L_c+15.0*M_atp_c+15.0*tRNA -([])-> 15.0*M_ala_L_c_tRNA+15.0*M_amp_c+30.0*M_pi_c
# 139	tRNA_charging_M_arg_L_c	 => 	tRNA_charging_M_arg_L_c: 5.0*M_arg_L_c+5.0*M_atp_c+5.0*tRNA -([])-> 5.0*M_arg_L_c_tRNA+5.0*M_amp_c+10.0*M_pi_c
# 140	tRNA_charging_M_asn_L_c	 => 	tRNA_charging_M_asn_L_c: 10.0*M_asn_L_c+10.0*M_atp_c+10.0*tRNA -([])-> 10.0*M_asn_L_c_tRNA+10.0*M_amp_c+20.0*M_pi_c
# 141	tRNA_charging_M_asp_L_c	 => 	tRNA_charging_M_asp_L_c: 12.0*M_asp_L_c+12.0*M_atp_c+12.0*tRNA -([])-> 12.0*M_asp_L_c_tRNA+12.0*M_amp_c+24.0*M_pi_c
# 142	tRNA_charging_M_cys_L_c	 => 	tRNA_charging_M_cys_L_c: 5.0*M_cys_L_c+5.0*M_atp_c+5.0*tRNA -([])-> 5.0*M_cys_L_c_tRNA+5.0*M_amp_c+10.0*M_pi_c
# 143	tRNA_charging_M_glu_L_c	 => 	tRNA_charging_M_glu_L_c: 12.0*M_glu_L_c+12.0*M_atp_c+12.0*tRNA -([])-> 12.0*M_glu_L_c_tRNA+12.0*M_amp_c+24.0*M_pi_c
# 144	tRNA_charging_M_gln_L_c	 => 	tRNA_charging_M_gln_L_c: 13.0*M_gln_L_c+13.0*M_atp_c+13.0*tRNA -([])-> 13.0*M_gln_L_c_tRNA+13.0*M_amp_c+26.0*M_pi_c
# 145	tRNA_charging_M_gly_L_c	 => 	tRNA_charging_M_gly_L_c: 10.0*M_gly_L_c+10.0*M_atp_c+10.0*tRNA -([])-> 10.0*M_gly_L_c_tRNA+10.0*M_amp_c+20.0*M_pi_c
# 146	tRNA_charging_M_his_L_c	 => 	tRNA_charging_M_his_L_c: 12.0*M_his_L_c+12.0*M_atp_c+12.0*tRNA -([])-> 12.0*M_his_L_c_tRNA+12.0*M_amp_c+24.0*M_pi_c
# 147	tRNA_charging_M_ile_L_c	 => 	tRNA_charging_M_ile_L_c: 9.0*M_ile_L_c+9.0*M_atp_c+9.0*tRNA -([])-> 9.0*M_ile_L_c_tRNA+9.0*M_amp_c+18.0*M_pi_c
# 148	tRNA_charging_M_leu_L_c	 => 	tRNA_charging_M_leu_L_c: 13.0*M_leu_L_c+13.0*M_atp_c+13.0*tRNA -([])-> 13.0*M_leu_L_c_tRNA+13.0*M_amp_c+26.0*M_pi_c
# 149	tRNA_charging_M_lys_L_c	 => 	tRNA_charging_M_lys_L_c: 12.0*M_lys_L_c+12.0*M_atp_c+12.0*tRNA -([])-> 12.0*M_lys_L_c_tRNA+12.0*M_amp_c+24.0*M_pi_c
# 150	tRNA_charging_M_met_L_c	 => 	tRNA_charging_M_met_L_c: 9.0*M_met_L_c+9.0*M_atp_c+9.0*tRNA -([])-> 9.0*M_met_L_c_tRNA+9.0*M_amp_c+18.0*M_pi_c
# 151	tRNA_charging_M_phe_L_c	 => 	tRNA_charging_M_phe_L_c: 20.0*M_phe_L_c+20.0*M_atp_c+20.0*tRNA -([])-> 20.0*M_phe_L_c_tRNA+20.0*M_amp_c+40.0*M_pi_c
# 152	tRNA_charging_M_pro_L_c	 => 	tRNA_charging_M_pro_L_c: 7.0*M_pro_L_c+7.0*M_atp_c+7.0*tRNA -([])-> 7.0*M_pro_L_c_tRNA+7.0*M_amp_c+14.0*M_pi_c
# 153	tRNA_charging_M_ser_L_c	 => 	tRNA_charging_M_ser_L_c: 10.0*M_ser_L_c+10.0*M_atp_c+10.0*tRNA -([])-> 10.0*M_ser_L_c_tRNA+10.0*M_amp_c+20.0*M_pi_c
# 154	tRNA_charging_M_thr_L_c	 => 	tRNA_charging_M_thr_L_c: 13.0*M_thr_L_c+13.0*M_atp_c+13.0*tRNA -([])-> 13.0*M_thr_L_c_tRNA+13.0*M_amp_c+26.0*M_pi_c
# 155	tRNA_charging_M_trp_L_c	 => 	tRNA_charging_M_trp_L_c: 5.0*M_trp_L_c+5.0*M_atp_c+5.0*tRNA -([])-> 5.0*M_trp_L_c_tRNA+5.0*M_amp_c+10.0*M_pi_c
# 156	tRNA_charging_M_tyr_L_c	 => 	tRNA_charging_M_tyr_L_c: 11.0*M_tyr_L_c+11.0*M_atp_c+11.0*tRNA -([])-> 11.0*M_tyr_L_c_tRNA+11.0*M_amp_c+22.0*M_pi_c
# 157	tRNA_charging_M_val_L_c	 => 	tRNA_charging_M_val_L_c: 16.0*M_val_L_c+16.0*M_atp_c+16.0*tRNA -([])-> 16.0*M_val_L_c_tRNA+16.0*M_amp_c+32.0*M_pi_c
# 158	mRNA_decay	 => 	mRNA_decay: mRNA -([])-> 144*M_cmp_c+151*M_gmp_c+189*M_ump_c+176*M_amp_c
# 159	tNRA_exchange	 => 	tNRA_exchange: tRNA -([])-> []
# 160	tNRA_exchange_reverse	 => 	-1*(tNRA_exchange: tRNA -([])-> [])
# 161	PROTEIN_export	 => 	PROTEIN_export: PROTEIN -([])-> []
# 162	M_ala_L_c_exchange	 => 	M_ala_L_c_exchange: M_ala_L_c -([])-> []
# 163	M_ala_L_c_exchange_reverse	 => 	-1*(M_ala_L_c_exchange: M_ala_L_c -([])-> [])
# 164	M_arg_L_c_exchange	 => 	M_arg_L_c_exchange: M_arg_L_c -([])-> []
# 165	M_arg_L_c_exchange_reverse	 => 	-1*(M_arg_L_c_exchange: M_arg_L_c -([])-> [])
# 166	M_asn_L_c_exchange	 => 	M_asn_L_c_exchange: M_asn_L_c -([])-> []
# 167	M_asn_L_c_exchange_reverse	 => 	-1*(M_asn_L_c_exchange: M_asn_L_c -([])-> [])
# 168	M_asp_L_c_exchange	 => 	M_asp_L_c_exchange: M_asp_L_c -([])-> []
# 169	M_asp_L_c_exchange_reverse	 => 	-1*(M_asp_L_c_exchange: M_asp_L_c -([])-> [])
# 170	M_cys_L_c_exchange	 => 	M_cys_L_c_exchange: M_cys_L_c -([])-> []
# 171	M_cys_L_c_exchange_reverse	 => 	-1*(M_cys_L_c_exchange: M_cys_L_c -([])-> [])
# 172	M_glu_L_c_exchange	 => 	M_glu_L_c_exchange: M_glu_L_c -([])-> []
# 173	M_glu_L_c_exchange_reverse	 => 	-1*(M_glu_L_c_exchange: M_glu_L_c -([])-> [])
# 174	M_gln_L_c_exchange	 => 	M_gln_L_c_exchange: M_gln_L_c -([])-> []
# 175	M_gln_L_c_exchange_reverse	 => 	-1*(M_gln_L_c_exchange: M_gln_L_c -([])-> [])
# 176	M_gly_L_c_exchange	 => 	M_gly_L_c_exchange: M_gly_L_c -([])-> []
# 177	M_gly_L_c_exchange_reverse	 => 	-1*(M_gly_L_c_exchange: M_gly_L_c -([])-> [])
# 178	M_his_L_c_exchange	 => 	M_his_L_c_exchange: M_his_L_c -([])-> []
# 179	M_his_L_c_exchange_reverse	 => 	-1*(M_his_L_c_exchange: M_his_L_c -([])-> [])
# 180	M_ile_L_c_exchange	 => 	M_ile_L_c_exchange: M_ile_L_c -([])-> []
# 181	M_ile_L_c_exchange_reverse	 => 	-1*(M_ile_L_c_exchange: M_ile_L_c -([])-> [])
# 182	M_leu_L_c_exchange	 => 	M_leu_L_c_exchange: M_leu_L_c -([])-> []
# 183	M_leu_L_c_exchange_reverse	 => 	-1*(M_leu_L_c_exchange: M_leu_L_c -([])-> [])
# 184	M_lys_L_c_exchange	 => 	M_lys_L_c_exchange: M_lys_L_c -([])-> []
# 185	M_lys_L_c_exchange_reverse	 => 	-1*(M_lys_L_c_exchange: M_lys_L_c -([])-> [])
# 186	M_met_L_c_exchange	 => 	M_met_L_c_exchange: M_met_L_c -([])-> []
# 187	M_met_L_c_exchange_reverse	 => 	-1*(M_met_L_c_exchange: M_met_L_c -([])-> [])
# 188	M_phe_L_c_exchange	 => 	M_phe_L_c_exchange: M_phe_L_c -([])-> []
# 189	M_phe_L_c_exchange_reverse	 => 	-1*(M_phe_L_c_exchange: M_phe_L_c -([])-> [])
# 190	M_pro_L_c_exchange	 => 	M_pro_L_c_exchange: M_pro_L_c -([])-> []
# 191	M_pro_L_c_exchange_reverse	 => 	-1*(M_pro_L_c_exchange: M_pro_L_c -([])-> [])
# 192	M_ser_L_c_exchange	 => 	M_ser_L_c_exchange: M_ser_L_c -([])-> []
# 193	M_ser_L_c_exchange_reverse	 => 	-1*(M_ser_L_c_exchange: M_ser_L_c -([])-> [])
# 194	M_thr_L_c_exchange	 => 	M_thr_L_c_exchange: M_thr_L_c -([])-> []
# 195	M_thr_L_c_exchange_reverse	 => 	-1*(M_thr_L_c_exchange: M_thr_L_c -([])-> [])
# 196	M_trp_L_c_exchange	 => 	M_trp_L_c_exchange: M_trp_L_c -([])-> []
# 197	M_trp_L_c_exchange_reverse	 => 	-1*(M_trp_L_c_exchange: M_trp_L_c -([])-> [])
# 198	M_tyr_L_c_exchange	 => 	M_tyr_L_c_exchange: M_tyr_L_c -([])-> []
# 199	M_tyr_L_c_exchange_reverse	 => 	-1*(M_tyr_L_c_exchange: M_tyr_L_c -([])-> [])
# 200	M_val_L_c_exchange	 => 	M_val_L_c_exchange: M_val_L_c -([])-> []
# 201	M_val_L_c_exchange_reverse	 => 	-1*(M_val_L_c_exchange: M_val_L_c -([])-> [])
# 202	M_o2_c_exchange	 => 	M_o2_c_exchange: M_o2_c -([])-> []
# 203	M_o2_c_exchange_reverse	 => 	-1*(M_o2_c_exchange: M_o2_c -([])-> [])
# 204	M_co2_c_exchange	 => 	M_co2_c_exchange: M_co2_c -([])-> []
# 205	M_co2_c_exchange_reverse	 => 	-1*(M_co2_c_exchange: M_co2_c -([])-> [])
# 206	M_h2s_c_exchange	 => 	M_h2s_c_exchange: M_h2s_c -([])-> []
# 207	M_h2s_c_exchange_reverse	 => 	-1*(M_h2s_c_exchange: M_h2s_c -([])-> [])
# 208	M_h_c_exchange	 => 	M_h_c_exchange: M_h_c -([])-> []
# 209	M_h_c_exchange_reverse	 => 	-1*(M_h_c_exchange: M_h_c -([])-> [])
# 210	M_h2o_c_exchange	 => 	M_h2o_c_exchange: M_h2o_c -([])-> []
# 211	M_h2o_c_exchange_reverse	 => 	-1*(M_h2o_c_exchange: M_h2o_c -([])-> [])
# 212	M_h_e_exchange	 => 	M_h_e_exchange: M_h_e -([])-> M_h_c
# 213	M_h_e_exchange_reverse	 => 	-1*(M_h_e_exchange: M_h_e -([])-> M_h_c)
# 214	M_nh4_c_exchange	 => 	M_nh4_c_exchange: M_nh4_c -([])-> []
# 215	M_nh4_c_exchange_reverse	 => 	-1*(M_nh4_c_exchange: M_nh4_c -([])-> [])
# 216	M_hco3_c_exchange	 => 	M_hco3_c_exchange: M_hco3_c -([])-> []
# 217	M_hco3_c_exchange_reverse	 => 	-1*(M_hco3_c_exchange: M_hco3_c -([])-> [])
# 218	M_pi_c_exchange	 => 	M_pi_c_exchange: M_pi_c -([])-> []
# 219	M_pi_c_exchange_reverse	 => 	-1*(M_pi_c_exchange: M_pi_c -([])-> [])
# 220	M_glc_D_c_exchange	 => 	M_glc_D_c_exchange: M_glc_D_c -([])-> []
# 221	M_glc_D_c_exchange_reverse	 => 	-1*(M_glc_D_c_exchange: M_glc_D_c -([])-> [])
# 222	M_for_c_exchange	 => 	M_for_c_exchange: M_for_c -([])-> []
# 223	M_for_c_exchange_reverse	 => 	-1*(M_for_c_exchange: M_for_c -([])-> [])
# 224	M_lac_D_c_exchange	 => 	M_lac_D_c_exchange: M_lac_D_c -([])-> []
# 225	M_lac_D_c_exchange_reverse	 => 	-1*(M_lac_D_c_exchange: M_lac_D_c -([])-> [])
# 226	M_ac_c_exchange	 => 	M_ac_c_exchange: M_ac_c -([])-> []
# 227	M_ac_c_exchange_reverse	 => 	-1*(M_ac_c_exchange: M_ac_c -([])-> [])
# 228	M_etoh_c_exchange	 => 	M_etoh_c_exchange: M_etoh_c -([])-> []
# 229	M_etoh_c_exchange_reverse	 => 	-1*(M_etoh_c_exchange: M_etoh_c -([])-> [])
# 230	M_akg_c_exchange	 => 	M_akg_c_exchange: M_akg_c -([])-> []
# 231	M_akg_c_exchange_reverse	 => 	-1*(M_akg_c_exchange: M_akg_c -([])-> [])
# 232	M_fum_c_exchange	 => 	M_fum_c_exchange: M_fum_c -([])-> []
# 233	M_fum_c_exchange_reverse	 => 	-1*(M_fum_c_exchange: M_fum_c -([])-> [])
# 234	M_mal_L_c_exchange	 => 	M_mal_L_c_exchange: M_mal_L_c -([])-> []
# 235	M_mal_L_c_exchange_reverse	 => 	-1*(M_mal_L_c_exchange: M_mal_L_c -([])-> [])
# 236	M_pyr_c_exchange	 => 	M_pyr_c_exchange: M_pyr_c -([])-> []
# 237	M_pyr_c_exchange_reverse	 => 	-1*(M_pyr_c_exchange: M_pyr_c -([])-> [])
# 238	M_succ_D_c_exchange	 => 	M_succ_D_c_exchange: M_succ_D_c -([])-> []
# 239	M_succ_D_c_exchange_reverse	 => 	-1*(M_succ_D_c_exchange: M_succ_D_c -([])-> [])

function Bounds(flux_name::AbstractString, flux_model::FluxModel, species_abundance_array, control_variable::Float64)
# ----------------------------------------------------------------------------------- #
# Bounds.jl was generated using the Kwatee code generation system.
# Bounds: Updates the flux bounds for flux with key
# Username: jeffreyvarner
# Type: NFBA-JULIA
# Version: 1.0
# Generation timestamp: 03-03-2016 21:13:51
#
# Input arguments:
# flux_name  - name of the flux whose bounds we are checking
# flux_model - custom flux model
# control_variable - value of the control variable for this flux
# species_abundance_array - value of the system state at current time step
#
# Return arguments:
# lower_bound - value of the new lower bound
# upper_bound - value of the new upper bound
# constraint_type - value of the GLPK constraint type
# ----------------------------------------------------------------------------------- #

# Default is to pass the bounds and constraint type back -
lower_bound = flux_model.flux_lower_bound;
upper_bound = flux_model.flux_upper_bound;
constraint_type = flux_model.flux_constraint_type

# Set a default upper and lower_bound = correct specific flux bounds
lower_bound = 0.0
upper_bound = 10.0


#Glucose uptake rate
if (flux_name == "M_glc_D_c_exchange_reverse")
	upper_bound = 10.0;
	#@show (flux_name,lower_bound,upper_bound)
end

#Oxygen uptake rate
if (flux_name == "M_o2_c_exchange_reverse")
	upper_bound = 10.0;
	#@show (flux_name,lower_bound,upper_bound)
end

#Formate secretion rate
if (flux_name == "M_for_c_exchange")
	upper_bound = 10.0;
	#@show (flux_name,lower_bound,upper_bound)
end

#Lactate secretion rate
if (flux_name == "M_lac_D_c_exchange")
	upper_bound = 10.0;
	#@show (flux_name,lower_bound,upper_bound)
end

#Acetate secretion rate
if (flux_name == "M_ac_c_exchange")
	upper_bound = 10.0;
	#@show (flux_name,lower_bound,upper_bound)
end

#Ethanol secretion rate
if (flux_name == "M_etoh_c_exchange")
	upper_bound = 10.0;
	#@show (flux_name,lower_bound,upper_bound)
end

#alpha-KG secretion rate
if (flux_name == "M_akg_c_exchange")
	upper_bound = 10.0;
	#@show (flux_name,lower_bound,upper_bound)
end

#Fumerate secretion rate
if (flux_name == "M_fum_c_exchange")
	upper_bound = 10.0;
	#@show (flux_name,lower_bound,upper_bound)
end

#Malate secretion rate
if (flux_name == "M_mal_L_c_exchange")
	upper_bound = 10.0;
	#@show (flux_name,lower_bound,upper_bound)
end

#Pyruvate secretion rate
if (flux_name == "M_pyr_c_exchange")
	upper_bound = 10.0;
	#@show (flux_name,lower_bound,upper_bound)
end

#Succinate secretion rate
if (flux_name == "M_succ_D_c_exchange")
	upper_bound = 10.0;
	#@show (flux_name,lower_bound,upper_bound)
end


if (flux_name == "M_h_e_exchange" || flux_name == "M_h_e_exchange_reverse" || flux_name == "M_h2o_c_exchange" || flux_name == "M_h2o_c_exchange_reverse")
	constraint_type = GLPK.FR
end

# Blocks -
blocked_reaction_set = data_dictionary["blocked_reaction_set"]
if (in(flux_name,blocked_reaction_set) == true)
	upper_bound = 0.0
end

# Update bounds for AA uptake et al -
sample_bounds_dictionary = data_dictionary["sample_bounds_dictionary"];
if (haskey(sample_bounds_dictionary,flux_name) == true)
	upper_bound = sample_bounds_dictionary[flux_name]
end

# Check on computed bounds -
if (lower_bound == upper_bound)
	constraint_type = GLPK.FX
end

return (lower_bound, upper_bound, constraint_type);
end
