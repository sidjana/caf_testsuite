PERFORMANCE_PATH=./performance
VALID_PATH=./validation


all: validation

help default:
	 @printf '\n%10s\n' "HPC Tools CAF- test suite"
	 @printf '%10s\n' "Usage: $(MAKE) <performance | validation> [<primary options> <secondary options>    ]"
	 @printf '%s\n%s\n%s\n\n' "For more details use:" "$(MAKE) performance TEST=help OR " "$(MAKE) validation TEST=help"

performance:
	@cd $(PERFORMANCE_PATH); $(MAKE) $(TEST) EMAIL=$(EMAIL)

validation:
	@cd $(VALID_PATH); echo "entering dir";
	@$(MAKE) $(TEST) EMAIL=$(EMAIL)

