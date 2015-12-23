ifneq (true,$(CI))
ifndef SUBMODULE
UPDATE_COMMAND = echo Updating template && git -C $(LIBDIR) pull
else
UPDATE_COMMAND = echo Your template is old, please run `make update`
endif

NOW = $$(date '+%s')
UPDATE_TIME = $$(stat $$([ $$(uname -s) = Darwin ] && echo -f '%m' || echo -c '%Y') $(LIBDIR)/.git/FETCH_HEAD)
UPDATE_INTERVAL = 1209600 # 2 weeks
UPDATE_NEEDED = $(shell [ $$(($(NOW) - $(UPDATE_TIME))) -gt $(UPDATE_INTERVAL) ] && echo true)

ifeq (true, $(UPDATE_NEEDED))
latest submit:: auto_update
endif

auto_update:
	@$(UPDATE_COMMAND)

.PHONY: update
update:
	git -C $(LIBDIR) pull

endif # CI
