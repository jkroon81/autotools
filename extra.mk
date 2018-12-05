asm: $(patsubst %.c,%.s,$(filter %.c,$(SOURCES)))

%.s: %.c
	$(V_ASM)$(COMPILE) -S $< -o $@

cpp: $(patsubst %.c,%.i,$(filter %.c,$(SOURCES)))

%.i: %.c
	$(V_CPP)$(COMPILE) -E $< -o $@

objdump: $(patsubst %.c,%.b,$(filter %.c,$(SOURCES)))

%.b: %.o
	$(V_OBJDUMP)$(OBJDUMP) -d $< > $@

clean-am: clean-extra
clean-extra:
	-rm -f $(patsubst ./%,%,$(addsuffix *.[bis],$(sort $(dir $(SOURCES)))))

define add_silent_rule
V_$1   = $$(v_$1_$$(V))
v_$1_  = $$(v_$1_$$(AM_DEFAULT_VERBOSITY))
v_$1_0 = @printf "  %-8s %s\n" $1 $$@;
endef

$(eval $(call add_silent_rule,ASM))
$(eval $(call add_silent_rule,CPP))
$(eval $(call add_silent_rule,OBJDUMP))

define add_library
objdump: $1.b
$1.b: $1
	$$(V_OBJDUMP)$$(OBJDUMP) -d $$< > $$@
endef
$(foreach l,$(LIBRARIES),$(eval $(call add_library,$l)))

define add_ltlibrary
objdump: $1.b
$1.b: $1
	$$(V_OBJDUMP)$$(OBJDUMP) -d $(1:%$(notdir $1)=$(dir $1).libs/$(notdir $(1:%.la=%.a))) > $$@
endef
$(foreach l,$(LTLIBRARIES),$(eval $(call add_ltlibrary,$l)))

define add_program
objdump: $1.b
$1.b: $1
	$$(V_OBJDUMP)$$(OBJDUMP) -d $$< > $$@
endef
$(foreach p,$(PROGRAMS),$(eval $(call add_program,$p)))

.PHONY: asm cpp objdump clean-extra
