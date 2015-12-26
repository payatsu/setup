python
import sys
# for CentOS
sys.path.insert(0,'/usr/share/gdb/python/')
# for Ubuntu
sys.path.insert(0,'/usr/local/share/gcc-4.9.1/python/')
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers(None)
end
