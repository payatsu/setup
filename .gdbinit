python
import sys
sys.path.insert(0, '/toolchains/share/gcc-5.3.0/python/')
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers(None)
sys.path.insert(0, '/toolchains/share/gdb/python')
end
