INPUT_DIR = .
CHKPT_DIR = .

bmarks = 401.bzip2

chkpts = $(addprefix chkpt.,${bmarks})
smpts = $(addprefix smpt.,${bmarks})

.PHONY: all ${bmarks} ${chkpts} 

all: ${bmarks}

chkpt: ${chkpts}	

smpt: ${smpts}	


chkpt.400.perlbench:	;checkpointer	-m2048 -s335500000000  	-ccheckpoint.3355 	pk -c   ./perlbench -I./lib/ checkspam.pl 2500 5 25 11 150 1 1 1 1  2>&1 | tee chkpt.log 
chkpt.401.bzip2: 			;checkpointer	-m2048 -s74700000000  	-ccheckpoint.747 		pk -c   ./bzip2 input.source 280 2>&1 | tee chkpt.log 
chkpt.401.gcc: 				;checkpointer	-m2048 -s42000000000  	-ccheckpoint.420 		pk -c   ./gcc expr.i -o expr.s 2>&1 | tee chkpt.log 
chkpt.429.mcf: 				;checkpointer	-m2048 -s231100000000  	-ccheckpoint.2311 	pk -c   ./mcf inp.in 2>&1 | tee chkpt.log 
chkpt.445.gobmk:			;checkpointer	-m2048 -s234100000000  	-ccheckpoint.2341		pk -c   ./go --quiet --mode gtp < score2.tst 2>&1 | tee chkpt.log 
chkpt.456.hmmer: 			;checkpointer	-m2048 -s42000000000  	-ccheckpoint.420 		pk -c   ./hmmer nph3.hmm swiss41 2>&1 | tee chkpt.log 
chkpt.458.sjeng: 			;checkpointer	-m2048 -s1893700000000 	-ccheckpoint.18937 	pk -c  	./sjeng ref.txt 2>&1 | tee chkpt.log 
chkpt.462.libquantum: ;checkpointer	-m2048 -s826300000000 	-ccheckpoint.8263 	pk -c  	./libquantum 1397 8 2>&1 | tee chkpt.log 
chkpt.464.h264ref:		;checkpointer	-m2048 -s218400000000 	-ccheckpoint.2184 	pk -c  	./h264ref -d foreman_ref_encoder_baseline.cfg 2>&1 | tee chkpt.log 
chkpt.471.omnetpp: 		;checkpointer	-m2048 -s255400000000 	-ccheckpoint.2554 	pk -c  	./omnetpp omnetpp.ini 2>&1 | tee chkpt.log 
chkpt.473.astar: 			;checkpointer	-m2048 -s118100000000  	-ccheckpoint.1181		pk -c   ./astar BigLakes2048.cfg 2>&1 | tee chkpt.log 
chkpt.483.xalancbmk:	;checkpointer	-m2048 -s826300000000 	-ccheckpoint.8263		pk -c  	./xalancbmk -v t5.xml xalanc.xsl 2>&1 | tee chkpt.log 

chkpt.410.bwaves:			;checkpointer	-m2048 -s2316900000000 	-ccheckpoint.23169	pk -c ./bwaves 2>&1 | tee chkpt.log 
chkpt.416.gamess:  		;checkpointer	-m2048 -s537000000000 	-ccheckpoint.5370		pk -c ./gamess < cytosine.2.config 2>&1 | tee chkpt.log
chkpt.433.milc:  			;checkpointer	-m2048 -s672100000000 	-ccheckpoint.6721		pk -c ./milc < su3imp.in 2>&1 | tee chkpt.log
chkpt.434.zeus:    		;checkpointer	-m2048 -s14214000000000	-ccheckpoint.142140	pk -c ./zeusmp 2>&1 | tee chkpt.log
chkpt.435.gromacs: 		;checkpointer	-m2048 -s1000000000 		-ccheckpoint.1000		pk -c ./gromacs -silent -deffnm gromacs -nice 0 2>&1 | tee chkpt.log
chkpt.436.cactusADM:	;checkpointer	-m2048 -s1000000000 		-ccheckpoint.1000		pk -c ./cactus benchADM.par 2>&1 | tee chkpt.log
chkpt.437.leslie3d:		;checkpointer	-m2048 -s91500000000		-ccheckpoint.915 		pk -c ./leslie3d < leslie3d.in 2>&1 | tee chkpt.log
chkpt.444.namd:    		;checkpointer	-m2048 -s1107400000000 	-ccheckpoint.11074	pk -c ./namd --input namd.input --iterations 38 --output namd.out 2>&1 | tee chkpt.log
chkpt.447.dealII:  		;checkpointer	-m2048 -s146500000000 	-ccheckpoint.1465		pk -c ./dealII 23 2>&1 | tee chkpt.log
chkpt.450.soplex:  		;checkpointer	-m2048 -s1000000000 		-ccheckpoint.1000		pk -c ./soplex -s1 -e -m45000 pds-50.mps 2>&1 | tee chkpt.log
#chkpt.450.soplex:    ;checkpointer -m2048 -s1000000000 		-ccheckpoint.1000		pk -c ./soplex -m3500 ref.mps 2>&1 | tee chkpt.log
chkpt.453.povray:  		;checkpointer	-m2048 -s1767000000000 	-ccheckpoint.17670	pk -c ./povray SPEC-benchmark-ref.ini 2>&1 | tee chkpt.log
chkpt.454.calculix:		;checkpointer	-m2048 -s2566700000000 	-ccheckpoint.25667	pk -c ./calculix -i hyperviscoplastic 2>&1 | tee chkpt.log
chkpt.459.gems:     	;checkpointer	-m2048 -s1000000000 		-ccheckpoint.1000		pk -c ./gems 2>&1 | tee chkpt.log
chkpt.470.lbm:     		;checkpointer	-m2048 -s1971300000000 	-ccheckpoint.19713	pk -c ./lbm 3000 reference.dat 0 0 100_100_130_ldc.of 2>&1 | tee chkpt.log
chkpt.482.sphinx3: 		;checkpointer	-m2048 -s1000000000 		-ccheckpoint.1000		pk -c ./sphinx3 ctlfile . args.an4 2>&1 | tee chkpt.log



smpt.400.perlbench:		;spike	-m2048 pk -c ./perlbench -I./lib/ checkspam.pl 2500 5 25 11 150 1 1 1 1  2>&1 | tee smpt.log 
smpt.401.bzip2: 			;spike	-m2048 pk -c ./bzip2 input.source 280 2>&1 | tee smpt.log 
smpt.401.gcc: 				;spike	-m2048 pk -c ./gcc expr.i -o expr.s 2>&1 | tee smpt.log 
smpt.429.mcf: 				;spike	-m2048 pk -c ./mcf inp.in 2>&1 | tee smpt.log 
smpt.445.gobmk:				;spike	-m2048 pk -c ./go --quiet --mode gtp < score2.tst 2>&1 | tee smpt.log 
smpt.456.hmmer: 			;spike	-m2048 pk -c ./hmmer nph3.hmm swiss41 2>&1 | tee smpt.log 
smpt.458.sjeng: 			;spike	-m2048 pk -c ./sjeng ref.txt 2>&1 | tee smpt.log 
smpt.462.libquantum: 	;spike	-m2048 pk -c ./libquantum 1397 8 2>&1 | tee smpt.log 
smpt.464.h264ref:			;spike	-m2048 pk -c ./h264ref -d foreman_ref_encoder_baseline.cfg 2>&1 | tee smpt.log 
smpt.471.omnetpp: 		;spike	-m2048 pk -c ./omnetpp omnetpp.ini 2>&1 | tee smpt.log 
smpt.473.astar: 			;spike	-m2048 pk -c ./astar BigLakes2048.cfg 2>&1 | tee smpt.log 
smpt.483.xalancbmk:		;spike	-m2048 pk -c ./xalancbmk -v t5.xml xalanc.xsl 2>&1 | tee smpt.log 



smpt.410.bwaves:			;spike	-m2048 pk -c ./bwaves 2>&1 | tee smpt.log 
smpt.416.gamess:   		;spike	-m2048 pk -c ./gamess < cytosine.2.config 2>&1 | tee smpt.log
smpt.433.milc:  			;spike	-m2048 pk -c ./milc < su3imp.in 2>&1 | tee smpt.log
smpt.434.zeus:     		;spike	-m2048 pk -c ./zeusmp 2>&1 | tee smpt.log
smpt.435.gromacs:  		;spike	-m2048 pk -c ./gromacs -silent -deffnm gromacs -nice 0 2>&1 | tee smpt.log
smpt.436.cactusADM:		;spike	-m2048 pk -c ./cactus benchADM.par 2>&1 | tee smpt.log
smpt.437.leslie3d:		;spike	-m2048 pk -c ./leslie3d < leslie3d.in 2>&1 | tee smpt.log
smpt.444.namd:    		;spike	-m2048 pk -c ./namd --input namd.input --iterations 38 --output namd.out 2>&1 | tee smpt.log
smpt.447.dealII:  		;spike	-m2048 pk -c ./dealII 23 2>&1 | tee smpt.log
smpt.450.soplex:  		;spike	-m2048 pk -c ./soplex -s1 -e -m45000 pds-50.mps 2>&1 | tee smpt.log
#smpt.450.soplex:     ;spike  -m2048 pk -c ./soplex -m3500 ref.mps 2>&1 | tee smpt.log
smpt.453.povray:  		;spike	-m2048 pk -c ./povray SPEC-benchmark-ref.ini 2>&1 | tee smpt.log
smpt.454.calculix:		;spike	-m2048 pk -c ./calculix -i hyperviscoplastic 2>&1 | tee smpt.log
smpt.459.gems:     		;spike	-m2048 pk -c ./gems 2>&1 | tee smpt.log
smpt.470.lbm:     		;spike	-m2048 pk -c ./lbm 3000 reference.dat 0 0 100_100_130_ldc.of 2>&1 | tee smpt.log
smpt.482.sphinx3: 		;spike	-m2048 pk -c ./sphinx3 ctlfile . args.an4 2>&1 | tee smpt.log

.ONESHELL:
.PHONY: simpoints
simpoints:	;gunzip bbv_proc_0.bb.gz -c > bbv.bb ; /home/rbasuro/SimPoint.3.2/bin/simpoint -maxK 10 -saveSimpoints simpoints -saveSimpointWeights weights -loadFVFile bbv.bb
