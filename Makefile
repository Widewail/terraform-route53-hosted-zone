init:
	tfenv use
	
test: init
	terraform validate