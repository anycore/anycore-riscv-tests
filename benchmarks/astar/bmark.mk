astar_riscv_checkpoint = /afs/eos/dist/riscv/checkpoints/473.astar_rivers_ref.322.0.20.gz 

.PHONY: astar_riscv_checkpoint_install
astar_riscv_checkpoint_install: $(astar_riscv_checkpoint)
	mkdir -p astar/install
	ln -s $(astar_riscv_checkpoint) astar/install

