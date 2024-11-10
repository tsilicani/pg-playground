open_swagger:
	@echo "Opening Swagger UI..."
	@open http://localhost:3000

reset_stack:
	@echo "Resetting stack..."
	@source ./config.sh && reset_stack

migrate:
	@echo "Migrating database..."
	@source ./config.sh && migrate

add_migration:
	@echo "Adding migration..."
	shmig create $(ARGS)

# Capture all arguments after the target name
ARGS = $(filter-out $@,$(MAKECMDGOALS))

# Prevent make from treating arguments as targets
%:
	@: