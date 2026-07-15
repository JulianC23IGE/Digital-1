TARGET = bintobcd
ICE40_SIM_CELLS=./lattice_sim/cells_sim_ecp5.v

ifeq ($(TARGET), bintobcd)
    OBJS = comp_zero.v contador.v corrector_bcd.v reg_R.v ctrl.v bintobcd.v
else ifeq ($(TARGET), ctrl)
    OBJS = ctrl.v
else ifeq ($(TARGET), contador)
    OBJS = contador.v
else ifeq ($(TARGET), comp_zero)
    OBJS = comp_zero.v
else ifeq ($(TARGET), corrector_bcd)
    OBJS = corrector_bcd.v
else ifeq ($(TARGET), reg_R)
    OBJS = reg_R.v
else
    OBJS = $(TARGET).v
endif

sim:
	rm -f a.out *.vcd
	iverilog  -DBENCH $(TARGET)_tb.v $(OBJS)
	vvp a.out
	gtkwave $(TARGET)_tb.vcd

sim_post_syn:
	yosys -v3 -l synth.log -p 'synth_ecp5 -top $(TARGET) -json $(TARGET).json; write_verilog -attr2comment $(TARGET)_synth.v' $(OBJS)
	iverilog  -I ./lattice_sim  $(TARGET)_tb.v $(TARGET)_synth.v $(ICE40_SIM_CELLS) 
	vvp a.out
	gtkwave $(TARGET)_tb.vcd

svg: $(OBJS)
	rm -rf *svg *out *dot
	yosys -p "prep -top ${TARGET}; memory -nomap; opt; opt_expr; techmap; abc -g AND,OR,XOR; write_json ${TARGET}.json" ${OBJS}
	yosys -p "read_verilog ${TARGET}.v; proc; memory -nomap; opt; opt_expr; techmap; abc -g AND,OR,XOR; show -format dot -prefix ${TARGET}_out"
	netlistsvg ${TARGET}.json -o ${TARGET}.svg
	google-chrome ${TARGET}.svg

$(TARGET).json :
	yosys -v3 -q -l synth.log -p 'attrmap -tocase keep -imap keep="true" keep=1; synth_ecp5 -top $(TARGET) -json $(TARGET).json; write_verilog -attr2comment  $(TARGET)_synth.v ' $(OBJS) -l  $(TARGET).rpt

$(TARGET)_out.config : $(TARGET).json
	nextpnr-ecp5 --json $(TARGET).json --lpf $(TARGET).lpf --textcfg $(TARGET)_out.config --25k --package CABGA256 --speed 6 --timing-allow-fail --seed 1 --lpf-allow-unconstrained --log  $(TARGET)_pnr.log

$(TARGET).bit :  $(TARGET)_out.config
	ecppack --bootaddr 0 --compress $(TARGET)_out.config --svf $(TARGET).svf --bit $@

configure_lattice: $(TARGET).bit   # TDI:TDO:TCK:TMS TXD:CTS:DTR:RXD
	sudo openFPGALoader -c ft232RL --pins=TXD:CTS:DTR:RXD -m  ${TARGET}.bit 

# --- Limpieza ---
clean:
	rm -rf *svg *out *dot a.out *.vcd *json *_synth.v *log *bit *rpt *svf *out.config