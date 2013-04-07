
	#include<mpi.h>


	int CAF_MODE_RDONLY = MPI_MODE_RDONLY;
	int CAF_MODE_WRONLY = MPI_MODE_WRONLY;
	int CAF_MODE_RDWR = MPI_MODE_RDWR;
	int CAF_MODE_CREATE = MPI_MODE_CREATE;


	// open/close
	void caf_file_open_(int* unit, char* file_name, int* access, int* ndim, int* dims, int* recl, int* async);
	void caf_file_close_(int *unit);
	void caf_file_delete_(char* file_nm);


	/**** non-strided operations ****/
	void caf_file_read_(int* unit, int* rec_lb, int* rec_ub, int* buf, int * len);
	void caf_file_write_(int* unit, int* rec_lb, int* rec_ub, int* buf, int * len);
	void caf_set_file_view(int idx, int * rec_lb, int * rec_ub);
	/**** end of non-strided operations ****/


	/**** strided operations ****/
	void caf_file_read_str_(int* unit, int* rec_lb, int* rec_ub, int* str, int* buf, int * len);
	void caf_file_write_str_(int* unit, int* rec_lb, int* rec_ub, int* str, int* buf, int * len);
	void caf_set_file_view_str(int idx, int* rec_lb, int* rec_ub, int* str);
	/**** end of strided operations ****/

	// support functions
	int get_fh_idx(int unit);
