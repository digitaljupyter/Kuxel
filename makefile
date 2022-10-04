all:
	gdc kuxel-sys/main.d -I ../salmon/ -fPIC -o libs/kuxel-repl.so -lreadline -lsalmon -shared -fPIC'
# build