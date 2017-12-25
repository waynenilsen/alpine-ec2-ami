.PHONY: ami
ami: build/convert
	build/convert alpine-ami.yaml > build/alpine-ami.json
	packer build -var-file=variables.json build/alpine-ami.json

build/convert:
	[ -d ".py3" ] || python3 -m venv .py3
	.py3/bin/pip install pyyaml boto3

	[ -d "build" ] || mkdir build

	# Make stupid simple little YAML/JSON converter so we can maintain our
	# packer configs in a sane format that allows comments but also use packer
	# which only supports JSON
	@echo "#!`pwd`/.py3/bin/python" > build/convert
	@echo "import yaml, json, sys" >> build/convert
	@echo "json.dump(yaml.load(open(sys.argv[1])), sys.stdout, indent=4, separators=(',', ': '))" >> build/convert
	@chmod +x build/convert

%.py: %.py.in
	sed "s|@PYTHON@|#!`pwd`/.py3/bin/python|" $< > $@
	chmod +x $@

.PHONY: clean
clean:
	rm -rf build .py3 scrub-old-amis.py gen-readme.py
