re-run:
	docker container rm common-frp
	docker run -dp 3100:3100 -p 3101:3101 -p 3102:3102 --name common-frp huhuang03/common-frp

.PHONY: re-run