.PHONY: build test clean

TARGET  = ptxas-wrapper
DESTDIR = /usr/local/bin

$(TARGET) : *.rkt
	raco exe -o $(TARGET) main.rkt

test :
	raco test --process *.rkt

# install : $(TARGET)
# 	install -m 755 $(TARGET) $(DESTDIR)

# uninstall :
# 	rm -f $(DESTDIR)/$(TARGET)

clean :
	rm $(TARGET)
