#lang racket

(provide (all-defined-out))

(define ptx-register-def
  #<<string-delimiter
.entry main$_omp_fn$0 (.param.u64 %in_ar0)
{
 .reg.u64 %ar0;
 .reg.u32 %r23;
 .reg.u64 %r24;
 .reg.u64 %r26;
 .reg.pred %r27;
 .reg.pred %r28;
 .reg.pred %r29;
 .reg.u32 %r30;
 }
string-delimiter
      )

(define ptx-register-def-out
'(kernel
  "main$_omp_fn$0"
  (storage ".param" ".u64" "%in_ar0")
  (storageN ".reg" ".u64" "%ar0")
  (storageN ".reg" ".u32" "%r23")
  (storageN ".reg" ".u64" "%r24")
  (storageN ".reg" ".u64" "%r26")
  (storageN ".reg" ".pred" "%r27")
  (storageN ".reg" ".pred" "%r28")
  (storageN ".reg" ".pred" "%r29")
  (storageN ".reg" ".u32" "%r30"))
)

(define ptx-sample1
  #<<string-delimiter
.entry main$_omp_fn$1 (.param.u64 %in_ar0)
{
	.reg.u64 %ar0;
	ld.param.u64 %ar0, [%in_ar0];
	.reg.u64 %r22;
	.reg.u32 %r23;
	.reg.f64 %r24;
	.reg.u64 %r25;
	.reg.u64 %r26;
	.reg.u64 %r30;
	.reg.f64 %r31;
	.reg.f64 %r32;
	.reg.u64 %r33;
	.reg.pred %r34;
	.reg.pred %r35;
	.reg.pred %r36;
	{
		.reg.u32	%x;
		mov.u32	%x, %tid.x;
		setp.ne.u32	%r36, %x, 0;
	}
	@%r36	bra	$L13;
		mov.u64	%r30, %ar0;
		ld.u64	%r22, [%r30];
		mov.u32	%r23, 10000;
		mov.f64	%r24, 0d0000000000000000;
		bra	$L8;
$L9:
		mov.u64	%r25, %r26;
		mov.b64	%r32, %r26;
		add.f64	%r31, %r24, %r32;
		mov.b64	%r33, %r31;
		atom.cas.b64	%r26, [%r22], %r26, %r33;
		setp.ne.u64	%r34, %r25, %r26;
	@%r34	bra	$L9;
$L13:
		bra	$L12;
$L8:
		add.f64	%r24, %r24, 0d3ff0000000000000;
		add.u32	%r23, %r23, -1;
		setp.ne.u32	%r35, %r23, 0;
	@%r35	bra	$L8;
		mov.u64	%r26, 0;
		bra	$L9;
$L12:
	ret;
}
string-delimiter
      )

(define ptx-sample1-out
'(kernel
  "main$_omp_fn$1"
  (storage ".param" ".u64" "%in_ar0")
  (storageN ".reg" ".u64" "%ar0")
  (instruction "ld" ".param" ".u64" "%ar0" "[%in_ar0]")
  (storageN ".reg" ".u64" "%r22")
  (storageN ".reg" ".u32" "%r23")
  (storageN ".reg" ".f64" "%r24")
  (storageN ".reg" ".u64" "%r25")
  (storageN ".reg" ".u64" "%r26")
  (storageN ".reg" ".u64" "%r30")
  (storageN ".reg" ".f64" "%r31")
  (storageN ".reg" ".f64" "%r32")
  (storageN ".reg" ".u64" "%r33")
  (storageN ".reg" ".pred" "%r34")
  (storageN ".reg" ".pred" "%r35")
  (storageN ".reg" ".pred" "%r36")
  (group
   (storageN ".reg" ".u32" "%x")
   (instruction "mov" ".u32" "%x" "%tid.x")
   (instruction "setp" ".ne" ".u32" "%r36" "%x" "0"))
  "@%r36"
  (instruction "bra" "$L13")
  (instruction "mov" ".u64" "%r30" "%ar0")
  (instruction "ld" ".u64" "%r22" "[%r30]")
  (instruction "mov" ".u32" "%r23" "10000")
  (instruction "mov" ".f64" "%r24" "0d0000000000000000")
  (instruction "bra" "$L8")
  "$L9:"
  (instruction "mov" ".u64" "%r25" "%r26")
  (instruction "mov" ".b64" "%r32" "%r26")
  (instruction "add" ".f64" "%r31" "%r24" "%r32")
  (instruction "mov" ".b64" "%r33" "%r31")
  (instruction "atom" ".cas" ".b64" "%r26" "[%r22]" "%r26" "%r33")
  (instruction "setp" ".ne" ".u64" "%r34" "%r25" "%r26")
  "@%r34"
  (instruction "bra" "$L9")
  "$L13:"
  (instruction "bra" "$L12")
  "$L8:"
  (instruction "add" ".f64" "%r24" "%r24" "0d3ff0000000000000")
  (instruction "add" ".u32" "%r23" "%r23" "-1")
  (instruction "setp" ".ne" ".u32" "%r35" "%r23" "0")
  "@%r35"
  (instruction "bra" "$L8")
  (instruction "mov" ".u64" "%r26" "0")
  (instruction "bra" "$L9")
  "$L12:"
  (instruction "ret"))
  )

(define ptx-sample2
  #<<string-delimiter


.version 7.2
.target sm_70
.address_size 64

	
.extern .shared .align 8 .b8 S18_main_17_gpu[];

.visible .entry main_11_gpu(
	.param .u64 main_11_gpu_param_0
)
.maxntid 128, 1, 1
{
	.reg .pred 	%p<6>;
	.reg .b32 	%r<19>;
	.reg .b64 	%rd<14>;
	.loc	1 11 0
Lfunc_begin0:
	.loc	1 11 0


	ld.param.u64 	%rd2, [main_11_gpu_param_0];
	mov.u32 	%r18, %tid.x;
	add.s32 	%r17, %r18, -9999;
	mov.u32 	%r16, 9616;
	cvta.to.global.u64 	%rd1, %rd2;
	bra.uni 	LBB0_1;

LBB0_11:
Ltmp0:
	.loc	1 15 1
	add.s32 	%r18, %r18, 512;
	add.s32 	%r16, %r16, -512;
	add.s32 	%r17, %r7, 128;

LBB0_1:
	.loc	1 14 1
	setp.gt.s32 	%p1, %r17, 0;
	@%p1 bra 	LBB0_3;

	.loc	1 15 1
	mul.wide.s32 	%rd3, %r18, 4;
	add.s64 	%rd4, %rd1, %rd3;
	st.global.u32 	[%rd4], %r18;

LBB0_3:
	add.s32 	%r12, %r17, 128;
	.loc	1 14 1
	setp.gt.s32 	%p2, %r12, 0;
	@%p2 bra 	LBB0_5;

	.loc	1 15 1
	mul.wide.s32 	%rd5, %r18, 4;
	add.s64 	%rd7, %rd1, %rd5;
	add.s32 	%r13, %r18, 128;
	st.global.u32 	[%rd7+512], %r13;

LBB0_5:
	.loc	1 14 1
	add.s32 	%r6, %r17, 256;
	setp.gt.s32 	%p3, %r6, 0;
	@%p3 bra 	LBB0_7;

	.loc	1 15 1
	mul.wide.s32 	%rd9, %r18, 4;
	add.s64 	%rd10, %rd1, %rd9;
	add.s32 	%r14, %r17, 10255;
	st.global.u32 	[%rd10+1024], %r14;

LBB0_7:
	.loc	1 14 1
	setp.gt.s32 	%p4, %r16, 0;
	@%p4 bra 	LBB0_9;
	bra.uni 	LBB0_8;

LBB0_9:
	add.s32 	%r7, %r6, 128;
	setp.gt.s32 	%p5, %r7, 0;
	@%p5 bra 	LBB0_11;

	.loc	1 15 1
	mul.wide.s32 	%rd12, %r18, 4;
	add.s64 	%rd13, %rd1, %rd12;
	add.s32 	%r15, %r17, 10383;
	st.global.u32 	[%rd13+1536], %r15;
	bra.uni 	LBB0_11;

LBB0_8:
	.loc	1 14 1
	ret;
Ltmp1:
Lfunc_end0:

}
	
.visible .entry main_17_gpu(
	.param .u64 main_17_gpu_param_0
)
.maxntid 128, 1, 1
{
	.reg .pred 	%p<83>;
	.reg .b32 	%r<90>;
	.reg .f64 	%fd<164>;
	.reg .b64 	%rd<12>;
	.loc	1 17 0
Lfunc_begin1:
	.loc	1 17 0


	.loc	1 19 1
	mov.u32 	%r1, %tid.x;
	add.s32 	%r5, %r1, -9999;
	mov.u64 	%rd4, S18_main_17_gpu;
	cvta.shared.u64 	%rd5, %rd4;
	setp.gt.s32 	%p1, %r5, 0;
	selp.f64 	%fd1, 0d0000000000000000, 0d3FF0000000000000, %p1;
	.loc	1 20 1
	add.s32 	%r6, %r1, -9871;
	.loc	1 19 1
	setp.gt.s32 	%p2, %r6, 0;
	.loc	1 20 1
	add.f64 	%fd2, %fd1, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd3, %fd1, %fd2, %p2;
	.loc	1 20 1
	add.s32 	%r7, %r1, -9743;
	.loc	1 19 1
	setp.gt.s32 	%p3, %r7, 0;
	.loc	1 20 1
	add.f64 	%fd4, %fd3, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd5, %fd3, %fd4, %p3;
	.loc	1 20 1
	add.s32 	%r8, %r1, -9615;
	.loc	1 19 1
	setp.gt.s32 	%p4, %r8, 0;
	.loc	1 20 1
	add.f64 	%fd6, %fd5, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd7, %fd5, %fd6, %p4;
	.loc	1 20 1
	add.s32 	%r9, %r1, -9487;
	.loc	1 19 1
	setp.gt.s32 	%p5, %r9, 0;
	.loc	1 20 1
	add.f64 	%fd8, %fd7, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd9, %fd7, %fd8, %p5;
	.loc	1 20 1
	add.s32 	%r10, %r1, -9359;
	.loc	1 19 1
	setp.gt.s32 	%p6, %r10, 0;
	.loc	1 20 1
	add.f64 	%fd10, %fd9, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd11, %fd9, %fd10, %p6;
	.loc	1 20 1
	add.s32 	%r11, %r1, -9231;
	.loc	1 19 1
	setp.gt.s32 	%p7, %r11, 0;
	.loc	1 20 1
	add.f64 	%fd12, %fd11, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd13, %fd11, %fd12, %p7;
	.loc	1 20 1
	add.s32 	%r12, %r1, -9103;
	.loc	1 19 1
	setp.gt.s32 	%p8, %r12, 0;
	.loc	1 20 1
	add.f64 	%fd14, %fd13, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd15, %fd13, %fd14, %p8;
	.loc	1 20 1
	add.s32 	%r13, %r1, -8975;
	.loc	1 19 1
	setp.gt.s32 	%p9, %r13, 0;
	.loc	1 20 1
	add.f64 	%fd16, %fd15, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd17, %fd15, %fd16, %p9;
	.loc	1 20 1
	add.s32 	%r14, %r1, -8847;
	.loc	1 19 1
	setp.gt.s32 	%p10, %r14, 0;
	.loc	1 20 1
	add.f64 	%fd18, %fd17, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd19, %fd17, %fd18, %p10;
	.loc	1 20 1
	add.s32 	%r15, %r1, -8719;
	.loc	1 19 1
	setp.gt.s32 	%p11, %r15, 0;
	.loc	1 20 1
	add.f64 	%fd20, %fd19, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd21, %fd19, %fd20, %p11;
	.loc	1 20 1
	add.s32 	%r16, %r1, -8591;
	.loc	1 19 1
	setp.gt.s32 	%p12, %r16, 0;
	.loc	1 20 1
	add.f64 	%fd22, %fd21, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd23, %fd21, %fd22, %p12;
	.loc	1 20 1
	add.s32 	%r17, %r1, -8463;
	.loc	1 19 1
	setp.gt.s32 	%p13, %r17, 0;
	.loc	1 20 1
	add.f64 	%fd24, %fd23, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd25, %fd23, %fd24, %p13;
	.loc	1 20 1
	add.s32 	%r18, %r1, -8335;
	.loc	1 19 1
	setp.gt.s32 	%p14, %r18, 0;
	.loc	1 20 1
	add.f64 	%fd26, %fd25, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd27, %fd25, %fd26, %p14;
	.loc	1 20 1
	add.s32 	%r19, %r1, -8207;
	.loc	1 19 1
	setp.gt.s32 	%p15, %r19, 0;
	.loc	1 20 1
	add.f64 	%fd28, %fd27, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd29, %fd27, %fd28, %p15;
	.loc	1 20 1
	add.s32 	%r20, %r1, -8079;
	.loc	1 19 1
	setp.gt.s32 	%p16, %r20, 0;
	.loc	1 20 1
	add.f64 	%fd30, %fd29, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd31, %fd29, %fd30, %p16;
	.loc	1 20 1
	add.s32 	%r21, %r1, -7951;
	.loc	1 19 1
	setp.gt.s32 	%p17, %r21, 0;
	.loc	1 20 1
	add.f64 	%fd32, %fd31, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd33, %fd31, %fd32, %p17;
	.loc	1 20 1
	add.s32 	%r22, %r1, -7823;
	.loc	1 19 1
	setp.gt.s32 	%p18, %r22, 0;
	.loc	1 20 1
	add.f64 	%fd34, %fd33, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd35, %fd33, %fd34, %p18;
	.loc	1 20 1
	add.s32 	%r23, %r1, -7695;
	.loc	1 19 1
	setp.gt.s32 	%p19, %r23, 0;
	.loc	1 20 1
	add.f64 	%fd36, %fd35, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd37, %fd35, %fd36, %p19;
	.loc	1 20 1
	add.s32 	%r24, %r1, -7567;
	.loc	1 19 1
	setp.gt.s32 	%p20, %r24, 0;
	.loc	1 20 1
	add.f64 	%fd38, %fd37, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd39, %fd37, %fd38, %p20;
	.loc	1 20 1
	add.s32 	%r25, %r1, -7439;
	.loc	1 19 1
	setp.gt.s32 	%p21, %r25, 0;
	.loc	1 20 1
	add.f64 	%fd40, %fd39, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd41, %fd39, %fd40, %p21;
	.loc	1 20 1
	add.s32 	%r26, %r1, -7311;
	.loc	1 19 1
	setp.gt.s32 	%p22, %r26, 0;
	.loc	1 20 1
	add.f64 	%fd42, %fd41, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd43, %fd41, %fd42, %p22;
	.loc	1 20 1
	add.s32 	%r27, %r1, -7183;
	.loc	1 19 1
	setp.gt.s32 	%p23, %r27, 0;
	.loc	1 20 1
	add.f64 	%fd44, %fd43, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd45, %fd43, %fd44, %p23;
	.loc	1 20 1
	add.s32 	%r28, %r1, -7055;
	.loc	1 19 1
	setp.gt.s32 	%p24, %r28, 0;
	.loc	1 20 1
	add.f64 	%fd46, %fd45, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd47, %fd45, %fd46, %p24;
	.loc	1 20 1
	add.s32 	%r29, %r1, -6927;
	.loc	1 19 1
	setp.gt.s32 	%p25, %r29, 0;
	.loc	1 20 1
	add.f64 	%fd48, %fd47, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd49, %fd47, %fd48, %p25;
	.loc	1 20 1
	add.s32 	%r30, %r1, -6799;
	.loc	1 19 1
	setp.gt.s32 	%p26, %r30, 0;
	.loc	1 20 1
	add.f64 	%fd50, %fd49, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd51, %fd49, %fd50, %p26;
	.loc	1 20 1
	add.s32 	%r31, %r1, -6671;
	.loc	1 19 1
	setp.gt.s32 	%p27, %r31, 0;
	.loc	1 20 1
	add.f64 	%fd52, %fd51, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd53, %fd51, %fd52, %p27;
	.loc	1 20 1
	add.s32 	%r32, %r1, -6543;
	.loc	1 19 1
	setp.gt.s32 	%p28, %r32, 0;
	.loc	1 20 1
	add.f64 	%fd54, %fd53, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd55, %fd53, %fd54, %p28;
	.loc	1 20 1
	add.s32 	%r33, %r1, -6415;
	.loc	1 19 1
	setp.gt.s32 	%p29, %r33, 0;
	.loc	1 20 1
	add.f64 	%fd56, %fd55, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd57, %fd55, %fd56, %p29;
	.loc	1 20 1
	add.s32 	%r34, %r1, -6287;
	.loc	1 19 1
	setp.gt.s32 	%p30, %r34, 0;
	.loc	1 20 1
	add.f64 	%fd58, %fd57, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd59, %fd57, %fd58, %p30;
	.loc	1 20 1
	add.s32 	%r35, %r1, -6159;
	.loc	1 19 1
	setp.gt.s32 	%p31, %r35, 0;
	.loc	1 20 1
	add.f64 	%fd60, %fd59, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd61, %fd59, %fd60, %p31;
	.loc	1 20 1
	add.s32 	%r36, %r1, -6031;
	.loc	1 19 1
	setp.gt.s32 	%p32, %r36, 0;
	.loc	1 20 1
	add.f64 	%fd62, %fd61, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd63, %fd61, %fd62, %p32;
	.loc	1 20 1
	add.s32 	%r37, %r1, -5903;
	.loc	1 19 1
	setp.gt.s32 	%p33, %r37, 0;
	.loc	1 20 1
	add.f64 	%fd64, %fd63, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd65, %fd63, %fd64, %p33;
	.loc	1 20 1
	add.s32 	%r38, %r1, -5775;
	.loc	1 19 1
	setp.gt.s32 	%p34, %r38, 0;
	.loc	1 20 1
	add.f64 	%fd66, %fd65, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd67, %fd65, %fd66, %p34;
	.loc	1 20 1
	add.s32 	%r39, %r1, -5647;
	.loc	1 19 1
	setp.gt.s32 	%p35, %r39, 0;
	.loc	1 20 1
	add.f64 	%fd68, %fd67, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd69, %fd67, %fd68, %p35;
	.loc	1 20 1
	add.s32 	%r40, %r1, -5519;
	.loc	1 19 1
	setp.gt.s32 	%p36, %r40, 0;
	.loc	1 20 1
	add.f64 	%fd70, %fd69, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd71, %fd69, %fd70, %p36;
	.loc	1 20 1
	add.s32 	%r41, %r1, -5391;
	.loc	1 19 1
	setp.gt.s32 	%p37, %r41, 0;
	.loc	1 20 1
	add.f64 	%fd72, %fd71, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd73, %fd71, %fd72, %p37;
	.loc	1 20 1
	add.s32 	%r42, %r1, -5263;
	.loc	1 19 1
	setp.gt.s32 	%p38, %r42, 0;
	.loc	1 20 1
	add.f64 	%fd74, %fd73, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd75, %fd73, %fd74, %p38;
	.loc	1 20 1
	add.s32 	%r43, %r1, -5135;
	.loc	1 19 1
	setp.gt.s32 	%p39, %r43, 0;
	.loc	1 20 1
	add.f64 	%fd76, %fd75, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd77, %fd75, %fd76, %p39;
	.loc	1 20 1
	add.s32 	%r44, %r1, -5007;
	.loc	1 19 1
	setp.gt.s32 	%p40, %r44, 0;
	.loc	1 20 1
	add.f64 	%fd78, %fd77, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd79, %fd77, %fd78, %p40;
	.loc	1 20 1
	add.s32 	%r45, %r1, -4879;
	.loc	1 19 1
	setp.gt.s32 	%p41, %r45, 0;
	.loc	1 20 1
	add.f64 	%fd80, %fd79, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd81, %fd79, %fd80, %p41;
	.loc	1 20 1
	add.s32 	%r46, %r1, -4751;
	.loc	1 19 1
	setp.gt.s32 	%p42, %r46, 0;
	.loc	1 20 1
	add.f64 	%fd82, %fd81, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd83, %fd81, %fd82, %p42;
	.loc	1 20 1
	add.s32 	%r47, %r1, -4623;
	.loc	1 19 1
	setp.gt.s32 	%p43, %r47, 0;
	.loc	1 20 1
	add.f64 	%fd84, %fd83, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd85, %fd83, %fd84, %p43;
	.loc	1 20 1
	add.s32 	%r48, %r1, -4495;
	.loc	1 19 1
	setp.gt.s32 	%p44, %r48, 0;
	.loc	1 20 1
	add.f64 	%fd86, %fd85, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd87, %fd85, %fd86, %p44;
	.loc	1 20 1
	add.s32 	%r49, %r1, -4367;
	.loc	1 19 1
	setp.gt.s32 	%p45, %r49, 0;
	.loc	1 20 1
	add.f64 	%fd88, %fd87, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd89, %fd87, %fd88, %p45;
	.loc	1 20 1
	add.s32 	%r50, %r1, -4239;
	.loc	1 19 1
	setp.gt.s32 	%p46, %r50, 0;
	.loc	1 20 1
	add.f64 	%fd90, %fd89, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd91, %fd89, %fd90, %p46;
	.loc	1 20 1
	add.s32 	%r51, %r1, -4111;
	.loc	1 19 1
	setp.gt.s32 	%p47, %r51, 0;
	.loc	1 20 1
	add.f64 	%fd92, %fd91, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd93, %fd91, %fd92, %p47;
	.loc	1 20 1
	add.s32 	%r52, %r1, -3983;
	.loc	1 19 1
	setp.gt.s32 	%p48, %r52, 0;
	.loc	1 20 1
	add.f64 	%fd94, %fd93, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd95, %fd93, %fd94, %p48;
	.loc	1 20 1
	add.s32 	%r53, %r1, -3855;
	.loc	1 19 1
	setp.gt.s32 	%p49, %r53, 0;
	.loc	1 20 1
	add.f64 	%fd96, %fd95, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd97, %fd95, %fd96, %p49;
	.loc	1 20 1
	add.s32 	%r54, %r1, -3727;
	.loc	1 19 1
	setp.gt.s32 	%p50, %r54, 0;
	.loc	1 20 1
	add.f64 	%fd98, %fd97, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd99, %fd97, %fd98, %p50;
	.loc	1 20 1
	add.s32 	%r55, %r1, -3599;
	.loc	1 19 1
	setp.gt.s32 	%p51, %r55, 0;
	.loc	1 20 1
	add.f64 	%fd100, %fd99, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd101, %fd99, %fd100, %p51;
	.loc	1 20 1
	add.s32 	%r56, %r1, -3471;
	.loc	1 19 1
	setp.gt.s32 	%p52, %r56, 0;
	.loc	1 20 1
	add.f64 	%fd102, %fd101, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd103, %fd101, %fd102, %p52;
	.loc	1 20 1
	add.s32 	%r57, %r1, -3343;
	.loc	1 19 1
	setp.gt.s32 	%p53, %r57, 0;
	.loc	1 20 1
	add.f64 	%fd104, %fd103, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd105, %fd103, %fd104, %p53;
	.loc	1 20 1
	add.s32 	%r58, %r1, -3215;
	.loc	1 19 1
	setp.gt.s32 	%p54, %r58, 0;
	.loc	1 20 1
	add.f64 	%fd106, %fd105, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd107, %fd105, %fd106, %p54;
	.loc	1 20 1
	add.s32 	%r59, %r1, -3087;
	.loc	1 19 1
	setp.gt.s32 	%p55, %r59, 0;
	.loc	1 20 1
	add.f64 	%fd108, %fd107, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd109, %fd107, %fd108, %p55;
	.loc	1 20 1
	add.s32 	%r60, %r1, -2959;
	.loc	1 19 1
	setp.gt.s32 	%p56, %r60, 0;
	.loc	1 20 1
	add.f64 	%fd110, %fd109, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd111, %fd109, %fd110, %p56;
	.loc	1 20 1
	add.s32 	%r61, %r1, -2831;
	.loc	1 19 1
	setp.gt.s32 	%p57, %r61, 0;
	.loc	1 20 1
	add.f64 	%fd112, %fd111, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd113, %fd111, %fd112, %p57;
	.loc	1 20 1
	add.s32 	%r62, %r1, -2703;
	.loc	1 19 1
	setp.gt.s32 	%p58, %r62, 0;
	.loc	1 20 1
	add.f64 	%fd114, %fd113, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd115, %fd113, %fd114, %p58;
	.loc	1 20 1
	add.s32 	%r63, %r1, -2575;
	.loc	1 19 1
	setp.gt.s32 	%p59, %r63, 0;
	.loc	1 20 1
	add.f64 	%fd116, %fd115, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd117, %fd115, %fd116, %p59;
	.loc	1 20 1
	add.s32 	%r64, %r1, -2447;
	.loc	1 19 1
	setp.gt.s32 	%p60, %r64, 0;
	.loc	1 20 1
	add.f64 	%fd118, %fd117, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd119, %fd117, %fd118, %p60;
	.loc	1 20 1
	add.s32 	%r65, %r1, -2319;
	.loc	1 19 1
	setp.gt.s32 	%p61, %r65, 0;
	.loc	1 20 1
	add.f64 	%fd120, %fd119, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd121, %fd119, %fd120, %p61;
	.loc	1 20 1
	add.s32 	%r66, %r1, -2191;
	.loc	1 19 1
	setp.gt.s32 	%p62, %r66, 0;
	.loc	1 20 1
	add.f64 	%fd122, %fd121, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd123, %fd121, %fd122, %p62;
	.loc	1 20 1
	add.s32 	%r67, %r1, -2063;
	.loc	1 19 1
	setp.gt.s32 	%p63, %r67, 0;
	.loc	1 20 1
	add.f64 	%fd124, %fd123, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd125, %fd123, %fd124, %p63;
	.loc	1 20 1
	add.s32 	%r68, %r1, -1935;
	.loc	1 19 1
	setp.gt.s32 	%p64, %r68, 0;
	.loc	1 20 1
	add.f64 	%fd126, %fd125, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd127, %fd125, %fd126, %p64;
	.loc	1 20 1
	add.s32 	%r69, %r1, -1807;
	.loc	1 19 1
	setp.gt.s32 	%p65, %r69, 0;
	.loc	1 20 1
	add.f64 	%fd128, %fd127, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd129, %fd127, %fd128, %p65;
	.loc	1 20 1
	add.s32 	%r70, %r1, -1679;
	.loc	1 19 1
	setp.gt.s32 	%p66, %r70, 0;
	.loc	1 20 1
	add.f64 	%fd130, %fd129, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd131, %fd129, %fd130, %p66;
	.loc	1 20 1
	add.s32 	%r71, %r1, -1551;
	.loc	1 19 1
	setp.gt.s32 	%p67, %r71, 0;
	.loc	1 20 1
	add.f64 	%fd132, %fd131, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd133, %fd131, %fd132, %p67;
	.loc	1 20 1
	add.s32 	%r72, %r1, -1423;
	.loc	1 19 1
	setp.gt.s32 	%p68, %r72, 0;
	.loc	1 20 1
	add.f64 	%fd134, %fd133, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd135, %fd133, %fd134, %p68;
	.loc	1 20 1
	add.s32 	%r73, %r1, -1295;
	.loc	1 19 1
	setp.gt.s32 	%p69, %r73, 0;
	.loc	1 20 1
	add.f64 	%fd136, %fd135, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd137, %fd135, %fd136, %p69;
	.loc	1 20 1
	add.s32 	%r74, %r1, -1167;
	.loc	1 19 1
	setp.gt.s32 	%p70, %r74, 0;
	.loc	1 20 1
	add.f64 	%fd138, %fd137, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd139, %fd137, %fd138, %p70;
	.loc	1 20 1
	add.s32 	%r75, %r1, -1039;
	.loc	1 19 1
	setp.gt.s32 	%p71, %r75, 0;
	.loc	1 20 1
	add.f64 	%fd140, %fd139, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd141, %fd139, %fd140, %p71;
	.loc	1 20 1
	add.s32 	%r76, %r1, -911;
	.loc	1 19 1
	setp.gt.s32 	%p72, %r76, 0;
	.loc	1 20 1
	add.f64 	%fd142, %fd141, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd143, %fd141, %fd142, %p72;
	.loc	1 20 1
	add.s32 	%r77, %r1, -783;
	.loc	1 19 1
	setp.gt.s32 	%p73, %r77, 0;
	.loc	1 20 1
	add.f64 	%fd144, %fd143, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd145, %fd143, %fd144, %p73;
	.loc	1 20 1
	add.s32 	%r78, %r1, -655;
	.loc	1 19 1
	setp.gt.s32 	%p74, %r78, 0;
	.loc	1 20 1
	add.f64 	%fd146, %fd145, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd147, %fd145, %fd146, %p74;
	.loc	1 20 1
	add.s32 	%r79, %r1, -527;
	.loc	1 19 1
	setp.gt.s32 	%p75, %r79, 0;
	.loc	1 20 1
	add.f64 	%fd148, %fd147, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd149, %fd147, %fd148, %p75;
	.loc	1 20 1
	add.s32 	%r80, %r1, -399;
	.loc	1 19 1
	setp.gt.s32 	%p76, %r80, 0;
	.loc	1 20 1
	add.f64 	%fd150, %fd149, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd151, %fd149, %fd150, %p76;
	.loc	1 20 1
	add.s32 	%r81, %r1, -271;
	.loc	1 19 1
	setp.gt.s32 	%p77, %r81, 0;
	.loc	1 20 1
	add.f64 	%fd152, %fd151, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd153, %fd151, %fd152, %p77;
	.loc	1 20 1
	add.s32 	%r82, %r1, -143;
	.loc	1 19 1
	setp.gt.s32 	%p78, %r82, 0;
	.loc	1 20 1
	add.f64 	%fd154, %fd153, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd155, %fd153, %fd154, %p78;
	.loc	1 20 1
	add.s32 	%r83, %r1, -15;
	.loc	1 19 1
	setp.gt.s32 	%p79, %r83, 0;
	.loc	1 20 1
	add.f64 	%fd156, %fd155, 0d3FF0000000000000;
	.loc	1 19 1
	selp.f64 	%fd157, %fd155, %fd156, %p79;
	cvta.to.shared.u64 	%rd6, %rd5;
	shl.b32 	%r84, %r1, 3;
	cvt.s64.s32 	%rd7, %r84;
	add.s64 	%rd2, %rd6, %rd7;
	st.shared.f64 	[%rd2], %fd157;
	mov.u32 	%r89, 128;
	bra.uni 	LBB1_1;

LBB1_3:
	shl.b32 	%r88, %r3, 3;
	cvt.s64.s32 	%rd8, %r88;
	add.s64 	%rd9, %rd2, %rd8;
	ld.shared.f64 	%fd158, [%rd9];
	ld.shared.f64 	%fd159, [%rd2];
	add.f64 	%fd160, %fd159, %fd158;
	st.shared.f64 	[%rd2], %fd160;
	mov.u32 	%r89, %r3;

LBB1_1:
	bar.sync 	0;
	setp.lt.s32 	%p80, %r89, 2;
	@%p80 bra 	LBB1_4;

	bar.sync 	0;
	add.s32 	%r85, %r89, 1;
	shr.s32 	%r3, %r85, 1;
	sub.s32 	%r86, %r1, %r89;
	add.s32 	%r87, %r86, %r3;
	setp.gt.s32 	%p81, %r87, -1;
	mov.u32 	%r89, %r3;
	@%p81 bra 	LBB1_1;
	bra.uni 	LBB1_3;

LBB1_4:
	setp.ne.s32 	%p82, %r1, 0;
	@%p82 bra 	LBB1_6;

	.loc	1 0 1
	ld.param.u64 	%rd11, [main_17_gpu_param_0];
	.loc	1 19 1
	cvta.to.global.u64 	%rd10, %rd11;
	ld.shared.f64 	%fd161, [%rd2];
	ld.global.f64 	%fd162, [%rd10];
	add.f64 	%fd163, %fd162, %fd161;
	st.global.f64 	[%rd10], %fd163;

LBB1_6:
	ret;
Ltmp2:
Lfunc_end1:

}

	.file	1 "/path/to/test.c"
string-delimiter
      )

(define ptx-sample2-out
'((module ".version 7.2")
  (module ".target sm_70")
  (module ".address_size 64")
  (linking ".extern" (storageN ".shared" ".align 8" ".b8" "S18_main_17_gpu[]"))
  (linking
   ".visible"
   (kernel
    "main_11_gpu"
    (storage ".param" ".u64" "main_11_gpu_param_0")
    (".maxntid" "128" "1" "1")
    (storageN ".reg" ".pred" "%p<6>")
    (storageN ".reg" ".b32" "%r<19>")
    (storageN ".reg" ".b64" "%rd<14>")
    (debugging ".loc" "1" "11" "0")
    "Lfunc_begin0:"
    (debugging ".loc" "1" "11" "0")
    (instruction "ld" ".param" ".u64" "%rd2" "[main_11_gpu_param_0]")
    (instruction "mov" ".u32" "%r18" "%tid.x")
    (instruction "add" ".s32" "%r17" "%r18" "-9999")
    (instruction "mov" ".u32" "%r16" "9616")
    (instruction "cvta" ".to" ".global" ".u64" "%rd1" "%rd2")
    (instruction "bra" ".uni" "LBB0_1")
    "LBB0_11:"
    "Ltmp0:"
    (debugging ".loc" "1" "15" "1")
    (instruction "add" ".s32" "%r18" "%r18" "512")
    (instruction "add" ".s32" "%r16" "%r16" "-512")
    (instruction "add" ".s32" "%r17" "%r7" "128")
    "LBB0_1:"
    (debugging ".loc" "1" "14" "1")
    (instruction "setp" ".gt" ".s32" "%p1" "%r17" "0")
    "@%p1"
    (instruction "bra" "LBB0_3")
    (debugging ".loc" "1" "15" "1")
    (instruction "mul" ".wide" ".s32" "%rd3" "%r18" "4")
    (instruction "add" ".s64" "%rd4" "%rd1" "%rd3")
    (instruction "st" ".global" ".u32" "[%rd4]" "%r18")
    "LBB0_3:"
    (instruction "add" ".s32" "%r12" "%r17" "128")
    (debugging ".loc" "1" "14" "1")
    (instruction "setp" ".gt" ".s32" "%p2" "%r12" "0")
    "@%p2"
    (instruction "bra" "LBB0_5")
    (debugging ".loc" "1" "15" "1")
    (instruction "mul" ".wide" ".s32" "%rd5" "%r18" "4")
    (instruction "add" ".s64" "%rd7" "%rd1" "%rd5")
    (instruction "add" ".s32" "%r13" "%r18" "128")
    (instruction "st" ".global" ".u32" "[%rd7+512]" "%r13")
    "LBB0_5:"
    (debugging ".loc" "1" "14" "1")
    (instruction "add" ".s32" "%r6" "%r17" "256")
    (instruction "setp" ".gt" ".s32" "%p3" "%r6" "0")
    "@%p3"
    (instruction "bra" "LBB0_7")
    (debugging ".loc" "1" "15" "1")
    (instruction "mul" ".wide" ".s32" "%rd9" "%r18" "4")
    (instruction "add" ".s64" "%rd10" "%rd1" "%rd9")
    (instruction "add" ".s32" "%r14" "%r17" "10255")
    (instruction "st" ".global" ".u32" "[%rd10+1024]" "%r14")
    "LBB0_7:"
    (debugging ".loc" "1" "14" "1")
    (instruction "setp" ".gt" ".s32" "%p4" "%r16" "0")
    "@%p4"
    (instruction "bra" "LBB0_9")
    (instruction "bra" ".uni" "LBB0_8")
    "LBB0_9:"
    (instruction "add" ".s32" "%r7" "%r6" "128")
    (instruction "setp" ".gt" ".s32" "%p5" "%r7" "0")
    "@%p5"
    (instruction "bra" "LBB0_11")
    (debugging ".loc" "1" "15" "1")
    (instruction "mul" ".wide" ".s32" "%rd12" "%r18" "4")
    (instruction "add" ".s64" "%rd13" "%rd1" "%rd12")
    (instruction "add" ".s32" "%r15" "%r17" "10383")
    (instruction "st" ".global" ".u32" "[%rd13+1536]" "%r15")
    (instruction "bra" ".uni" "LBB0_11")
    "LBB0_8:"
    (debugging ".loc" "1" "14" "1")
    (instruction "ret")
    "Ltmp1:"
    "Lfunc_end0:"))
  (linking
   ".visible"
   (kernel
    "main_17_gpu"
    (storage ".param" ".u64" "main_17_gpu_param_0")
    (".maxntid" "128" "1" "1")
    (storageN ".reg" ".pred" "%p<83>")
    (storageN ".reg" ".b32" "%r<90>")
    (storageN ".reg" ".f64" "%fd<164>")
    (storageN ".reg" ".b64" "%rd<12>")
    (debugging ".loc" "1" "17" "0")
    "Lfunc_begin1:"
    (debugging ".loc" "1" "17" "0")
    (debugging ".loc" "1" "19" "1")
    (instruction "mov" ".u32" "%r1" "%tid.x")
    (instruction "add" ".s32" "%r5" "%r1" "-9999")
    (instruction "mov" ".u64" "%rd4" "S18_main_17_gpu")
    (instruction "cvta" ".shared" ".u64" "%rd5" "%rd4")
    (instruction "setp" ".gt" ".s32" "%p1" "%r5" "0")
    (instruction
     "selp"
     ".f64"
     "%fd1"
     "0d0000000000000000"
     "0d3FF0000000000000"
     "%p1")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r6" "%r1" "-9871")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p2" "%r6" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd2" "%fd1" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd3" "%fd1" "%fd2" "%p2")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r7" "%r1" "-9743")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p3" "%r7" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd4" "%fd3" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd5" "%fd3" "%fd4" "%p3")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r8" "%r1" "-9615")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p4" "%r8" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd6" "%fd5" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd7" "%fd5" "%fd6" "%p4")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r9" "%r1" "-9487")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p5" "%r9" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd8" "%fd7" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd9" "%fd7" "%fd8" "%p5")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r10" "%r1" "-9359")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p6" "%r10" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd10" "%fd9" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd11" "%fd9" "%fd10" "%p6")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r11" "%r1" "-9231")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p7" "%r11" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd12" "%fd11" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd13" "%fd11" "%fd12" "%p7")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r12" "%r1" "-9103")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p8" "%r12" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd14" "%fd13" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd15" "%fd13" "%fd14" "%p8")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r13" "%r1" "-8975")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p9" "%r13" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd16" "%fd15" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd17" "%fd15" "%fd16" "%p9")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r14" "%r1" "-8847")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p10" "%r14" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd18" "%fd17" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd19" "%fd17" "%fd18" "%p10")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r15" "%r1" "-8719")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p11" "%r15" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd20" "%fd19" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd21" "%fd19" "%fd20" "%p11")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r16" "%r1" "-8591")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p12" "%r16" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd22" "%fd21" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd23" "%fd21" "%fd22" "%p12")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r17" "%r1" "-8463")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p13" "%r17" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd24" "%fd23" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd25" "%fd23" "%fd24" "%p13")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r18" "%r1" "-8335")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p14" "%r18" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd26" "%fd25" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd27" "%fd25" "%fd26" "%p14")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r19" "%r1" "-8207")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p15" "%r19" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd28" "%fd27" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd29" "%fd27" "%fd28" "%p15")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r20" "%r1" "-8079")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p16" "%r20" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd30" "%fd29" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd31" "%fd29" "%fd30" "%p16")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r21" "%r1" "-7951")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p17" "%r21" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd32" "%fd31" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd33" "%fd31" "%fd32" "%p17")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r22" "%r1" "-7823")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p18" "%r22" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd34" "%fd33" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd35" "%fd33" "%fd34" "%p18")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r23" "%r1" "-7695")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p19" "%r23" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd36" "%fd35" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd37" "%fd35" "%fd36" "%p19")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r24" "%r1" "-7567")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p20" "%r24" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd38" "%fd37" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd39" "%fd37" "%fd38" "%p20")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r25" "%r1" "-7439")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p21" "%r25" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd40" "%fd39" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd41" "%fd39" "%fd40" "%p21")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r26" "%r1" "-7311")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p22" "%r26" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd42" "%fd41" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd43" "%fd41" "%fd42" "%p22")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r27" "%r1" "-7183")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p23" "%r27" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd44" "%fd43" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd45" "%fd43" "%fd44" "%p23")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r28" "%r1" "-7055")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p24" "%r28" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd46" "%fd45" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd47" "%fd45" "%fd46" "%p24")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r29" "%r1" "-6927")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p25" "%r29" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd48" "%fd47" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd49" "%fd47" "%fd48" "%p25")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r30" "%r1" "-6799")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p26" "%r30" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd50" "%fd49" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd51" "%fd49" "%fd50" "%p26")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r31" "%r1" "-6671")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p27" "%r31" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd52" "%fd51" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd53" "%fd51" "%fd52" "%p27")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r32" "%r1" "-6543")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p28" "%r32" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd54" "%fd53" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd55" "%fd53" "%fd54" "%p28")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r33" "%r1" "-6415")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p29" "%r33" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd56" "%fd55" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd57" "%fd55" "%fd56" "%p29")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r34" "%r1" "-6287")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p30" "%r34" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd58" "%fd57" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd59" "%fd57" "%fd58" "%p30")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r35" "%r1" "-6159")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p31" "%r35" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd60" "%fd59" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd61" "%fd59" "%fd60" "%p31")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r36" "%r1" "-6031")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p32" "%r36" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd62" "%fd61" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd63" "%fd61" "%fd62" "%p32")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r37" "%r1" "-5903")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p33" "%r37" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd64" "%fd63" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd65" "%fd63" "%fd64" "%p33")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r38" "%r1" "-5775")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p34" "%r38" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd66" "%fd65" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd67" "%fd65" "%fd66" "%p34")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r39" "%r1" "-5647")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p35" "%r39" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd68" "%fd67" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd69" "%fd67" "%fd68" "%p35")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r40" "%r1" "-5519")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p36" "%r40" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd70" "%fd69" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd71" "%fd69" "%fd70" "%p36")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r41" "%r1" "-5391")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p37" "%r41" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd72" "%fd71" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd73" "%fd71" "%fd72" "%p37")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r42" "%r1" "-5263")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p38" "%r42" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd74" "%fd73" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd75" "%fd73" "%fd74" "%p38")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r43" "%r1" "-5135")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p39" "%r43" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd76" "%fd75" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd77" "%fd75" "%fd76" "%p39")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r44" "%r1" "-5007")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p40" "%r44" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd78" "%fd77" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd79" "%fd77" "%fd78" "%p40")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r45" "%r1" "-4879")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p41" "%r45" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd80" "%fd79" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd81" "%fd79" "%fd80" "%p41")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r46" "%r1" "-4751")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p42" "%r46" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd82" "%fd81" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd83" "%fd81" "%fd82" "%p42")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r47" "%r1" "-4623")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p43" "%r47" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd84" "%fd83" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd85" "%fd83" "%fd84" "%p43")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r48" "%r1" "-4495")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p44" "%r48" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd86" "%fd85" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd87" "%fd85" "%fd86" "%p44")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r49" "%r1" "-4367")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p45" "%r49" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd88" "%fd87" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd89" "%fd87" "%fd88" "%p45")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r50" "%r1" "-4239")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p46" "%r50" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd90" "%fd89" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd91" "%fd89" "%fd90" "%p46")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r51" "%r1" "-4111")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p47" "%r51" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd92" "%fd91" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd93" "%fd91" "%fd92" "%p47")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r52" "%r1" "-3983")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p48" "%r52" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd94" "%fd93" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd95" "%fd93" "%fd94" "%p48")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r53" "%r1" "-3855")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p49" "%r53" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd96" "%fd95" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd97" "%fd95" "%fd96" "%p49")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r54" "%r1" "-3727")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p50" "%r54" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd98" "%fd97" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd99" "%fd97" "%fd98" "%p50")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r55" "%r1" "-3599")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p51" "%r55" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd100" "%fd99" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd101" "%fd99" "%fd100" "%p51")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r56" "%r1" "-3471")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p52" "%r56" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd102" "%fd101" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd103" "%fd101" "%fd102" "%p52")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r57" "%r1" "-3343")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p53" "%r57" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd104" "%fd103" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd105" "%fd103" "%fd104" "%p53")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r58" "%r1" "-3215")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p54" "%r58" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd106" "%fd105" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd107" "%fd105" "%fd106" "%p54")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r59" "%r1" "-3087")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p55" "%r59" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd108" "%fd107" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd109" "%fd107" "%fd108" "%p55")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r60" "%r1" "-2959")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p56" "%r60" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd110" "%fd109" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd111" "%fd109" "%fd110" "%p56")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r61" "%r1" "-2831")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p57" "%r61" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd112" "%fd111" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd113" "%fd111" "%fd112" "%p57")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r62" "%r1" "-2703")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p58" "%r62" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd114" "%fd113" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd115" "%fd113" "%fd114" "%p58")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r63" "%r1" "-2575")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p59" "%r63" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd116" "%fd115" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd117" "%fd115" "%fd116" "%p59")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r64" "%r1" "-2447")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p60" "%r64" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd118" "%fd117" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd119" "%fd117" "%fd118" "%p60")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r65" "%r1" "-2319")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p61" "%r65" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd120" "%fd119" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd121" "%fd119" "%fd120" "%p61")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r66" "%r1" "-2191")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p62" "%r66" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd122" "%fd121" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd123" "%fd121" "%fd122" "%p62")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r67" "%r1" "-2063")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p63" "%r67" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd124" "%fd123" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd125" "%fd123" "%fd124" "%p63")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r68" "%r1" "-1935")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p64" "%r68" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd126" "%fd125" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd127" "%fd125" "%fd126" "%p64")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r69" "%r1" "-1807")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p65" "%r69" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd128" "%fd127" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd129" "%fd127" "%fd128" "%p65")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r70" "%r1" "-1679")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p66" "%r70" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd130" "%fd129" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd131" "%fd129" "%fd130" "%p66")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r71" "%r1" "-1551")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p67" "%r71" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd132" "%fd131" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd133" "%fd131" "%fd132" "%p67")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r72" "%r1" "-1423")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p68" "%r72" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd134" "%fd133" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd135" "%fd133" "%fd134" "%p68")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r73" "%r1" "-1295")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p69" "%r73" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd136" "%fd135" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd137" "%fd135" "%fd136" "%p69")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r74" "%r1" "-1167")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p70" "%r74" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd138" "%fd137" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd139" "%fd137" "%fd138" "%p70")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r75" "%r1" "-1039")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p71" "%r75" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd140" "%fd139" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd141" "%fd139" "%fd140" "%p71")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r76" "%r1" "-911")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p72" "%r76" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd142" "%fd141" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd143" "%fd141" "%fd142" "%p72")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r77" "%r1" "-783")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p73" "%r77" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd144" "%fd143" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd145" "%fd143" "%fd144" "%p73")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r78" "%r1" "-655")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p74" "%r78" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd146" "%fd145" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd147" "%fd145" "%fd146" "%p74")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r79" "%r1" "-527")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p75" "%r79" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd148" "%fd147" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd149" "%fd147" "%fd148" "%p75")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r80" "%r1" "-399")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p76" "%r80" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd150" "%fd149" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd151" "%fd149" "%fd150" "%p76")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r81" "%r1" "-271")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p77" "%r81" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd152" "%fd151" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd153" "%fd151" "%fd152" "%p77")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r82" "%r1" "-143")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p78" "%r82" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd154" "%fd153" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd155" "%fd153" "%fd154" "%p78")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".s32" "%r83" "%r1" "-15")
    (debugging ".loc" "1" "19" "1")
    (instruction "setp" ".gt" ".s32" "%p79" "%r83" "0")
    (debugging ".loc" "1" "20" "1")
    (instruction "add" ".f64" "%fd156" "%fd155" "0d3FF0000000000000")
    (debugging ".loc" "1" "19" "1")
    (instruction "selp" ".f64" "%fd157" "%fd155" "%fd156" "%p79")
    (instruction "cvta" ".to" ".shared" ".u64" "%rd6" "%rd5")
    (instruction "shl" ".b32" "%r84" "%r1" "3")
    (instruction "cvt" ".s64" ".s32" "%rd7" "%r84")
    (instruction "add" ".s64" "%rd2" "%rd6" "%rd7")
    (instruction "st" ".shared" ".f64" "[%rd2]" "%fd157")
    (instruction "mov" ".u32" "%r89" "128")
    (instruction "bra" ".uni" "LBB1_1")
    "LBB1_3:"
    (instruction "shl" ".b32" "%r88" "%r3" "3")
    (instruction "cvt" ".s64" ".s32" "%rd8" "%r88")
    (instruction "add" ".s64" "%rd9" "%rd2" "%rd8")
    (instruction "ld" ".shared" ".f64" "%fd158" "[%rd9]")
    (instruction "ld" ".shared" ".f64" "%fd159" "[%rd2]")
    (instruction "add" ".f64" "%fd160" "%fd159" "%fd158")
    (instruction "st" ".shared" ".f64" "[%rd2]" "%fd160")
    (instruction "mov" ".u32" "%r89" "%r3")
    "LBB1_1:"
    (instruction "bar" ".sync" "0")
    (instruction "setp" ".lt" ".s32" "%p80" "%r89" "2")
    "@%p80"
    (instruction "bra" "LBB1_4")
    (instruction "bar" ".sync" "0")
    (instruction "add" ".s32" "%r85" "%r89" "1")
    (instruction "shr" ".s32" "%r3" "%r85" "1")
    (instruction "sub" ".s32" "%r86" "%r1" "%r89")
    (instruction "add" ".s32" "%r87" "%r86" "%r3")
    (instruction "setp" ".gt" ".s32" "%p81" "%r87" "-1")
    (instruction "mov" ".u32" "%r89" "%r3")
    "@%p81"
    (instruction "bra" "LBB1_1")
    (instruction "bra" ".uni" "LBB1_3")
    "LBB1_4:"
    (instruction "setp" ".ne" ".s32" "%p82" "%r1" "0")
    "@%p82"
    (instruction "bra" "LBB1_6")
    (debugging ".loc" "1" "0" "1")
    (instruction "ld" ".param" ".u64" "%rd11" "[main_17_gpu_param_0]")
    (debugging ".loc" "1" "19" "1")
    (instruction "cvta" ".to" ".global" ".u64" "%rd10" "%rd11")
    (instruction "ld" ".shared" ".f64" "%fd161" "[%rd2]")
    (instruction "ld" ".global" ".f64" "%fd162" "[%rd10]")
    (instruction "add" ".f64" "%fd163" "%fd162" "%fd161")
    (instruction "st" ".global" ".f64" "[%rd10]" "%fd163")
    "LBB1_6:"
    (instruction "ret")
    "Ltmp2:"
    "Lfunc_end1:"))
  (debugging ".file" "1" "\"/path/to/test.c\""))
  )

(define ptx-sample3
  #<<string-delimiter

	.version	3.1
	.target	sm_35
	.address_size 64




.entry main$_omp_fn$0 (.param.u64 %in_ar0);


.entry main$_omp_fn$0 (.param.u64 %in_ar0)
{
	.reg.u64 %ar0;
	ld.param.u64 %ar0, [%in_ar0];
	.reg.u32 %r23;
	.reg.u64 %r24;
	.reg.u64 %r26;
	.reg.pred %r27;
	.reg.pred %r28;
	.reg.pred %r29;
	.reg.u32 %r30;
	{
		.reg.u32	%x;
		mov.u32	%x, %tid.x;
		setp.ne.u32	%r28, %x, 0;
	}
	@%r28	bra	$L6;
		mov.u64	%r26, %ar0;
		ld.u64	%r24, [%r26];
		mov.u32	%r23, 0;
$L6:
$L2:
		setp.eq.u32	%r29, 1, 0;
	@%r28	bra	$L5;
		st.u32	[%r24], %r23;
		add.u32	%r23, %r23, 1;
		add.u64	%r24, %r24, 4;
		setp.ne.u32	%r27, %r23, 10000;
		mov.pred	%r29, %r27;
$L5:
		mov.pred	%r27, %r29;
		selp.u32	%r30, 1, 0, %r27;
		shfl.idx.b32	%r30, %r30, 0, 31;
		setp.ne.u32	%r27, %r30, 0;
	@%r27	bra.uni	$L2;
	ret;
}


.entry main$_omp_fn$1 (.param.u64 %in_ar0);


.entry main$_omp_fn$1 (.param.u64 %in_ar0)
{
	.reg.u64 %ar0;
	ld.param.u64 %ar0, [%in_ar0];
	.reg.u64 %r22;
	.reg.u32 %r23;
	.reg.f64 %r24;
	.reg.u64 %r25;
	.reg.u64 %r26;
	.reg.u64 %r30;
	.reg.f64 %r31;
	.reg.f64 %r32;
	.reg.u64 %r33;
	.reg.pred %r34;
	.reg.pred %r35;
	.reg.pred %r36;
	{
		.reg.u32	%x;
		mov.u32	%x, %tid.x;
		setp.ne.u32	%r36, %x, 0;
	}
	@%r36	bra	$L13;
		mov.u64	%r30, %ar0;
		ld.u64	%r22, [%r30];
		mov.u32	%r23, 10000;
		mov.f64	%r24, 0d0000000000000000;
		bra	$L8;
$L9:
		mov.u64	%r25, %r26;
		mov.b64	%r32, %r26;
		add.f64	%r31, %r24, %r32;
		mov.b64	%r33, %r31;
		atom.cas.b64	%r26, [%r22], %r26, %r33;
		setp.ne.u64	%r34, %r25, %r26;
	@%r34	bra	$L9;
$L13:
		bra	$L12;
$L8:
		add.f64	%r24, %r24, 0d3ff0000000000000;
		add.u32	%r23, %r23, -1;
		setp.ne.u32	%r35, %r23, 0;
	@%r35	bra	$L8;
		mov.u64	%r26, 0;
		bra	$L9;
$L12:
	ret;
}

string-delimiter
      )

(define ptx-sample3-out
'((module ".version\t3.1")
  (module ".target\tsm_35")
  (module ".address_size 64")
  (kernel "main$_omp_fn$0" (storage ".param" ".u64" "%in_ar0"))
  (kernel
   "main$_omp_fn$0"
   (storage ".param" ".u64" "%in_ar0")
   (storageN ".reg" ".u64" "%ar0")
   (instruction "ld" ".param" ".u64" "%ar0" "[%in_ar0]")
   (storageN ".reg" ".u32" "%r23")
   (storageN ".reg" ".u64" "%r24")
   (storageN ".reg" ".u64" "%r26")
   (storageN ".reg" ".pred" "%r27")
   (storageN ".reg" ".pred" "%r28")
   (storageN ".reg" ".pred" "%r29")
   (storageN ".reg" ".u32" "%r30")
   (group
    (storageN ".reg" ".u32" "%x")
    (instruction "mov" ".u32" "%x" "%tid.x")
    (instruction "setp" ".ne" ".u32" "%r28" "%x" "0"))
   "@%r28"
   (instruction "bra" "$L6")
   (instruction "mov" ".u64" "%r26" "%ar0")
   (instruction "ld" ".u64" "%r24" "[%r26]")
   (instruction "mov" ".u32" "%r23" "0")
   "$L6:"
   "$L2:"
   (instruction "setp" ".eq" ".u32" "%r29" "1" "0")
   "@%r28"
   (instruction "bra" "$L5")
   (instruction "st" ".u32" "[%r24]" "%r23")
   (instruction "add" ".u32" "%r23" "%r23" "1")
   (instruction "add" ".u64" "%r24" "%r24" "4")
   (instruction "setp" ".ne" ".u32" "%r27" "%r23" "10000")
   (instruction "mov" ".pred" "%r29" "%r27")
   "$L5:"
   (instruction "mov" ".pred" "%r27" "%r29")
   (instruction "selp" ".u32" "%r30" "1" "0" "%r27")
   (instruction "shfl" ".idx" ".b32" "%r30" "%r30" "0" "31")
   (instruction "setp" ".ne" ".u32" "%r27" "%r30" "0")
   "@%r27"
   (instruction "bra" ".uni" "$L2")
   (instruction "ret"))
  (kernel "main$_omp_fn$1" (storage ".param" ".u64" "%in_ar0"))
  (kernel
   "main$_omp_fn$1"
   (storage ".param" ".u64" "%in_ar0")
   (storageN ".reg" ".u64" "%ar0")
   (instruction "ld" ".param" ".u64" "%ar0" "[%in_ar0]")
   (storageN ".reg" ".u64" "%r22")
   (storageN ".reg" ".u32" "%r23")
   (storageN ".reg" ".f64" "%r24")
   (storageN ".reg" ".u64" "%r25")
   (storageN ".reg" ".u64" "%r26")
   (storageN ".reg" ".u64" "%r30")
   (storageN ".reg" ".f64" "%r31")
   (storageN ".reg" ".f64" "%r32")
   (storageN ".reg" ".u64" "%r33")
   (storageN ".reg" ".pred" "%r34")
   (storageN ".reg" ".pred" "%r35")
   (storageN ".reg" ".pred" "%r36")
   (group
    (storageN ".reg" ".u32" "%x")
    (instruction "mov" ".u32" "%x" "%tid.x")
    (instruction "setp" ".ne" ".u32" "%r36" "%x" "0"))
   "@%r36"
   (instruction "bra" "$L13")
   (instruction "mov" ".u64" "%r30" "%ar0")
   (instruction "ld" ".u64" "%r22" "[%r30]")
   (instruction "mov" ".u32" "%r23" "10000")
   (instruction "mov" ".f64" "%r24" "0d0000000000000000")
   (instruction "bra" "$L8")
   "$L9:"
   (instruction "mov" ".u64" "%r25" "%r26")
   (instruction "mov" ".b64" "%r32" "%r26")
   (instruction "add" ".f64" "%r31" "%r24" "%r32")
   (instruction "mov" ".b64" "%r33" "%r31")
   (instruction "atom" ".cas" ".b64" "%r26" "[%r22]" "%r26" "%r33")
   (instruction "setp" ".ne" ".u64" "%r34" "%r25" "%r26")
   "@%r34"
   (instruction "bra" "$L9")
   "$L13:"
   (instruction "bra" "$L12")
   "$L8:"
   (instruction "add" ".f64" "%r24" "%r24" "0d3ff0000000000000")
   (instruction "add" ".u32" "%r23" "%r23" "-1")
   (instruction "setp" ".ne" ".u32" "%r35" "%r23" "0")
   "@%r35"
   (instruction "bra" "$L8")
   (instruction "mov" ".u64" "%r26" "0")
   (instruction "bra" "$L9")
   "$L12:"
   (instruction "ret")))
  )

(define ptx-sample4
  #<<string-delimiter
.entry compute_rhs$_omp_fn$0 (.param.u64 %in_ar0)
{
	.reg.u64 %ar0;
	ld.param.u64 %ar0, [%in_ar0];
	.reg.f64 %r22;
	.reg.u32 %r23;
	.reg.u32 %r27;
	.reg.u32 %r31;
	.reg.f64 %r33;
	.reg.u32 %r34;
	.reg.f64 %r35;
	.reg.f64 %r39;
	.reg.u32 %r40;
	.reg.f64 %r44;
	.reg.u64 %r47;
	.reg.f64 %r49;
	.reg.u64 %r50;
	.reg.u64 %r53;
	.reg.u64 %r56;
	.reg.u64 %r59;
	.reg.f64 %r60;
	.reg.f64 %r61;
	.reg.f64 %r63;
	.reg.f64 %r64;
	.reg.f64 %r65;
	.reg.f64 %r67;
	.reg.u64 %r68;
	.reg.u64 %r70;
	.reg.f64 %r78;
	.reg.u32 %r79;
	.reg.u32 %r80;
	.reg.u32 %r84;
	.reg.f64 %r85;
	.reg.f64 %r86;
	.reg.u32 %r90;
	.reg.u32 %r91;
	.reg.u32 %r93;
	.reg.f64 %r94;
	.reg.f64 %r95;
	.reg.f64 %r97;
	.reg.f64 %r98;
	.reg.f64 %r99;
	.reg.f64 %r101;
	.reg.u32 %r103;
	.reg.f64 %r106;
	.reg.f64 %r113;
	.reg.f64 %r114;
	.reg.f64 %r116;
	.reg.f64 %r117;
	.reg.f64 %r118;
	.reg.f64 %r120;
	.reg.u32 %r122;
	.reg.f64 %r124;
	.reg.f64 %r131;
	.reg.f64 %r132;
	.reg.f64 %r134;
	.reg.f64 %r135;
	.reg.f64 %r136;
	.reg.f64 %r138;
	.reg.u32 %r140;
	.reg.f64 %r143;
	.reg.f64 %r150;
	.reg.f64 %r151;
	.reg.f64 %r153;
	.reg.f64 %r154;
	.reg.f64 %r155;
	.reg.f64 %r157;
	.reg.u32 %r159;
	.reg.u64 %r161;
	.reg.u64 %r164;
	.reg.u64 %r168;
	.reg.u64 %r172;
	.reg.u64 %r176;
	.reg.u64 %r180;
	.reg.u64 %r184;
	.reg.u64 %r185;
	.reg.u64 %r186;
	.reg.u32 %r187;
	.reg.u32 %r188;
	.reg.u32 %r189;
	.reg.pred %r190;
	.reg.u64 %r191;
	.reg.u64 %r192;
	.reg.u32 %r193;
	.reg.pred %r194;
	.reg.pred %r195;
	.reg.u64 %r196;
	.reg.u64 %r198;
	.reg.u64 %r201;
	.reg.u64 %r202;
	.reg.u64 %r203;
	.reg.u64 %r204;
	.reg.f64 %r206;
	.reg.u64 %r215;
	.reg.u64 %r218;
	.reg.u64 %r221;
	.reg.u64 %r222;
	.reg.u64 %r231;
	.reg.f64 %r232;
	.reg.f64 %r233;
	.reg.u64 %r242;
	.reg.f64 %r243;
	.reg.f64 %r244;
	.reg.u64 %r253;
	.reg.f64 %r254;
	.reg.f64 %r255;
	.reg.f64 %r256;
	.reg.f64 %r257;
	.reg.u64 %r266;
	.reg.u64 %r275;
	.reg.f64 %r276;
	.reg.pred %r277;
	.reg.u64 %r278;
	.reg.u64 %r284;
	.reg.u64 %r285;
	.reg.u64 %r286;
	.reg.f64 %r288;
	.reg.u64 %r297;
	.reg.u64 %r299;
	.reg.u64 %r300;
	.reg.u64 %r309;
	.reg.f64 %r310;
	.reg.f64 %r311;
	.reg.u64 %r320;
	.reg.f64 %r321;
	.reg.f64 %r322;
	.reg.u64 %r331;
	.reg.f64 %r332;
	.reg.f64 %r333;
	.reg.f64 %r334;
	.reg.f64 %r335;
	.reg.u64 %r344;
	.reg.u64 %r353;
	.reg.f64 %r354;
	.reg.pred %r355;
	.reg.u64 %r356;
	.reg.u64 %r362;
	.reg.u64 %r363;
	.reg.u64 %r364;
	.reg.f64 %r366;
	.reg.u64 %r375;
	.reg.u64 %r377;
	.reg.u64 %r378;
	.reg.u64 %r387;
	.reg.f64 %r388;
	.reg.f64 %r389;
	.reg.u64 %r398;
	.reg.f64 %r399;
	.reg.f64 %r400;
	.reg.u64 %r409;
	.reg.f64 %r410;
	.reg.f64 %r411;
	.reg.f64 %r412;
	.reg.f64 %r413;
	.reg.u64 %r422;
	.reg.u64 %r431;
	.reg.f64 %r432;
	.reg.pred %r433;
	.reg.u64 %r434;
	.reg.u64 %r440;
	.reg.u64 %r441;
	.reg.u64 %r442;
	.reg.f64 %r444;
	.reg.u64 %r453;
	.reg.u64 %r455;
	.reg.u64 %r456;
	.reg.u64 %r465;
	.reg.f64 %r466;
	.reg.f64 %r467;
	.reg.u64 %r476;
	.reg.f64 %r477;
	.reg.f64 %r478;
	.reg.u64 %r487;
	.reg.f64 %r488;
	.reg.f64 %r489;
	.reg.f64 %r490;
	.reg.f64 %r491;
	.reg.u64 %r500;
	.reg.u64 %r509;
	.reg.f64 %r510;
	.reg.pred %r511;
	.reg.u64 %r512;
	.reg.u64 %r518;
	.reg.u64 %r519;
	.reg.u64 %r520;
	.reg.f64 %r522;
	.reg.u64 %r531;
	.reg.u64 %r533;
	.reg.u64 %r534;
	.reg.u64 %r543;
	.reg.f64 %r544;
	.reg.f64 %r545;
	.reg.u64 %r554;
	.reg.f64 %r555;
	.reg.f64 %r556;
	.reg.u64 %r565;
	.reg.f64 %r566;
	.reg.f64 %r567;
	.reg.f64 %r568;
	.reg.f64 %r569;
	.reg.u64 %r578;
	.reg.u64 %r587;
	.reg.f64 %r588;
	.reg.pred %r589;
	.reg.u64 %r590;
	.reg.u64 %r596;
	.reg.u64 %r597;
	.reg.u64 %r598;
	.reg.f64 %r600;
	.reg.u64 %r609;
	.reg.u64 %r611;
	.reg.u64 %r612;
	.reg.u64 %r621;
	.reg.f64 %r622;
	.reg.f64 %r623;
	.reg.u64 %r632;
	.reg.f64 %r633;
	.reg.f64 %r634;
	.reg.u64 %r643;
	.reg.f64 %r644;
	.reg.f64 %r645;
	.reg.f64 %r646;
	.reg.f64 %r647;
	.reg.u64 %r656;
	.reg.u64 %r665;
	.reg.f64 %r666;
	.reg.pred %r667;
	.reg.pred %r668;
	.reg.u64 %r669;
	.reg.u64 %r670;
	.reg.u64 %r672;
	.reg.u32 %r673;
	.reg.u32 %r674;
	.reg.f64 %r675;
	.reg.u32 %r677;
	.reg.u32 %r678;
	.reg.u32 %r679;
	.reg.u32 %r680;
	.reg.u32 %r681;
	.reg.u32 %r682;
	.reg.u32 %r683;
	.reg.u32 %r684;
	.reg.u64 %r685;
	.reg.u64 %r686;
	.reg.pred %r687;
	.reg.pred %r688;
	.reg.u32 %r689;
	.reg.pred %r690;
	.reg.u32 %r691;
	.reg.pred %r692;
	.reg.u32 %r693;
	.reg.u32 %r694;
	.reg.u32 %r695;
	.reg.u32 %r696;
	{
		.reg.u32	%y;
		mov.u32	%y, %tid.y;
		setp.ne.u32	%r692, %y, 0;
	}
	{
		.reg.u32	%x;
		mov.u32	%x, %tid.x;
		setp.ne.u32	%r687, %x, 0;
	}
	@%r692	bra.uni	$L23;
	@%r687	bra	$L24;
		mov.u64	%r185, %ar0;
		ld.u64	%r186, [%r185];
		ld.u32	%r27, [%r186];
		mov.u32	%r90, %ctaid.x;
		add.u32	%r187, %r27, 192;
		div.s32	%r84, %r187, 192;
		mul.lo.u32	%r23, %r84, %r90;
		add.u32	%r188, %r27, 1;
		add.u32	%r189, %r23, %r84;
		min.s32	%r34, %r188, %r189;
		setp.lt.s32	%r190, %r23, %r34;
		selp.u32	%r695, 1, 0, %r190;
		st.shared.u32	[__oacc_bcast], %r695;
$L24:
$L23:
		bar.sync	0;
		ld.shared.u32	%r696, [__oacc_bcast];
		setp.ne.u32	%r190, %r696, 0;
		bar.sync	0;
	@!%r190	bra.uni	$L1;
	@%r692	bra.uni	$L21;
	@%r687	bra	$L22;
		ld.u64	%r191, [%r185+16];
		ld.u32	%r31, [%r191];
		ld.u64	%r192, [%r185+8];
		ld.u32	%r193, [%r192];
		add.u32	%r79, %r193, 1;
		add.u32	%r673, %r31, 1;
		mov.u32	%r674, 26569;
		mov.f64	%r675, 0d3ff0000000000000;
$L22:
$L21:
$L10:
	
	@%r692	bra.uni	$L19;
	@%r687	bra	$L20;
		cvta.shared.u64	%r686, __oacc_bcast;
		st.u32	[%r686], %r23;
		st.u32	[%r686+4], %r34;
		st.u32	[%r686+8], %r79;
		st.u64	[%r686+16], %r185;
		st.u32	[%r686+24], %r673;
		st.u32	[%r686+28], %r674;
		st.f64	[%r686+32], %r675;
$L20:
$L19:
		setp.eq.u32	%r690, 1, 0;
		bar.sync	0;
	
	@%r687	bra	$L16;
		cvta.shared.u64	%r685, __oacc_bcast;
		ld.u32	%r23, [%r685];
		ld.u32	%r34, [%r685+4];
		ld.u32	%r79, [%r685+8];
		ld.u64	%r185, [%r685+16];
		ld.u32	%r673, [%r685+24];
		ld.u32	%r674, [%r685+28];
		ld.f64	%r675, [%r685+32];
		mov.u32	%r91, %tid.y;
		setp.gt.s32	%r194, %r79, %r91;
		mov.pred	%r690, %r194;
$L16:
		mov.pred	%r194, %r690;
		selp.u32	%r691, 1, 0, %r194;
		shfl.idx.b32	%r691, %r691, 0, 31;
		setp.ne.u32	%r194, %r691, 0;
	@%r194	bra.uni	$L3;
$L9:
	
		bar.sync	0;
	
	@%r692	bra.uni	$L17;
	@%r687	bra	$L18;
		add.u32	%r23, %r23, 1;
		setp.ne.u32	%r668, %r34, %r23;
		selp.u32	%r693, 1, 0, %r668;
		st.shared.u32	[__oacc_bcast], %r693;
$L18:
$L17:
		bar.sync	0;
		ld.shared.u32	%r694, [__oacc_bcast];
		setp.ne.u32	%r668, %r694, 0;
		bar.sync	0;
	@%r668	bra.uni	$L10;
		bra	$L1;
$L3:
	@%r687	bra	$L15;
		mov.u32	%r80, %r91;
		cvt.s64.s32	%r669, %r23;
		mul.lo.u64	%r670, %r669, 26569;
		mul.wide.s32	%r672, %r23, %r674;
$L15:
$L8:
	
	
		shfl.idx.b32	%r23, %r23, 0, 31;
		shfl.idx.b32	%r34, %r34, 0, 31;
		shfl.idx.b32	%r79, %r79, 0, 31;
		shfl.idx.b32	%r80, %r80, 0, 31;
		mov.b64	{%r677,%r678}, %r185;
		shfl.idx.b32	%r677, %r677, 0, 31;
		shfl.idx.b32	%r678, %r678, 0, 31;
		mov.b64	%r185, {%r677,%r678};
		mov.b64	{%r679,%r680}, %r670;
		shfl.idx.b32	%r679, %r679, 0, 31;
		shfl.idx.b32	%r680, %r680, 0, 31;
		mov.b64	%r670, {%r679,%r680};
		mov.b64	{%r681,%r682}, %r672;
		shfl.idx.b32	%r681, %r681, 0, 31;
		shfl.idx.b32	%r682, %r682, 0, 31;
		mov.b64	%r672, {%r681,%r682};
		shfl.idx.b32	%r673, %r673, 0, 31;
		shfl.idx.b32	%r674, %r674, 0, 31;
		mov.b64	{%r683,%r684}, %r675;
		shfl.idx.b32	%r683, %r683, 0, 31;
		shfl.idx.b32	%r684, %r684, 0, 31;
		mov.b64	%r675, {%r683,%r684};
		mov.u32	%r93, %tid.x;
		setp.gt.s32	%r195, %r673, %r93;
	@%r195	bra	$L5;
$L7:
	
		setp.eq.u32	%r688, 1, 0;
	
	@%r687	bra	$L14;
		add.u32	%r80, %r80, 16;
		setp.gt.s32	%r667, %r79, %r80;
		mov.pred	%r688, %r667;
$L14:
		mov.pred	%r667, %r688;
		selp.u32	%r689, 1, 0, %r667;
		shfl.idx.b32	%r689, %r689, 0, 31;
		setp.ne.u32	%r667, %r689, 0;
	@%r667	bra.uni	$L8;
		bra	$L9;
$L5:
		ld.u64	%r47, [%r185+32];
		ld.u64	%r50, [%r185+48];
		ld.u64	%r53, [%r185+80];
		ld.u64	%r56, [%r185+72];
		ld.u64	%r59, [%r185+64];
		ld.u64	%r68, [%r185+40];
		ld.u64	%r70, [%r185+56];
		cvt.s64.s32	%r196, %r93;
		cvt.s64.s32	%r198, %r80;
		mad.lo.u64	%r201, %r198, 163, %r670;
		add.u64	%r202, %r201, %r196;
		shl.b64	%r203, %r202, 3;
		add.u64	%r204, %r47, %r203;
		ld.f64	%r206, [%r204];
		div.rn.f64	%r78, %r675, %r206;
		add.u64	%r215, %r50, %r203;
		st.f64	[%r215], %r78;
		cvt.s64.s32	%r218, %r80;
		mad.lo.u64	%r161, %r218, 163, %r672;
		add.u64	%r221, %r196, %r161;
		shl.b64	%r222, %r221, 3;
		add.u64	%r164, %r47, %r222;
		add.u64	%r231, %r53, %r203;
		ld.f64	%r233, [%r164+34433424];
		mul.f64	%r232, %r233, %r78;
		st.f64	[%r231], %r232;
		add.u64	%r242, %r56, %r203;
		ld.f64	%r244, [%r164+68866848];
		mul.f64	%r243, %r244, %r78;
		st.f64	[%r242], %r243;
		add.u64	%r253, %r59, %r203;
		ld.f64	%r255, [%r164+103300272];
		mul.f64	%r254, %r255, %r78;
		st.f64	[%r253], %r254;
		ld.f64	%r33, [%r164+34433424];
		ld.f64	%r22, [%r164+68866848];
		mul.f64	%r256, %r22, %r22;
		fma.rn.f64	%r85, %r33, %r33, %r256;
		ld.f64	%r86, [%r164+103300272];
		fma.rn.f64	%r35, %r86, %r86, %r85;
		mul.f64	%r257, %r35, 0d3fe0000000000000;
		mul.f64	%r39, %r257, %r78;
		add.u64	%r266, %r68, %r203;
		st.f64	[%r266], %r39;
		add.u64	%r275, %r70, %r203;
		mul.f64	%r276, %r39, %r78;
		st.f64	[%r275], %r276;
		add.u32	%r40, %r93, 32;
		setp.ge.s32	%r277, %r40, %r673;
	@%r277	bra	$L7;
		cvt.s64.s32	%r278, %r40;
		add.u64	%r284, %r201, %r278;
		shl.b64	%r285, %r284, 3;
		add.u64	%r286, %r47, %r285;
		ld.f64	%r288, [%r286];
		div.rn.f64	%r44, %r675, %r288;
		add.u64	%r297, %r50, %r285;
		st.f64	[%r297], %r44;
		add.u64	%r299, %r278, %r161;
		shl.b64	%r300, %r299, 3;
		add.u64	%r168, %r47, %r300;
		add.u64	%r309, %r53, %r285;
		ld.f64	%r311, [%r168+34433424];
		mul.f64	%r310, %r311, %r44;
		st.f64	[%r309], %r310;
		add.u64	%r320, %r56, %r285;
		ld.f64	%r322, [%r168+68866848];
		mul.f64	%r321, %r322, %r44;
		st.f64	[%r320], %r321;
		add.u64	%r331, %r59, %r285;
		ld.f64	%r333, [%r168+103300272];
		mul.f64	%r332, %r333, %r44;
		st.f64	[%r331], %r332;
		ld.f64	%r94, [%r168+34433424];
		ld.f64	%r95, [%r168+68866848];
		mul.f64	%r334, %r95, %r95;
		fma.rn.f64	%r97, %r94, %r94, %r334;
		ld.f64	%r98, [%r168+103300272];
		fma.rn.f64	%r99, %r98, %r98, %r97;
		mul.f64	%r335, %r99, 0d3fe0000000000000;
		mul.f64	%r101, %r335, %r44;
		add.u64	%r344, %r68, %r285;
		st.f64	[%r344], %r101;
		add.u64	%r353, %r70, %r285;
		mul.f64	%r354, %r44, %r101;
		st.f64	[%r353], %r354;
		add.u32	%r103, %r93, 64;
		setp.le.s32	%r355, %r673, %r103;
	@%r355	bra	$L7;
		cvt.s64.s32	%r356, %r103;
		add.u64	%r362, %r201, %r356;
		shl.b64	%r363, %r362, 3;
		add.u64	%r364, %r47, %r363;
		ld.f64	%r366, [%r364];
		div.rn.f64	%r106, %r675, %r366;
		add.u64	%r375, %r50, %r363;
		st.f64	[%r375], %r106;
		add.u64	%r377, %r356, %r161;
		shl.b64	%r378, %r377, 3;
		add.u64	%r172, %r47, %r378;
		add.u64	%r387, %r53, %r363;
		ld.f64	%r389, [%r172+34433424];
		mul.f64	%r388, %r389, %r106;
		st.f64	[%r387], %r388;
		add.u64	%r398, %r56, %r363;
		ld.f64	%r400, [%r172+68866848];
		mul.f64	%r399, %r400, %r106;
		st.f64	[%r398], %r399;
		add.u64	%r409, %r59, %r363;
		ld.f64	%r411, [%r172+103300272];
		mul.f64	%r410, %r411, %r106;
		st.f64	[%r409], %r410;
		ld.f64	%r113, [%r172+34433424];
		ld.f64	%r114, [%r172+68866848];
		mul.f64	%r412, %r114, %r114;
		fma.rn.f64	%r116, %r113, %r113, %r412;
		ld.f64	%r117, [%r172+103300272];
		fma.rn.f64	%r118, %r117, %r117, %r116;
		mul.f64	%r413, %r118, 0d3fe0000000000000;
		mul.f64	%r120, %r413, %r106;
		add.u64	%r422, %r68, %r363;
		st.f64	[%r422], %r120;
		add.u64	%r431, %r70, %r363;
		mul.f64	%r432, %r106, %r120;
		st.f64	[%r431], %r432;
		add.u32	%r122, %r93, 96;
		setp.le.s32	%r433, %r673, %r122;
	@%r433	bra	$L7;
		cvt.s64.s32	%r434, %r122;
		add.u64	%r440, %r201, %r434;
		shl.b64	%r441, %r440, 3;
		add.u64	%r442, %r47, %r441;
		ld.f64	%r444, [%r442];
		div.rn.f64	%r124, %r675, %r444;
		add.u64	%r453, %r50, %r441;
		st.f64	[%r453], %r124;
		add.u64	%r455, %r434, %r161;
		shl.b64	%r456, %r455, 3;
		add.u64	%r176, %r47, %r456;
		add.u64	%r465, %r53, %r441;
		ld.f64	%r467, [%r176+34433424];
		mul.f64	%r466, %r467, %r124;
		st.f64	[%r465], %r466;
		add.u64	%r476, %r56, %r441;
		ld.f64	%r478, [%r176+68866848];
		mul.f64	%r477, %r478, %r124;
		st.f64	[%r476], %r477;
		add.u64	%r487, %r59, %r441;
		ld.f64	%r489, [%r176+103300272];
		mul.f64	%r488, %r489, %r124;
		st.f64	[%r487], %r488;
		ld.f64	%r131, [%r176+34433424];
		ld.f64	%r132, [%r176+68866848];
		mul.f64	%r490, %r132, %r132;
		fma.rn.f64	%r134, %r131, %r131, %r490;
		ld.f64	%r135, [%r176+103300272];
		fma.rn.f64	%r136, %r135, %r135, %r134;
		mul.f64	%r491, %r136, 0d3fe0000000000000;
		mul.f64	%r138, %r491, %r124;
		add.u64	%r500, %r68, %r441;
		st.f64	[%r500], %r138;
		add.u64	%r509, %r70, %r441;
		mul.f64	%r510, %r124, %r138;
		st.f64	[%r509], %r510;
		add.u32	%r140, %r93, 128;
		setp.le.s32	%r511, %r673, %r140;
	@%r511	bra	$L7;
		cvt.s64.s32	%r512, %r140;
		add.u64	%r518, %r201, %r512;
		shl.b64	%r519, %r518, 3;
		add.u64	%r520, %r47, %r519;
		ld.f64	%r522, [%r520];
		div.rn.f64	%r143, %r675, %r522;
		add.u64	%r531, %r50, %r519;
		st.f64	[%r531], %r143;
		add.u64	%r533, %r512, %r161;
		shl.b64	%r534, %r533, 3;
		add.u64	%r180, %r47, %r534;
		add.u64	%r543, %r53, %r519;
		ld.f64	%r545, [%r180+34433424];
		mul.f64	%r544, %r545, %r143;
		st.f64	[%r543], %r544;
		add.u64	%r554, %r56, %r519;
		ld.f64	%r556, [%r180+68866848];
		mul.f64	%r555, %r556, %r143;
		st.f64	[%r554], %r555;
		add.u64	%r565, %r59, %r519;
		ld.f64	%r567, [%r180+103300272];
		mul.f64	%r566, %r567, %r143;
		st.f64	[%r565], %r566;
		ld.f64	%r150, [%r180+34433424];
		ld.f64	%r151, [%r180+68866848];
		mul.f64	%r568, %r151, %r151;
		fma.rn.f64	%r153, %r150, %r150, %r568;
		ld.f64	%r154, [%r180+103300272];
		fma.rn.f64	%r155, %r154, %r154, %r153;
		mul.f64	%r569, %r155, 0d3fe0000000000000;
		mul.f64	%r157, %r569, %r143;
		add.u64	%r578, %r68, %r519;
		st.f64	[%r578], %r157;
		add.u64	%r587, %r70, %r519;
		mul.f64	%r588, %r143, %r157;
		st.f64	[%r587], %r588;
		add.u32	%r159, %r93, 160;
		setp.le.s32	%r589, %r673, %r159;
	@%r589	bra	$L7;
		cvt.s64.s32	%r590, %r159;
		add.u64	%r596, %r201, %r590;
		shl.b64	%r597, %r596, 3;
		add.u64	%r598, %r47, %r597;
		ld.f64	%r600, [%r598];
		div.rn.f64	%r49, %r675, %r600;
		add.u64	%r609, %r50, %r597;
		st.f64	[%r609], %r49;
		add.u64	%r611, %r590, %r161;
		shl.b64	%r612, %r611, 3;
		add.u64	%r184, %r47, %r612;
		add.u64	%r621, %r53, %r597;
		ld.f64	%r623, [%r184+34433424];
		mul.f64	%r622, %r623, %r49;
		st.f64	[%r621], %r622;
		add.u64	%r632, %r56, %r597;
		ld.f64	%r634, [%r184+68866848];
		mul.f64	%r633, %r634, %r49;
		st.f64	[%r632], %r633;
		add.u64	%r643, %r59, %r597;
		ld.f64	%r645, [%r184+103300272];
		mul.f64	%r644, %r645, %r49;
		st.f64	[%r643], %r644;
		ld.f64	%r60, [%r184+34433424];
		ld.f64	%r61, [%r184+68866848];
		mul.f64	%r646, %r61, %r61;
		fma.rn.f64	%r63, %r60, %r60, %r646;
		ld.f64	%r64, [%r184+103300272];
		fma.rn.f64	%r65, %r64, %r64, %r63;
		mul.f64	%r647, %r65, 0d3fe0000000000000;
		mul.f64	%r67, %r647, %r49;
		add.u64	%r656, %r68, %r597;
		st.f64	[%r656], %r67;
		add.u64	%r665, %r70, %r597;
		mul.f64	%r666, %r49, %r67;
		st.f64	[%r665], %r666;
		bra	$L7;
$L1:
	ret;
}
string-delimiter
      )

(define ptx-sample4-out
'((kernel
   "compute_rhs$_omp_fn$0"
   (storage ".param" ".u64" "%in_ar0")
   (storageN ".reg" ".u64" "%ar0")
   (instruction "ld" ".param" ".u64" "%ar0" "[%in_ar0]")
   (storageN ".reg" ".f64" "%r22")
   (storageN ".reg" ".u32" "%r23")
   (storageN ".reg" ".u32" "%r27")
   (storageN ".reg" ".u32" "%r31")
   (storageN ".reg" ".f64" "%r33")
   (storageN ".reg" ".u32" "%r34")
   (storageN ".reg" ".f64" "%r35")
   (storageN ".reg" ".f64" "%r39")
   (storageN ".reg" ".u32" "%r40")
   (storageN ".reg" ".f64" "%r44")
   (storageN ".reg" ".u64" "%r47")
   (storageN ".reg" ".f64" "%r49")
   (storageN ".reg" ".u64" "%r50")
   (storageN ".reg" ".u64" "%r53")
   (storageN ".reg" ".u64" "%r56")
   (storageN ".reg" ".u64" "%r59")
   (storageN ".reg" ".f64" "%r60")
   (storageN ".reg" ".f64" "%r61")
   (storageN ".reg" ".f64" "%r63")
   (storageN ".reg" ".f64" "%r64")
   (storageN ".reg" ".f64" "%r65")
   (storageN ".reg" ".f64" "%r67")
   (storageN ".reg" ".u64" "%r68")
   (storageN ".reg" ".u64" "%r70")
   (storageN ".reg" ".f64" "%r78")
   (storageN ".reg" ".u32" "%r79")
   (storageN ".reg" ".u32" "%r80")
   (storageN ".reg" ".u32" "%r84")
   (storageN ".reg" ".f64" "%r85")
   (storageN ".reg" ".f64" "%r86")
   (storageN ".reg" ".u32" "%r90")
   (storageN ".reg" ".u32" "%r91")
   (storageN ".reg" ".u32" "%r93")
   (storageN ".reg" ".f64" "%r94")
   (storageN ".reg" ".f64" "%r95")
   (storageN ".reg" ".f64" "%r97")
   (storageN ".reg" ".f64" "%r98")
   (storageN ".reg" ".f64" "%r99")
   (storageN ".reg" ".f64" "%r101")
   (storageN ".reg" ".u32" "%r103")
   (storageN ".reg" ".f64" "%r106")
   (storageN ".reg" ".f64" "%r113")
   (storageN ".reg" ".f64" "%r114")
   (storageN ".reg" ".f64" "%r116")
   (storageN ".reg" ".f64" "%r117")
   (storageN ".reg" ".f64" "%r118")
   (storageN ".reg" ".f64" "%r120")
   (storageN ".reg" ".u32" "%r122")
   (storageN ".reg" ".f64" "%r124")
   (storageN ".reg" ".f64" "%r131")
   (storageN ".reg" ".f64" "%r132")
   (storageN ".reg" ".f64" "%r134")
   (storageN ".reg" ".f64" "%r135")
   (storageN ".reg" ".f64" "%r136")
   (storageN ".reg" ".f64" "%r138")
   (storageN ".reg" ".u32" "%r140")
   (storageN ".reg" ".f64" "%r143")
   (storageN ".reg" ".f64" "%r150")
   (storageN ".reg" ".f64" "%r151")
   (storageN ".reg" ".f64" "%r153")
   (storageN ".reg" ".f64" "%r154")
   (storageN ".reg" ".f64" "%r155")
   (storageN ".reg" ".f64" "%r157")
   (storageN ".reg" ".u32" "%r159")
   (storageN ".reg" ".u64" "%r161")
   (storageN ".reg" ".u64" "%r164")
   (storageN ".reg" ".u64" "%r168")
   (storageN ".reg" ".u64" "%r172")
   (storageN ".reg" ".u64" "%r176")
   (storageN ".reg" ".u64" "%r180")
   (storageN ".reg" ".u64" "%r184")
   (storageN ".reg" ".u64" "%r185")
   (storageN ".reg" ".u64" "%r186")
   (storageN ".reg" ".u32" "%r187")
   (storageN ".reg" ".u32" "%r188")
   (storageN ".reg" ".u32" "%r189")
   (storageN ".reg" ".pred" "%r190")
   (storageN ".reg" ".u64" "%r191")
   (storageN ".reg" ".u64" "%r192")
   (storageN ".reg" ".u32" "%r193")
   (storageN ".reg" ".pred" "%r194")
   (storageN ".reg" ".pred" "%r195")
   (storageN ".reg" ".u64" "%r196")
   (storageN ".reg" ".u64" "%r198")
   (storageN ".reg" ".u64" "%r201")
   (storageN ".reg" ".u64" "%r202")
   (storageN ".reg" ".u64" "%r203")
   (storageN ".reg" ".u64" "%r204")
   (storageN ".reg" ".f64" "%r206")
   (storageN ".reg" ".u64" "%r215")
   (storageN ".reg" ".u64" "%r218")
   (storageN ".reg" ".u64" "%r221")
   (storageN ".reg" ".u64" "%r222")
   (storageN ".reg" ".u64" "%r231")
   (storageN ".reg" ".f64" "%r232")
   (storageN ".reg" ".f64" "%r233")
   (storageN ".reg" ".u64" "%r242")
   (storageN ".reg" ".f64" "%r243")
   (storageN ".reg" ".f64" "%r244")
   (storageN ".reg" ".u64" "%r253")
   (storageN ".reg" ".f64" "%r254")
   (storageN ".reg" ".f64" "%r255")
   (storageN ".reg" ".f64" "%r256")
   (storageN ".reg" ".f64" "%r257")
   (storageN ".reg" ".u64" "%r266")
   (storageN ".reg" ".u64" "%r275")
   (storageN ".reg" ".f64" "%r276")
   (storageN ".reg" ".pred" "%r277")
   (storageN ".reg" ".u64" "%r278")
   (storageN ".reg" ".u64" "%r284")
   (storageN ".reg" ".u64" "%r285")
   (storageN ".reg" ".u64" "%r286")
   (storageN ".reg" ".f64" "%r288")
   (storageN ".reg" ".u64" "%r297")
   (storageN ".reg" ".u64" "%r299")
   (storageN ".reg" ".u64" "%r300")
   (storageN ".reg" ".u64" "%r309")
   (storageN ".reg" ".f64" "%r310")
   (storageN ".reg" ".f64" "%r311")
   (storageN ".reg" ".u64" "%r320")
   (storageN ".reg" ".f64" "%r321")
   (storageN ".reg" ".f64" "%r322")
   (storageN ".reg" ".u64" "%r331")
   (storageN ".reg" ".f64" "%r332")
   (storageN ".reg" ".f64" "%r333")
   (storageN ".reg" ".f64" "%r334")
   (storageN ".reg" ".f64" "%r335")
   (storageN ".reg" ".u64" "%r344")
   (storageN ".reg" ".u64" "%r353")
   (storageN ".reg" ".f64" "%r354")
   (storageN ".reg" ".pred" "%r355")
   (storageN ".reg" ".u64" "%r356")
   (storageN ".reg" ".u64" "%r362")
   (storageN ".reg" ".u64" "%r363")
   (storageN ".reg" ".u64" "%r364")
   (storageN ".reg" ".f64" "%r366")
   (storageN ".reg" ".u64" "%r375")
   (storageN ".reg" ".u64" "%r377")
   (storageN ".reg" ".u64" "%r378")
   (storageN ".reg" ".u64" "%r387")
   (storageN ".reg" ".f64" "%r388")
   (storageN ".reg" ".f64" "%r389")
   (storageN ".reg" ".u64" "%r398")
   (storageN ".reg" ".f64" "%r399")
   (storageN ".reg" ".f64" "%r400")
   (storageN ".reg" ".u64" "%r409")
   (storageN ".reg" ".f64" "%r410")
   (storageN ".reg" ".f64" "%r411")
   (storageN ".reg" ".f64" "%r412")
   (storageN ".reg" ".f64" "%r413")
   (storageN ".reg" ".u64" "%r422")
   (storageN ".reg" ".u64" "%r431")
   (storageN ".reg" ".f64" "%r432")
   (storageN ".reg" ".pred" "%r433")
   (storageN ".reg" ".u64" "%r434")
   (storageN ".reg" ".u64" "%r440")
   (storageN ".reg" ".u64" "%r441")
   (storageN ".reg" ".u64" "%r442")
   (storageN ".reg" ".f64" "%r444")
   (storageN ".reg" ".u64" "%r453")
   (storageN ".reg" ".u64" "%r455")
   (storageN ".reg" ".u64" "%r456")
   (storageN ".reg" ".u64" "%r465")
   (storageN ".reg" ".f64" "%r466")
   (storageN ".reg" ".f64" "%r467")
   (storageN ".reg" ".u64" "%r476")
   (storageN ".reg" ".f64" "%r477")
   (storageN ".reg" ".f64" "%r478")
   (storageN ".reg" ".u64" "%r487")
   (storageN ".reg" ".f64" "%r488")
   (storageN ".reg" ".f64" "%r489")
   (storageN ".reg" ".f64" "%r490")
   (storageN ".reg" ".f64" "%r491")
   (storageN ".reg" ".u64" "%r500")
   (storageN ".reg" ".u64" "%r509")
   (storageN ".reg" ".f64" "%r510")
   (storageN ".reg" ".pred" "%r511")
   (storageN ".reg" ".u64" "%r512")
   (storageN ".reg" ".u64" "%r518")
   (storageN ".reg" ".u64" "%r519")
   (storageN ".reg" ".u64" "%r520")
   (storageN ".reg" ".f64" "%r522")
   (storageN ".reg" ".u64" "%r531")
   (storageN ".reg" ".u64" "%r533")
   (storageN ".reg" ".u64" "%r534")
   (storageN ".reg" ".u64" "%r543")
   (storageN ".reg" ".f64" "%r544")
   (storageN ".reg" ".f64" "%r545")
   (storageN ".reg" ".u64" "%r554")
   (storageN ".reg" ".f64" "%r555")
   (storageN ".reg" ".f64" "%r556")
   (storageN ".reg" ".u64" "%r565")
   (storageN ".reg" ".f64" "%r566")
   (storageN ".reg" ".f64" "%r567")
   (storageN ".reg" ".f64" "%r568")
   (storageN ".reg" ".f64" "%r569")
   (storageN ".reg" ".u64" "%r578")
   (storageN ".reg" ".u64" "%r587")
   (storageN ".reg" ".f64" "%r588")
   (storageN ".reg" ".pred" "%r589")
   (storageN ".reg" ".u64" "%r590")
   (storageN ".reg" ".u64" "%r596")
   (storageN ".reg" ".u64" "%r597")
   (storageN ".reg" ".u64" "%r598")
   (storageN ".reg" ".f64" "%r600")
   (storageN ".reg" ".u64" "%r609")
   (storageN ".reg" ".u64" "%r611")
   (storageN ".reg" ".u64" "%r612")
   (storageN ".reg" ".u64" "%r621")
   (storageN ".reg" ".f64" "%r622")
   (storageN ".reg" ".f64" "%r623")
   (storageN ".reg" ".u64" "%r632")
   (storageN ".reg" ".f64" "%r633")
   (storageN ".reg" ".f64" "%r634")
   (storageN ".reg" ".u64" "%r643")
   (storageN ".reg" ".f64" "%r644")
   (storageN ".reg" ".f64" "%r645")
   (storageN ".reg" ".f64" "%r646")
   (storageN ".reg" ".f64" "%r647")
   (storageN ".reg" ".u64" "%r656")
   (storageN ".reg" ".u64" "%r665")
   (storageN ".reg" ".f64" "%r666")
   (storageN ".reg" ".pred" "%r667")
   (storageN ".reg" ".pred" "%r668")
   (storageN ".reg" ".u64" "%r669")
   (storageN ".reg" ".u64" "%r670")
   (storageN ".reg" ".u64" "%r672")
   (storageN ".reg" ".u32" "%r673")
   (storageN ".reg" ".u32" "%r674")
   (storageN ".reg" ".f64" "%r675")
   (storageN ".reg" ".u32" "%r677")
   (storageN ".reg" ".u32" "%r678")
   (storageN ".reg" ".u32" "%r679")
   (storageN ".reg" ".u32" "%r680")
   (storageN ".reg" ".u32" "%r681")
   (storageN ".reg" ".u32" "%r682")
   (storageN ".reg" ".u32" "%r683")
   (storageN ".reg" ".u32" "%r684")
   (storageN ".reg" ".u64" "%r685")
   (storageN ".reg" ".u64" "%r686")
   (storageN ".reg" ".pred" "%r687")
   (storageN ".reg" ".pred" "%r688")
   (storageN ".reg" ".u32" "%r689")
   (storageN ".reg" ".pred" "%r690")
   (storageN ".reg" ".u32" "%r691")
   (storageN ".reg" ".pred" "%r692")
   (storageN ".reg" ".u32" "%r693")
   (storageN ".reg" ".u32" "%r694")
   (storageN ".reg" ".u32" "%r695")
   (storageN ".reg" ".u32" "%r696")
   (group
    (storageN ".reg" ".u32" "%y")
    (instruction "mov" ".u32" "%y" "%tid.y")
    (instruction "setp" ".ne" ".u32" "%r692" "%y" "0"))
   (group
    (storageN ".reg" ".u32" "%x")
    (instruction "mov" ".u32" "%x" "%tid.x")
    (instruction "setp" ".ne" ".u32" "%r687" "%x" "0"))
   "@%r692"
   (instruction "bra" ".uni" "$L23")
   "@%r687"
   (instruction "bra" "$L24")
   (instruction "mov" ".u64" "%r185" "%ar0")
   (instruction "ld" ".u64" "%r186" "[%r185]")
   (instruction "ld" ".u32" "%r27" "[%r186]")
   (instruction "mov" ".u32" "%r90" "%ctaid.x")
   (instruction "add" ".u32" "%r187" "%r27" "192")
   (instruction "div" ".s32" "%r84" "%r187" "192")
   (instruction "mul" ".lo" ".u32" "%r23" "%r84" "%r90")
   (instruction "add" ".u32" "%r188" "%r27" "1")
   (instruction "add" ".u32" "%r189" "%r23" "%r84")
   (instruction "min" ".s32" "%r34" "%r188" "%r189")
   (instruction "setp" ".lt" ".s32" "%r190" "%r23" "%r34")
   (instruction "selp" ".u32" "%r695" "1" "0" "%r190")
   (instruction "st" ".shared" ".u32" "[__oacc_bcast]" "%r695")
   "$L24:"
   "$L23:"
   (instruction "bar" ".sync" "0")
   (instruction "ld" ".shared" ".u32" "%r696" "[__oacc_bcast]")
   (instruction "setp" ".ne" ".u32" "%r190" "%r696" "0")
   (instruction "bar" ".sync" "0")
   "@!%r190"
   (instruction "bra" ".uni" "$L1")
   "@%r692"
   (instruction "bra" ".uni" "$L21")
   "@%r687"
   (instruction "bra" "$L22")
   (instruction "ld" ".u64" "%r191" "[%r185+16]")
   (instruction "ld" ".u32" "%r31" "[%r191]")
   (instruction "ld" ".u64" "%r192" "[%r185+8]")
   (instruction "ld" ".u32" "%r193" "[%r192]")
   (instruction "add" ".u32" "%r79" "%r193" "1")
   (instruction "add" ".u32" "%r673" "%r31" "1")
   (instruction "mov" ".u32" "%r674" "26569")
   (instruction "mov" ".f64" "%r675" "0d3ff0000000000000")
   "$L22:"
   "$L21:"
   "$L10:"
   "@%r692"
   (instruction "bra" ".uni" "$L19")
   "@%r687"
   (instruction "bra" "$L20")
   (instruction "cvta" ".shared" ".u64" "%r686" "__oacc_bcast")
   (instruction "st" ".u32" "[%r686]" "%r23")
   (instruction "st" ".u32" "[%r686+4]" "%r34")
   (instruction "st" ".u32" "[%r686+8]" "%r79")
   (instruction "st" ".u64" "[%r686+16]" "%r185")
   (instruction "st" ".u32" "[%r686+24]" "%r673")
   (instruction "st" ".u32" "[%r686+28]" "%r674")
   (instruction "st" ".f64" "[%r686+32]" "%r675")
   "$L20:"
   "$L19:"
   (instruction "setp" ".eq" ".u32" "%r690" "1" "0")
   (instruction "bar" ".sync" "0")
   "@%r687"
   (instruction "bra" "$L16")
   (instruction "cvta" ".shared" ".u64" "%r685" "__oacc_bcast")
   (instruction "ld" ".u32" "%r23" "[%r685]")
   (instruction "ld" ".u32" "%r34" "[%r685+4]")
   (instruction "ld" ".u32" "%r79" "[%r685+8]")
   (instruction "ld" ".u64" "%r185" "[%r685+16]")
   (instruction "ld" ".u32" "%r673" "[%r685+24]")
   (instruction "ld" ".u32" "%r674" "[%r685+28]")
   (instruction "ld" ".f64" "%r675" "[%r685+32]")
   (instruction "mov" ".u32" "%r91" "%tid.y")
   (instruction "setp" ".gt" ".s32" "%r194" "%r79" "%r91")
   (instruction "mov" ".pred" "%r690" "%r194")
   "$L16:"
   (instruction "mov" ".pred" "%r194" "%r690")
   (instruction "selp" ".u32" "%r691" "1" "0" "%r194")
   (instruction "shfl" ".idx" ".b32" "%r691" "%r691" "0" "31")
   (instruction "setp" ".ne" ".u32" "%r194" "%r691" "0")
   "@%r194"
   (instruction "bra" ".uni" "$L3")
   "$L9:"
   (instruction "bar" ".sync" "0")
   "@%r692"
   (instruction "bra" ".uni" "$L17")
   "@%r687"
   (instruction "bra" "$L18")
   (instruction "add" ".u32" "%r23" "%r23" "1")
   (instruction "setp" ".ne" ".u32" "%r668" "%r34" "%r23")
   (instruction "selp" ".u32" "%r693" "1" "0" "%r668")
   (instruction "st" ".shared" ".u32" "[__oacc_bcast]" "%r693")
   "$L18:"
   "$L17:"
   (instruction "bar" ".sync" "0")
   (instruction "ld" ".shared" ".u32" "%r694" "[__oacc_bcast]")
   (instruction "setp" ".ne" ".u32" "%r668" "%r694" "0")
   (instruction "bar" ".sync" "0")
   "@%r668"
   (instruction "bra" ".uni" "$L10")
   (instruction "bra" "$L1")
   "$L3:"
   "@%r687"
   (instruction "bra" "$L15")
   (instruction "mov" ".u32" "%r80" "%r91")
   (instruction "cvt" ".s64" ".s32" "%r669" "%r23")
   (instruction "mul" ".lo" ".u64" "%r670" "%r669" "26569")
   (instruction "mul" ".wide" ".s32" "%r672" "%r23" "%r674")
   "$L15:"
   "$L8:"
   (instruction "shfl" ".idx" ".b32" "%r23" "%r23" "0" "31")
   (instruction "shfl" ".idx" ".b32" "%r34" "%r34" "0" "31")
   (instruction "shfl" ".idx" ".b32" "%r79" "%r79" "0" "31")
   (instruction "shfl" ".idx" ".b32" "%r80" "%r80" "0" "31")
   (instruction "mov" ".b64" "{%r677,%r678}" "%r185")
   (instruction "shfl" ".idx" ".b32" "%r677" "%r677" "0" "31")
   (instruction "shfl" ".idx" ".b32" "%r678" "%r678" "0" "31")
   (instruction "mov" ".b64" "%r185" "{%r677,%r678}")
   (instruction "mov" ".b64" "{%r679,%r680}" "%r670")
   (instruction "shfl" ".idx" ".b32" "%r679" "%r679" "0" "31")
   (instruction "shfl" ".idx" ".b32" "%r680" "%r680" "0" "31")
   (instruction "mov" ".b64" "%r670" "{%r679,%r680}")
   (instruction "mov" ".b64" "{%r681,%r682}" "%r672")
   (instruction "shfl" ".idx" ".b32" "%r681" "%r681" "0" "31")
   (instruction "shfl" ".idx" ".b32" "%r682" "%r682" "0" "31")
   (instruction "mov" ".b64" "%r672" "{%r681,%r682}")
   (instruction "shfl" ".idx" ".b32" "%r673" "%r673" "0" "31")
   (instruction "shfl" ".idx" ".b32" "%r674" "%r674" "0" "31")
   (instruction "mov" ".b64" "{%r683,%r684}" "%r675")
   (instruction "shfl" ".idx" ".b32" "%r683" "%r683" "0" "31")
   (instruction "shfl" ".idx" ".b32" "%r684" "%r684" "0" "31")
   (instruction "mov" ".b64" "%r675" "{%r683,%r684}")
   (instruction "mov" ".u32" "%r93" "%tid.x")
   (instruction "setp" ".gt" ".s32" "%r195" "%r673" "%r93")
   "@%r195"
   (instruction "bra" "$L5")
   "$L7:"
   (instruction "setp" ".eq" ".u32" "%r688" "1" "0")
   "@%r687"
   (instruction "bra" "$L14")
   (instruction "add" ".u32" "%r80" "%r80" "16")
   (instruction "setp" ".gt" ".s32" "%r667" "%r79" "%r80")
   (instruction "mov" ".pred" "%r688" "%r667")
   "$L14:"
   (instruction "mov" ".pred" "%r667" "%r688")
   (instruction "selp" ".u32" "%r689" "1" "0" "%r667")
   (instruction "shfl" ".idx" ".b32" "%r689" "%r689" "0" "31")
   (instruction "setp" ".ne" ".u32" "%r667" "%r689" "0")
   "@%r667"
   (instruction "bra" ".uni" "$L8")
   (instruction "bra" "$L9")
   "$L5:"
   (instruction "ld" ".u64" "%r47" "[%r185+32]")
   (instruction "ld" ".u64" "%r50" "[%r185+48]")
   (instruction "ld" ".u64" "%r53" "[%r185+80]")
   (instruction "ld" ".u64" "%r56" "[%r185+72]")
   (instruction "ld" ".u64" "%r59" "[%r185+64]")
   (instruction "ld" ".u64" "%r68" "[%r185+40]")
   (instruction "ld" ".u64" "%r70" "[%r185+56]")
   (instruction "cvt" ".s64" ".s32" "%r196" "%r93")
   (instruction "cvt" ".s64" ".s32" "%r198" "%r80")
   (instruction "mad" ".lo" ".u64" "%r201" "%r198" "163" "%r670")
   (instruction "add" ".u64" "%r202" "%r201" "%r196")
   (instruction "shl" ".b64" "%r203" "%r202" "3")
   (instruction "add" ".u64" "%r204" "%r47" "%r203")
   (instruction "ld" ".f64" "%r206" "[%r204]")
   (instruction "div" ".rn" ".f64" "%r78" "%r675" "%r206")
   (instruction "add" ".u64" "%r215" "%r50" "%r203")
   (instruction "st" ".f64" "[%r215]" "%r78")
   (instruction "cvt" ".s64" ".s32" "%r218" "%r80")
   (instruction "mad" ".lo" ".u64" "%r161" "%r218" "163" "%r672")
   (instruction "add" ".u64" "%r221" "%r196" "%r161")
   (instruction "shl" ".b64" "%r222" "%r221" "3")
   (instruction "add" ".u64" "%r164" "%r47" "%r222")
   (instruction "add" ".u64" "%r231" "%r53" "%r203")
   (instruction "ld" ".f64" "%r233" "[%r164+34433424]")
   (instruction "mul" ".f64" "%r232" "%r233" "%r78")
   (instruction "st" ".f64" "[%r231]" "%r232")
   (instruction "add" ".u64" "%r242" "%r56" "%r203")
   (instruction "ld" ".f64" "%r244" "[%r164+68866848]")
   (instruction "mul" ".f64" "%r243" "%r244" "%r78")
   (instruction "st" ".f64" "[%r242]" "%r243")
   (instruction "add" ".u64" "%r253" "%r59" "%r203")
   (instruction "ld" ".f64" "%r255" "[%r164+103300272]")
   (instruction "mul" ".f64" "%r254" "%r255" "%r78")
   (instruction "st" ".f64" "[%r253]" "%r254")
   (instruction "ld" ".f64" "%r33" "[%r164+34433424]")
   (instruction "ld" ".f64" "%r22" "[%r164+68866848]")
   (instruction "mul" ".f64" "%r256" "%r22" "%r22")
   (instruction "fma" ".rn" ".f64" "%r85" "%r33" "%r33" "%r256")
   (instruction "ld" ".f64" "%r86" "[%r164+103300272]")
   (instruction "fma" ".rn" ".f64" "%r35" "%r86" "%r86" "%r85")
   (instruction "mul" ".f64" "%r257" "%r35" "0d3fe0000000000000")
   (instruction "mul" ".f64" "%r39" "%r257" "%r78")
   (instruction "add" ".u64" "%r266" "%r68" "%r203")
   (instruction "st" ".f64" "[%r266]" "%r39")
   (instruction "add" ".u64" "%r275" "%r70" "%r203")
   (instruction "mul" ".f64" "%r276" "%r39" "%r78")
   (instruction "st" ".f64" "[%r275]" "%r276")
   (instruction "add" ".u32" "%r40" "%r93" "32")
   (instruction "setp" ".ge" ".s32" "%r277" "%r40" "%r673")
   "@%r277"
   (instruction "bra" "$L7")
   (instruction "cvt" ".s64" ".s32" "%r278" "%r40")
   (instruction "add" ".u64" "%r284" "%r201" "%r278")
   (instruction "shl" ".b64" "%r285" "%r284" "3")
   (instruction "add" ".u64" "%r286" "%r47" "%r285")
   (instruction "ld" ".f64" "%r288" "[%r286]")
   (instruction "div" ".rn" ".f64" "%r44" "%r675" "%r288")
   (instruction "add" ".u64" "%r297" "%r50" "%r285")
   (instruction "st" ".f64" "[%r297]" "%r44")
   (instruction "add" ".u64" "%r299" "%r278" "%r161")
   (instruction "shl" ".b64" "%r300" "%r299" "3")
   (instruction "add" ".u64" "%r168" "%r47" "%r300")
   (instruction "add" ".u64" "%r309" "%r53" "%r285")
   (instruction "ld" ".f64" "%r311" "[%r168+34433424]")
   (instruction "mul" ".f64" "%r310" "%r311" "%r44")
   (instruction "st" ".f64" "[%r309]" "%r310")
   (instruction "add" ".u64" "%r320" "%r56" "%r285")
   (instruction "ld" ".f64" "%r322" "[%r168+68866848]")
   (instruction "mul" ".f64" "%r321" "%r322" "%r44")
   (instruction "st" ".f64" "[%r320]" "%r321")
   (instruction "add" ".u64" "%r331" "%r59" "%r285")
   (instruction "ld" ".f64" "%r333" "[%r168+103300272]")
   (instruction "mul" ".f64" "%r332" "%r333" "%r44")
   (instruction "st" ".f64" "[%r331]" "%r332")
   (instruction "ld" ".f64" "%r94" "[%r168+34433424]")
   (instruction "ld" ".f64" "%r95" "[%r168+68866848]")
   (instruction "mul" ".f64" "%r334" "%r95" "%r95")
   (instruction "fma" ".rn" ".f64" "%r97" "%r94" "%r94" "%r334")
   (instruction "ld" ".f64" "%r98" "[%r168+103300272]")
   (instruction "fma" ".rn" ".f64" "%r99" "%r98" "%r98" "%r97")
   (instruction "mul" ".f64" "%r335" "%r99" "0d3fe0000000000000")
   (instruction "mul" ".f64" "%r101" "%r335" "%r44")
   (instruction "add" ".u64" "%r344" "%r68" "%r285")
   (instruction "st" ".f64" "[%r344]" "%r101")
   (instruction "add" ".u64" "%r353" "%r70" "%r285")
   (instruction "mul" ".f64" "%r354" "%r44" "%r101")
   (instruction "st" ".f64" "[%r353]" "%r354")
   (instruction "add" ".u32" "%r103" "%r93" "64")
   (instruction "setp" ".le" ".s32" "%r355" "%r673" "%r103")
   "@%r355"
   (instruction "bra" "$L7")
   (instruction "cvt" ".s64" ".s32" "%r356" "%r103")
   (instruction "add" ".u64" "%r362" "%r201" "%r356")
   (instruction "shl" ".b64" "%r363" "%r362" "3")
   (instruction "add" ".u64" "%r364" "%r47" "%r363")
   (instruction "ld" ".f64" "%r366" "[%r364]")
   (instruction "div" ".rn" ".f64" "%r106" "%r675" "%r366")
   (instruction "add" ".u64" "%r375" "%r50" "%r363")
   (instruction "st" ".f64" "[%r375]" "%r106")
   (instruction "add" ".u64" "%r377" "%r356" "%r161")
   (instruction "shl" ".b64" "%r378" "%r377" "3")
   (instruction "add" ".u64" "%r172" "%r47" "%r378")
   (instruction "add" ".u64" "%r387" "%r53" "%r363")
   (instruction "ld" ".f64" "%r389" "[%r172+34433424]")
   (instruction "mul" ".f64" "%r388" "%r389" "%r106")
   (instruction "st" ".f64" "[%r387]" "%r388")
   (instruction "add" ".u64" "%r398" "%r56" "%r363")
   (instruction "ld" ".f64" "%r400" "[%r172+68866848]")
   (instruction "mul" ".f64" "%r399" "%r400" "%r106")
   (instruction "st" ".f64" "[%r398]" "%r399")
   (instruction "add" ".u64" "%r409" "%r59" "%r363")
   (instruction "ld" ".f64" "%r411" "[%r172+103300272]")
   (instruction "mul" ".f64" "%r410" "%r411" "%r106")
   (instruction "st" ".f64" "[%r409]" "%r410")
   (instruction "ld" ".f64" "%r113" "[%r172+34433424]")
   (instruction "ld" ".f64" "%r114" "[%r172+68866848]")
   (instruction "mul" ".f64" "%r412" "%r114" "%r114")
   (instruction "fma" ".rn" ".f64" "%r116" "%r113" "%r113" "%r412")
   (instruction "ld" ".f64" "%r117" "[%r172+103300272]")
   (instruction "fma" ".rn" ".f64" "%r118" "%r117" "%r117" "%r116")
   (instruction "mul" ".f64" "%r413" "%r118" "0d3fe0000000000000")
   (instruction "mul" ".f64" "%r120" "%r413" "%r106")
   (instruction "add" ".u64" "%r422" "%r68" "%r363")
   (instruction "st" ".f64" "[%r422]" "%r120")
   (instruction "add" ".u64" "%r431" "%r70" "%r363")
   (instruction "mul" ".f64" "%r432" "%r106" "%r120")
   (instruction "st" ".f64" "[%r431]" "%r432")
   (instruction "add" ".u32" "%r122" "%r93" "96")
   (instruction "setp" ".le" ".s32" "%r433" "%r673" "%r122")
   "@%r433"
   (instruction "bra" "$L7")
   (instruction "cvt" ".s64" ".s32" "%r434" "%r122")
   (instruction "add" ".u64" "%r440" "%r201" "%r434")
   (instruction "shl" ".b64" "%r441" "%r440" "3")
   (instruction "add" ".u64" "%r442" "%r47" "%r441")
   (instruction "ld" ".f64" "%r444" "[%r442]")
   (instruction "div" ".rn" ".f64" "%r124" "%r675" "%r444")
   (instruction "add" ".u64" "%r453" "%r50" "%r441")
   (instruction "st" ".f64" "[%r453]" "%r124")
   (instruction "add" ".u64" "%r455" "%r434" "%r161")
   (instruction "shl" ".b64" "%r456" "%r455" "3")
   (instruction "add" ".u64" "%r176" "%r47" "%r456")
   (instruction "add" ".u64" "%r465" "%r53" "%r441")
   (instruction "ld" ".f64" "%r467" "[%r176+34433424]")
   (instruction "mul" ".f64" "%r466" "%r467" "%r124")
   (instruction "st" ".f64" "[%r465]" "%r466")
   (instruction "add" ".u64" "%r476" "%r56" "%r441")
   (instruction "ld" ".f64" "%r478" "[%r176+68866848]")
   (instruction "mul" ".f64" "%r477" "%r478" "%r124")
   (instruction "st" ".f64" "[%r476]" "%r477")
   (instruction "add" ".u64" "%r487" "%r59" "%r441")
   (instruction "ld" ".f64" "%r489" "[%r176+103300272]")
   (instruction "mul" ".f64" "%r488" "%r489" "%r124")
   (instruction "st" ".f64" "[%r487]" "%r488")
   (instruction "ld" ".f64" "%r131" "[%r176+34433424]")
   (instruction "ld" ".f64" "%r132" "[%r176+68866848]")
   (instruction "mul" ".f64" "%r490" "%r132" "%r132")
   (instruction "fma" ".rn" ".f64" "%r134" "%r131" "%r131" "%r490")
   (instruction "ld" ".f64" "%r135" "[%r176+103300272]")
   (instruction "fma" ".rn" ".f64" "%r136" "%r135" "%r135" "%r134")
   (instruction "mul" ".f64" "%r491" "%r136" "0d3fe0000000000000")
   (instruction "mul" ".f64" "%r138" "%r491" "%r124")
   (instruction "add" ".u64" "%r500" "%r68" "%r441")
   (instruction "st" ".f64" "[%r500]" "%r138")
   (instruction "add" ".u64" "%r509" "%r70" "%r441")
   (instruction "mul" ".f64" "%r510" "%r124" "%r138")
   (instruction "st" ".f64" "[%r509]" "%r510")
   (instruction "add" ".u32" "%r140" "%r93" "128")
   (instruction "setp" ".le" ".s32" "%r511" "%r673" "%r140")
   "@%r511"
   (instruction "bra" "$L7")
   (instruction "cvt" ".s64" ".s32" "%r512" "%r140")
   (instruction "add" ".u64" "%r518" "%r201" "%r512")
   (instruction "shl" ".b64" "%r519" "%r518" "3")
   (instruction "add" ".u64" "%r520" "%r47" "%r519")
   (instruction "ld" ".f64" "%r522" "[%r520]")
   (instruction "div" ".rn" ".f64" "%r143" "%r675" "%r522")
   (instruction "add" ".u64" "%r531" "%r50" "%r519")
   (instruction "st" ".f64" "[%r531]" "%r143")
   (instruction "add" ".u64" "%r533" "%r512" "%r161")
   (instruction "shl" ".b64" "%r534" "%r533" "3")
   (instruction "add" ".u64" "%r180" "%r47" "%r534")
   (instruction "add" ".u64" "%r543" "%r53" "%r519")
   (instruction "ld" ".f64" "%r545" "[%r180+34433424]")
   (instruction "mul" ".f64" "%r544" "%r545" "%r143")
   (instruction "st" ".f64" "[%r543]" "%r544")
   (instruction "add" ".u64" "%r554" "%r56" "%r519")
   (instruction "ld" ".f64" "%r556" "[%r180+68866848]")
   (instruction "mul" ".f64" "%r555" "%r556" "%r143")
   (instruction "st" ".f64" "[%r554]" "%r555")
   (instruction "add" ".u64" "%r565" "%r59" "%r519")
   (instruction "ld" ".f64" "%r567" "[%r180+103300272]")
   (instruction "mul" ".f64" "%r566" "%r567" "%r143")
   (instruction "st" ".f64" "[%r565]" "%r566")
   (instruction "ld" ".f64" "%r150" "[%r180+34433424]")
   (instruction "ld" ".f64" "%r151" "[%r180+68866848]")
   (instruction "mul" ".f64" "%r568" "%r151" "%r151")
   (instruction "fma" ".rn" ".f64" "%r153" "%r150" "%r150" "%r568")
   (instruction "ld" ".f64" "%r154" "[%r180+103300272]")
   (instruction "fma" ".rn" ".f64" "%r155" "%r154" "%r154" "%r153")
   (instruction "mul" ".f64" "%r569" "%r155" "0d3fe0000000000000")
   (instruction "mul" ".f64" "%r157" "%r569" "%r143")
   (instruction "add" ".u64" "%r578" "%r68" "%r519")
   (instruction "st" ".f64" "[%r578]" "%r157")
   (instruction "add" ".u64" "%r587" "%r70" "%r519")
   (instruction "mul" ".f64" "%r588" "%r143" "%r157")
   (instruction "st" ".f64" "[%r587]" "%r588")
   (instruction "add" ".u32" "%r159" "%r93" "160")
   (instruction "setp" ".le" ".s32" "%r589" "%r673" "%r159")
   "@%r589"
   (instruction "bra" "$L7")
   (instruction "cvt" ".s64" ".s32" "%r590" "%r159")
   (instruction "add" ".u64" "%r596" "%r201" "%r590")
   (instruction "shl" ".b64" "%r597" "%r596" "3")
   (instruction "add" ".u64" "%r598" "%r47" "%r597")
   (instruction "ld" ".f64" "%r600" "[%r598]")
   (instruction "div" ".rn" ".f64" "%r49" "%r675" "%r600")
   (instruction "add" ".u64" "%r609" "%r50" "%r597")
   (instruction "st" ".f64" "[%r609]" "%r49")
   (instruction "add" ".u64" "%r611" "%r590" "%r161")
   (instruction "shl" ".b64" "%r612" "%r611" "3")
   (instruction "add" ".u64" "%r184" "%r47" "%r612")
   (instruction "add" ".u64" "%r621" "%r53" "%r597")
   (instruction "ld" ".f64" "%r623" "[%r184+34433424]")
   (instruction "mul" ".f64" "%r622" "%r623" "%r49")
   (instruction "st" ".f64" "[%r621]" "%r622")
   (instruction "add" ".u64" "%r632" "%r56" "%r597")
   (instruction "ld" ".f64" "%r634" "[%r184+68866848]")
   (instruction "mul" ".f64" "%r633" "%r634" "%r49")
   (instruction "st" ".f64" "[%r632]" "%r633")
   (instruction "add" ".u64" "%r643" "%r59" "%r597")
   (instruction "ld" ".f64" "%r645" "[%r184+103300272]")
   (instruction "mul" ".f64" "%r644" "%r645" "%r49")
   (instruction "st" ".f64" "[%r643]" "%r644")
   (instruction "ld" ".f64" "%r60" "[%r184+34433424]")
   (instruction "ld" ".f64" "%r61" "[%r184+68866848]")
   (instruction "mul" ".f64" "%r646" "%r61" "%r61")
   (instruction "fma" ".rn" ".f64" "%r63" "%r60" "%r60" "%r646")
   (instruction "ld" ".f64" "%r64" "[%r184+103300272]")
   (instruction "fma" ".rn" ".f64" "%r65" "%r64" "%r64" "%r63")
   (instruction "mul" ".f64" "%r647" "%r65" "0d3fe0000000000000")
   (instruction "mul" ".f64" "%r67" "%r647" "%r49")
   (instruction "add" ".u64" "%r656" "%r68" "%r597")
   (instruction "st" ".f64" "[%r656]" "%r67")
   (instruction "add" ".u64" "%r665" "%r70" "%r597")
   (instruction "mul" ".f64" "%r666" "%r49" "%r67")
   (instruction "st" ".f64" "[%r665]" "%r666")
   (instruction "bra" "$L7")
   "$L1:"
   (instruction "ret")))
  )

(define ptx-sample5
  #<<string-delimiter
.entry main$_omp_fn$1 (.param.u64 %in_ar0)
{
	.reg.u64 %ar0;
	ld.param.u64 %ar0, [%in_ar0];
	.reg.u64 %r22;
	.reg.u32 %r24;
	.reg.u32 %r25;
	.reg.u64 %r26;
	.reg.u64 %r27;
	.reg.u64 %r28;
	.reg.u64 %r29;
	.reg.u64 %r30;
	.reg.u64 %r31;
	.reg.u64 %r32;
	.reg.u64 %r35;
	.reg.u64 %r36;
	.reg.u64 %r40;
	.reg.u64 %r45;
	.reg.u64 %r62;
	.reg.u64 %r68;
	.reg.u64 %r69;
	.reg.u64 %r70;
	.reg.pred %r71;
	.reg.u64 %r72;
	.reg.u32 %r73;
	.reg.u32 %r74;
	.reg.u32 %r75;
	.reg.u32 %r76;
	.reg.u32 %r77;
	.reg.u32 %r78;
	.reg.u16 %r79;
	.reg.u16 %r80;
	.reg.u16 %r81;
	.reg.u32 %r82;
	.reg.u32 %r83;
	.reg.u32 %r84;
	.reg.u32 %r85;
	.reg.u32 %r86;
	.reg.u32 %r87;
	.reg.u32 %r88;
	.reg.u16 %r89;
	.reg.u16 %r90;
	.reg.u16 %r91;
	.reg.u32 %r92;
	.reg.u16 %r93;
	.reg.u16 %r94;
	.reg.u16 %r95;
	.reg.u32 %r96;
	.reg.u32 %r97;
	.reg.u32 %r98;
	.reg.u32 %r99;
	.reg.u32 %r100;
	.reg.u32 %r101;
	.reg.u32 %r102;
	.reg.u16 %r103;
	.reg.u16 %r104;
	.reg.u16 %r105;
	.reg.u32 %r106;
	.reg.u16 %r107;
	.reg.u16 %r108;
	.reg.u16 %r109;
	.reg.u32 %r110;
	.reg.u32 %r111;
	.reg.u32 %r112;
	.reg.u32 %r113;
	.reg.u32 %r114;
	.reg.u32 %r115;
	.reg.u32 %r116;
	.reg.u16 %r117;
	.reg.u16 %r118;
	.reg.u16 %r119;
	.reg.u32 %r120;
	.reg.u16 %r121;
	.reg.u16 %r122;
	.reg.u16 %r123;
	.reg.u32 %r124;
	.reg.u32 %r125;
	.reg.u32 %r126;
	.reg.u32 %r127;
	.reg.u32 %r128;
	.reg.u32 %r129;
	.reg.u32 %r130;
	.reg.u16 %r131;
	.reg.u16 %r132;
	.reg.u16 %r133;
	.reg.u32 %r134;
	.reg.u16 %r135;
	.reg.u16 %r136;
	.reg.u16 %r137;
	.reg.u32 %r138;
	.reg.u32 %r139;
	.reg.u32 %r140;
	.reg.u32 %r141;
	.reg.u32 %r142;
	.reg.u32 %r143;
	.reg.u32 %r144;
	.reg.u16 %r145;
	.reg.u16 %r146;
	.reg.u16 %r147;
	.reg.u32 %r148;
	.reg.u16 %r149;
	.reg.u16 %r150;
	.reg.u16 %r151;
	.reg.u32 %r152;
	.reg.u16 %r153;
	.reg.pred %r154;
	.reg.u32 %r158;
	.reg.u64 %r160;
	.reg.u64 %r167;
	.reg.u64 %r174;
	.reg.u64 %r181;
	.reg.u64 %r183;
	.reg.u64 %r184;
	.reg.u64 %r185;
	.reg.f64 %r186;
	.reg.pred %r190;
	.reg.pred %r195;
	.reg.pred %r196;
	.reg.u32 %r197;
	.reg.pred %r198;
	.reg.u32 %r199;
	.reg.pred %r200;
	.reg.u32 %r201;
	.reg.u16 %r202;
	{
		.reg.u32	%x;
		mov.u32	%x, %tid.x;
		setp.ne.u32	%r195, %x, 0;
	}
		setp.eq.u32	%r200, 1, 0;
	@%r195	bra	$L15;
		mov.u64	%r69, %ar0;
		ld.u64	%r70, [%r69];
		ld.u32	%r24, [%r70];
		setp.le.s32	%r71, %r24, 0;
		mov.pred	%r200, %r71;
$L15:
		mov.pred	%r71, %r200;
		selp.u32	%r201, 1, 0, %r71;
		shfl.idx.b32	%r201, %r201, 0, 31;
		setp.ne.u32	%r71, %r201, 0;
	@%r71	bra.uni	$L6;
		setp.eq.u32	%r198, 1, 0;
	@%r195	bra	$L14;
		ld.u64	%r28, [%r69+16];
		ld.u64	%r29, [%r69+32];
		ld.u64	%r30, [%r69+8];
		ld.u64	%r31, [%r69+24];
		add.u32	%r25, %r24, -1;
		cvt.u64.u32	%r72, %r24;
		shl.b64	%r26, %r72, 3;
		add.u64	%r27, %r28, %r26;
		add.u64	%r36, %r29, %r26;
		add.u64	%r40, %r30, %r26;
		add.u64	%r45, %r31, %r26;
		set.u32.le.u64	%r74, %r27, %r29;
		neg.s32	%r75, %r74;
		mov.u32	%r73, %r75;
		set.u32.ge.u64	%r77, %r28, %r36;
		neg.s32	%r78, %r77;
		mov.u32	%r76, %r78;
		cvt.u16.u8	%r202, %r73;
		mov.u16	%r80, %r202;
		cvt.u16.u8	%r202, %r76;
		mov.u16	%r81, %r202;
		or.b16	%r79, %r80, %r81;
		cvt.u32.u16	%r82, %r79;
		set.u32.le.u64	%r84, %r27, %r30;
		neg.s32	%r85, %r84;
		mov.u32	%r83, %r85;
		set.u32.ge.u64	%r87, %r28, %r40;
		neg.s32	%r88, %r87;
		mov.u32	%r86, %r88;
		cvt.u16.u8	%r202, %r83;
		mov.u16	%r90, %r202;
		cvt.u16.u8	%r202, %r86;
		mov.u16	%r91, %r202;
		or.b16	%r89, %r90, %r91;
		cvt.u32.u16	%r92, %r89;
		cvt.u16.u8	%r202, %r82;
		mov.u16	%r94, %r202;
		cvt.u16.u8	%r202, %r92;
		mov.u16	%r95, %r202;
		and.b16	%r93, %r94, %r95;
		cvt.u32.u16	%r96, %r93;
		set.u32.le.u64	%r98, %r27, %r31;
		neg.s32	%r99, %r98;
		mov.u32	%r97, %r99;
		set.u32.ge.u64	%r101, %r28, %r45;
		neg.s32	%r102, %r101;
		mov.u32	%r100, %r102;
		cvt.u16.u8	%r202, %r97;
		mov.u16	%r104, %r202;
		cvt.u16.u8	%r202, %r100;
		mov.u16	%r105, %r202;
		or.b16	%r103, %r104, %r105;
		cvt.u32.u16	%r106, %r103;
		cvt.u16.u8	%r202, %r96;
		mov.u16	%r108, %r202;
		cvt.u16.u8	%r202, %r106;
		mov.u16	%r109, %r202;
		and.b16	%r107, %r108, %r109;
		cvt.u32.u16	%r110, %r107;
		set.u32.ge.u64	%r112, %r30, %r36;
		neg.s32	%r113, %r112;
		mov.u32	%r111, %r113;
		set.u32.ge.u64	%r115, %r29, %r40;
		neg.s32	%r116, %r115;
		mov.u32	%r114, %r116;
		cvt.u16.u8	%r202, %r111;
		mov.u16	%r118, %r202;
		cvt.u16.u8	%r202, %r114;
		mov.u16	%r119, %r202;
		or.b16	%r117, %r118, %r119;
		cvt.u32.u16	%r120, %r117;
		cvt.u16.u8	%r202, %r110;
		mov.u16	%r122, %r202;
		cvt.u16.u8	%r202, %r120;
		mov.u16	%r123, %r202;
		and.b16	%r121, %r122, %r123;
		cvt.u32.u16	%r124, %r121;
		set.u32.ge.u64	%r126, %r31, %r36;
		neg.s32	%r127, %r126;
		mov.u32	%r125, %r127;
		set.u32.ge.u64	%r129, %r29, %r45;
		neg.s32	%r130, %r129;
		mov.u32	%r128, %r130;
		cvt.u16.u8	%r202, %r125;
		mov.u16	%r132, %r202;
		cvt.u16.u8	%r202, %r128;
		mov.u16	%r133, %r202;
		or.b16	%r131, %r132, %r133;
		cvt.u32.u16	%r134, %r131;
		cvt.u16.u8	%r202, %r124;
		mov.u16	%r136, %r202;
		cvt.u16.u8	%r202, %r134;
		mov.u16	%r137, %r202;
		and.b16	%r135, %r136, %r137;
		cvt.u32.u16	%r138, %r135;
		set.u32.ge.u64	%r140, %r31, %r40;
		neg.s32	%r141, %r140;
		mov.u32	%r139, %r141;
		set.u32.ge.u64	%r143, %r30, %r45;
		neg.s32	%r144, %r143;
		mov.u32	%r142, %r144;
		cvt.u16.u8	%r202, %r139;
		mov.u16	%r146, %r202;
		cvt.u16.u8	%r202, %r142;
		mov.u16	%r147, %r202;
		or.b16	%r145, %r146, %r147;
		cvt.u32.u16	%r148, %r145;
		cvt.u16.u8	%r202, %r138;
		mov.u16	%r150, %r202;
		cvt.u16.u8	%r202, %r148;
		mov.u16	%r151, %r202;
		and.b16	%r149, %r150, %r151;
		cvt.u32.u16	%r152, %r149;
		cvt.u16.u8	%r153, %r152;
		setp.eq.u16	%r154, %r153, 0;
		mov.pred	%r198, %r154;
$L14:
		mov.pred	%r154, %r198;
		selp.u32	%r199, 1, 0, %r154;
		shfl.idx.b32	%r199, %r199, 0, 31;
		setp.ne.u32	%r154, %r199, 0;
	@%r154	bra.uni	$L8;
	@%r195	bra	$L11;
		mov.u32	%r158, 0;
	{
		.param.u64 %value_in;
		.param.u64 %out_arg1;
		st.param.u64 [%out_arg1], %r28;
		.param.u32 %out_arg2;
		st.param.u32 [%out_arg2], %r158;
		.param.u64 %out_arg3;
		st.param.u64 [%out_arg3], %r26;
		call (%value_in), memset, (%out_arg1, %out_arg2, %out_arg3);
		ld.param.u64	%r160, [%value_in];
	}
	{
		.param.u64 %value_in;
		.param.u64 %out_arg1;
		st.param.u64 [%out_arg1], %r31;
		.param.u32 %out_arg2;
		st.param.u32 [%out_arg2], %r158;
		.param.u64 %out_arg3;
		st.param.u64 [%out_arg3], %r26;
		call (%value_in), memset, (%out_arg1, %out_arg2, %out_arg3);
		ld.param.u64	%r167, [%value_in];
	}
	{
		.param.u64 %value_in;
		.param.u64 %out_arg1;
		st.param.u64 [%out_arg1], %r30;
		.param.u32 %out_arg2;
		st.param.u32 [%out_arg2], %r158;
		.param.u64 %out_arg3;
		st.param.u64 [%out_arg3], %r26;
		call (%value_in), memset, (%out_arg1, %out_arg2, %out_arg3);
		ld.param.u64	%r174, [%value_in];
	}
	{
		.param.u64 %value_in;
		.param.u64 %out_arg1;
		st.param.u64 [%out_arg1], %r29;
		.param.u32 %out_arg2;
		st.param.u32 [%out_arg2], %r158;
		.param.u64 %out_arg3;
		st.param.u64 [%out_arg3], %r26;
		call (%value_in), memset, (%out_arg1, %out_arg2, %out_arg3);
		ld.param.u64	%r181, [%value_in];
	}
$L11:
		bra	$L6;
$L8:
	@%r195	bra	$L13;
		mov.u64	%r22, %r28;
		mov.u64	%r35, %r29;
		mov.u64	%r32, %r30;
		mov.u64	%r62, %r31;
		add.u64	%r183, %r22, 8;
		cvt.u64.u32	%r184, %r25;
		shl.b64	%r185, %r184, 3;
		add.u64	%r68, %r183, %r185;
		mov.f64	%r186, 0d0000000000000000;
$L13:
$L9:
		setp.eq.u32	%r196, 1, 0;
	@%r195	bra	$L12;
		st.f64	[%r22], %r186;
		st.f64	[%r35], %r186;
		st.f64	[%r32], %r186;
		st.f64	[%r62], %r186;
		add.u64	%r22, %r22, 8;
		add.u64	%r35, %r35, 8;
		add.u64	%r32, %r32, 8;
		add.u64	%r62, %r62, 8;
		setp.ne.u64	%r190, %r22, %r68;
		mov.pred	%r196, %r190;
$L12:
		mov.pred	%r190, %r196;
		selp.u32	%r197, 1, 0, %r190;
		shfl.idx.b32	%r197, %r197, 0, 31;
		setp.ne.u32	%r190, %r197, 0;
	@%r190	bra.uni	$L9;
$L6:
	ret;
}
string-delimiter
      )

(define ptx-sample5-out
'((kernel
   "main$_omp_fn$1"
   (storage ".param" ".u64" "%in_ar0")
   (storageN ".reg" ".u64" "%ar0")
   (instruction "ld" ".param" ".u64" "%ar0" "[%in_ar0]")
   (storageN ".reg" ".u64" "%r22")
   (storageN ".reg" ".u32" "%r24")
   (storageN ".reg" ".u32" "%r25")
   (storageN ".reg" ".u64" "%r26")
   (storageN ".reg" ".u64" "%r27")
   (storageN ".reg" ".u64" "%r28")
   (storageN ".reg" ".u64" "%r29")
   (storageN ".reg" ".u64" "%r30")
   (storageN ".reg" ".u64" "%r31")
   (storageN ".reg" ".u64" "%r32")
   (storageN ".reg" ".u64" "%r35")
   (storageN ".reg" ".u64" "%r36")
   (storageN ".reg" ".u64" "%r40")
   (storageN ".reg" ".u64" "%r45")
   (storageN ".reg" ".u64" "%r62")
   (storageN ".reg" ".u64" "%r68")
   (storageN ".reg" ".u64" "%r69")
   (storageN ".reg" ".u64" "%r70")
   (storageN ".reg" ".pred" "%r71")
   (storageN ".reg" ".u64" "%r72")
   (storageN ".reg" ".u32" "%r73")
   (storageN ".reg" ".u32" "%r74")
   (storageN ".reg" ".u32" "%r75")
   (storageN ".reg" ".u32" "%r76")
   (storageN ".reg" ".u32" "%r77")
   (storageN ".reg" ".u32" "%r78")
   (storageN ".reg" ".u16" "%r79")
   (storageN ".reg" ".u16" "%r80")
   (storageN ".reg" ".u16" "%r81")
   (storageN ".reg" ".u32" "%r82")
   (storageN ".reg" ".u32" "%r83")
   (storageN ".reg" ".u32" "%r84")
   (storageN ".reg" ".u32" "%r85")
   (storageN ".reg" ".u32" "%r86")
   (storageN ".reg" ".u32" "%r87")
   (storageN ".reg" ".u32" "%r88")
   (storageN ".reg" ".u16" "%r89")
   (storageN ".reg" ".u16" "%r90")
   (storageN ".reg" ".u16" "%r91")
   (storageN ".reg" ".u32" "%r92")
   (storageN ".reg" ".u16" "%r93")
   (storageN ".reg" ".u16" "%r94")
   (storageN ".reg" ".u16" "%r95")
   (storageN ".reg" ".u32" "%r96")
   (storageN ".reg" ".u32" "%r97")
   (storageN ".reg" ".u32" "%r98")
   (storageN ".reg" ".u32" "%r99")
   (storageN ".reg" ".u32" "%r100")
   (storageN ".reg" ".u32" "%r101")
   (storageN ".reg" ".u32" "%r102")
   (storageN ".reg" ".u16" "%r103")
   (storageN ".reg" ".u16" "%r104")
   (storageN ".reg" ".u16" "%r105")
   (storageN ".reg" ".u32" "%r106")
   (storageN ".reg" ".u16" "%r107")
   (storageN ".reg" ".u16" "%r108")
   (storageN ".reg" ".u16" "%r109")
   (storageN ".reg" ".u32" "%r110")
   (storageN ".reg" ".u32" "%r111")
   (storageN ".reg" ".u32" "%r112")
   (storageN ".reg" ".u32" "%r113")
   (storageN ".reg" ".u32" "%r114")
   (storageN ".reg" ".u32" "%r115")
   (storageN ".reg" ".u32" "%r116")
   (storageN ".reg" ".u16" "%r117")
   (storageN ".reg" ".u16" "%r118")
   (storageN ".reg" ".u16" "%r119")
   (storageN ".reg" ".u32" "%r120")
   (storageN ".reg" ".u16" "%r121")
   (storageN ".reg" ".u16" "%r122")
   (storageN ".reg" ".u16" "%r123")
   (storageN ".reg" ".u32" "%r124")
   (storageN ".reg" ".u32" "%r125")
   (storageN ".reg" ".u32" "%r126")
   (storageN ".reg" ".u32" "%r127")
   (storageN ".reg" ".u32" "%r128")
   (storageN ".reg" ".u32" "%r129")
   (storageN ".reg" ".u32" "%r130")
   (storageN ".reg" ".u16" "%r131")
   (storageN ".reg" ".u16" "%r132")
   (storageN ".reg" ".u16" "%r133")
   (storageN ".reg" ".u32" "%r134")
   (storageN ".reg" ".u16" "%r135")
   (storageN ".reg" ".u16" "%r136")
   (storageN ".reg" ".u16" "%r137")
   (storageN ".reg" ".u32" "%r138")
   (storageN ".reg" ".u32" "%r139")
   (storageN ".reg" ".u32" "%r140")
   (storageN ".reg" ".u32" "%r141")
   (storageN ".reg" ".u32" "%r142")
   (storageN ".reg" ".u32" "%r143")
   (storageN ".reg" ".u32" "%r144")
   (storageN ".reg" ".u16" "%r145")
   (storageN ".reg" ".u16" "%r146")
   (storageN ".reg" ".u16" "%r147")
   (storageN ".reg" ".u32" "%r148")
   (storageN ".reg" ".u16" "%r149")
   (storageN ".reg" ".u16" "%r150")
   (storageN ".reg" ".u16" "%r151")
   (storageN ".reg" ".u32" "%r152")
   (storageN ".reg" ".u16" "%r153")
   (storageN ".reg" ".pred" "%r154")
   (storageN ".reg" ".u32" "%r158")
   (storageN ".reg" ".u64" "%r160")
   (storageN ".reg" ".u64" "%r167")
   (storageN ".reg" ".u64" "%r174")
   (storageN ".reg" ".u64" "%r181")
   (storageN ".reg" ".u64" "%r183")
   (storageN ".reg" ".u64" "%r184")
   (storageN ".reg" ".u64" "%r185")
   (storageN ".reg" ".f64" "%r186")
   (storageN ".reg" ".pred" "%r190")
   (storageN ".reg" ".pred" "%r195")
   (storageN ".reg" ".pred" "%r196")
   (storageN ".reg" ".u32" "%r197")
   (storageN ".reg" ".pred" "%r198")
   (storageN ".reg" ".u32" "%r199")
   (storageN ".reg" ".pred" "%r200")
   (storageN ".reg" ".u32" "%r201")
   (storageN ".reg" ".u16" "%r202")
   (group
    (storageN ".reg" ".u32" "%x")
    (instruction "mov" ".u32" "%x" "%tid.x")
    (instruction "setp" ".ne" ".u32" "%r195" "%x" "0"))
   (instruction "setp" ".eq" ".u32" "%r200" "1" "0")
   "@%r195"
   (instruction "bra" "$L15")
   (instruction "mov" ".u64" "%r69" "%ar0")
   (instruction "ld" ".u64" "%r70" "[%r69]")
   (instruction "ld" ".u32" "%r24" "[%r70]")
   (instruction "setp" ".le" ".s32" "%r71" "%r24" "0")
   (instruction "mov" ".pred" "%r200" "%r71")
   "$L15:"
   (instruction "mov" ".pred" "%r71" "%r200")
   (instruction "selp" ".u32" "%r201" "1" "0" "%r71")
   (instruction "shfl" ".idx" ".b32" "%r201" "%r201" "0" "31")
   (instruction "setp" ".ne" ".u32" "%r71" "%r201" "0")
   "@%r71"
   (instruction "bra" ".uni" "$L6")
   (instruction "setp" ".eq" ".u32" "%r198" "1" "0")
   "@%r195"
   (instruction "bra" "$L14")
   (instruction "ld" ".u64" "%r28" "[%r69+16]")
   (instruction "ld" ".u64" "%r29" "[%r69+32]")
   (instruction "ld" ".u64" "%r30" "[%r69+8]")
   (instruction "ld" ".u64" "%r31" "[%r69+24]")
   (instruction "add" ".u32" "%r25" "%r24" "-1")
   (instruction "cvt" ".u64" ".u32" "%r72" "%r24")
   (instruction "shl" ".b64" "%r26" "%r72" "3")
   (instruction "add" ".u64" "%r27" "%r28" "%r26")
   (instruction "add" ".u64" "%r36" "%r29" "%r26")
   (instruction "add" ".u64" "%r40" "%r30" "%r26")
   (instruction "add" ".u64" "%r45" "%r31" "%r26")
   (instruction "set" ".u32" ".le" ".u64" "%r74" "%r27" "%r29")
   (instruction "neg" ".s32" "%r75" "%r74")
   (instruction "mov" ".u32" "%r73" "%r75")
   (instruction "set" ".u32" ".ge" ".u64" "%r77" "%r28" "%r36")
   (instruction "neg" ".s32" "%r78" "%r77")
   (instruction "mov" ".u32" "%r76" "%r78")
   (instruction "cvt" ".u16" ".u8" "%r202" "%r73")
   (instruction "mov" ".u16" "%r80" "%r202")
   (instruction "cvt" ".u16" ".u8" "%r202" "%r76")
   (instruction "mov" ".u16" "%r81" "%r202")
   (instruction "or" ".b16" "%r79" "%r80" "%r81")
   (instruction "cvt" ".u32" ".u16" "%r82" "%r79")
   (instruction "set" ".u32" ".le" ".u64" "%r84" "%r27" "%r30")
   (instruction "neg" ".s32" "%r85" "%r84")
   (instruction "mov" ".u32" "%r83" "%r85")
   (instruction "set" ".u32" ".ge" ".u64" "%r87" "%r28" "%r40")
   (instruction "neg" ".s32" "%r88" "%r87")
   (instruction "mov" ".u32" "%r86" "%r88")
   (instruction "cvt" ".u16" ".u8" "%r202" "%r83")
   (instruction "mov" ".u16" "%r90" "%r202")
   (instruction "cvt" ".u16" ".u8" "%r202" "%r86")
   (instruction "mov" ".u16" "%r91" "%r202")
   (instruction "or" ".b16" "%r89" "%r90" "%r91")
   (instruction "cvt" ".u32" ".u16" "%r92" "%r89")
   (instruction "cvt" ".u16" ".u8" "%r202" "%r82")
   (instruction "mov" ".u16" "%r94" "%r202")
   (instruction "cvt" ".u16" ".u8" "%r202" "%r92")
   (instruction "mov" ".u16" "%r95" "%r202")
   (instruction "and" ".b16" "%r93" "%r94" "%r95")
   (instruction "cvt" ".u32" ".u16" "%r96" "%r93")
   (instruction "set" ".u32" ".le" ".u64" "%r98" "%r27" "%r31")
   (instruction "neg" ".s32" "%r99" "%r98")
   (instruction "mov" ".u32" "%r97" "%r99")
   (instruction "set" ".u32" ".ge" ".u64" "%r101" "%r28" "%r45")
   (instruction "neg" ".s32" "%r102" "%r101")
   (instruction "mov" ".u32" "%r100" "%r102")
   (instruction "cvt" ".u16" ".u8" "%r202" "%r97")
   (instruction "mov" ".u16" "%r104" "%r202")
   (instruction "cvt" ".u16" ".u8" "%r202" "%r100")
   (instruction "mov" ".u16" "%r105" "%r202")
   (instruction "or" ".b16" "%r103" "%r104" "%r105")
   (instruction "cvt" ".u32" ".u16" "%r106" "%r103")
   (instruction "cvt" ".u16" ".u8" "%r202" "%r96")
   (instruction "mov" ".u16" "%r108" "%r202")
   (instruction "cvt" ".u16" ".u8" "%r202" "%r106")
   (instruction "mov" ".u16" "%r109" "%r202")
   (instruction "and" ".b16" "%r107" "%r108" "%r109")
   (instruction "cvt" ".u32" ".u16" "%r110" "%r107")
   (instruction "set" ".u32" ".ge" ".u64" "%r112" "%r30" "%r36")
   (instruction "neg" ".s32" "%r113" "%r112")
   (instruction "mov" ".u32" "%r111" "%r113")
   (instruction "set" ".u32" ".ge" ".u64" "%r115" "%r29" "%r40")
   (instruction "neg" ".s32" "%r116" "%r115")
   (instruction "mov" ".u32" "%r114" "%r116")
   (instruction "cvt" ".u16" ".u8" "%r202" "%r111")
   (instruction "mov" ".u16" "%r118" "%r202")
   (instruction "cvt" ".u16" ".u8" "%r202" "%r114")
   (instruction "mov" ".u16" "%r119" "%r202")
   (instruction "or" ".b16" "%r117" "%r118" "%r119")
   (instruction "cvt" ".u32" ".u16" "%r120" "%r117")
   (instruction "cvt" ".u16" ".u8" "%r202" "%r110")
   (instruction "mov" ".u16" "%r122" "%r202")
   (instruction "cvt" ".u16" ".u8" "%r202" "%r120")
   (instruction "mov" ".u16" "%r123" "%r202")
   (instruction "and" ".b16" "%r121" "%r122" "%r123")
   (instruction "cvt" ".u32" ".u16" "%r124" "%r121")
   (instruction "set" ".u32" ".ge" ".u64" "%r126" "%r31" "%r36")
   (instruction "neg" ".s32" "%r127" "%r126")
   (instruction "mov" ".u32" "%r125" "%r127")
   (instruction "set" ".u32" ".ge" ".u64" "%r129" "%r29" "%r45")
   (instruction "neg" ".s32" "%r130" "%r129")
   (instruction "mov" ".u32" "%r128" "%r130")
   (instruction "cvt" ".u16" ".u8" "%r202" "%r125")
   (instruction "mov" ".u16" "%r132" "%r202")
   (instruction "cvt" ".u16" ".u8" "%r202" "%r128")
   (instruction "mov" ".u16" "%r133" "%r202")
   (instruction "or" ".b16" "%r131" "%r132" "%r133")
   (instruction "cvt" ".u32" ".u16" "%r134" "%r131")
   (instruction "cvt" ".u16" ".u8" "%r202" "%r124")
   (instruction "mov" ".u16" "%r136" "%r202")
   (instruction "cvt" ".u16" ".u8" "%r202" "%r134")
   (instruction "mov" ".u16" "%r137" "%r202")
   (instruction "and" ".b16" "%r135" "%r136" "%r137")
   (instruction "cvt" ".u32" ".u16" "%r138" "%r135")
   (instruction "set" ".u32" ".ge" ".u64" "%r140" "%r31" "%r40")
   (instruction "neg" ".s32" "%r141" "%r140")
   (instruction "mov" ".u32" "%r139" "%r141")
   (instruction "set" ".u32" ".ge" ".u64" "%r143" "%r30" "%r45")
   (instruction "neg" ".s32" "%r144" "%r143")
   (instruction "mov" ".u32" "%r142" "%r144")
   (instruction "cvt" ".u16" ".u8" "%r202" "%r139")
   (instruction "mov" ".u16" "%r146" "%r202")
   (instruction "cvt" ".u16" ".u8" "%r202" "%r142")
   (instruction "mov" ".u16" "%r147" "%r202")
   (instruction "or" ".b16" "%r145" "%r146" "%r147")
   (instruction "cvt" ".u32" ".u16" "%r148" "%r145")
   (instruction "cvt" ".u16" ".u8" "%r202" "%r138")
   (instruction "mov" ".u16" "%r150" "%r202")
   (instruction "cvt" ".u16" ".u8" "%r202" "%r148")
   (instruction "mov" ".u16" "%r151" "%r202")
   (instruction "and" ".b16" "%r149" "%r150" "%r151")
   (instruction "cvt" ".u32" ".u16" "%r152" "%r149")
   (instruction "cvt" ".u16" ".u8" "%r153" "%r152")
   (instruction "setp" ".eq" ".u16" "%r154" "%r153" "0")
   (instruction "mov" ".pred" "%r198" "%r154")
   "$L14:"
   (instruction "mov" ".pred" "%r154" "%r198")
   (instruction "selp" ".u32" "%r199" "1" "0" "%r154")
   (instruction "shfl" ".idx" ".b32" "%r199" "%r199" "0" "31")
   (instruction "setp" ".ne" ".u32" "%r154" "%r199" "0")
   "@%r154"
   (instruction "bra" ".uni" "$L8")
   "@%r195"
   (instruction "bra" "$L11")
   (instruction "mov" ".u32" "%r158" "0")
   (group
    (storageN ".param" ".u64" "%value_in")
    (storageN ".param" ".u64" "%out_arg1")
    (instruction "st" ".param" ".u64" "[%out_arg1]" "%r28")
    (storageN ".param" ".u32" "%out_arg2")
    (instruction "st" ".param" ".u32" "[%out_arg2]" "%r158")
    (storageN ".param" ".u64" "%out_arg3")
    (instruction "st" ".param" ".u64" "[%out_arg3]" "%r26")
    (instruction
     "call"
     "(%value_in)"
     "memset"
     "(%out_arg1,%out_arg2,%out_arg3)")
    (instruction "ld" ".param" ".u64" "%r160" "[%value_in]"))
   (group
    (storageN ".param" ".u64" "%value_in")
    (storageN ".param" ".u64" "%out_arg1")
    (instruction "st" ".param" ".u64" "[%out_arg1]" "%r31")
    (storageN ".param" ".u32" "%out_arg2")
    (instruction "st" ".param" ".u32" "[%out_arg2]" "%r158")
    (storageN ".param" ".u64" "%out_arg3")
    (instruction "st" ".param" ".u64" "[%out_arg3]" "%r26")
    (instruction
     "call"
     "(%value_in)"
     "memset"
     "(%out_arg1,%out_arg2,%out_arg3)")
    (instruction "ld" ".param" ".u64" "%r167" "[%value_in]"))
   (group
    (storageN ".param" ".u64" "%value_in")
    (storageN ".param" ".u64" "%out_arg1")
    (instruction "st" ".param" ".u64" "[%out_arg1]" "%r30")
    (storageN ".param" ".u32" "%out_arg2")
    (instruction "st" ".param" ".u32" "[%out_arg2]" "%r158")
    (storageN ".param" ".u64" "%out_arg3")
    (instruction "st" ".param" ".u64" "[%out_arg3]" "%r26")
    (instruction
     "call"
     "(%value_in)"
     "memset"
     "(%out_arg1,%out_arg2,%out_arg3)")
    (instruction "ld" ".param" ".u64" "%r174" "[%value_in]"))
   (group
    (storageN ".param" ".u64" "%value_in")
    (storageN ".param" ".u64" "%out_arg1")
    (instruction "st" ".param" ".u64" "[%out_arg1]" "%r29")
    (storageN ".param" ".u32" "%out_arg2")
    (instruction "st" ".param" ".u32" "[%out_arg2]" "%r158")
    (storageN ".param" ".u64" "%out_arg3")
    (instruction "st" ".param" ".u64" "[%out_arg3]" "%r26")
    (instruction
     "call"
     "(%value_in)"
     "memset"
     "(%out_arg1,%out_arg2,%out_arg3)")
    (instruction "ld" ".param" ".u64" "%r181" "[%value_in]"))
   "$L11:"
   (instruction "bra" "$L6")
   "$L8:"
   "@%r195"
   (instruction "bra" "$L13")
   (instruction "mov" ".u64" "%r22" "%r28")
   (instruction "mov" ".u64" "%r35" "%r29")
   (instruction "mov" ".u64" "%r32" "%r30")
   (instruction "mov" ".u64" "%r62" "%r31")
   (instruction "add" ".u64" "%r183" "%r22" "8")
   (instruction "cvt" ".u64" ".u32" "%r184" "%r25")
   (instruction "shl" ".b64" "%r185" "%r184" "3")
   (instruction "add" ".u64" "%r68" "%r183" "%r185")
   (instruction "mov" ".f64" "%r186" "0d0000000000000000")
   "$L13:"
   "$L9:"
   (instruction "setp" ".eq" ".u32" "%r196" "1" "0")
   "@%r195"
   (instruction "bra" "$L12")
   (instruction "st" ".f64" "[%r22]" "%r186")
   (instruction "st" ".f64" "[%r35]" "%r186")
   (instruction "st" ".f64" "[%r32]" "%r186")
   (instruction "st" ".f64" "[%r62]" "%r186")
   (instruction "add" ".u64" "%r22" "%r22" "8")
   (instruction "add" ".u64" "%r35" "%r35" "8")
   (instruction "add" ".u64" "%r32" "%r32" "8")
   (instruction "add" ".u64" "%r62" "%r62" "8")
   (instruction "setp" ".ne" ".u64" "%r190" "%r22" "%r68")
   (instruction "mov" ".pred" "%r196" "%r190")
   "$L12:"
   (instruction "mov" ".pred" "%r190" "%r196")
   (instruction "selp" ".u32" "%r197" "1" "0" "%r190")
   (instruction "shfl" ".idx" ".b32" "%r197" "%r197" "0" "31")
   (instruction "setp" ".ne" ".u32" "%r190" "%r197" "0")
   "@%r190"
   (instruction "bra" ".uni" "$L9")
   "$L6:"
   (instruction "ret")))
  )

(define ptx-sample6
  #<<string-delimiter

.extern .func (.param.f64 %value_out) exp (.param.f64 %in_ar0);


.extern .func sincos (.param.f64 %in_ar0, .param.u64 %in_ar1, .param.u64 %in_ar2);


.shared .align 8 .u8 __oacc_bcast[648];


.shared .align 8 .u8 __worker_red[16];


.shared .align 8 .u8 __vector_red[16];


.entry fft_init$_omp_fn$1 (.param.u64 %in_ar0)
{
	.reg.u64 %ar0;
	ld.param.u64 %ar0, [%in_ar0];
	.local .align 16 .b8 %frame_ar[16];
	.reg.u64 %frame;
	cvta.local.u64 %frame, %frame_ar;
	.reg.f64 %r24;
	.reg.u32 %r26;
	.reg.u32 %r28;
	.reg.u32 %r32;
	.reg.u32 %r33;
	.reg.u64 %r39;
	.reg.u64 %r41;
	.reg.u64 %r43;
	.reg.u64 %r45;
	.reg.u32 %r47;
	.reg.u32 %r49;
	.reg.u64 %r50;
	.reg.u32 %r57;
	.reg.u32 %r58;
	.reg.u32 %r59;
	.reg.f64 %r60;
	.reg.f64 %r61;
	.reg.u64 %r68;
	.reg.u64 %r69;
	.reg.u64 %r70;
	.reg.u64 %r71;
	.reg.u64 %r72;
	.reg.u32 %r73;
	.reg.u32 %r74;
	.reg.u32 %r75;
	.reg.u32 %r76;
	.reg.u32 %r77;
	.reg.u32 %r78;
	.reg.pred %r79;
	.reg.u32 %r80;
	.reg.u32 %r81;
	.reg.u32 %r82;
	.reg.u64 %r83;
	.reg.u64 %r84;
	.reg.u32 %r86;
	.reg.u64 %r87;
	.reg.u64 %r91;
	.reg.u32 %r97;
	.reg.f64 %r98;
	.reg.f64 %r99;
	.reg.u64 %r100;
	.reg.u64 %r101;
	.reg.u64 %r103;
	.reg.pred %r104;
	.reg.u64 %r105;
	.reg.u64 %r106;
	.reg.u64 %r107;
	.reg.u64 %r108;
	.reg.u64 %r109;
	.reg.u32 %r110;
	.reg.pred %r111;
	.reg.u64 %r112;
	.reg.u64 %r113;
	.reg.u64 %r114;
	.reg.u64 %r115;
	.reg.u32 %r116;
	.reg.pred %r117;
	.reg.u64 %r118;
	.reg.pred %r119;
	{
		.reg.u32	%x;
		mov.u32	%x, %tid.x;
		setp.ne.u32	%r119, %x, 0;
	}
	@%r119	bra	$L58;
		mov.u64	%r69, %ar0;
		ld.u64	%r70, [%r69+24];
		ld.f64	%r24, [%r70];
		ld.u64	%r71, [%r69+32];
		ld.u32	%r26, [%r71];
		ld.u64	%r72, [%r69+40];
		ld.u32	%r28, [%r72];
	
		cvta.shared.u64	%r113, __oacc_bcast;
		mov.u64	%r115, %frame;
		mov.u32	%r116, 2;
		add.u64	%r118, %r113, 0;
$L57:
		add.u32	%r116, %r116, -1;
		ld.u64	%r114, [%r115];
		st.u64	[%r118], %r114;
		add.u64	%r118, %r118, 8;
		setp.ne.u32	%r117, %r116, 0;
		add.u64	%r115, %r115, 8;
	@%r117	bra.uni	$L57;
		st.f64	[%r113+16], %r24;
		st.u32	[%r113+24], %r26;
		st.u32	[%r113+28], %r28;
		st.u64	[%r113+32], %r69;
$L58:
		bar.sync	0;
	
		cvta.shared.u64	%r107, __oacc_bcast;
		mov.u64	%r109, %frame;
		mov.u32	%r110, 2;
		add.u64	%r112, %r107, 0;
$L56:
		add.u32	%r110, %r110, -1;
		ld.u64	%r108, [%r112];
		add.u64	%r112, %r112, 8;
		st.u64	[%r109], %r108;
		setp.ne.u32	%r111, %r110, 0;
		add.u64	%r109, %r109, 8;
	@%r111	bra.uni	$L56;
		ld.f64	%r24, [%r107+16];
		ld.u32	%r26, [%r107+24];
		ld.u32	%r28, [%r107+28];
		ld.u64	%r69, [%r107+32];
		mov.u32	%r57, %nctaid.x;
		mov.u32	%r58, %ctaid.x;
		mov.u32	%r59, %tid.x;
		shl.b32	%r47, %r57, 7;
		add.u32	%r73, %r26, -1;
		add.u32	%r74, %r73, %r47;
		div.s32	%r49, %r74, %r47;
		mul.lo.u32	%r75, %r49, %r58;
		shl.b32	%r76, %r75, 7;
		add.u32	%r32, %r76, %r59;
		shl.b32	%r77, %r49, 7;
		add.u32	%r78, %r77, %r32;
		min.s32	%r33, %r78, %r26;
		setp.ge.s32	%r79, %r32, %r33;
	@%r79	bra	$L53;
		ld.u64	%r39, [%r69+8];
		ld.u64	%r41, [%r69];
		cvt.s64.s32	%r45, %r32;
		sub.u32	%r80, %r33, %r32;
		add.u32	%r81, %r80, -1;
		shr.u32	%r82, %r81, 7;
		cvt.u64.u32	%r83, %r82;
		shl.b64	%r84, %r83, 7;
		add.u64	%r106, %r45, 128;
		add.u64	%r68, %r84, %r106;
		add.u32	%r86, %r28, %r32;
		cvt.s64.s32	%r87, %r86;
		sub.u64	%r91, %r87, %r45;
		shl.b64	%r50, %r91, 3;
		add.u64	%r105, %frame, 8;
$L54:
		cvt.u32.u64	%r97, %r45;
		cvt.rn.f64.s32	%r98, %r97;
		mul.f64	%r99, %r98, %r24;
	{
		.param.f64 %out_arg1;
		st.param.f64 [%out_arg1], %r99;
		.param.u64 %out_arg2;
		st.param.u64 [%out_arg2], %frame;
		.param.u64 %out_arg3;
		st.param.u64 [%out_arg3], %r105;
		call sincos, (%out_arg1, %out_arg2, %out_arg3);
	}
		ld.f64	%r60, [%frame+8];
		ld.f64	%r61, [%frame];
		shl.b64	%r43, %r45, 3;
		add.u64	%r100, %r43, %r50;
		add.u64	%r101, %r39, %r100;
		st.f64	[%r101+-8], %r60;
		add.u64	%r103, %r41, %r100;
		st.f64	[%r103+-8], %r61;
		mov.u64	%r45, %r106;
		setp.ne.u64	%r104, %r106, %r68;
	@!%r104	bra	$L53;
		add.u64	%r106, %r106, 128;
		bra	$L54;
$L53:
	
		bar.sync	0;
	
	ret;
}
string-delimiter
      )

(define ptx-sample6-out
'((linking
   ".extern"
   (function
    (storage ".param" ".f64" "%value_out")
    "exp"
    (storage ".param" ".f64" "%in_ar0")))
  (linking
   ".extern"
   (function
    "sincos"
    (storage ".param" ".f64" "%in_ar0")
    (storage ".param" ".u64" "%in_ar1")
    (storage ".param" ".u64" "%in_ar2")))
  (storageN ".shared" ".align 8" ".u8" "__oacc_bcast[648]")
  (storageN ".shared" ".align 8" ".u8" "__worker_red[16]")
  (storageN ".shared" ".align 8" ".u8" "__vector_red[16]")
  (kernel
   "fft_init$_omp_fn$1"
   (storage ".param" ".u64" "%in_ar0")
   (storageN ".reg" ".u64" "%ar0")
   (instruction "ld" ".param" ".u64" "%ar0" "[%in_ar0]")
   (storageN ".local" ".align 16" ".b8" "%frame_ar[16]")
   (storageN ".reg" ".u64" "%frame")
   (instruction "cvta" ".local" ".u64" "%frame" "%frame_ar")
   (storageN ".reg" ".f64" "%r24")
   (storageN ".reg" ".u32" "%r26")
   (storageN ".reg" ".u32" "%r28")
   (storageN ".reg" ".u32" "%r32")
   (storageN ".reg" ".u32" "%r33")
   (storageN ".reg" ".u64" "%r39")
   (storageN ".reg" ".u64" "%r41")
   (storageN ".reg" ".u64" "%r43")
   (storageN ".reg" ".u64" "%r45")
   (storageN ".reg" ".u32" "%r47")
   (storageN ".reg" ".u32" "%r49")
   (storageN ".reg" ".u64" "%r50")
   (storageN ".reg" ".u32" "%r57")
   (storageN ".reg" ".u32" "%r58")
   (storageN ".reg" ".u32" "%r59")
   (storageN ".reg" ".f64" "%r60")
   (storageN ".reg" ".f64" "%r61")
   (storageN ".reg" ".u64" "%r68")
   (storageN ".reg" ".u64" "%r69")
   (storageN ".reg" ".u64" "%r70")
   (storageN ".reg" ".u64" "%r71")
   (storageN ".reg" ".u64" "%r72")
   (storageN ".reg" ".u32" "%r73")
   (storageN ".reg" ".u32" "%r74")
   (storageN ".reg" ".u32" "%r75")
   (storageN ".reg" ".u32" "%r76")
   (storageN ".reg" ".u32" "%r77")
   (storageN ".reg" ".u32" "%r78")
   (storageN ".reg" ".pred" "%r79")
   (storageN ".reg" ".u32" "%r80")
   (storageN ".reg" ".u32" "%r81")
   (storageN ".reg" ".u32" "%r82")
   (storageN ".reg" ".u64" "%r83")
   (storageN ".reg" ".u64" "%r84")
   (storageN ".reg" ".u32" "%r86")
   (storageN ".reg" ".u64" "%r87")
   (storageN ".reg" ".u64" "%r91")
   (storageN ".reg" ".u32" "%r97")
   (storageN ".reg" ".f64" "%r98")
   (storageN ".reg" ".f64" "%r99")
   (storageN ".reg" ".u64" "%r100")
   (storageN ".reg" ".u64" "%r101")
   (storageN ".reg" ".u64" "%r103")
   (storageN ".reg" ".pred" "%r104")
   (storageN ".reg" ".u64" "%r105")
   (storageN ".reg" ".u64" "%r106")
   (storageN ".reg" ".u64" "%r107")
   (storageN ".reg" ".u64" "%r108")
   (storageN ".reg" ".u64" "%r109")
   (storageN ".reg" ".u32" "%r110")
   (storageN ".reg" ".pred" "%r111")
   (storageN ".reg" ".u64" "%r112")
   (storageN ".reg" ".u64" "%r113")
   (storageN ".reg" ".u64" "%r114")
   (storageN ".reg" ".u64" "%r115")
   (storageN ".reg" ".u32" "%r116")
   (storageN ".reg" ".pred" "%r117")
   (storageN ".reg" ".u64" "%r118")
   (storageN ".reg" ".pred" "%r119")
   (group
    (storageN ".reg" ".u32" "%x")
    (instruction "mov" ".u32" "%x" "%tid.x")
    (instruction "setp" ".ne" ".u32" "%r119" "%x" "0"))
   "@%r119"
   (instruction "bra" "$L58")
   (instruction "mov" ".u64" "%r69" "%ar0")
   (instruction "ld" ".u64" "%r70" "[%r69+24]")
   (instruction "ld" ".f64" "%r24" "[%r70]")
   (instruction "ld" ".u64" "%r71" "[%r69+32]")
   (instruction "ld" ".u32" "%r26" "[%r71]")
   (instruction "ld" ".u64" "%r72" "[%r69+40]")
   (instruction "ld" ".u32" "%r28" "[%r72]")
   (instruction "cvta" ".shared" ".u64" "%r113" "__oacc_bcast")
   (instruction "mov" ".u64" "%r115" "%frame")
   (instruction "mov" ".u32" "%r116" "2")
   (instruction "add" ".u64" "%r118" "%r113" "0")
   "$L57:"
   (instruction "add" ".u32" "%r116" "%r116" "-1")
   (instruction "ld" ".u64" "%r114" "[%r115]")
   (instruction "st" ".u64" "[%r118]" "%r114")
   (instruction "add" ".u64" "%r118" "%r118" "8")
   (instruction "setp" ".ne" ".u32" "%r117" "%r116" "0")
   (instruction "add" ".u64" "%r115" "%r115" "8")
   "@%r117"
   (instruction "bra" ".uni" "$L57")
   (instruction "st" ".f64" "[%r113+16]" "%r24")
   (instruction "st" ".u32" "[%r113+24]" "%r26")
   (instruction "st" ".u32" "[%r113+28]" "%r28")
   (instruction "st" ".u64" "[%r113+32]" "%r69")
   "$L58:"
   (instruction "bar" ".sync" "0")
   (instruction "cvta" ".shared" ".u64" "%r107" "__oacc_bcast")
   (instruction "mov" ".u64" "%r109" "%frame")
   (instruction "mov" ".u32" "%r110" "2")
   (instruction "add" ".u64" "%r112" "%r107" "0")
   "$L56:"
   (instruction "add" ".u32" "%r110" "%r110" "-1")
   (instruction "ld" ".u64" "%r108" "[%r112]")
   (instruction "add" ".u64" "%r112" "%r112" "8")
   (instruction "st" ".u64" "[%r109]" "%r108")
   (instruction "setp" ".ne" ".u32" "%r111" "%r110" "0")
   (instruction "add" ".u64" "%r109" "%r109" "8")
   "@%r111"
   (instruction "bra" ".uni" "$L56")
   (instruction "ld" ".f64" "%r24" "[%r107+16]")
   (instruction "ld" ".u32" "%r26" "[%r107+24]")
   (instruction "ld" ".u32" "%r28" "[%r107+28]")
   (instruction "ld" ".u64" "%r69" "[%r107+32]")
   (instruction "mov" ".u32" "%r57" "%nctaid.x")
   (instruction "mov" ".u32" "%r58" "%ctaid.x")
   (instruction "mov" ".u32" "%r59" "%tid.x")
   (instruction "shl" ".b32" "%r47" "%r57" "7")
   (instruction "add" ".u32" "%r73" "%r26" "-1")
   (instruction "add" ".u32" "%r74" "%r73" "%r47")
   (instruction "div" ".s32" "%r49" "%r74" "%r47")
   (instruction "mul" ".lo" ".u32" "%r75" "%r49" "%r58")
   (instruction "shl" ".b32" "%r76" "%r75" "7")
   (instruction "add" ".u32" "%r32" "%r76" "%r59")
   (instruction "shl" ".b32" "%r77" "%r49" "7")
   (instruction "add" ".u32" "%r78" "%r77" "%r32")
   (instruction "min" ".s32" "%r33" "%r78" "%r26")
   (instruction "setp" ".ge" ".s32" "%r79" "%r32" "%r33")
   "@%r79"
   (instruction "bra" "$L53")
   (instruction "ld" ".u64" "%r39" "[%r69+8]")
   (instruction "ld" ".u64" "%r41" "[%r69]")
   (instruction "cvt" ".s64" ".s32" "%r45" "%r32")
   (instruction "sub" ".u32" "%r80" "%r33" "%r32")
   (instruction "add" ".u32" "%r81" "%r80" "-1")
   (instruction "shr" ".u32" "%r82" "%r81" "7")
   (instruction "cvt" ".u64" ".u32" "%r83" "%r82")
   (instruction "shl" ".b64" "%r84" "%r83" "7")
   (instruction "add" ".u64" "%r106" "%r45" "128")
   (instruction "add" ".u64" "%r68" "%r84" "%r106")
   (instruction "add" ".u32" "%r86" "%r28" "%r32")
   (instruction "cvt" ".s64" ".s32" "%r87" "%r86")
   (instruction "sub" ".u64" "%r91" "%r87" "%r45")
   (instruction "shl" ".b64" "%r50" "%r91" "3")
   (instruction "add" ".u64" "%r105" "%frame" "8")
   "$L54:"
   (instruction "cvt" ".u32" ".u64" "%r97" "%r45")
   (instruction "cvt" ".rn" ".f64" ".s32" "%r98" "%r97")
   (instruction "mul" ".f64" "%r99" "%r98" "%r24")
   (group
    (storageN ".param" ".f64" "%out_arg1")
    (instruction "st" ".param" ".f64" "[%out_arg1]" "%r99")
    (storageN ".param" ".u64" "%out_arg2")
    (instruction "st" ".param" ".u64" "[%out_arg2]" "%frame")
    (storageN ".param" ".u64" "%out_arg3")
    (instruction "st" ".param" ".u64" "[%out_arg3]" "%r105")
    (instruction "call" "sincos" "(%out_arg1,%out_arg2,%out_arg3)"))
   (instruction "ld" ".f64" "%r60" "[%frame+8]")
   (instruction "ld" ".f64" "%r61" "[%frame]")
   (instruction "shl" ".b64" "%r43" "%r45" "3")
   (instruction "add" ".u64" "%r100" "%r43" "%r50")
   (instruction "add" ".u64" "%r101" "%r39" "%r100")
   (instruction "st" ".f64" "[%r101+-8]" "%r60")
   (instruction "add" ".u64" "%r103" "%r41" "%r100")
   (instruction "st" ".f64" "[%r103+-8]" "%r61")
   (instruction "mov" ".u64" "%r45" "%r106")
   (instruction "setp" ".ne" ".u64" "%r104" "%r106" "%r68")
   "@!%r104"
   (instruction "bra" "$L53")
   (instruction "add" ".u64" "%r106" "%r106" "128")
   (instruction "bra" "$L54")
   "$L53:"
   (instruction "bar" ".sync" "0")
   (instruction "ret")))
  )

(define ptx-sample7
  #<<string-delimiter
.visible .entry fft_init_572_gpu(
	.param .u32 fft_init_572_gpu_param_0,
	.param .u64 fft_init_572_gpu_param_1,
	.param .u64 fft_init_572_gpu_param_2,
	.param .f64 fft_init_572_gpu_param_3,
	.param .u32 fft_init_572_gpu_param_4
)
.maxntid 128, 1, 1
{
	.local .align 4 .b8 	__local_depot4[4];
	.reg .b64 	%SP;
	.reg .b64 	%SPL;
	.reg .pred 	%p<9>;
	.reg .b32 	%r<40>;
	.reg .f64 	%fd<59>;
	.reg .b64 	%rd<11>;


	mov.u64 	%SPL, __local_depot4;
	cvta.local.u64 	%SP, %SPL;
	ld.param.u32 	%r12, [fft_init_572_gpu_param_0];
	ld.param.u64 	%rd4, [fft_init_572_gpu_param_1];
	ld.param.u64 	%rd5, [fft_init_572_gpu_param_2];
	ld.param.f64 	%fd13, [fft_init_572_gpu_param_3];
	ld.param.u32 	%r14, [fft_init_572_gpu_param_4];
	cvta.to.global.u64 	%rd1, %rd5;
	cvta.to.global.u64 	%rd2, %rd4;
	add.u64 	%rd6, %SP, 0;
	add.u64 	%rd3, %SPL, 0;
	mov.u32 	%r15, %nctaid.x;
	shl.b32 	%r1, %r15, 7;
	mov.u32 	%r16, %ctaid.x;
	shl.b32 	%r2, %r16, 7;
	mov.u32 	%r3, %tid.x;
	mov.u32 	%r17, 1;
	sub.s32 	%r4, %r17, %r12;
	add.s32 	%r5, %r14, -1;
	mov.u32 	%r38, 0;

BB4_1:
	add.s32 	%r18, %r38, %r2;
	add.s32 	%r7, %r18, %r3;
	add.s32 	%r19, %r7, %r4;
	setp.gt.s32	%p1, %r19, 0;
	@%p1 bra 	BB4_10;

	cvt.rn.f64.s32	%fd14, %r7;
	mul.f64 	%fd55, %fd14, %fd13;
	{
	.reg .b32 %temp; 
	mov.b64 	{%temp, %r20}, %fd55;
	}
	and.b32  	%r21, %r20, 2147483647;
	setp.ne.s32	%p2, %r21, 2146435072;
	@%p2 bra 	BB4_5;

	{
	.reg .b32 %temp; 
	mov.b64 	{%r22, %temp}, %fd55;
	}
	setp.ne.s32	%p3, %r22, 0;
	@%p3 bra 	BB4_5;

	mov.f64 	%fd15, 0d0000000000000000;
	mul.rn.f64 	%fd55, %fd55, %fd15;

BB4_5:
	mul.f64 	%fd16, %fd55, 0d3FE45F306DC9C883;
	cvt.rni.s32.f64	%r39, %fd16;
	st.local.u32 	[%rd3], %r39;
	cvt.rn.f64.s32	%fd17, %r39;
	neg.f64 	%fd18, %fd17;
	mov.f64 	%fd19, 0d3FF921FB54442D18;
	fma.rn.f64 	%fd20, %fd18, %fd19, %fd55;
	mov.f64 	%fd21, 0d3C91A62633145C00;
	fma.rn.f64 	%fd22, %fd18, %fd21, %fd20;
	mov.f64 	%fd23, 0d397B839A252049C0;
	fma.rn.f64 	%fd56, %fd18, %fd23, %fd22;
	{
	.reg .b32 %temp; 
	mov.b64 	{%temp, %r23}, %fd55;
	}
	and.b32  	%r24, %r23, 2145386496;
	setp.lt.u32	%p4, %r24, 1105199104;
	@%p4 bra 	BB4_7;

	// Callseq Start 0
	{
	.reg .b32 temp_param_reg;
	// <end>}
	.param .b64 param0;
	st.param.f64	[param0+0], %fd55;
	.param .b64 param1;
	st.param.b64	[param1+0], %rd6;
	.param .b64 retval0;
	call.uni (retval0), 
	__internal_trig_reduction_slowpathd, 
	(
	param0, 
	param1
	);
	ld.param.f64	%fd56, [retval0+0];
	
	//{
	}// Callseq End 0
	ld.local.u32 	%r39, [%rd3];

BB4_7:
	mul.rn.f64 	%fd24, %fd56, %fd56;
	mov.f64 	%fd25, 0d3E21EEA7C1EF8528;
	mov.f64 	%fd26, 0dBDA8FF8320FD8164;
	fma.rn.f64 	%fd27, %fd26, %fd24, %fd25;
	mov.f64 	%fd28, 0dBE927E4F8E06E6D9;
	fma.rn.f64 	%fd29, %fd27, %fd24, %fd28;
	mov.f64 	%fd30, 0d3EFA01A019DDBCE9;
	fma.rn.f64 	%fd31, %fd29, %fd24, %fd30;
	mov.f64 	%fd32, 0dBF56C16C16C15D47;
	fma.rn.f64 	%fd33, %fd31, %fd24, %fd32;
	mov.f64 	%fd34, 0d3FA5555555555551;
	fma.rn.f64 	%fd35, %fd33, %fd24, %fd34;
	mov.f64 	%fd36, 0dBFE0000000000000;
	fma.rn.f64 	%fd37, %fd35, %fd24, %fd36;
	mov.f64 	%fd38, 0d3FF0000000000000;
	fma.rn.f64 	%fd39, %fd37, %fd24, %fd38;
	mov.f64 	%fd40, 0dBE5AE5F12CB0D246;
	mov.f64 	%fd41, 0d3DE5DB65F9785EBA;
	fma.rn.f64 	%fd42, %fd41, %fd24, %fd40;
	mov.f64 	%fd43, 0d3EC71DE369ACE392;
	fma.rn.f64 	%fd44, %fd42, %fd24, %fd43;
	mov.f64 	%fd45, 0dBF2A01A019DB62A1;
	fma.rn.f64 	%fd46, %fd44, %fd24, %fd45;
	mov.f64 	%fd47, 0d3F81111111110818;
	fma.rn.f64 	%fd48, %fd46, %fd24, %fd47;
	mov.f64 	%fd49, 0dBFC5555555555554;
	fma.rn.f64 	%fd50, %fd48, %fd24, %fd49;
	mov.f64 	%fd51, 0d0000000000000000;
	fma.rn.f64 	%fd52, %fd50, %fd24, %fd51;
	fma.rn.f64 	%fd53, %fd52, %fd56, %fd56;
	{
	.reg .b32 %temp; 
	mov.b64 	{%temp, %r25}, %fd53;
	}
	{
	.reg .b32 %temp; 
	mov.b64 	{%r26, %temp}, %fd53;
	}
	xor.b32  	%r27, %r25, -2147483648;
	mov.b64 	%fd54, {%r26, %r27};
	and.b32  	%r28, %r39, 1;
	setp.eq.b32	%p5, %r28, 1;
	not.pred 	%p6, %p5;
	selp.f64	%fd57, %fd53, %fd39, %p6;
	selp.f64	%fd58, %fd39, %fd54, %p6;
	and.b32  	%r29, %r39, 2;
	setp.eq.s32	%p7, %r29, 0;
	@%p7 bra 	BB4_9;

	{
	.reg .b32 %temp; 
	mov.b64 	{%temp, %r30}, %fd57;
	}
	xor.b32  	%r31, %r30, -2147483648;
	{
	.reg .b32 %temp; 
	mov.b64 	{%r32, %temp}, %fd57;
	}
	mov.b64 	%fd57, {%r32, %r31};
	{
	.reg .b32 %temp; 
	mov.b64 	{%temp, %r33}, %fd58;
	}
	xor.b32  	%r34, %r33, -2147483648;
	{
	.reg .b32 %temp; 
	mov.b64 	{%r35, %temp}, %fd58;
	}
	mov.b64 	%fd58, {%r35, %r34};

BB4_9:
	add.s32 	%r36, %r7, %r5;
	mul.wide.s32 	%rd8, %r36, 8;
	add.s64 	%rd9, %rd2, %rd8;
	st.global.f64 	[%rd9], %fd58;
	add.s64 	%rd10, %rd1, %rd8;
	st.global.f64 	[%rd10], %fd57;

BB4_10:
	add.s32 	%r38, %r38, %r1;
	sub.s32 	%r37, %r38, %r12;
	setp.lt.s32	%p8, %r37, 0;
	@%p8 bra 	BB4_1;

	ret;
}
string-delimiter
      )

(define ptx-sample7-out
'((linking
   ".visible"
   (kernel
    "fft_init_572_gpu"
    (storage ".param" ".u32" "fft_init_572_gpu_param_0")
    (storage ".param" ".u64" "fft_init_572_gpu_param_1")
    (storage ".param" ".u64" "fft_init_572_gpu_param_2")
    (storage ".param" ".f64" "fft_init_572_gpu_param_3")
    (storage ".param" ".u32" "fft_init_572_gpu_param_4")
    (".maxntid" "128" "1" "1")
    (storageN ".local" ".align 4" ".b8" "__local_depot4[4]")
    (storageN ".reg" ".b64" "%SP")
    (storageN ".reg" ".b64" "%SPL")
    (storageN ".reg" ".pred" "%p<9>")
    (storageN ".reg" ".b32" "%r<40>")
    (storageN ".reg" ".f64" "%fd<59>")
    (storageN ".reg" ".b64" "%rd<11>")
    (instruction "mov" ".u64" "%SPL" "__local_depot4")
    (instruction "cvta" ".local" ".u64" "%SP" "%SPL")
    (instruction "ld" ".param" ".u32" "%r12" "[fft_init_572_gpu_param_0]")
    (instruction "ld" ".param" ".u64" "%rd4" "[fft_init_572_gpu_param_1]")
    (instruction "ld" ".param" ".u64" "%rd5" "[fft_init_572_gpu_param_2]")
    (instruction "ld" ".param" ".f64" "%fd13" "[fft_init_572_gpu_param_3]")
    (instruction "ld" ".param" ".u32" "%r14" "[fft_init_572_gpu_param_4]")
    (instruction "cvta" ".to" ".global" ".u64" "%rd1" "%rd5")
    (instruction "cvta" ".to" ".global" ".u64" "%rd2" "%rd4")
    (instruction "add" ".u64" "%rd6" "%SP" "0")
    (instruction "add" ".u64" "%rd3" "%SPL" "0")
    (instruction "mov" ".u32" "%r15" "%nctaid.x")
    (instruction "shl" ".b32" "%r1" "%r15" "7")
    (instruction "mov" ".u32" "%r16" "%ctaid.x")
    (instruction "shl" ".b32" "%r2" "%r16" "7")
    (instruction "mov" ".u32" "%r3" "%tid.x")
    (instruction "mov" ".u32" "%r17" "1")
    (instruction "sub" ".s32" "%r4" "%r17" "%r12")
    (instruction "add" ".s32" "%r5" "%r14" "-1")
    (instruction "mov" ".u32" "%r38" "0")
    "BB4_1:"
    (instruction "add" ".s32" "%r18" "%r38" "%r2")
    (instruction "add" ".s32" "%r7" "%r18" "%r3")
    (instruction "add" ".s32" "%r19" "%r7" "%r4")
    (instruction "setp" ".gt" ".s32" "%p1" "%r19" "0")
    "@%p1"
    (instruction "bra" "BB4_10")
    (instruction "cvt" ".rn" ".f64" ".s32" "%fd14" "%r7")
    (instruction "mul" ".f64" "%fd55" "%fd14" "%fd13")
    (group
     (storageN ".reg" ".b32" "%temp")
     (instruction "mov" ".b64" "{%temp,%r20}" "%fd55"))
    (instruction "and" ".b32" "%r21" "%r20" "2147483647")
    (instruction "setp" ".ne" ".s32" "%p2" "%r21" "2146435072")
    "@%p2"
    (instruction "bra" "BB4_5")
    (group
     (storageN ".reg" ".b32" "%temp")
     (instruction "mov" ".b64" "{%r22,%temp}" "%fd55"))
    (instruction "setp" ".ne" ".s32" "%p3" "%r22" "0")
    "@%p3"
    (instruction "bra" "BB4_5")
    (instruction "mov" ".f64" "%fd15" "0d0000000000000000")
    (instruction "mul" ".rn" ".f64" "%fd55" "%fd55" "%fd15")
    "BB4_5:"
    (instruction "mul" ".f64" "%fd16" "%fd55" "0d3FE45F306DC9C883")
    (instruction "cvt" ".rni" ".s32" ".f64" "%r39" "%fd16")
    (instruction "st" ".local" ".u32" "[%rd3]" "%r39")
    (instruction "cvt" ".rn" ".f64" ".s32" "%fd17" "%r39")
    (instruction "neg" ".f64" "%fd18" "%fd17")
    (instruction "mov" ".f64" "%fd19" "0d3FF921FB54442D18")
    (instruction "fma" ".rn" ".f64" "%fd20" "%fd18" "%fd19" "%fd55")
    (instruction "mov" ".f64" "%fd21" "0d3C91A62633145C00")
    (instruction "fma" ".rn" ".f64" "%fd22" "%fd18" "%fd21" "%fd20")
    (instruction "mov" ".f64" "%fd23" "0d397B839A252049C0")
    (instruction "fma" ".rn" ".f64" "%fd56" "%fd18" "%fd23" "%fd22")
    (group
     (storageN ".reg" ".b32" "%temp")
     (instruction "mov" ".b64" "{%temp,%r23}" "%fd55"))
    (instruction "and" ".b32" "%r24" "%r23" "2145386496")
    (instruction "setp" ".lt" ".u32" "%p4" "%r24" "1105199104")
    "@%p4"
    (instruction "bra" "BB4_7")
    (group
     (storageN ".reg" ".b32" "temp_param_reg")
     (storageN ".param" ".b64" "param0")
     (instruction "st" ".param" ".f64" "[param0+0]" "%fd55")
     (storageN ".param" ".b64" "param1")
     (instruction "st" ".param" ".b64" "[param1+0]" "%rd6")
     (storageN ".param" ".b64" "retval0")
     (instruction
      "call"
      ".uni"
      "(retval0)"
      "__internal_trig_reduction_slowpathd"
      "(param0,param1)")
     (instruction "ld" ".param" ".f64" "%fd56" "[retval0+0]"))
    (instruction "ld" ".local" ".u32" "%r39" "[%rd3]")
    "BB4_7:"
    (instruction "mul" ".rn" ".f64" "%fd24" "%fd56" "%fd56")
    (instruction "mov" ".f64" "%fd25" "0d3E21EEA7C1EF8528")
    (instruction "mov" ".f64" "%fd26" "0dBDA8FF8320FD8164")
    (instruction "fma" ".rn" ".f64" "%fd27" "%fd26" "%fd24" "%fd25")
    (instruction "mov" ".f64" "%fd28" "0dBE927E4F8E06E6D9")
    (instruction "fma" ".rn" ".f64" "%fd29" "%fd27" "%fd24" "%fd28")
    (instruction "mov" ".f64" "%fd30" "0d3EFA01A019DDBCE9")
    (instruction "fma" ".rn" ".f64" "%fd31" "%fd29" "%fd24" "%fd30")
    (instruction "mov" ".f64" "%fd32" "0dBF56C16C16C15D47")
    (instruction "fma" ".rn" ".f64" "%fd33" "%fd31" "%fd24" "%fd32")
    (instruction "mov" ".f64" "%fd34" "0d3FA5555555555551")
    (instruction "fma" ".rn" ".f64" "%fd35" "%fd33" "%fd24" "%fd34")
    (instruction "mov" ".f64" "%fd36" "0dBFE0000000000000")
    (instruction "fma" ".rn" ".f64" "%fd37" "%fd35" "%fd24" "%fd36")
    (instruction "mov" ".f64" "%fd38" "0d3FF0000000000000")
    (instruction "fma" ".rn" ".f64" "%fd39" "%fd37" "%fd24" "%fd38")
    (instruction "mov" ".f64" "%fd40" "0dBE5AE5F12CB0D246")
    (instruction "mov" ".f64" "%fd41" "0d3DE5DB65F9785EBA")
    (instruction "fma" ".rn" ".f64" "%fd42" "%fd41" "%fd24" "%fd40")
    (instruction "mov" ".f64" "%fd43" "0d3EC71DE369ACE392")
    (instruction "fma" ".rn" ".f64" "%fd44" "%fd42" "%fd24" "%fd43")
    (instruction "mov" ".f64" "%fd45" "0dBF2A01A019DB62A1")
    (instruction "fma" ".rn" ".f64" "%fd46" "%fd44" "%fd24" "%fd45")
    (instruction "mov" ".f64" "%fd47" "0d3F81111111110818")
    (instruction "fma" ".rn" ".f64" "%fd48" "%fd46" "%fd24" "%fd47")
    (instruction "mov" ".f64" "%fd49" "0dBFC5555555555554")
    (instruction "fma" ".rn" ".f64" "%fd50" "%fd48" "%fd24" "%fd49")
    (instruction "mov" ".f64" "%fd51" "0d0000000000000000")
    (instruction "fma" ".rn" ".f64" "%fd52" "%fd50" "%fd24" "%fd51")
    (instruction "fma" ".rn" ".f64" "%fd53" "%fd52" "%fd56" "%fd56")
    (group
     (storageN ".reg" ".b32" "%temp")
     (instruction "mov" ".b64" "{%temp,%r25}" "%fd53"))
    (group
     (storageN ".reg" ".b32" "%temp")
     (instruction "mov" ".b64" "{%r26,%temp}" "%fd53"))
    (instruction "xor" ".b32" "%r27" "%r25" "-2147483648")
    (instruction "mov" ".b64" "%fd54" "{%r26,%r27}")
    (instruction "and" ".b32" "%r28" "%r39" "1")
    (instruction "setp" ".eq" ".b32" "%p5" "%r28" "1")
    (instruction "not" ".pred" "%p6" "%p5")
    (instruction "selp" ".f64" "%fd57" "%fd53" "%fd39" "%p6")
    (instruction "selp" ".f64" "%fd58" "%fd39" "%fd54" "%p6")
    (instruction "and" ".b32" "%r29" "%r39" "2")
    (instruction "setp" ".eq" ".s32" "%p7" "%r29" "0")
    "@%p7"
    (instruction "bra" "BB4_9")
    (group
     (storageN ".reg" ".b32" "%temp")
     (instruction "mov" ".b64" "{%temp,%r30}" "%fd57"))
    (instruction "xor" ".b32" "%r31" "%r30" "-2147483648")
    (group
     (storageN ".reg" ".b32" "%temp")
     (instruction "mov" ".b64" "{%r32,%temp}" "%fd57"))
    (instruction "mov" ".b64" "%fd57" "{%r32,%r31}")
    (group
     (storageN ".reg" ".b32" "%temp")
     (instruction "mov" ".b64" "{%temp,%r33}" "%fd58"))
    (instruction "xor" ".b32" "%r34" "%r33" "-2147483648")
    (group
     (storageN ".reg" ".b32" "%temp")
     (instruction "mov" ".b64" "{%r35,%temp}" "%fd58"))
    (instruction "mov" ".b64" "%fd58" "{%r35,%r34}")
    "BB4_9:"
    (instruction "add" ".s32" "%r36" "%r7" "%r5")
    (instruction "mul" ".wide" ".s32" "%rd8" "%r36" "8")
    (instruction "add" ".s64" "%rd9" "%rd2" "%rd8")
    (instruction "st" ".global" ".f64" "[%rd9]" "%fd58")
    (instruction "add" ".s64" "%rd10" "%rd1" "%rd8")
    (instruction "st" ".global" ".f64" "[%rd10]" "%fd57")
    "BB4_10:"
    (instruction "add" ".s32" "%r38" "%r38" "%r1")
    (instruction "sub" ".s32" "%r37" "%r38" "%r12")
    (instruction "setp" ".lt" ".s32" "%p8" "%r37" "0")
    "@%p8"
    (instruction "bra" "BB4_1")
    (instruction "ret"))))
  )

(define ptx-sample8
  #<<string-delimiter
.weak .entry ComputeQCPU_53_gpu(
	.param .u32 ComputeQCPU_53_gpu_param_0,
	.param .u32 ComputeQCPU_53_gpu_param_1,
	.param .u64 ComputeQCPU_53_gpu_param_2,
	.param .u64 ComputeQCPU_53_gpu_param_3,
	.param .u64 ComputeQCPU_53_gpu_param_4,
	.param .u64 ComputeQCPU_53_gpu_param_5,
	.param .u64 ComputeQCPU_53_gpu_param_6,
	.param .u64 ComputeQCPU_53_gpu_param_7
)
.maxntid 128, 1, 1
{
	.local .align 4 .b8 	__local_depot1[28];
	.reg .b64 	%SP;
	.reg .b64 	%SPL;
	.reg .pred 	%p<34>;
	.reg .f32 	%f<129>;
	.reg .b32 	%r<102>;
	.reg .f64 	%fd<3>;
	.reg .b64 	%rd<43>;


	mov.u64 	%SPL, __local_depot1;
	cvta.local.u64 	%SP, %SPL;
	ld.param.u32 	%r36, [ComputeQCPU_53_gpu_param_0];
	ld.param.u32 	%r37, [ComputeQCPU_53_gpu_param_1];
	ld.param.u64 	%rd8, [ComputeQCPU_53_gpu_param_2];
	ld.param.u64 	%rd9, [ComputeQCPU_53_gpu_param_3];
	ld.param.u64 	%rd10, [ComputeQCPU_53_gpu_param_4];
	ld.param.u64 	%rd11, [ComputeQCPU_53_gpu_param_5];
	ld.param.u64 	%rd12, [ComputeQCPU_53_gpu_param_6];
	ld.param.u64 	%rd13, [ComputeQCPU_53_gpu_param_7];
	mov.u32 	%r92, 0;
	mov.u32 	%r1, %tid.x;
	cvta.to.global.u64 	%rd14, %rd10;
	cvta.to.global.u64 	%rd17, %rd12;
	cvta.to.global.u64 	%rd19, %rd13;
	cvta.to.global.u64 	%rd36, %rd8;
	cvta.to.global.u64 	%rd39, %rd9;
	cvta.to.global.u64 	%rd21, %rd11;

BB1_1:
	mov.u32 	%r3, %ctaid.x;
	add.s32 	%r39, %r3, %r92;
	add.s32 	%r40, %r37, -1;
	setp.gt.s32	%p17, %r39, %r40;
	@%p17 bra 	BB1_51;

	bar.sync 	0;
	mul.wide.s32 	%rd15, %r39, 4;
	add.s64 	%rd16, %rd14, %rd15;
	ld.global.f32 	%f3, [%rd16];
	add.s64 	%rd18, %rd17, %rd15;
	ld.global.f32 	%f4, [%rd18];
	add.s64 	%rd20, %rd19, %rd15;
	ld.global.f32 	%f5, [%rd20];
	mov.u32 	%r93, 0;
	mov.f32 	%f120, 0f00000000;
	mov.f32 	%f121, %f120;

BB1_3:
	add.s32 	%r43, %r36, -1;
	add.s32 	%r5, %r1, %r93;
	setp.gt.s32	%p18, %r5, %r43;
	@%p18 bra 	BB1_16;

	mul.wide.s32 	%rd22, %r5, 16;
	add.s64 	%rd23, %rd21, %rd22;
	ld.global.nc.v4.f32 	{%f31, %f32, %f33, %f34}, [%rd23];
	mul.f32 	%f35, %f5, %f31;
	fma.rn.f32 	%f36, %f4, %f32, %f35;
	fma.rn.f32 	%f37, %f3, %f33, %f36;
	mul.f32 	%f12, %f37, 0f40C90FDB;
	mul.f32 	%f38, %f12, 0f3F22F983;
	cvt.rni.s32.f32	%r101, %f38;
	cvt.rn.f32.s32	%f39, %r101;
	mov.f32 	%f40, 0fBFC90FDA;
	fma.rn.f32 	%f41, %f39, %f40, %f12;
	mov.f32 	%f42, 0fB3A22168;
	fma.rn.f32 	%f43, %f39, %f42, %f41;
	mov.f32 	%f44, 0fA7C234C5;
	fma.rn.f32 	%f122, %f39, %f44, %f43;
	abs.f32 	%f14, %f12;
	setp.leu.f32	%p19, %f14, 0f47CE4780;
	@%p19 bra 	BB1_15;

	setp.eq.f32	%p20, %f14, 0f7F800000;
	@%p20 bra 	BB1_14;
	bra.uni 	BB1_6;

BB1_14:
	mov.f32 	%f47, 0f00000000;
	mul.rn.f32 	%f122, %f12, %f47;
	bra.uni 	BB1_15;

BB1_6:
	mov.b32 	 %r7, %f12;
	shr.u32 	%r8, %r7, 23;
	bfe.u32 	%r46, %r7, 23, 8;
	add.s32 	%r47, %r46, -128;
	shl.b32 	%r48, %r7, 8;
	or.b32  	%r9, %r48, -2147483648;
	shr.u32 	%r10, %r47, 5;
	add.u64 	%rd25, %SP, 0;
	add.u64 	%rd42, %SPL, 0;
	mov.u32 	%r95, 0;
	mov.u64 	%rd41, __cudart_i2opi_f;
	mov.u32 	%r94, -6;

BB1_7:
	.pragma "nounroll";
	ld.const.u32 	%r51, [%rd41];
	
	{
	mad.lo.cc.u32   %r49, %r51, %r9, %r95;
	madc.hi.u32     %r95, %r51, %r9,  0;
	}
	
	st.local.u32 	[%rd42], %r49;
	add.s64 	%rd42, %rd42, 4;
	add.s64 	%rd41, %rd41, 4;
	add.s32 	%r94, %r94, 1;
	setp.ne.s32	%p21, %r94, 0;
	@%p21 bra 	BB1_7;

	and.b32  	%r15, %r7, -2147483648;
	cvta.to.local.u64 	%rd27, %rd25;
	st.local.u32 	[%rd27+24], %r95;
	mov.u32 	%r54, 6;
	sub.s32 	%r55, %r54, %r10;
	mul.wide.s32 	%rd28, %r55, 4;
	add.s64 	%rd6, %rd27, %rd28;
	ld.local.u32 	%r97, [%rd6];
	ld.local.u32 	%r96, [%rd6+-4];
	and.b32  	%r18, %r8, 31;
	setp.eq.s32	%p22, %r18, 0;
	@%p22 bra 	BB1_10;

	mov.u32 	%r56, 32;
	sub.s32 	%r57, %r56, %r18;
	shr.u32 	%r58, %r96, %r57;
	shl.b32 	%r59, %r97, %r18;
	add.s32 	%r97, %r58, %r59;
	ld.local.u32 	%r60, [%rd6+-8];
	shr.u32 	%r61, %r60, %r57;
	shl.b32 	%r62, %r96, %r18;
	add.s32 	%r96, %r61, %r62;

BB1_10:
	shr.u32 	%r63, %r96, 30;
	shl.b32 	%r64, %r97, 2;
	add.s32 	%r99, %r64, %r63;
	shl.b32 	%r24, %r96, 2;
	shr.u32 	%r65, %r99, 31;
	shr.u32 	%r66, %r97, 30;
	add.s32 	%r25, %r65, %r66;
	setp.eq.s32	%p23, %r65, 0;
	@%p23 bra 	BB1_11;
	bra.uni 	BB1_12;

BB1_11:
	mov.u32 	%r98, %r24;
	mov.u32 	%r100, %r15;
	bra.uni 	BB1_13;

BB1_12:
	not.b32 	%r67, %r99;
	neg.s32 	%r98, %r24;
	setp.eq.s32	%p24, %r24, 0;
	selp.u32	%r68, 1, 0, %p24;
	add.s32 	%r99, %r68, %r67;
	xor.b32  	%r100, %r15, -2147483648;

BB1_13:
	cvt.u64.u32	%rd29, %r99;
	cvt.u64.u32	%rd30, %r98;
	bfi.b64 	%rd31, %rd29, %rd30, 32, 32;
	cvt.rn.f64.s64	%fd1, %rd31;
	mul.f64 	%fd2, %fd1, 0d3BF921FB54442D19;
	cvt.rn.f32.f64	%f45, %fd2;
	neg.f32 	%f46, %f45;
	setp.eq.s32	%p25, %r100, 0;
	selp.f32	%f122, %f45, %f46, %p25;
	setp.eq.s32	%p26, %r15, 0;
	neg.s32 	%r69, %r25;
	selp.b32	%r101, %r25, %r69, %p26;

BB1_15:
	mul.f32 	%f48, %f122, %f122;
	mov.f32 	%f49, 0fBAB607ED;
	mov.f32 	%f50, 0f37CBAC00;
	fma.rn.f32 	%f51, %f50, %f48, %f49;
	mov.f32 	%f52, 0f3D2AAABB;
	fma.rn.f32 	%f53, %f51, %f48, %f52;
	mov.f32 	%f54, 0fBEFFFFFF;
	fma.rn.f32 	%f55, %f53, %f48, %f54;
	mov.f32 	%f56, 0f3F800000;
	fma.rn.f32 	%f57, %f55, %f48, %f56;
	mov.f32 	%f58, 0f00000000;
	fma.rn.f32 	%f59, %f48, %f122, %f58;
	mov.f32 	%f60, 0f3C0885E4;
	mov.f32 	%f61, 0fB94D4153;
	fma.rn.f32 	%f62, %f61, %f48, %f60;
	mov.f32 	%f63, 0fBE2AAAA8;
	fma.rn.f32 	%f64, %f62, %f48, %f63;
	fma.rn.f32 	%f65, %f64, %f59, %f122;
	and.b32  	%r70, %r101, 1;
	setp.eq.b32	%p27, %r70, 1;
	not.pred 	%p28, %p27;
	selp.f32	%f66, %f65, %f57, %p28;
	selp.f32	%f67, %f57, %f65, %p28;
	and.b32  	%r71, %r101, 2;
	setp.eq.s32	%p29, %r71, 0;
	neg.f32 	%f68, %f66;
	selp.f32	%f69, %f66, %f68, %p29;
	add.s32 	%r72, %r101, 1;
	and.b32  	%r73, %r72, 2;
	setp.eq.s32	%p30, %r73, 0;
	neg.f32 	%f70, %f67;
	selp.f32	%f71, %f67, %f70, %p30;
	fma.rn.f32 	%f120, %f71, %f34, %f120;
	fma.rn.f32 	%f121, %f34, %f69, %f121;

BB1_16:
	add.s32 	%r93, %r93, 128;
	setp.lt.s32	%p31, %r93, %r36;
	@%p31 bra 	BB1_3;

	add.s32 	%r74, %r1, -64;
	setp.gt.s32	%p1, %r74, -1;
	mov.u64 	%rd32, S33_ComputeQCPU_53_gpu;
	cvta.shared.u64 	%rd33, %rd32;
	cvta.to.shared.u64 	%rd34, %rd33;
	shl.b32 	%r75, %r1, 2;
	cvt.s64.s32	%rd35, %r75;
	add.s64 	%rd7, %rd34, %rd35;
	st.shared.f32 	[%rd7], %f120;
	bar.sync 	0;
	bar.sync 	0;
	@%p1 bra 	BB1_19;

	ld.shared.f32 	%f72, [%rd7];
	ld.shared.f32 	%f73, [%rd7+256];
	add.f32 	%f74, %f72, %f73;
	st.shared.f32 	[%rd7], %f74;

BB1_19:
	add.s32 	%r76, %r1, -32;
	setp.gt.s32	%p2, %r76, -1;
	bar.sync 	0;
	bar.sync 	0;
	@%p2 bra 	BB1_21;

	ld.shared.f32 	%f75, [%rd7];
	ld.shared.f32 	%f76, [%rd7+128];
	add.f32 	%f77, %f75, %f76;
	st.shared.f32 	[%rd7], %f77;

BB1_21:
	add.s32 	%r77, %r1, -16;
	setp.gt.s32	%p3, %r77, -1;
	bar.sync 	0;
	bar.sync 	0;
	@%p3 bra 	BB1_23;

	ld.shared.f32 	%f78, [%rd7];
	ld.shared.f32 	%f79, [%rd7+64];
	add.f32 	%f80, %f78, %f79;
	st.shared.f32 	[%rd7], %f80;

BB1_23:
	add.s32 	%r78, %r1, -8;
	setp.gt.s32	%p4, %r78, -1;
	bar.sync 	0;
	bar.sync 	0;
	@%p4 bra 	BB1_25;

	ld.shared.f32 	%f81, [%rd7];
	ld.shared.f32 	%f82, [%rd7+32];
	add.f32 	%f83, %f81, %f82;
	st.shared.f32 	[%rd7], %f83;

BB1_25:
	add.s32 	%r79, %r1, -4;
	setp.gt.s32	%p5, %r79, -1;
	bar.sync 	0;
	bar.sync 	0;
	@%p5 bra 	BB1_27;

	ld.shared.f32 	%f84, [%rd7];
	ld.shared.f32 	%f85, [%rd7+16];
	add.f32 	%f86, %f84, %f85;
	st.shared.f32 	[%rd7], %f86;

BB1_27:
	add.s32 	%r80, %r1, -2;
	setp.gt.s32	%p6, %r80, -1;
	bar.sync 	0;
	bar.sync 	0;
	@%p6 bra 	BB1_29;

	ld.shared.f32 	%f87, [%rd7];
	ld.shared.f32 	%f88, [%rd7+8];
	add.f32 	%f89, %f87, %f88;
	st.shared.f32 	[%rd7], %f89;

BB1_29:
	add.s32 	%r81, %r1, -1;
	setp.gt.s32	%p7, %r81, -1;
	bar.sync 	0;
	bar.sync 	0;
	@%p7 bra 	BB1_31;

	ld.shared.f32 	%f90, [%rd7];
	ld.shared.f32 	%f91, [%rd7+4];
	add.f32 	%f92, %f90, %f91;
	st.shared.f32 	[%rd7], %f92;

BB1_31:
	setp.eq.s32	%p8, %r1, 0;
	bar.sync 	0;
	@!%p8 bra 	BB1_33;
	bra.uni 	BB1_32;

BB1_32:
	ld.shared.f32 	%f127, [%rd7];

BB1_33:
	st.shared.f32 	[%rd7], %f121;
	bar.sync 	0;
	bar.sync 	0;
	@%p1 bra 	BB1_35;

	ld.shared.f32 	%f93, [%rd7];
	ld.shared.f32 	%f94, [%rd7+256];
	add.f32 	%f95, %f93, %f94;
	st.shared.f32 	[%rd7], %f95;

BB1_35:
	bar.sync 	0;
	bar.sync 	0;
	@%p2 bra 	BB1_37;

	ld.shared.f32 	%f96, [%rd7];
	ld.shared.f32 	%f97, [%rd7+128];
	add.f32 	%f98, %f96, %f97;
	st.shared.f32 	[%rd7], %f98;

BB1_37:
	bar.sync 	0;
	bar.sync 	0;
	@%p3 bra 	BB1_39;

	ld.shared.f32 	%f99, [%rd7];
	ld.shared.f32 	%f100, [%rd7+64];
	add.f32 	%f101, %f99, %f100;
	st.shared.f32 	[%rd7], %f101;

BB1_39:
	bar.sync 	0;
	bar.sync 	0;
	@%p4 bra 	BB1_41;

	ld.shared.f32 	%f102, [%rd7];
	ld.shared.f32 	%f103, [%rd7+32];
	add.f32 	%f104, %f102, %f103;
	st.shared.f32 	[%rd7], %f104;

BB1_41:
	bar.sync 	0;
	bar.sync 	0;
	@%p5 bra 	BB1_43;

	ld.shared.f32 	%f105, [%rd7];
	ld.shared.f32 	%f106, [%rd7+16];
	add.f32 	%f107, %f105, %f106;
	st.shared.f32 	[%rd7], %f107;

BB1_43:
	bar.sync 	0;
	bar.sync 	0;
	@%p6 bra 	BB1_45;

	ld.shared.f32 	%f108, [%rd7];
	ld.shared.f32 	%f109, [%rd7+8];
	add.f32 	%f110, %f108, %f109;
	st.shared.f32 	[%rd7], %f110;

BB1_45:
	bar.sync 	0;
	bar.sync 	0;
	@%p7 bra 	BB1_47;

	ld.shared.f32 	%f111, [%rd7];
	ld.shared.f32 	%f112, [%rd7+4];
	add.f32 	%f113, %f111, %f112;
	st.shared.f32 	[%rd7], %f113;

BB1_47:
	bar.sync 	0;
	@!%p8 bra 	BB1_49;
	bra.uni 	BB1_48;

BB1_48:
	ld.shared.f32 	%f128, [%rd7];

BB1_49:
	bar.sync 	0;
	setp.ne.s32	%p32, %r1, 0;
	@%p32 bra 	BB1_51;

	add.s64 	%rd38, %rd36, %rd15;
	ld.global.f32 	%f114, [%rd38];
	add.f32 	%f115, %f127, %f114;
	st.global.f32 	[%rd38], %f115;
	add.s64 	%rd40, %rd39, %rd15;
	ld.global.f32 	%f116, [%rd40];
	add.f32 	%f117, %f128, %f116;
	st.global.f32 	[%rd40], %f117;

BB1_51:
	mov.u32 	%r91, %nctaid.x;
	add.s32 	%r92, %r91, %r92;
	setp.lt.s32	%p33, %r92, %r37;
	@%p33 bra 	BB1_1;

	ret;
}
string-delimiter
      )

(define ptx-sample8-out
'(linking
  ".weak"
  (kernel
   "ComputeQCPU_53_gpu"
   (storage ".param" ".u32" "ComputeQCPU_53_gpu_param_0")
   (storage ".param" ".u32" "ComputeQCPU_53_gpu_param_1")
   (storage ".param" ".u64" "ComputeQCPU_53_gpu_param_2")
   (storage ".param" ".u64" "ComputeQCPU_53_gpu_param_3")
   (storage ".param" ".u64" "ComputeQCPU_53_gpu_param_4")
   (storage ".param" ".u64" "ComputeQCPU_53_gpu_param_5")
   (storage ".param" ".u64" "ComputeQCPU_53_gpu_param_6")
   (storage ".param" ".u64" "ComputeQCPU_53_gpu_param_7")
   (".maxntid" "128" "1" "1")
   (storageN ".local" ".align 4" ".b8" "__local_depot1[28]")
   (storageN ".reg" ".b64" "%SP")
   (storageN ".reg" ".b64" "%SPL")
   (storageN ".reg" ".pred" "%p<34>")
   (storageN ".reg" ".f32" "%f<129>")
   (storageN ".reg" ".b32" "%r<102>")
   (storageN ".reg" ".f64" "%fd<3>")
   (storageN ".reg" ".b64" "%rd<43>")
   (instruction "mov" ".u64" "%SPL" "__local_depot1")
   (instruction "cvta" ".local" ".u64" "%SP" "%SPL")
   (instruction "ld" ".param" ".u32" "%r36" "[ComputeQCPU_53_gpu_param_0]")
   (instruction "ld" ".param" ".u32" "%r37" "[ComputeQCPU_53_gpu_param_1]")
   (instruction "ld" ".param" ".u64" "%rd8" "[ComputeQCPU_53_gpu_param_2]")
   (instruction "ld" ".param" ".u64" "%rd9" "[ComputeQCPU_53_gpu_param_3]")
   (instruction "ld" ".param" ".u64" "%rd10" "[ComputeQCPU_53_gpu_param_4]")
   (instruction "ld" ".param" ".u64" "%rd11" "[ComputeQCPU_53_gpu_param_5]")
   (instruction "ld" ".param" ".u64" "%rd12" "[ComputeQCPU_53_gpu_param_6]")
   (instruction "ld" ".param" ".u64" "%rd13" "[ComputeQCPU_53_gpu_param_7]")
   (instruction "mov" ".u32" "%r92" "0")
   (instruction "mov" ".u32" "%r1" "%tid.x")
   (instruction "cvta" ".to" ".global" ".u64" "%rd14" "%rd10")
   (instruction "cvta" ".to" ".global" ".u64" "%rd17" "%rd12")
   (instruction "cvta" ".to" ".global" ".u64" "%rd19" "%rd13")
   (instruction "cvta" ".to" ".global" ".u64" "%rd36" "%rd8")
   (instruction "cvta" ".to" ".global" ".u64" "%rd39" "%rd9")
   (instruction "cvta" ".to" ".global" ".u64" "%rd21" "%rd11")
   "BB1_1:"
   (instruction "mov" ".u32" "%r3" "%ctaid.x")
   (instruction "add" ".s32" "%r39" "%r3" "%r92")
   (instruction "add" ".s32" "%r40" "%r37" "-1")
   (instruction "setp" ".gt" ".s32" "%p17" "%r39" "%r40")
   "@%p17"
   (instruction "bra" "BB1_51")
   (instruction "bar" ".sync" "0")
   (instruction "mul" ".wide" ".s32" "%rd15" "%r39" "4")
   (instruction "add" ".s64" "%rd16" "%rd14" "%rd15")
   (instruction "ld" ".global" ".f32" "%f3" "[%rd16]")
   (instruction "add" ".s64" "%rd18" "%rd17" "%rd15")
   (instruction "ld" ".global" ".f32" "%f4" "[%rd18]")
   (instruction "add" ".s64" "%rd20" "%rd19" "%rd15")
   (instruction "ld" ".global" ".f32" "%f5" "[%rd20]")
   (instruction "mov" ".u32" "%r93" "0")
   (instruction "mov" ".f32" "%f120" "0f00000000")
   (instruction "mov" ".f32" "%f121" "%f120")
   "BB1_3:"
   (instruction "add" ".s32" "%r43" "%r36" "-1")
   (instruction "add" ".s32" "%r5" "%r1" "%r93")
   (instruction "setp" ".gt" ".s32" "%p18" "%r5" "%r43")
   "@%p18"
   (instruction "bra" "BB1_16")
   (instruction "mul" ".wide" ".s32" "%rd22" "%r5" "16")
   (instruction "add" ".s64" "%rd23" "%rd21" "%rd22")
   (instruction
    "ld"
    ".global"
    ".nc"
    ".v4"
    ".f32"
    "{%f31,%f32,%f33,%f34}"
    "[%rd23]")
   (instruction "mul" ".f32" "%f35" "%f5" "%f31")
   (instruction "fma" ".rn" ".f32" "%f36" "%f4" "%f32" "%f35")
   (instruction "fma" ".rn" ".f32" "%f37" "%f3" "%f33" "%f36")
   (instruction "mul" ".f32" "%f12" "%f37" "0f40C90FDB")
   (instruction "mul" ".f32" "%f38" "%f12" "0f3F22F983")
   (instruction "cvt" ".rni" ".s32" ".f32" "%r101" "%f38")
   (instruction "cvt" ".rn" ".f32" ".s32" "%f39" "%r101")
   (instruction "mov" ".f32" "%f40" "0fBFC90FDA")
   (instruction "fma" ".rn" ".f32" "%f41" "%f39" "%f40" "%f12")
   (instruction "mov" ".f32" "%f42" "0fB3A22168")
   (instruction "fma" ".rn" ".f32" "%f43" "%f39" "%f42" "%f41")
   (instruction "mov" ".f32" "%f44" "0fA7C234C5")
   (instruction "fma" ".rn" ".f32" "%f122" "%f39" "%f44" "%f43")
   (instruction "abs" ".f32" "%f14" "%f12")
   (instruction "setp" ".leu" ".f32" "%p19" "%f14" "0f47CE4780")
   "@%p19"
   (instruction "bra" "BB1_15")
   (instruction "setp" ".eq" ".f32" "%p20" "%f14" "0f7F800000")
   "@%p20"
   (instruction "bra" "BB1_14")
   (instruction "bra" ".uni" "BB1_6")
   "BB1_14:"
   (instruction "mov" ".f32" "%f47" "0f00000000")
   (instruction "mul" ".rn" ".f32" "%f122" "%f12" "%f47")
   (instruction "bra" ".uni" "BB1_15")
   "BB1_6:"
   (instruction "mov" ".b32" "%r7" "%f12")
   (instruction "shr" ".u32" "%r8" "%r7" "23")
   (instruction "bfe" ".u32" "%r46" "%r7" "23" "8")
   (instruction "add" ".s32" "%r47" "%r46" "-128")
   (instruction "shl" ".b32" "%r48" "%r7" "8")
   (instruction "or" ".b32" "%r9" "%r48" "-2147483648")
   (instruction "shr" ".u32" "%r10" "%r47" "5")
   (instruction "add" ".u64" "%rd25" "%SP" "0")
   (instruction "add" ".u64" "%rd42" "%SPL" "0")
   (instruction "mov" ".u32" "%r95" "0")
   (instruction "mov" ".u64" "%rd41" "__cudart_i2opi_f")
   (instruction "mov" ".u32" "%r94" "-6")
   "BB1_7:"
   (pragma "\"nounroll\"")
   (instruction "ld" ".const" ".u32" "%r51" "[%rd41]")
   (group
    (instruction "mad" ".lo" ".cc" ".u32" "%r49" "%r51" "%r9" "%r95")
    (instruction "madc" ".hi" ".u32" "%r95" "%r51" "%r9" "0"))
   (instruction "st" ".local" ".u32" "[%rd42]" "%r49")
   (instruction "add" ".s64" "%rd42" "%rd42" "4")
   (instruction "add" ".s64" "%rd41" "%rd41" "4")
   (instruction "add" ".s32" "%r94" "%r94" "1")
   (instruction "setp" ".ne" ".s32" "%p21" "%r94" "0")
   "@%p21"
   (instruction "bra" "BB1_7")
   (instruction "and" ".b32" "%r15" "%r7" "-2147483648")
   (instruction "cvta" ".to" ".local" ".u64" "%rd27" "%rd25")
   (instruction "st" ".local" ".u32" "[%rd27+24]" "%r95")
   (instruction "mov" ".u32" "%r54" "6")
   (instruction "sub" ".s32" "%r55" "%r54" "%r10")
   (instruction "mul" ".wide" ".s32" "%rd28" "%r55" "4")
   (instruction "add" ".s64" "%rd6" "%rd27" "%rd28")
   (instruction "ld" ".local" ".u32" "%r97" "[%rd6]")
   (instruction "ld" ".local" ".u32" "%r96" "[%rd6+-4]")
   (instruction "and" ".b32" "%r18" "%r8" "31")
   (instruction "setp" ".eq" ".s32" "%p22" "%r18" "0")
   "@%p22"
   (instruction "bra" "BB1_10")
   (instruction "mov" ".u32" "%r56" "32")
   (instruction "sub" ".s32" "%r57" "%r56" "%r18")
   (instruction "shr" ".u32" "%r58" "%r96" "%r57")
   (instruction "shl" ".b32" "%r59" "%r97" "%r18")
   (instruction "add" ".s32" "%r97" "%r58" "%r59")
   (instruction "ld" ".local" ".u32" "%r60" "[%rd6+-8]")
   (instruction "shr" ".u32" "%r61" "%r60" "%r57")
   (instruction "shl" ".b32" "%r62" "%r96" "%r18")
   (instruction "add" ".s32" "%r96" "%r61" "%r62")
   "BB1_10:"
   (instruction "shr" ".u32" "%r63" "%r96" "30")
   (instruction "shl" ".b32" "%r64" "%r97" "2")
   (instruction "add" ".s32" "%r99" "%r64" "%r63")
   (instruction "shl" ".b32" "%r24" "%r96" "2")
   (instruction "shr" ".u32" "%r65" "%r99" "31")
   (instruction "shr" ".u32" "%r66" "%r97" "30")
   (instruction "add" ".s32" "%r25" "%r65" "%r66")
   (instruction "setp" ".eq" ".s32" "%p23" "%r65" "0")
   "@%p23"
   (instruction "bra" "BB1_11")
   (instruction "bra" ".uni" "BB1_12")
   "BB1_11:"
   (instruction "mov" ".u32" "%r98" "%r24")
   (instruction "mov" ".u32" "%r100" "%r15")
   (instruction "bra" ".uni" "BB1_13")
   "BB1_12:"
   (instruction "not" ".b32" "%r67" "%r99")
   (instruction "neg" ".s32" "%r98" "%r24")
   (instruction "setp" ".eq" ".s32" "%p24" "%r24" "0")
   (instruction "selp" ".u32" "%r68" "1" "0" "%p24")
   (instruction "add" ".s32" "%r99" "%r68" "%r67")
   (instruction "xor" ".b32" "%r100" "%r15" "-2147483648")
   "BB1_13:"
   (instruction "cvt" ".u64" ".u32" "%rd29" "%r99")
   (instruction "cvt" ".u64" ".u32" "%rd30" "%r98")
   (instruction "bfi" ".b64" "%rd31" "%rd29" "%rd30" "32" "32")
   (instruction "cvt" ".rn" ".f64" ".s64" "%fd1" "%rd31")
   (instruction "mul" ".f64" "%fd2" "%fd1" "0d3BF921FB54442D19")
   (instruction "cvt" ".rn" ".f32" ".f64" "%f45" "%fd2")
   (instruction "neg" ".f32" "%f46" "%f45")
   (instruction "setp" ".eq" ".s32" "%p25" "%r100" "0")
   (instruction "selp" ".f32" "%f122" "%f45" "%f46" "%p25")
   (instruction "setp" ".eq" ".s32" "%p26" "%r15" "0")
   (instruction "neg" ".s32" "%r69" "%r25")
   (instruction "selp" ".b32" "%r101" "%r25" "%r69" "%p26")
   "BB1_15:"
   (instruction "mul" ".f32" "%f48" "%f122" "%f122")
   (instruction "mov" ".f32" "%f49" "0fBAB607ED")
   (instruction "mov" ".f32" "%f50" "0f37CBAC00")
   (instruction "fma" ".rn" ".f32" "%f51" "%f50" "%f48" "%f49")
   (instruction "mov" ".f32" "%f52" "0f3D2AAABB")
   (instruction "fma" ".rn" ".f32" "%f53" "%f51" "%f48" "%f52")
   (instruction "mov" ".f32" "%f54" "0fBEFFFFFF")
   (instruction "fma" ".rn" ".f32" "%f55" "%f53" "%f48" "%f54")
   (instruction "mov" ".f32" "%f56" "0f3F800000")
   (instruction "fma" ".rn" ".f32" "%f57" "%f55" "%f48" "%f56")
   (instruction "mov" ".f32" "%f58" "0f00000000")
   (instruction "fma" ".rn" ".f32" "%f59" "%f48" "%f122" "%f58")
   (instruction "mov" ".f32" "%f60" "0f3C0885E4")
   (instruction "mov" ".f32" "%f61" "0fB94D4153")
   (instruction "fma" ".rn" ".f32" "%f62" "%f61" "%f48" "%f60")
   (instruction "mov" ".f32" "%f63" "0fBE2AAAA8")
   (instruction "fma" ".rn" ".f32" "%f64" "%f62" "%f48" "%f63")
   (instruction "fma" ".rn" ".f32" "%f65" "%f64" "%f59" "%f122")
   (instruction "and" ".b32" "%r70" "%r101" "1")
   (instruction "setp" ".eq" ".b32" "%p27" "%r70" "1")
   (instruction "not" ".pred" "%p28" "%p27")
   (instruction "selp" ".f32" "%f66" "%f65" "%f57" "%p28")
   (instruction "selp" ".f32" "%f67" "%f57" "%f65" "%p28")
   (instruction "and" ".b32" "%r71" "%r101" "2")
   (instruction "setp" ".eq" ".s32" "%p29" "%r71" "0")
   (instruction "neg" ".f32" "%f68" "%f66")
   (instruction "selp" ".f32" "%f69" "%f66" "%f68" "%p29")
   (instruction "add" ".s32" "%r72" "%r101" "1")
   (instruction "and" ".b32" "%r73" "%r72" "2")
   (instruction "setp" ".eq" ".s32" "%p30" "%r73" "0")
   (instruction "neg" ".f32" "%f70" "%f67")
   (instruction "selp" ".f32" "%f71" "%f67" "%f70" "%p30")
   (instruction "fma" ".rn" ".f32" "%f120" "%f71" "%f34" "%f120")
   (instruction "fma" ".rn" ".f32" "%f121" "%f34" "%f69" "%f121")
   "BB1_16:"
   (instruction "add" ".s32" "%r93" "%r93" "128")
   (instruction "setp" ".lt" ".s32" "%p31" "%r93" "%r36")
   "@%p31"
   (instruction "bra" "BB1_3")
   (instruction "add" ".s32" "%r74" "%r1" "-64")
   (instruction "setp" ".gt" ".s32" "%p1" "%r74" "-1")
   (instruction "mov" ".u64" "%rd32" "S33_ComputeQCPU_53_gpu")
   (instruction "cvta" ".shared" ".u64" "%rd33" "%rd32")
   (instruction "cvta" ".to" ".shared" ".u64" "%rd34" "%rd33")
   (instruction "shl" ".b32" "%r75" "%r1" "2")
   (instruction "cvt" ".s64" ".s32" "%rd35" "%r75")
   (instruction "add" ".s64" "%rd7" "%rd34" "%rd35")
   (instruction "st" ".shared" ".f32" "[%rd7]" "%f120")
   (instruction "bar" ".sync" "0")
   (instruction "bar" ".sync" "0")
   "@%p1"
   (instruction "bra" "BB1_19")
   (instruction "ld" ".shared" ".f32" "%f72" "[%rd7]")
   (instruction "ld" ".shared" ".f32" "%f73" "[%rd7+256]")
   (instruction "add" ".f32" "%f74" "%f72" "%f73")
   (instruction "st" ".shared" ".f32" "[%rd7]" "%f74")
   "BB1_19:"
   (instruction "add" ".s32" "%r76" "%r1" "-32")
   (instruction "setp" ".gt" ".s32" "%p2" "%r76" "-1")
   (instruction "bar" ".sync" "0")
   (instruction "bar" ".sync" "0")
   "@%p2"
   (instruction "bra" "BB1_21")
   (instruction "ld" ".shared" ".f32" "%f75" "[%rd7]")
   (instruction "ld" ".shared" ".f32" "%f76" "[%rd7+128]")
   (instruction "add" ".f32" "%f77" "%f75" "%f76")
   (instruction "st" ".shared" ".f32" "[%rd7]" "%f77")
   "BB1_21:"
   (instruction "add" ".s32" "%r77" "%r1" "-16")
   (instruction "setp" ".gt" ".s32" "%p3" "%r77" "-1")
   (instruction "bar" ".sync" "0")
   (instruction "bar" ".sync" "0")
   "@%p3"
   (instruction "bra" "BB1_23")
   (instruction "ld" ".shared" ".f32" "%f78" "[%rd7]")
   (instruction "ld" ".shared" ".f32" "%f79" "[%rd7+64]")
   (instruction "add" ".f32" "%f80" "%f78" "%f79")
   (instruction "st" ".shared" ".f32" "[%rd7]" "%f80")
   "BB1_23:"
   (instruction "add" ".s32" "%r78" "%r1" "-8")
   (instruction "setp" ".gt" ".s32" "%p4" "%r78" "-1")
   (instruction "bar" ".sync" "0")
   (instruction "bar" ".sync" "0")
   "@%p4"
   (instruction "bra" "BB1_25")
   (instruction "ld" ".shared" ".f32" "%f81" "[%rd7]")
   (instruction "ld" ".shared" ".f32" "%f82" "[%rd7+32]")
   (instruction "add" ".f32" "%f83" "%f81" "%f82")
   (instruction "st" ".shared" ".f32" "[%rd7]" "%f83")
   "BB1_25:"
   (instruction "add" ".s32" "%r79" "%r1" "-4")
   (instruction "setp" ".gt" ".s32" "%p5" "%r79" "-1")
   (instruction "bar" ".sync" "0")
   (instruction "bar" ".sync" "0")
   "@%p5"
   (instruction "bra" "BB1_27")
   (instruction "ld" ".shared" ".f32" "%f84" "[%rd7]")
   (instruction "ld" ".shared" ".f32" "%f85" "[%rd7+16]")
   (instruction "add" ".f32" "%f86" "%f84" "%f85")
   (instruction "st" ".shared" ".f32" "[%rd7]" "%f86")
   "BB1_27:"
   (instruction "add" ".s32" "%r80" "%r1" "-2")
   (instruction "setp" ".gt" ".s32" "%p6" "%r80" "-1")
   (instruction "bar" ".sync" "0")
   (instruction "bar" ".sync" "0")
   "@%p6"
   (instruction "bra" "BB1_29")
   (instruction "ld" ".shared" ".f32" "%f87" "[%rd7]")
   (instruction "ld" ".shared" ".f32" "%f88" "[%rd7+8]")
   (instruction "add" ".f32" "%f89" "%f87" "%f88")
   (instruction "st" ".shared" ".f32" "[%rd7]" "%f89")
   "BB1_29:"
   (instruction "add" ".s32" "%r81" "%r1" "-1")
   (instruction "setp" ".gt" ".s32" "%p7" "%r81" "-1")
   (instruction "bar" ".sync" "0")
   (instruction "bar" ".sync" "0")
   "@%p7"
   (instruction "bra" "BB1_31")
   (instruction "ld" ".shared" ".f32" "%f90" "[%rd7]")
   (instruction "ld" ".shared" ".f32" "%f91" "[%rd7+4]")
   (instruction "add" ".f32" "%f92" "%f90" "%f91")
   (instruction "st" ".shared" ".f32" "[%rd7]" "%f92")
   "BB1_31:"
   (instruction "setp" ".eq" ".s32" "%p8" "%r1" "0")
   (instruction "bar" ".sync" "0")
   "@!%p8"
   (instruction "bra" "BB1_33")
   (instruction "bra" ".uni" "BB1_32")
   "BB1_32:"
   (instruction "ld" ".shared" ".f32" "%f127" "[%rd7]")
   "BB1_33:"
   (instruction "st" ".shared" ".f32" "[%rd7]" "%f121")
   (instruction "bar" ".sync" "0")
   (instruction "bar" ".sync" "0")
   "@%p1"
   (instruction "bra" "BB1_35")
   (instruction "ld" ".shared" ".f32" "%f93" "[%rd7]")
   (instruction "ld" ".shared" ".f32" "%f94" "[%rd7+256]")
   (instruction "add" ".f32" "%f95" "%f93" "%f94")
   (instruction "st" ".shared" ".f32" "[%rd7]" "%f95")
   "BB1_35:"
   (instruction "bar" ".sync" "0")
   (instruction "bar" ".sync" "0")
   "@%p2"
   (instruction "bra" "BB1_37")
   (instruction "ld" ".shared" ".f32" "%f96" "[%rd7]")
   (instruction "ld" ".shared" ".f32" "%f97" "[%rd7+128]")
   (instruction "add" ".f32" "%f98" "%f96" "%f97")
   (instruction "st" ".shared" ".f32" "[%rd7]" "%f98")
   "BB1_37:"
   (instruction "bar" ".sync" "0")
   (instruction "bar" ".sync" "0")
   "@%p3"
   (instruction "bra" "BB1_39")
   (instruction "ld" ".shared" ".f32" "%f99" "[%rd7]")
   (instruction "ld" ".shared" ".f32" "%f100" "[%rd7+64]")
   (instruction "add" ".f32" "%f101" "%f99" "%f100")
   (instruction "st" ".shared" ".f32" "[%rd7]" "%f101")
   "BB1_39:"
   (instruction "bar" ".sync" "0")
   (instruction "bar" ".sync" "0")
   "@%p4"
   (instruction "bra" "BB1_41")
   (instruction "ld" ".shared" ".f32" "%f102" "[%rd7]")
   (instruction "ld" ".shared" ".f32" "%f103" "[%rd7+32]")
   (instruction "add" ".f32" "%f104" "%f102" "%f103")
   (instruction "st" ".shared" ".f32" "[%rd7]" "%f104")
   "BB1_41:"
   (instruction "bar" ".sync" "0")
   (instruction "bar" ".sync" "0")
   "@%p5"
   (instruction "bra" "BB1_43")
   (instruction "ld" ".shared" ".f32" "%f105" "[%rd7]")
   (instruction "ld" ".shared" ".f32" "%f106" "[%rd7+16]")
   (instruction "add" ".f32" "%f107" "%f105" "%f106")
   (instruction "st" ".shared" ".f32" "[%rd7]" "%f107")
   "BB1_43:"
   (instruction "bar" ".sync" "0")
   (instruction "bar" ".sync" "0")
   "@%p6"
   (instruction "bra" "BB1_45")
   (instruction "ld" ".shared" ".f32" "%f108" "[%rd7]")
   (instruction "ld" ".shared" ".f32" "%f109" "[%rd7+8]")
   (instruction "add" ".f32" "%f110" "%f108" "%f109")
   (instruction "st" ".shared" ".f32" "[%rd7]" "%f110")
   "BB1_45:"
   (instruction "bar" ".sync" "0")
   (instruction "bar" ".sync" "0")
   "@%p7"
   (instruction "bra" "BB1_47")
   (instruction "ld" ".shared" ".f32" "%f111" "[%rd7]")
   (instruction "ld" ".shared" ".f32" "%f112" "[%rd7+4]")
   (instruction "add" ".f32" "%f113" "%f111" "%f112")
   (instruction "st" ".shared" ".f32" "[%rd7]" "%f113")
   "BB1_47:"
   (instruction "bar" ".sync" "0")
   "@!%p8"
   (instruction "bra" "BB1_49")
   (instruction "bra" ".uni" "BB1_48")
   "BB1_48:"
   (instruction "ld" ".shared" ".f32" "%f128" "[%rd7]")
   "BB1_49:"
   (instruction "bar" ".sync" "0")
   (instruction "setp" ".ne" ".s32" "%p32" "%r1" "0")
   "@%p32"
   (instruction "bra" "BB1_51")
   (instruction "add" ".s64" "%rd38" "%rd36" "%rd15")
   (instruction "ld" ".global" ".f32" "%f114" "[%rd38]")
   (instruction "add" ".f32" "%f115" "%f127" "%f114")
   (instruction "st" ".global" ".f32" "[%rd38]" "%f115")
   (instruction "add" ".s64" "%rd40" "%rd39" "%rd15")
   (instruction "ld" ".global" ".f32" "%f116" "[%rd40]")
   (instruction "add" ".f32" "%f117" "%f128" "%f116")
   (instruction "st" ".global" ".f32" "[%rd40]" "%f117")
   "BB1_51:"
   (instruction "mov" ".u32" "%r91" "%nctaid.x")
   (instruction "add" ".s32" "%r92" "%r91" "%r92")
   (instruction "setp" ".lt" ".s32" "%p33" "%r92" "%r37")
   "@%p33"
   (instruction "bra" "BB1_1")
   (instruction "ret")))
  )

(define ptx-sample9
  #<<string-delimiter
.global .align 8 .u64 __ZL3Cnt$ref = generic(_ZL3Cnt);
.global .align 4 .u32 _ZL7IterCnt;
.global .align 8 .u64 __ZL7IterCnt$ref = generic(_ZL7IterCnt);
.global .align 8 .u64 _ZL8AllLanes = -1;
.global .align 8 .u64 __ZL8AllLanes$ref = generic(_ZL8AllLanes);
.shared .align 1 .b8 parallelLevel[32];

.weak .entry __omp_offloading_30_2a930bc_main_l8(
        .param .u64 __omp_offloading_30_2a930bc_main_l8_param_0,
        .param .u64 __omp_offloading_30_2a930bc_main_l8_param_1
)
{
        .reg .pred      %p<16>;
        .reg .b16       %rs<5>;
        .reg .f32       %f<2>;
        .reg .b32       %r<55>;
        .reg .b64       %rd<25>;

        ld.param.u64    %rd11, [__omp_offloading_30_2a930bc_main_l8_param_0];
        mov.u32         %r1, %tid.x;
        setp.ne.s32     %p1, %r1, 0;
        shr.s32         %r48, %r1, 31;
        mov.u64         %rd22, parallelLevel;
        @%p1 bra        LBB0_2;
        bra.uni         LBB0_1;
LBB0_2:
        and.b32         %r24, %r1, 31;
        setp.ne.s32     %p2, %r24, 0;
        @%p2 bra        LBB0_4;
        mov.u32         %r25, %ntid.x;
        setp.gt.s32     %p3, %r25, 1;
        selp.b16        %rs2, -127, 1, %p3;
        shr.u32         %r27, %r48, 27;
        add.s32         %r28, %r1, %r27;
        shr.s32         %r29, %r28, 5;
        cvt.u64.u32     %rd13, %r29;
        add.s64         %rd15, %rd22, %rd13;
        st.shared.u8    [%rd15], %rs2;
        bra.uni         LBB0_4;
LBB0_1:
        mov.u32         %r30, %ntid.x;
        setp.gt.s32     %p4, %r30, 1;
        selp.b16        %rs3, -127, 1, %p4;
        st.shared.u8    [parallelLevel], %rs3;
LBB0_4:
        bar.sync        0;
        cvt.u32.u64     %r3, %rd11;
        setp.lt.s32     %p6, %r3, 1;
        @%p6 bra        LBB0_14;
        mov.u32         %r5, %ntid.x;
        setp.lt.s32     %p7, %r5, 1;
        mov.u32         %r6, %ctaid.x;
        mov.u32         %r7, %nctaid.x;
        @%p7 bra        LBB0_7;
        mul.lo.s32      %r51, %r7, %r5;
        mul.lo.s32      %r54, %r6, %r5;
        mov.u32         %r49, %r5;
        bra.uni         LBB0_8;
LBB0_7:
        div.s32         %r35, %r3, %r7;
        mul.lo.s32      %r36, %r35, %r7;
        sub.s32         %r37, %r3, %r36;
        setp.gt.s32     %p8, %r37, %r6;
        add.s32         %r38, %r35, 1;
        mul.lo.s32      %r39, %r38, %r6;
        mad.lo.s32      %r40, %r35, %r6, %r37;
        selp.b32        %r49, %r38, %r35, %p8;
        selp.b32        %r54, %r39, %r40, %p8;
        mov.u32         %r51, %r3;
LBB0_8:
        setp.ge.s32     %p9, %r54, %r3;
        @%p9 bra        LBB0_14;
        shr.u32         %r32, %r48, 27;
        add.s32         %r33, %r1, %r32;
        shr.s32         %r34, %r33, 5;
        cvt.u64.u32     %rd16, %r34;
        add.s64         %rd18, %rd22, %rd16;
        ld.shared.u8    %rs1, [%rd18];
        and.b16         %rs4, %rs1, 126;
        ld.param.u64    %rd12, [__omp_offloading_30_2a930bc_main_l8_param_1];
        setp.eq.s16     %p5, %rs4, 0;
        cvta.to.global.u64      %rd1, %rd12;
        selp.b32        %r2, %r1, 0, %p5;
        add.s32         %r4, %r3, -1;
        add.s32         %r41, %r49, %r54;
        add.s32         %r15, %r41, -1;
        setp.eq.s16     %p10, %rs1, 129;
        setp.lt.s32     %p11, %r15, %r3;
        selp.b32        %r53, %r15, %r4, %p11;
        selp.b32        %r42, %r5, 1, %p10;
        cvt.s64.s32     %rd2, %r42;
        neg.s64         %rd3, %rd2;
        add.s32         %r43, %r2, %r42;
        add.s32         %r52, %r43, %r54;
        bra.uni         LBB0_10;
LBB0_13:
        cvt.u32.u64     %r46, %rd5;
        add.s32         %r54, %r54, %r51;
        add.s32         %r47, %r46, %r51;
        setp.lt.s32     %p14, %r47, %r3;
        selp.b32        %r53, %r47, %r4, %p14;
        add.s32         %r52, %r52, %r51;
        setp.lt.s32     %p15, %r54, %r3;
        @%p15 bra       LBB0_10;
        bra.uni         LBB0_14;
LBB0_10:
        cvt.u64.u32     %rd5, %r53;
        add.s32         %r44, %r54, %r2;
        cvt.s64.s32     %rd24, %r44;
        setp.gt.u64     %p12, %rd24, %rd5;
        @%p12 bra       LBB0_13;
        cvt.s64.s32     %rd19, %r52;
        add.s64         %rd23, %rd3, %rd19;
LBB0_12:
        cvt.u32.u64     %r45, %rd23;
        cvt.rn.f32.s32  %f1, %r45;
        shl.b64         %rd20, %rd24, 2;
        add.s64         %rd21, %rd1, %rd20;
        st.global.f32   [%rd21], %f1;
        add.s64         %rd23, %rd23, %rd2;
        cvt.s64.s32     %rd24, %rd23;
        setp.le.u64     %p13, %rd23, %rd5;
        @%p13 bra       LBB0_12;
        bra.uni         LBB0_13;
LBB0_14:
        ret;

}

.weak .entry __omp_offloading_30_2a930bc_main_l14(
        .param .u64 __omp_offloading_30_2a930bc_main_l14_param_0,
        .param .u64 __omp_offloading_30_2a930bc_main_l14_param_1,
        .param .u64 __omp_offloading_30_2a930bc_main_l14_param_2
)
{
        .reg .pred      %p<17>;
        .reg .b16       %rs<5>;
        .reg .f32       %f<34>;
        .reg .b32       %r<56>;
        .reg .b64       %rd<21>;

        ld.param.u64    %rd9, [__omp_offloading_30_2a930bc_main_l14_param_0];
        mov.u32         %r1, %tid.x;
        setp.ne.s32     %p1, %r1, 0;
        shr.s32         %r48, %r1, 31;
        mov.u64         %rd19, parallelLevel;
        @%p1 bra        LBB1_2;
        bra.uni         LBB1_1;
LBB1_2:
        and.b32         %r27, %r1, 31;
        setp.ne.s32     %p2, %r27, 0;
        @%p2 bra        LBB1_4;
        mov.u32         %r28, %ntid.x;
        setp.gt.s32     %p3, %r28, 1;
        selp.b16        %rs2, -127, 1, %p3;
        shr.u32         %r30, %r48, 27;
        add.s32         %r31, %r1, %r30;
        shr.s32         %r32, %r31, 5;
        cvt.u64.u32     %rd12, %r32;
        add.s64         %rd14, %rd19, %rd12;
        st.shared.u8    [%rd14], %rs2;
        bra.uni         LBB1_4;
LBB1_1:
        mov.u32         %r33, %ntid.x;
        setp.gt.s32     %p4, %r33, 1;
        selp.b16        %rs3, -127, 1, %p4;
        st.shared.u8    [parallelLevel], %rs3;
LBB1_4:
        bar.sync        0;
        cvt.u32.u64     %r3, %rd9;
        setp.lt.s32     %p6, %r3, 1;
        @%p6 bra        LBB1_16;
        mov.u32         %r5, %ntid.x;
        setp.lt.s32     %p7, %r5, 1;
        mov.u32         %r6, %ctaid.x;
        mov.u32         %r7, %nctaid.x;
        @%p7 bra        LBB1_7;
        mul.lo.s32      %r51, %r7, %r5;
        mul.lo.s32      %r53, %r6, %r5;
        mov.u32         %r49, %r5;
        bra.uni         LBB1_8;
LBB1_7:
        div.s32         %r38, %r3, %r7;
        mul.lo.s32      %r39, %r38, %r7;
        sub.s32         %r40, %r3, %r39;
        setp.gt.s32     %p8, %r40, %r6;
        add.s32         %r41, %r38, 1;
        mul.lo.s32      %r42, %r41, %r6;
        mad.lo.s32      %r43, %r38, %r6, %r40;
        selp.b32        %r49, %r41, %r38, %p8;
        selp.b32        %r53, %r42, %r43, %p8;
        mov.u32         %r51, %r3;
LBB1_8:
        setp.ge.s32     %p9, %r53, %r3;
        @%p9 bra        LBB1_16;
        shr.u32         %r35, %r48, 27;
        add.s32         %r36, %r1, %r35;
        shr.s32         %r37, %r36, 5;
        cvt.u64.u32     %rd15, %r37;
        add.s64         %rd17, %rd19, %rd15;
        ld.shared.u8    %rs1, [%rd17];
        and.b16         %rs4, %rs1, 126;
        ld.param.u64    %rd10, [__omp_offloading_30_2a930bc_main_l14_param_2];
        ld.param.u64    %rd11, [__omp_offloading_30_2a930bc_main_l14_param_1];
        setp.eq.s16     %p5, %rs4, 0;
        cvta.to.global.u64      %rd1, %rd10;
        cvta.to.global.u64      %rd2, %rd11;
        selp.b32        %r2, %r1, 0, %p5;
        add.s32         %r4, %r3, -1;
        add.s32         %r44, %r49, %r53;
        add.s32         %r15, %r44, -1;
        setp.eq.s16     %p10, %rs1, 129;
        setp.lt.s32     %p11, %r15, %r3;
        selp.b32        %r52, %r15, %r4, %p11;
        selp.b32        %r17, %r5, 1, %p10;
        bra.uni         LBB1_10;
LBB1_15:
        cvt.u32.u64     %r46, %rd3;
        add.s32         %r53, %r53, %r51;
        add.s32         %r47, %r46, %r51;
        setp.lt.s32     %p15, %r47, %r3;
        selp.b32        %r52, %r47, %r4, %p15;
        setp.lt.s32     %p16, %r53, %r3;
        @%p16 bra       LBB1_10;
        bra.uni         LBB1_16;
LBB1_10:
        cvt.u64.u32     %rd3, %r52;
        add.s32         %r54, %r53, %r2;
        cvt.s64.s32     %rd20, %r54;
        setp.gt.u64     %p12, %rd20, %rd3;
        @%p12 bra       LBB1_15;
        bra.uni         LBB1_11;
LBB1_14:
        add.s32         %r54, %r54, %r17;
        cvt.s64.s32     %rd20, %r54;
        setp.gt.u64     %p14, %rd20, %rd3;
        @%p14 bra       LBB1_15;
LBB1_11:
        shl.b64         %rd18, %rd20, 2;
        add.s64         %rd6, %rd1, %rd18;
        add.s64         %rd7, %rd2, %rd18;
        ld.global.f32   %f33, [%rd7];
        mov.u32         %r55, 990;
LBB1_12:
        ld.global.f32   %f4, [%rd6];
        mul.rn.f32      %f5, %f4, 0f40400000;
        add.rn.f32      %f6, %f33, %f5;
        st.global.f32   [%rd7], %f6;
        ld.global.f32   %f7, [%rd6];
        mul.rn.f32      %f8, %f7, 0f40400000;
        add.rn.f32      %f9, %f6, %f8;
        st.global.f32   [%rd7], %f9;
        ld.global.f32   %f10, [%rd6];
        mul.rn.f32      %f11, %f10, 0f40400000;
        add.rn.f32      %f12, %f9, %f11;
        st.global.f32   [%rd7], %f12;
        ld.global.f32   %f13, [%rd6];
        mul.rn.f32      %f14, %f13, 0f40400000;
        add.rn.f32      %f15, %f12, %f14;
        st.global.f32   [%rd7], %f15;
        ld.global.f32   %f16, [%rd6];
        mul.rn.f32      %f17, %f16, 0f40400000;
        add.rn.f32      %f18, %f15, %f17;
        st.global.f32   [%rd7], %f18;
        ld.global.f32   %f19, [%rd6];
        mul.rn.f32      %f20, %f19, 0f40400000;
        add.rn.f32      %f21, %f18, %f20;
        st.global.f32   [%rd7], %f21;
        ld.global.f32   %f22, [%rd6];
        mul.rn.f32      %f23, %f22, 0f40400000;
        add.rn.f32      %f24, %f21, %f23;
        st.global.f32   [%rd7], %f24;
        ld.global.f32   %f25, [%rd6];
        mul.rn.f32      %f26, %f25, 0f40400000;
        add.rn.f32      %f27, %f24, %f26;
        st.global.f32   [%rd7], %f27;
        ld.global.f32   %f28, [%rd6];
        mul.rn.f32      %f29, %f28, 0f40400000;
        add.rn.f32      %f30, %f27, %f29;
        st.global.f32   [%rd7], %f30;
        ld.global.f32   %f31, [%rd6];
        mul.rn.f32      %f32, %f31, 0f40400000;
        add.rn.f32      %f33, %f30, %f32;
        st.global.f32   [%rd7], %f33;
        setp.eq.s32     %p13, %r55, 0;
        @%p13 bra       LBB1_14;
        add.s32         %r55, %r55, -10;
        bra.uni         LBB1_12;
LBB1_16:
        ret;

}
string-delimiter
      )

(define ptx-sample9-out
'((storageN ".global" ".align 8" ".u64" ("__ZL3Cnt$ref" "generic(_ZL3Cnt)"))
  (storageN ".global" ".align 4" ".u32" "_ZL7IterCnt")
  (storageN
   ".global"
   ".align 8"
   ".u64"
   ("__ZL7IterCnt$ref" "generic(_ZL7IterCnt)"))
  (storageN ".global" ".align 8" ".u64" ("_ZL8AllLanes" "-1"))
  (storageN
   ".global"
   ".align 8"
   ".u64"
   ("__ZL8AllLanes$ref" "generic(_ZL8AllLanes)"))
  (storageN ".shared" ".align 1" ".b8" "parallelLevel[32]")
  (linking
   ".weak"
   (kernel
    "__omp_offloading_30_2a930bc_main_l8"
    (storage ".param" ".u64" "__omp_offloading_30_2a930bc_main_l8_param_0")
    (storage ".param" ".u64" "__omp_offloading_30_2a930bc_main_l8_param_1")
    (storageN ".reg" ".pred" "%p<16>")
    (storageN ".reg" ".b16" "%rs<5>")
    (storageN ".reg" ".f32" "%f<2>")
    (storageN ".reg" ".b32" "%r<55>")
    (storageN ".reg" ".b64" "%rd<25>")
    (instruction
     "ld"
     ".param"
     ".u64"
     "%rd11"
     "[__omp_offloading_30_2a930bc_main_l8_param_0]")
    (instruction "mov" ".u32" "%r1" "%tid.x")
    (instruction "setp" ".ne" ".s32" "%p1" "%r1" "0")
    (instruction "shr" ".s32" "%r48" "%r1" "31")
    (instruction "mov" ".u64" "%rd22" "parallelLevel")
    "@%p1"
    (instruction "bra" "LBB0_2")
    (instruction "bra" ".uni" "LBB0_1")
    "LBB0_2:"
    (instruction "and" ".b32" "%r24" "%r1" "31")
    (instruction "setp" ".ne" ".s32" "%p2" "%r24" "0")
    "@%p2"
    (instruction "bra" "LBB0_4")
    (instruction "mov" ".u32" "%r25" "%ntid.x")
    (instruction "setp" ".gt" ".s32" "%p3" "%r25" "1")
    (instruction "selp" ".b16" "%rs2" "-127" "1" "%p3")
    (instruction "shr" ".u32" "%r27" "%r48" "27")
    (instruction "add" ".s32" "%r28" "%r1" "%r27")
    (instruction "shr" ".s32" "%r29" "%r28" "5")
    (instruction "cvt" ".u64" ".u32" "%rd13" "%r29")
    (instruction "add" ".s64" "%rd15" "%rd22" "%rd13")
    (instruction "st" ".shared" ".u8" "[%rd15]" "%rs2")
    (instruction "bra" ".uni" "LBB0_4")
    "LBB0_1:"
    (instruction "mov" ".u32" "%r30" "%ntid.x")
    (instruction "setp" ".gt" ".s32" "%p4" "%r30" "1")
    (instruction "selp" ".b16" "%rs3" "-127" "1" "%p4")
    (instruction "st" ".shared" ".u8" "[parallelLevel]" "%rs3")
    "LBB0_4:"
    (instruction "bar" ".sync" "0")
    (instruction "cvt" ".u32" ".u64" "%r3" "%rd11")
    (instruction "setp" ".lt" ".s32" "%p6" "%r3" "1")
    "@%p6"
    (instruction "bra" "LBB0_14")
    (instruction "mov" ".u32" "%r5" "%ntid.x")
    (instruction "setp" ".lt" ".s32" "%p7" "%r5" "1")
    (instruction "mov" ".u32" "%r6" "%ctaid.x")
    (instruction "mov" ".u32" "%r7" "%nctaid.x")
    "@%p7"
    (instruction "bra" "LBB0_7")
    (instruction "mul" ".lo" ".s32" "%r51" "%r7" "%r5")
    (instruction "mul" ".lo" ".s32" "%r54" "%r6" "%r5")
    (instruction "mov" ".u32" "%r49" "%r5")
    (instruction "bra" ".uni" "LBB0_8")
    "LBB0_7:"
    (instruction "div" ".s32" "%r35" "%r3" "%r7")
    (instruction "mul" ".lo" ".s32" "%r36" "%r35" "%r7")
    (instruction "sub" ".s32" "%r37" "%r3" "%r36")
    (instruction "setp" ".gt" ".s32" "%p8" "%r37" "%r6")
    (instruction "add" ".s32" "%r38" "%r35" "1")
    (instruction "mul" ".lo" ".s32" "%r39" "%r38" "%r6")
    (instruction "mad" ".lo" ".s32" "%r40" "%r35" "%r6" "%r37")
    (instruction "selp" ".b32" "%r49" "%r38" "%r35" "%p8")
    (instruction "selp" ".b32" "%r54" "%r39" "%r40" "%p8")
    (instruction "mov" ".u32" "%r51" "%r3")
    "LBB0_8:"
    (instruction "setp" ".ge" ".s32" "%p9" "%r54" "%r3")
    "@%p9"
    (instruction "bra" "LBB0_14")
    (instruction "shr" ".u32" "%r32" "%r48" "27")
    (instruction "add" ".s32" "%r33" "%r1" "%r32")
    (instruction "shr" ".s32" "%r34" "%r33" "5")
    (instruction "cvt" ".u64" ".u32" "%rd16" "%r34")
    (instruction "add" ".s64" "%rd18" "%rd22" "%rd16")
    (instruction "ld" ".shared" ".u8" "%rs1" "[%rd18]")
    (instruction "and" ".b16" "%rs4" "%rs1" "126")
    (instruction
     "ld"
     ".param"
     ".u64"
     "%rd12"
     "[__omp_offloading_30_2a930bc_main_l8_param_1]")
    (instruction "setp" ".eq" ".s16" "%p5" "%rs4" "0")
    (instruction "cvta" ".to" ".global" ".u64" "%rd1" "%rd12")
    (instruction "selp" ".b32" "%r2" "%r1" "0" "%p5")
    (instruction "add" ".s32" "%r4" "%r3" "-1")
    (instruction "add" ".s32" "%r41" "%r49" "%r54")
    (instruction "add" ".s32" "%r15" "%r41" "-1")
    (instruction "setp" ".eq" ".s16" "%p10" "%rs1" "129")
    (instruction "setp" ".lt" ".s32" "%p11" "%r15" "%r3")
    (instruction "selp" ".b32" "%r53" "%r15" "%r4" "%p11")
    (instruction "selp" ".b32" "%r42" "%r5" "1" "%p10")
    (instruction "cvt" ".s64" ".s32" "%rd2" "%r42")
    (instruction "neg" ".s64" "%rd3" "%rd2")
    (instruction "add" ".s32" "%r43" "%r2" "%r42")
    (instruction "add" ".s32" "%r52" "%r43" "%r54")
    (instruction "bra" ".uni" "LBB0_10")
    "LBB0_13:"
    (instruction "cvt" ".u32" ".u64" "%r46" "%rd5")
    (instruction "add" ".s32" "%r54" "%r54" "%r51")
    (instruction "add" ".s32" "%r47" "%r46" "%r51")
    (instruction "setp" ".lt" ".s32" "%p14" "%r47" "%r3")
    (instruction "selp" ".b32" "%r53" "%r47" "%r4" "%p14")
    (instruction "add" ".s32" "%r52" "%r52" "%r51")
    (instruction "setp" ".lt" ".s32" "%p15" "%r54" "%r3")
    "@%p15"
    (instruction "bra" "LBB0_10")
    (instruction "bra" ".uni" "LBB0_14")
    "LBB0_10:"
    (instruction "cvt" ".u64" ".u32" "%rd5" "%r53")
    (instruction "add" ".s32" "%r44" "%r54" "%r2")
    (instruction "cvt" ".s64" ".s32" "%rd24" "%r44")
    (instruction "setp" ".gt" ".u64" "%p12" "%rd24" "%rd5")
    "@%p12"
    (instruction "bra" "LBB0_13")
    (instruction "cvt" ".s64" ".s32" "%rd19" "%r52")
    (instruction "add" ".s64" "%rd23" "%rd3" "%rd19")
    "LBB0_12:"
    (instruction "cvt" ".u32" ".u64" "%r45" "%rd23")
    (instruction "cvt" ".rn" ".f32" ".s32" "%f1" "%r45")
    (instruction "shl" ".b64" "%rd20" "%rd24" "2")
    (instruction "add" ".s64" "%rd21" "%rd1" "%rd20")
    (instruction "st" ".global" ".f32" "[%rd21]" "%f1")
    (instruction "add" ".s64" "%rd23" "%rd23" "%rd2")
    (instruction "cvt" ".s64" ".s32" "%rd24" "%rd23")
    (instruction "setp" ".le" ".u64" "%p13" "%rd23" "%rd5")
    "@%p13"
    (instruction "bra" "LBB0_12")
    (instruction "bra" ".uni" "LBB0_13")
    "LBB0_14:"
    (instruction "ret")))
  (linking
   ".weak"
   (kernel
    "__omp_offloading_30_2a930bc_main_l14"
    (storage ".param" ".u64" "__omp_offloading_30_2a930bc_main_l14_param_0")
    (storage ".param" ".u64" "__omp_offloading_30_2a930bc_main_l14_param_1")
    (storage ".param" ".u64" "__omp_offloading_30_2a930bc_main_l14_param_2")
    (storageN ".reg" ".pred" "%p<17>")
    (storageN ".reg" ".b16" "%rs<5>")
    (storageN ".reg" ".f32" "%f<34>")
    (storageN ".reg" ".b32" "%r<56>")
    (storageN ".reg" ".b64" "%rd<21>")
    (instruction
     "ld"
     ".param"
     ".u64"
     "%rd9"
     "[__omp_offloading_30_2a930bc_main_l14_param_0]")
    (instruction "mov" ".u32" "%r1" "%tid.x")
    (instruction "setp" ".ne" ".s32" "%p1" "%r1" "0")
    (instruction "shr" ".s32" "%r48" "%r1" "31")
    (instruction "mov" ".u64" "%rd19" "parallelLevel")
    "@%p1"
    (instruction "bra" "LBB1_2")
    (instruction "bra" ".uni" "LBB1_1")
    "LBB1_2:"
    (instruction "and" ".b32" "%r27" "%r1" "31")
    (instruction "setp" ".ne" ".s32" "%p2" "%r27" "0")
    "@%p2"
    (instruction "bra" "LBB1_4")
    (instruction "mov" ".u32" "%r28" "%ntid.x")
    (instruction "setp" ".gt" ".s32" "%p3" "%r28" "1")
    (instruction "selp" ".b16" "%rs2" "-127" "1" "%p3")
    (instruction "shr" ".u32" "%r30" "%r48" "27")
    (instruction "add" ".s32" "%r31" "%r1" "%r30")
    (instruction "shr" ".s32" "%r32" "%r31" "5")
    (instruction "cvt" ".u64" ".u32" "%rd12" "%r32")
    (instruction "add" ".s64" "%rd14" "%rd19" "%rd12")
    (instruction "st" ".shared" ".u8" "[%rd14]" "%rs2")
    (instruction "bra" ".uni" "LBB1_4")
    "LBB1_1:"
    (instruction "mov" ".u32" "%r33" "%ntid.x")
    (instruction "setp" ".gt" ".s32" "%p4" "%r33" "1")
    (instruction "selp" ".b16" "%rs3" "-127" "1" "%p4")
    (instruction "st" ".shared" ".u8" "[parallelLevel]" "%rs3")
    "LBB1_4:"
    (instruction "bar" ".sync" "0")
    (instruction "cvt" ".u32" ".u64" "%r3" "%rd9")
    (instruction "setp" ".lt" ".s32" "%p6" "%r3" "1")
    "@%p6"
    (instruction "bra" "LBB1_16")
    (instruction "mov" ".u32" "%r5" "%ntid.x")
    (instruction "setp" ".lt" ".s32" "%p7" "%r5" "1")
    (instruction "mov" ".u32" "%r6" "%ctaid.x")
    (instruction "mov" ".u32" "%r7" "%nctaid.x")
    "@%p7"
    (instruction "bra" "LBB1_7")
    (instruction "mul" ".lo" ".s32" "%r51" "%r7" "%r5")
    (instruction "mul" ".lo" ".s32" "%r53" "%r6" "%r5")
    (instruction "mov" ".u32" "%r49" "%r5")
    (instruction "bra" ".uni" "LBB1_8")
    "LBB1_7:"
    (instruction "div" ".s32" "%r38" "%r3" "%r7")
    (instruction "mul" ".lo" ".s32" "%r39" "%r38" "%r7")
    (instruction "sub" ".s32" "%r40" "%r3" "%r39")
    (instruction "setp" ".gt" ".s32" "%p8" "%r40" "%r6")
    (instruction "add" ".s32" "%r41" "%r38" "1")
    (instruction "mul" ".lo" ".s32" "%r42" "%r41" "%r6")
    (instruction "mad" ".lo" ".s32" "%r43" "%r38" "%r6" "%r40")
    (instruction "selp" ".b32" "%r49" "%r41" "%r38" "%p8")
    (instruction "selp" ".b32" "%r53" "%r42" "%r43" "%p8")
    (instruction "mov" ".u32" "%r51" "%r3")
    "LBB1_8:"
    (instruction "setp" ".ge" ".s32" "%p9" "%r53" "%r3")
    "@%p9"
    (instruction "bra" "LBB1_16")
    (instruction "shr" ".u32" "%r35" "%r48" "27")
    (instruction "add" ".s32" "%r36" "%r1" "%r35")
    (instruction "shr" ".s32" "%r37" "%r36" "5")
    (instruction "cvt" ".u64" ".u32" "%rd15" "%r37")
    (instruction "add" ".s64" "%rd17" "%rd19" "%rd15")
    (instruction "ld" ".shared" ".u8" "%rs1" "[%rd17]")
    (instruction "and" ".b16" "%rs4" "%rs1" "126")
    (instruction
     "ld"
     ".param"
     ".u64"
     "%rd10"
     "[__omp_offloading_30_2a930bc_main_l14_param_2]")
    (instruction
     "ld"
     ".param"
     ".u64"
     "%rd11"
     "[__omp_offloading_30_2a930bc_main_l14_param_1]")
    (instruction "setp" ".eq" ".s16" "%p5" "%rs4" "0")
    (instruction "cvta" ".to" ".global" ".u64" "%rd1" "%rd10")
    (instruction "cvta" ".to" ".global" ".u64" "%rd2" "%rd11")
    (instruction "selp" ".b32" "%r2" "%r1" "0" "%p5")
    (instruction "add" ".s32" "%r4" "%r3" "-1")
    (instruction "add" ".s32" "%r44" "%r49" "%r53")
    (instruction "add" ".s32" "%r15" "%r44" "-1")
    (instruction "setp" ".eq" ".s16" "%p10" "%rs1" "129")
    (instruction "setp" ".lt" ".s32" "%p11" "%r15" "%r3")
    (instruction "selp" ".b32" "%r52" "%r15" "%r4" "%p11")
    (instruction "selp" ".b32" "%r17" "%r5" "1" "%p10")
    (instruction "bra" ".uni" "LBB1_10")
    "LBB1_15:"
    (instruction "cvt" ".u32" ".u64" "%r46" "%rd3")
    (instruction "add" ".s32" "%r53" "%r53" "%r51")
    (instruction "add" ".s32" "%r47" "%r46" "%r51")
    (instruction "setp" ".lt" ".s32" "%p15" "%r47" "%r3")
    (instruction "selp" ".b32" "%r52" "%r47" "%r4" "%p15")
    (instruction "setp" ".lt" ".s32" "%p16" "%r53" "%r3")
    "@%p16"
    (instruction "bra" "LBB1_10")
    (instruction "bra" ".uni" "LBB1_16")
    "LBB1_10:"
    (instruction "cvt" ".u64" ".u32" "%rd3" "%r52")
    (instruction "add" ".s32" "%r54" "%r53" "%r2")
    (instruction "cvt" ".s64" ".s32" "%rd20" "%r54")
    (instruction "setp" ".gt" ".u64" "%p12" "%rd20" "%rd3")
    "@%p12"
    (instruction "bra" "LBB1_15")
    (instruction "bra" ".uni" "LBB1_11")
    "LBB1_14:"
    (instruction "add" ".s32" "%r54" "%r54" "%r17")
    (instruction "cvt" ".s64" ".s32" "%rd20" "%r54")
    (instruction "setp" ".gt" ".u64" "%p14" "%rd20" "%rd3")
    "@%p14"
    (instruction "bra" "LBB1_15")
    "LBB1_11:"
    (instruction "shl" ".b64" "%rd18" "%rd20" "2")
    (instruction "add" ".s64" "%rd6" "%rd1" "%rd18")
    (instruction "add" ".s64" "%rd7" "%rd2" "%rd18")
    (instruction "ld" ".global" ".f32" "%f33" "[%rd7]")
    (instruction "mov" ".u32" "%r55" "990")
    "LBB1_12:"
    (instruction "ld" ".global" ".f32" "%f4" "[%rd6]")
    (instruction "mul" ".rn" ".f32" "%f5" "%f4" "0f40400000")
    (instruction "add" ".rn" ".f32" "%f6" "%f33" "%f5")
    (instruction "st" ".global" ".f32" "[%rd7]" "%f6")
    (instruction "ld" ".global" ".f32" "%f7" "[%rd6]")
    (instruction "mul" ".rn" ".f32" "%f8" "%f7" "0f40400000")
    (instruction "add" ".rn" ".f32" "%f9" "%f6" "%f8")
    (instruction "st" ".global" ".f32" "[%rd7]" "%f9")
    (instruction "ld" ".global" ".f32" "%f10" "[%rd6]")
    (instruction "mul" ".rn" ".f32" "%f11" "%f10" "0f40400000")
    (instruction "add" ".rn" ".f32" "%f12" "%f9" "%f11")
    (instruction "st" ".global" ".f32" "[%rd7]" "%f12")
    (instruction "ld" ".global" ".f32" "%f13" "[%rd6]")
    (instruction "mul" ".rn" ".f32" "%f14" "%f13" "0f40400000")
    (instruction "add" ".rn" ".f32" "%f15" "%f12" "%f14")
    (instruction "st" ".global" ".f32" "[%rd7]" "%f15")
    (instruction "ld" ".global" ".f32" "%f16" "[%rd6]")
    (instruction "mul" ".rn" ".f32" "%f17" "%f16" "0f40400000")
    (instruction "add" ".rn" ".f32" "%f18" "%f15" "%f17")
    (instruction "st" ".global" ".f32" "[%rd7]" "%f18")
    (instruction "ld" ".global" ".f32" "%f19" "[%rd6]")
    (instruction "mul" ".rn" ".f32" "%f20" "%f19" "0f40400000")
    (instruction "add" ".rn" ".f32" "%f21" "%f18" "%f20")
    (instruction "st" ".global" ".f32" "[%rd7]" "%f21")
    (instruction "ld" ".global" ".f32" "%f22" "[%rd6]")
    (instruction "mul" ".rn" ".f32" "%f23" "%f22" "0f40400000")
    (instruction "add" ".rn" ".f32" "%f24" "%f21" "%f23")
    (instruction "st" ".global" ".f32" "[%rd7]" "%f24")
    (instruction "ld" ".global" ".f32" "%f25" "[%rd6]")
    (instruction "mul" ".rn" ".f32" "%f26" "%f25" "0f40400000")
    (instruction "add" ".rn" ".f32" "%f27" "%f24" "%f26")
    (instruction "st" ".global" ".f32" "[%rd7]" "%f27")
    (instruction "ld" ".global" ".f32" "%f28" "[%rd6]")
    (instruction "mul" ".rn" ".f32" "%f29" "%f28" "0f40400000")
    (instruction "add" ".rn" ".f32" "%f30" "%f27" "%f29")
    (instruction "st" ".global" ".f32" "[%rd7]" "%f30")
    (instruction "ld" ".global" ".f32" "%f31" "[%rd6]")
    (instruction "mul" ".rn" ".f32" "%f32" "%f31" "0f40400000")
    (instruction "add" ".rn" ".f32" "%f33" "%f30" "%f32")
    (instruction "st" ".global" ".f32" "[%rd7]" "%f33")
    (instruction "setp" ".eq" ".s32" "%p13" "%r55" "0")
    "@%p13"
    (instruction "bra" "LBB1_14")
    (instruction "add" ".s32" "%r55" "%r55" "-10")
    (instruction "bra" ".uni" "LBB1_12")
    "LBB1_16:"
    (instruction "ret"))))
  )

(define ptx-sample10
  #<<string-delimiter
.func test$_omp_fn$1 (.param.u64 %in_ar0)
{
        .reg.u64 %ar0;
        ld.param.u64 %ar0, [%in_ar0];
        .reg.u32 %r22;
        .reg.u32 %r23;
        .reg.u32 %r24;
        .reg.u32 %r25;
        .reg.u32 %r26;
        .reg.u32 %r27;
        .reg.u32 %r28;
        .reg.u32 %r29;
        .reg.u32 %r30;
        .reg.u32 %r31;
        .reg.u32 %r32;
        .reg.u32 %r33;
        .reg.u32 %r34;
        .reg.u32 %r36;
        .reg.u32 %r37;
        .reg.u32 %r38;
        .reg.u32 %r40;
        .reg.u32 %r41;
        .reg.u32 %r42;
        .reg.u32 %r43;
        .reg.u64 %r44;
        .reg.u64 %r45;
        .reg.f32 %r46;
        .reg.f32 %r47;
        .reg.u32 %r52;
        .reg.u32 %r54;
        .reg.u32 %r55;
        .reg.u32 %r58;
        .reg.u32 %r64;
        .reg.u32 %r65;
        .reg.u32 %r71;
        .reg.u32 %r74;
        .reg.u32 %r76;
        .reg.u32 %r79;
        .reg.u32 %r80;
        .reg.u32 %r83;
        .reg.u32 %r86;
        .reg.u32 %r87;
        .reg.u32 %r93;
        .reg.f32 %r104;
        .reg.u32 %r106;
        .reg.u64 %r111;
        .reg.u64 %r113;
        .reg.u64 %r115;
        .reg.u64 %r117;
        .reg.u64 %r118;
        .reg.u64 %r122;
        .reg.u64 %r124;
        .reg.u64 %r126;
        .reg.u64 %r128;
        .reg.u32 %r129;
        .reg.u32 %r131;
        .reg.u64 %r135;
        .reg.u32 %r136;
        .reg.u32 %r137;
        .reg.u32 %r138;
        .reg.pred %r139;
        .reg.pred %r141;
        .reg.u32 %r143;
        .reg.u32 %r145;
        .reg.u32 %r147;
        .reg.u32 %r148;
        .reg.pred %r149;
        .reg.pred %r150;
        .reg.pred %r152;
        .reg.pred %r153;
        .reg.pred %r154;
        .reg.pred %r155;
        .reg.u32 %r156;
        .reg.u32 %r157;
        .reg.u32 %r158;
        .reg.u64 %r159;
        .reg.u64 %r160;
        .reg.u64 %r162;
        .reg.u64 %r163;
        .reg.u32 %r164;
        .reg.u32 %r165;
        .reg.u64 %r166;
        .reg.u32 %r167;
        .reg.u32 %r168;
        .reg.u64 %r169;
        .reg.u32 %r170;
        .reg.u32 %r171;
        .reg.u64 %r172;
        .reg.u32 %r173;
        .reg.u32 %r174;
        .reg.u32 %r175;
        .reg.u64 %r176;
        .reg.u64 %r177;
        .reg.u64 %r178;
        .reg.f32 %r179;
        .reg.f32 %r180;
        .reg.f32 %r181;
        .reg.u64 %r182;
        .reg.f32 %r183;
        .reg.f32 %r184;
        .reg.u64 %r185;
        .reg.f32 %r186;
        .reg.f32 %r187;
        .reg.f32 %r188;
        .reg.f32 %r189;
        .reg.f32 %r190;
        .reg.f32 %r191;
        .reg.f32 %r192;
        .reg.f32 %r193;
        .reg.f32 %r194;
        .reg.v2.u32 %r196;
        .reg.pred %r197;
        .reg.u32 %r198;
        .reg.u32 %r199;
        .reg.u32 %r200;
        .reg.u32 %r201;
        .reg.pred %r202;
        .reg.pred %r203;
        .reg.pred %r204;
        .reg.pred %r205;
        .reg.pred %r206;
        .reg.pred %r207;
        .reg.pred %r208;
        .reg.u32 %r213;
        .reg.pred %r214;
        .reg.u64 %r216;
        .reg.u32 %r218;
        .reg.pred %r219;
        .reg.u32 %r222;
        .reg.u32 %r223;
        .reg.u32 %r224;
        .reg.u64 %r229;
        .reg.u64 %r230;
        .reg.u64 %r231;
        .reg.f32 %r232;
        .reg.f32 %r233;
        .reg.f32 %r234;
        .reg.u64 %r235;
        .reg.f32 %r236;
        .reg.f32 %r237;
        .reg.u64 %r238;
        .reg.f32 %r239;
        .reg.f32 %r240;
        .reg.f32 %r241;
        .reg.f32 %r242;
        .reg.f32 %r243;
        .reg.f32 %r244;
        .reg.f32 %r245;
        .reg.f32 %r246;
        .reg.f32 %r247;
        .reg.f32 %r248;
        .reg.pred %r249;
        .reg.pred %r250;
        .reg.pred %r251;
        .reg.pred %r253;
        .reg.pred %r255;
        .reg.pred %r257;
        .reg.pred %r259;
        .reg.pred %r261;
        .reg.pred %r263;
        .reg.pred %r264;
        .reg.pred %r283;
        .reg.u64 %r284;
        .reg.u64 %r285;
        .reg.u64 %r286;
        .reg.f32 %r287;
        .reg.f32 %r288;
        .reg.f32 %r289;
        .reg.u64 %r290;
        .reg.f32 %r291;
        .reg.f32 %r292;
        .reg.u64 %r293;
        .reg.f32 %r294;
        .reg.f32 %r295;
        .reg.f32 %r296;
        .reg.f32 %r297;
        .reg.f32 %r298;
        .reg.f32 %r299;
        .reg.f32 %r300;
        .reg.f32 %r301;
        .reg.f32 %r302;
        .reg.f32 %r303;
        .reg.pred %r304;
                mov.u64 %r135, %ar0;
                ld.u32  %r34, [%r135+72];
                ld.u32  %r38, [%r135+56];
        {
                .param.u32 %value_in;
                call (%value_in), omp_get_num_threads;
                ld.param.u32    %r136, [%value_in];
        }
        {
                .param.u32 %value_in;
                call (%value_in), omp_get_thread_num;
                ld.param.u32    %r137, [%value_in];
        }
                ld.u32  %r138, [%r135+68];
                sub.u32 %r52, %r138, %r34;
                div.u32 %r23, %r52, %r136;
                rem.u32 %r24, %r52, %r136;
                setp.lt.u32     %r139, %r137, %r24;
        @%r139  bra     $L2;
$L15:
                mad.lo.u32      %r54, %r23, %r137, %r24;
                add.u32 %r55, %r23, %r54;
                setp.ge.u32     %r141, %r54, %r55;
        @%r141  bra     $L16;
                ld.u32  %r36, [%r135+64];
                ld.u32  %r37, [%r135+60];
                ld.u32  %r40, [%r135+48];
                ld.u32  %r41, [%r135+44];
                ld.u32  %r42, [%r135+28];
                ld.u32  %r43, [%r135+24];
                ld.u64  %r44, [%r135+8];
                ld.u64  %r45, [%r135];
                ld.f32  %r46, [%r135+20];
                ld.f32  %r47, [%r135+16];
                add.u32 %r25, %r34, %r54;
                add.u32 %r22, %r34, %r55;
                rem.u32 %r143, %r25, %r37;
                add.u32 %r26, %r143, 1;
                div.u32 %r58, %r25, %r37;
                rem.u32 %r145, %r58, %r36;
                add.u32 %r28, %r145, 1;
                div.u32 %r147, %r58, %r36;
                add.u32 %r29, %r147, 1;
                ld.u32  %r148, [%r135+52];
                sub.u32 %r30, %r148, %r26;
                mov.u32 %r93, 0;
                mov.u32 %r86, %r93;
                mov.u32 %r79, %r93;
$L10:
                min.u32 %r64, %r23, %r30;
                add.u32 %r65, %r25, %r64;
                add.u32 %r131, %r29, 1;
                add.u32 %r27, %r28, 1;
                setp.lt.u32     %r149, %r25, %r65;
        @%r149  bra     $L4;
                mov.u32 %r28, %r80;
                mov.u32 %r65, %r25;
$L12:
                mov.u32 %r198, 1;
                not.b32 %r200, %r29;
                add.u32 %r199, %r200, %r41;
                and.b32 %r201, %r199, 7;
                setp.lt.s32     %r150, %r27, %r40;
        @%r150  bra     $L5;
                bra     $L65;
$L6:
                mov.u32 %r29, %r218;
                setp.lt.s32     %r219, %r198, %r40;
        @%r219  bra     $L5;
                mov.u32 %r27, %r198;
                add.u32 %r218, %r218, 8;
                setp.gt.s32     %r283, %r41, %r218;
        @%r283  bra     $L6;
$L67:
                setp.eq.u32     %r152, %r93, 0;
                selp.u32        %r222, 0, %r87, %r152;
                setp.eq.u32     %r153, %r86, 0;
                selp.u32        %r223, 0, %r28, %r153;
                setp.eq.u32     %r154, %r79, 0;
                selp.u32        %r224, 0, %r74, %r154;
                setp.ne.u32     %r155, %r38, %r65;
        @%r155  bra     $L3;
                add.u32 %r31, %r222, 1;
                add.u32 %r32, %r223, 1;
                add.u32 %r33, %r224, 1;
                bra     $L3;
$L5:
                sub.u32 %r23, %r22, %r65;
                mov.u32 %r80, %r28;
                mov.u32 %r30, %r37;
                mov.u32 %r28, %r27;
                mov.u32 %r25, %r65;
                mov.u32 %r26, 1;
                bra     $L10;
$L4:
                mul.lo.u32      %r71, %r42, %r131;
                add.u32 %r156, %r42, %r42;
                sub.u32 %r76, %r71, %r156;
                add.u32 %r83, %r42, %r76;
                mov.u32 %r129, %r26;
                add.u32 %r157, %r28, %r83;
                mul.lo.u32      %r158, %r157, %r43;
                cvt.s64.s32     %r126, %r158;
                cvt.s64.s32     %r159, %r129;
                add.u64 %r160, %r159, %r126;
                shl.b64 %r124, %r160, 2;
                add.u64 %r128, %r45, %r124;
                add.u64 %r122, %r44, %r124;
                add.u32 %r106, %r64, %r129;
                neg.s64 %r162, %r126;
                shl.b64 %r163, %r162, 2;
                add.u32 %r164, %r28, %r71;
                mul.lo.u32      %r165, %r164, %r43;
                cvt.s64.s32     %r166, %r165;
                shl.b64 %r117, %r166, 2;
                add.u32 %r167, %r28, %r76;
                mul.lo.u32      %r168, %r167, %r43;
                cvt.s64.s32     %r169, %r168;
                shl.b64 %r115, %r169, 2;
                add.u32 %r170, %r83, %r27;
                mul.lo.u32      %r171, %r170, %r43;
                cvt.s64.s32     %r172, %r171;
                shl.b64 %r113, %r172, 2;
                add.u32 %r173, %r28, -1;
                add.u32 %r174, %r173, %r83;
                mul.lo.u32      %r175, %r174, %r43;
                cvt.s64.s32     %r176, %r175;
                shl.b64 %r111, %r176, 2;
                and.b32 %r213, %r64, 1;
                setp.eq.u32     %r214, %r213, 0;
        @!%r214 bra     $L66;
$L11:
                add.u64 %r118, %r163, %r128;
                add.u64 %r177, %r118, %r117;
                add.u64 %r178, %r118, %r115;
                ld.f32  %r180, [%r177];
                ld.f32  %r181, [%r178];
                add.f32 %r179, %r180, %r181;
                add.u64 %r182, %r118, %r113;
                ld.f32  %r184, [%r182];
                add.f32 %r183, %r179, %r184;
                add.u64 %r185, %r118, %r111;
                ld.f32  %r187, [%r185];
                add.f32 %r186, %r183, %r187;
                ld.f32  %r189, [%r128+4];
                add.f32 %r188, %r186, %r189;
                ld.f32  %r191, [%r128+-4];
                add.f32 %r190, %r188, %r191;
                ld.f32  %r193, [%r128];
                mul.f32 %r192, %r47, %r193;
                neg.f32 %r194, %r192;
                fma.rn.f32      %r104, %r46, %r190, %r194;
                st.f32  [%r122], %r104;
                add.u64 %r216, %r128, 4;
                add.u32 %r87, %r129, 1;
                add.u64 %r229, %r163, %r216;
                add.u64 %r230, %r229, %r117;
                add.u64 %r231, %r229, %r115;
                ld.f32  %r232, [%r230];
                ld.f32  %r233, [%r231];
                add.f32 %r234, %r232, %r233;
                add.u64 %r235, %r229, %r113;
                ld.f32  %r236, [%r235];
                add.f32 %r237, %r234, %r236;
                add.u64 %r238, %r229, %r111;
                ld.f32  %r239, [%r238];
                add.f32 %r240, %r237, %r239;
                ld.f32  %r241, [%r216+4];
                add.f32 %r242, %r240, %r241;
                ld.f32  %r243, [%r128];
                add.f32 %r244, %r242, %r243;
                ld.f32  %r245, [%r216];
                mul.f32 %r246, %r47, %r245;
                neg.f32 %r247, %r246;
                fma.rn.f32      %r248, %r46, %r244, %r247;
                st.f32  [%r122+4], %r248;
                add.u32 %r129, %r129, 2;
                add.u64 %r128, %r128, 8;
                add.u64 %r122, %r122, 8;
                setp.ne.u32     %r249, %r106, %r129;
        @%r249  bra     $L11;
$L68:
                mov.u32 %r74, %r29;
                mov.u32 %r93, 1;
                mov.u32 %r86, %r93;
                mov.u32 %r79, %r93;
                bra     $L12;
$L16:
                mov.u32 %r22, 0;
$L3:
                mov.v2.u32      %r196, { 0, 0 };
                mov.u32 %r196.x, %r31;
                mov.u32 %r196.y, %r32;
                setp.eq.u32     %r197, %r22, %r38;
        @!%r197 bra     $L1;
                st.u32  [%r135+40], %r33;
                st.v2.u32       [%r135+32], %r196;
                bra     $L1;
$L2:
                add.u32 %r23, %r23, 1;
                mov.u32 %r24, 0;
                bra     $L15;
$L1:
        ret;
$L65:
                add.u32 %r218, %r29, 1;
                mov.u32 %r27, %r198;
                setp.gt.s32     %r250, %r41, %r218;
        @!%r250 bra     $L67;
                setp.eq.u32     %r208, %r201, 0;
        @%r208  bra     $L6;
                setp.eq.u32     %r207, %r201, 1;
        @%r207  bra     $L51;
                setp.eq.u32     %r206, %r201, 2;
        @%r206  bra     $L52;
                setp.eq.u32     %r205, %r201, 3;
        @%r205  bra     $L53;
                setp.eq.u32     %r204, %r201, 4;
        @%r204  bra     $L54;
                setp.eq.u32     %r203, %r201, 5;
        @%r203  bra     $L55;
                setp.eq.u32     %r202, %r201, 6;
        @%r202  bra     $L56;
                mov.u32 %r29, %r218;
                setp.lt.s32     %r251, %r27, %r40;
        @%r251  bra     $L5;
                add.u32 %r218, %r218, 1;
                mov.u32 %r27, %r198;
$L56:
                mov.u32 %r29, %r218;
                setp.lt.s32     %r253, %r198, %r40;
        @%r253  bra     $L5;
                add.u32 %r218, %r218, 1;
                mov.u32 %r27, %r198;
$L55:
                mov.u32 %r29, %r218;
                setp.lt.s32     %r255, %r198, %r40;
        @%r255  bra     $L5;
                add.u32 %r218, %r218, 1;
                mov.u32 %r27, %r198;
$L54:
                mov.u32 %r29, %r218;
                setp.lt.s32     %r257, %r198, %r40;
        @%r257  bra     $L5;
                add.u32 %r218, %r218, 1;
                mov.u32 %r27, %r198;
$L53:
                mov.u32 %r29, %r218;
                setp.lt.s32     %r259, %r198, %r40;
        @%r259  bra     $L5;
                add.u32 %r218, %r218, 1;
                mov.u32 %r27, %r198;
$L52:
                mov.u32 %r29, %r218;
                setp.lt.s32     %r261, %r198, %r40;
        @%r261  bra     $L5;
                add.u32 %r218, %r218, 1;
                mov.u32 %r27, %r198;
$L51:
                mov.u32 %r29, %r218;
                setp.lt.s32     %r263, %r198, %r40;
        @%r263  bra     $L5;
                add.u32 %r218, %r218, 1;
                mov.u32 %r27, %r198;
                setp.gt.s32     %r264, %r41, %r218;
        @%r264  bra     $L6;
                bra     $L67;
$L66:
                mov.u32 %r87, %r129;
                add.u64 %r284, %r163, %r128;
                add.u64 %r285, %r284, %r117;
                add.u64 %r286, %r284, %r115;
                ld.f32  %r287, [%r285];
                ld.f32  %r288, [%r286];
                add.f32 %r289, %r287, %r288;
                add.u64 %r290, %r284, %r113;
                ld.f32  %r291, [%r290];
                add.f32 %r292, %r289, %r291;
                add.u64 %r293, %r284, %r111;
                ld.f32  %r294, [%r293];
                add.f32 %r295, %r292, %r294;
                ld.f32  %r296, [%r128+4];
                add.f32 %r297, %r295, %r296;
                ld.f32  %r298, [%r128+-4];
                add.f32 %r299, %r297, %r298;
                ld.f32  %r300, [%r128];
                mul.f32 %r301, %r47, %r300;
                neg.f32 %r302, %r301;
                fma.rn.f32      %r303, %r46, %r299, %r302;
                st.f32  [%r122], %r303;
                add.u32 %r129, %r87, 1;
                add.u64 %r128, %r128, 4;
                add.u64 %r122, %r122, 4;
                setp.ne.u32     %r304, %r106, %r129;
        @%r304  bra     $L11;
                bra     $L68;
}
string-delimiter
      )

(define ptx-sample10-out
'((function
   "test$_omp_fn$1"
   (storage ".param" ".u64" "%in_ar0")
   (storageN ".reg" ".u64" "%ar0")
   (instruction "ld" ".param" ".u64" "%ar0" "[%in_ar0]")
   (storageN ".reg" ".u32" "%r22")
   (storageN ".reg" ".u32" "%r23")
   (storageN ".reg" ".u32" "%r24")
   (storageN ".reg" ".u32" "%r25")
   (storageN ".reg" ".u32" "%r26")
   (storageN ".reg" ".u32" "%r27")
   (storageN ".reg" ".u32" "%r28")
   (storageN ".reg" ".u32" "%r29")
   (storageN ".reg" ".u32" "%r30")
   (storageN ".reg" ".u32" "%r31")
   (storageN ".reg" ".u32" "%r32")
   (storageN ".reg" ".u32" "%r33")
   (storageN ".reg" ".u32" "%r34")
   (storageN ".reg" ".u32" "%r36")
   (storageN ".reg" ".u32" "%r37")
   (storageN ".reg" ".u32" "%r38")
   (storageN ".reg" ".u32" "%r40")
   (storageN ".reg" ".u32" "%r41")
   (storageN ".reg" ".u32" "%r42")
   (storageN ".reg" ".u32" "%r43")
   (storageN ".reg" ".u64" "%r44")
   (storageN ".reg" ".u64" "%r45")
   (storageN ".reg" ".f32" "%r46")
   (storageN ".reg" ".f32" "%r47")
   (storageN ".reg" ".u32" "%r52")
   (storageN ".reg" ".u32" "%r54")
   (storageN ".reg" ".u32" "%r55")
   (storageN ".reg" ".u32" "%r58")
   (storageN ".reg" ".u32" "%r64")
   (storageN ".reg" ".u32" "%r65")
   (storageN ".reg" ".u32" "%r71")
   (storageN ".reg" ".u32" "%r74")
   (storageN ".reg" ".u32" "%r76")
   (storageN ".reg" ".u32" "%r79")
   (storageN ".reg" ".u32" "%r80")
   (storageN ".reg" ".u32" "%r83")
   (storageN ".reg" ".u32" "%r86")
   (storageN ".reg" ".u32" "%r87")
   (storageN ".reg" ".u32" "%r93")
   (storageN ".reg" ".f32" "%r104")
   (storageN ".reg" ".u32" "%r106")
   (storageN ".reg" ".u64" "%r111")
   (storageN ".reg" ".u64" "%r113")
   (storageN ".reg" ".u64" "%r115")
   (storageN ".reg" ".u64" "%r117")
   (storageN ".reg" ".u64" "%r118")
   (storageN ".reg" ".u64" "%r122")
   (storageN ".reg" ".u64" "%r124")
   (storageN ".reg" ".u64" "%r126")
   (storageN ".reg" ".u64" "%r128")
   (storageN ".reg" ".u32" "%r129")
   (storageN ".reg" ".u32" "%r131")
   (storageN ".reg" ".u64" "%r135")
   (storageN ".reg" ".u32" "%r136")
   (storageN ".reg" ".u32" "%r137")
   (storageN ".reg" ".u32" "%r138")
   (storageN ".reg" ".pred" "%r139")
   (storageN ".reg" ".pred" "%r141")
   (storageN ".reg" ".u32" "%r143")
   (storageN ".reg" ".u32" "%r145")
   (storageN ".reg" ".u32" "%r147")
   (storageN ".reg" ".u32" "%r148")
   (storageN ".reg" ".pred" "%r149")
   (storageN ".reg" ".pred" "%r150")
   (storageN ".reg" ".pred" "%r152")
   (storageN ".reg" ".pred" "%r153")
   (storageN ".reg" ".pred" "%r154")
   (storageN ".reg" ".pred" "%r155")
   (storageN ".reg" ".u32" "%r156")
   (storageN ".reg" ".u32" "%r157")
   (storageN ".reg" ".u32" "%r158")
   (storageN ".reg" ".u64" "%r159")
   (storageN ".reg" ".u64" "%r160")
   (storageN ".reg" ".u64" "%r162")
   (storageN ".reg" ".u64" "%r163")
   (storageN ".reg" ".u32" "%r164")
   (storageN ".reg" ".u32" "%r165")
   (storageN ".reg" ".u64" "%r166")
   (storageN ".reg" ".u32" "%r167")
   (storageN ".reg" ".u32" "%r168")
   (storageN ".reg" ".u64" "%r169")
   (storageN ".reg" ".u32" "%r170")
   (storageN ".reg" ".u32" "%r171")
   (storageN ".reg" ".u64" "%r172")
   (storageN ".reg" ".u32" "%r173")
   (storageN ".reg" ".u32" "%r174")
   (storageN ".reg" ".u32" "%r175")
   (storageN ".reg" ".u64" "%r176")
   (storageN ".reg" ".u64" "%r177")
   (storageN ".reg" ".u64" "%r178")
   (storageN ".reg" ".f32" "%r179")
   (storageN ".reg" ".f32" "%r180")
   (storageN ".reg" ".f32" "%r181")
   (storageN ".reg" ".u64" "%r182")
   (storageN ".reg" ".f32" "%r183")
   (storageN ".reg" ".f32" "%r184")
   (storageN ".reg" ".u64" "%r185")
   (storageN ".reg" ".f32" "%r186")
   (storageN ".reg" ".f32" "%r187")
   (storageN ".reg" ".f32" "%r188")
   (storageN ".reg" ".f32" "%r189")
   (storageN ".reg" ".f32" "%r190")
   (storageN ".reg" ".f32" "%r191")
   (storageN ".reg" ".f32" "%r192")
   (storageN ".reg" ".f32" "%r193")
   (storageN ".reg" ".f32" "%r194")
   (storageN ".reg" ".v2" ".u32" "%r196")
   (storageN ".reg" ".pred" "%r197")
   (storageN ".reg" ".u32" "%r198")
   (storageN ".reg" ".u32" "%r199")
   (storageN ".reg" ".u32" "%r200")
   (storageN ".reg" ".u32" "%r201")
   (storageN ".reg" ".pred" "%r202")
   (storageN ".reg" ".pred" "%r203")
   (storageN ".reg" ".pred" "%r204")
   (storageN ".reg" ".pred" "%r205")
   (storageN ".reg" ".pred" "%r206")
   (storageN ".reg" ".pred" "%r207")
   (storageN ".reg" ".pred" "%r208")
   (storageN ".reg" ".u32" "%r213")
   (storageN ".reg" ".pred" "%r214")
   (storageN ".reg" ".u64" "%r216")
   (storageN ".reg" ".u32" "%r218")
   (storageN ".reg" ".pred" "%r219")
   (storageN ".reg" ".u32" "%r222")
   (storageN ".reg" ".u32" "%r223")
   (storageN ".reg" ".u32" "%r224")
   (storageN ".reg" ".u64" "%r229")
   (storageN ".reg" ".u64" "%r230")
   (storageN ".reg" ".u64" "%r231")
   (storageN ".reg" ".f32" "%r232")
   (storageN ".reg" ".f32" "%r233")
   (storageN ".reg" ".f32" "%r234")
   (storageN ".reg" ".u64" "%r235")
   (storageN ".reg" ".f32" "%r236")
   (storageN ".reg" ".f32" "%r237")
   (storageN ".reg" ".u64" "%r238")
   (storageN ".reg" ".f32" "%r239")
   (storageN ".reg" ".f32" "%r240")
   (storageN ".reg" ".f32" "%r241")
   (storageN ".reg" ".f32" "%r242")
   (storageN ".reg" ".f32" "%r243")
   (storageN ".reg" ".f32" "%r244")
   (storageN ".reg" ".f32" "%r245")
   (storageN ".reg" ".f32" "%r246")
   (storageN ".reg" ".f32" "%r247")
   (storageN ".reg" ".f32" "%r248")
   (storageN ".reg" ".pred" "%r249")
   (storageN ".reg" ".pred" "%r250")
   (storageN ".reg" ".pred" "%r251")
   (storageN ".reg" ".pred" "%r253")
   (storageN ".reg" ".pred" "%r255")
   (storageN ".reg" ".pred" "%r257")
   (storageN ".reg" ".pred" "%r259")
   (storageN ".reg" ".pred" "%r261")
   (storageN ".reg" ".pred" "%r263")
   (storageN ".reg" ".pred" "%r264")
   (storageN ".reg" ".pred" "%r283")
   (storageN ".reg" ".u64" "%r284")
   (storageN ".reg" ".u64" "%r285")
   (storageN ".reg" ".u64" "%r286")
   (storageN ".reg" ".f32" "%r287")
   (storageN ".reg" ".f32" "%r288")
   (storageN ".reg" ".f32" "%r289")
   (storageN ".reg" ".u64" "%r290")
   (storageN ".reg" ".f32" "%r291")
   (storageN ".reg" ".f32" "%r292")
   (storageN ".reg" ".u64" "%r293")
   (storageN ".reg" ".f32" "%r294")
   (storageN ".reg" ".f32" "%r295")
   (storageN ".reg" ".f32" "%r296")
   (storageN ".reg" ".f32" "%r297")
   (storageN ".reg" ".f32" "%r298")
   (storageN ".reg" ".f32" "%r299")
   (storageN ".reg" ".f32" "%r300")
   (storageN ".reg" ".f32" "%r301")
   (storageN ".reg" ".f32" "%r302")
   (storageN ".reg" ".f32" "%r303")
   (storageN ".reg" ".pred" "%r304")
   (instruction "mov" ".u64" "%r135" "%ar0")
   (instruction "ld" ".u32" "%r34" "[%r135+72]")
   (instruction "ld" ".u32" "%r38" "[%r135+56]")
   (group
    (storageN ".param" ".u32" "%value_in")
    (instruction "call" "(%value_in)" "omp_get_num_threads")
    (instruction "ld" ".param" ".u32" "%r136" "[%value_in]"))
   (group
    (storageN ".param" ".u32" "%value_in")
    (instruction "call" "(%value_in)" "omp_get_thread_num")
    (instruction "ld" ".param" ".u32" "%r137" "[%value_in]"))
   (instruction "ld" ".u32" "%r138" "[%r135+68]")
   (instruction "sub" ".u32" "%r52" "%r138" "%r34")
   (instruction "div" ".u32" "%r23" "%r52" "%r136")
   (instruction "rem" ".u32" "%r24" "%r52" "%r136")
   (instruction "setp" ".lt" ".u32" "%r139" "%r137" "%r24")
   "@%r139"
   (instruction "bra" "$L2")
   "$L15:"
   (instruction "mad" ".lo" ".u32" "%r54" "%r23" "%r137" "%r24")
   (instruction "add" ".u32" "%r55" "%r23" "%r54")
   (instruction "setp" ".ge" ".u32" "%r141" "%r54" "%r55")
   "@%r141"
   (instruction "bra" "$L16")
   (instruction "ld" ".u32" "%r36" "[%r135+64]")
   (instruction "ld" ".u32" "%r37" "[%r135+60]")
   (instruction "ld" ".u32" "%r40" "[%r135+48]")
   (instruction "ld" ".u32" "%r41" "[%r135+44]")
   (instruction "ld" ".u32" "%r42" "[%r135+28]")
   (instruction "ld" ".u32" "%r43" "[%r135+24]")
   (instruction "ld" ".u64" "%r44" "[%r135+8]")
   (instruction "ld" ".u64" "%r45" "[%r135]")
   (instruction "ld" ".f32" "%r46" "[%r135+20]")
   (instruction "ld" ".f32" "%r47" "[%r135+16]")
   (instruction "add" ".u32" "%r25" "%r34" "%r54")
   (instruction "add" ".u32" "%r22" "%r34" "%r55")
   (instruction "rem" ".u32" "%r143" "%r25" "%r37")
   (instruction "add" ".u32" "%r26" "%r143" "1")
   (instruction "div" ".u32" "%r58" "%r25" "%r37")
   (instruction "rem" ".u32" "%r145" "%r58" "%r36")
   (instruction "add" ".u32" "%r28" "%r145" "1")
   (instruction "div" ".u32" "%r147" "%r58" "%r36")
   (instruction "add" ".u32" "%r29" "%r147" "1")
   (instruction "ld" ".u32" "%r148" "[%r135+52]")
   (instruction "sub" ".u32" "%r30" "%r148" "%r26")
   (instruction "mov" ".u32" "%r93" "0")
   (instruction "mov" ".u32" "%r86" "%r93")
   (instruction "mov" ".u32" "%r79" "%r93")
   "$L10:"
   (instruction "min" ".u32" "%r64" "%r23" "%r30")
   (instruction "add" ".u32" "%r65" "%r25" "%r64")
   (instruction "add" ".u32" "%r131" "%r29" "1")
   (instruction "add" ".u32" "%r27" "%r28" "1")
   (instruction "setp" ".lt" ".u32" "%r149" "%r25" "%r65")
   "@%r149"
   (instruction "bra" "$L4")
   (instruction "mov" ".u32" "%r28" "%r80")
   (instruction "mov" ".u32" "%r65" "%r25")
   "$L12:"
   (instruction "mov" ".u32" "%r198" "1")
   (instruction "not" ".b32" "%r200" "%r29")
   (instruction "add" ".u32" "%r199" "%r200" "%r41")
   (instruction "and" ".b32" "%r201" "%r199" "7")
   (instruction "setp" ".lt" ".s32" "%r150" "%r27" "%r40")
   "@%r150"
   (instruction "bra" "$L5")
   (instruction "bra" "$L65")
   "$L6:"
   (instruction "mov" ".u32" "%r29" "%r218")
   (instruction "setp" ".lt" ".s32" "%r219" "%r198" "%r40")
   "@%r219"
   (instruction "bra" "$L5")
   (instruction "mov" ".u32" "%r27" "%r198")
   (instruction "add" ".u32" "%r218" "%r218" "8")
   (instruction "setp" ".gt" ".s32" "%r283" "%r41" "%r218")
   "@%r283"
   (instruction "bra" "$L6")
   "$L67:"
   (instruction "setp" ".eq" ".u32" "%r152" "%r93" "0")
   (instruction "selp" ".u32" "%r222" "0" "%r87" "%r152")
   (instruction "setp" ".eq" ".u32" "%r153" "%r86" "0")
   (instruction "selp" ".u32" "%r223" "0" "%r28" "%r153")
   (instruction "setp" ".eq" ".u32" "%r154" "%r79" "0")
   (instruction "selp" ".u32" "%r224" "0" "%r74" "%r154")
   (instruction "setp" ".ne" ".u32" "%r155" "%r38" "%r65")
   "@%r155"
   (instruction "bra" "$L3")
   (instruction "add" ".u32" "%r31" "%r222" "1")
   (instruction "add" ".u32" "%r32" "%r223" "1")
   (instruction "add" ".u32" "%r33" "%r224" "1")
   (instruction "bra" "$L3")
   "$L5:"
   (instruction "sub" ".u32" "%r23" "%r22" "%r65")
   (instruction "mov" ".u32" "%r80" "%r28")
   (instruction "mov" ".u32" "%r30" "%r37")
   (instruction "mov" ".u32" "%r28" "%r27")
   (instruction "mov" ".u32" "%r25" "%r65")
   (instruction "mov" ".u32" "%r26" "1")
   (instruction "bra" "$L10")
   "$L4:"
   (instruction "mul" ".lo" ".u32" "%r71" "%r42" "%r131")
   (instruction "add" ".u32" "%r156" "%r42" "%r42")
   (instruction "sub" ".u32" "%r76" "%r71" "%r156")
   (instruction "add" ".u32" "%r83" "%r42" "%r76")
   (instruction "mov" ".u32" "%r129" "%r26")
   (instruction "add" ".u32" "%r157" "%r28" "%r83")
   (instruction "mul" ".lo" ".u32" "%r158" "%r157" "%r43")
   (instruction "cvt" ".s64" ".s32" "%r126" "%r158")
   (instruction "cvt" ".s64" ".s32" "%r159" "%r129")
   (instruction "add" ".u64" "%r160" "%r159" "%r126")
   (instruction "shl" ".b64" "%r124" "%r160" "2")
   (instruction "add" ".u64" "%r128" "%r45" "%r124")
   (instruction "add" ".u64" "%r122" "%r44" "%r124")
   (instruction "add" ".u32" "%r106" "%r64" "%r129")
   (instruction "neg" ".s64" "%r162" "%r126")
   (instruction "shl" ".b64" "%r163" "%r162" "2")
   (instruction "add" ".u32" "%r164" "%r28" "%r71")
   (instruction "mul" ".lo" ".u32" "%r165" "%r164" "%r43")
   (instruction "cvt" ".s64" ".s32" "%r166" "%r165")
   (instruction "shl" ".b64" "%r117" "%r166" "2")
   (instruction "add" ".u32" "%r167" "%r28" "%r76")
   (instruction "mul" ".lo" ".u32" "%r168" "%r167" "%r43")
   (instruction "cvt" ".s64" ".s32" "%r169" "%r168")
   (instruction "shl" ".b64" "%r115" "%r169" "2")
   (instruction "add" ".u32" "%r170" "%r83" "%r27")
   (instruction "mul" ".lo" ".u32" "%r171" "%r170" "%r43")
   (instruction "cvt" ".s64" ".s32" "%r172" "%r171")
   (instruction "shl" ".b64" "%r113" "%r172" "2")
   (instruction "add" ".u32" "%r173" "%r28" "-1")
   (instruction "add" ".u32" "%r174" "%r173" "%r83")
   (instruction "mul" ".lo" ".u32" "%r175" "%r174" "%r43")
   (instruction "cvt" ".s64" ".s32" "%r176" "%r175")
   (instruction "shl" ".b64" "%r111" "%r176" "2")
   (instruction "and" ".b32" "%r213" "%r64" "1")
   (instruction "setp" ".eq" ".u32" "%r214" "%r213" "0")
   "@!%r214"
   (instruction "bra" "$L66")
   "$L11:"
   (instruction "add" ".u64" "%r118" "%r163" "%r128")
   (instruction "add" ".u64" "%r177" "%r118" "%r117")
   (instruction "add" ".u64" "%r178" "%r118" "%r115")
   (instruction "ld" ".f32" "%r180" "[%r177]")
   (instruction "ld" ".f32" "%r181" "[%r178]")
   (instruction "add" ".f32" "%r179" "%r180" "%r181")
   (instruction "add" ".u64" "%r182" "%r118" "%r113")
   (instruction "ld" ".f32" "%r184" "[%r182]")
   (instruction "add" ".f32" "%r183" "%r179" "%r184")
   (instruction "add" ".u64" "%r185" "%r118" "%r111")
   (instruction "ld" ".f32" "%r187" "[%r185]")
   (instruction "add" ".f32" "%r186" "%r183" "%r187")
   (instruction "ld" ".f32" "%r189" "[%r128+4]")
   (instruction "add" ".f32" "%r188" "%r186" "%r189")
   (instruction "ld" ".f32" "%r191" "[%r128+-4]")
   (instruction "add" ".f32" "%r190" "%r188" "%r191")
   (instruction "ld" ".f32" "%r193" "[%r128]")
   (instruction "mul" ".f32" "%r192" "%r47" "%r193")
   (instruction "neg" ".f32" "%r194" "%r192")
   (instruction "fma" ".rn" ".f32" "%r104" "%r46" "%r190" "%r194")
   (instruction "st" ".f32" "[%r122]" "%r104")
   (instruction "add" ".u64" "%r216" "%r128" "4")
   (instruction "add" ".u32" "%r87" "%r129" "1")
   (instruction "add" ".u64" "%r229" "%r163" "%r216")
   (instruction "add" ".u64" "%r230" "%r229" "%r117")
   (instruction "add" ".u64" "%r231" "%r229" "%r115")
   (instruction "ld" ".f32" "%r232" "[%r230]")
   (instruction "ld" ".f32" "%r233" "[%r231]")
   (instruction "add" ".f32" "%r234" "%r232" "%r233")
   (instruction "add" ".u64" "%r235" "%r229" "%r113")
   (instruction "ld" ".f32" "%r236" "[%r235]")
   (instruction "add" ".f32" "%r237" "%r234" "%r236")
   (instruction "add" ".u64" "%r238" "%r229" "%r111")
   (instruction "ld" ".f32" "%r239" "[%r238]")
   (instruction "add" ".f32" "%r240" "%r237" "%r239")
   (instruction "ld" ".f32" "%r241" "[%r216+4]")
   (instruction "add" ".f32" "%r242" "%r240" "%r241")
   (instruction "ld" ".f32" "%r243" "[%r128]")
   (instruction "add" ".f32" "%r244" "%r242" "%r243")
   (instruction "ld" ".f32" "%r245" "[%r216]")
   (instruction "mul" ".f32" "%r246" "%r47" "%r245")
   (instruction "neg" ".f32" "%r247" "%r246")
   (instruction "fma" ".rn" ".f32" "%r248" "%r46" "%r244" "%r247")
   (instruction "st" ".f32" "[%r122+4]" "%r248")
   (instruction "add" ".u32" "%r129" "%r129" "2")
   (instruction "add" ".u64" "%r128" "%r128" "8")
   (instruction "add" ".u64" "%r122" "%r122" "8")
   (instruction "setp" ".ne" ".u32" "%r249" "%r106" "%r129")
   "@%r249"
   (instruction "bra" "$L11")
   "$L68:"
   (instruction "mov" ".u32" "%r74" "%r29")
   (instruction "mov" ".u32" "%r93" "1")
   (instruction "mov" ".u32" "%r86" "%r93")
   (instruction "mov" ".u32" "%r79" "%r93")
   (instruction "bra" "$L12")
   "$L16:"
   (instruction "mov" ".u32" "%r22" "0")
   "$L3:"
   (instruction "mov" ".v2" ".u32" "%r196" "{0,0}")
   (instruction "mov" ".u32" "%r196.x" "%r31")
   (instruction "mov" ".u32" "%r196.y" "%r32")
   (instruction "setp" ".eq" ".u32" "%r197" "%r22" "%r38")
   "@!%r197"
   (instruction "bra" "$L1")
   (instruction "st" ".u32" "[%r135+40]" "%r33")
   (instruction "st" ".v2" ".u32" "[%r135+32]" "%r196")
   (instruction "bra" "$L1")
   "$L2:"
   (instruction "add" ".u32" "%r23" "%r23" "1")
   (instruction "mov" ".u32" "%r24" "0")
   (instruction "bra" "$L15")
   "$L1:"
   (instruction "ret")
   "$L65:"
   (instruction "add" ".u32" "%r218" "%r29" "1")
   (instruction "mov" ".u32" "%r27" "%r198")
   (instruction "setp" ".gt" ".s32" "%r250" "%r41" "%r218")
   "@!%r250"
   (instruction "bra" "$L67")
   (instruction "setp" ".eq" ".u32" "%r208" "%r201" "0")
   "@%r208"
   (instruction "bra" "$L6")
   (instruction "setp" ".eq" ".u32" "%r207" "%r201" "1")
   "@%r207"
   (instruction "bra" "$L51")
   (instruction "setp" ".eq" ".u32" "%r206" "%r201" "2")
   "@%r206"
   (instruction "bra" "$L52")
   (instruction "setp" ".eq" ".u32" "%r205" "%r201" "3")
   "@%r205"
   (instruction "bra" "$L53")
   (instruction "setp" ".eq" ".u32" "%r204" "%r201" "4")
   "@%r204"
   (instruction "bra" "$L54")
   (instruction "setp" ".eq" ".u32" "%r203" "%r201" "5")
   "@%r203"
   (instruction "bra" "$L55")
   (instruction "setp" ".eq" ".u32" "%r202" "%r201" "6")
   "@%r202"
   (instruction "bra" "$L56")
   (instruction "mov" ".u32" "%r29" "%r218")
   (instruction "setp" ".lt" ".s32" "%r251" "%r27" "%r40")
   "@%r251"
   (instruction "bra" "$L5")
   (instruction "add" ".u32" "%r218" "%r218" "1")
   (instruction "mov" ".u32" "%r27" "%r198")
   "$L56:"
   (instruction "mov" ".u32" "%r29" "%r218")
   (instruction "setp" ".lt" ".s32" "%r253" "%r198" "%r40")
   "@%r253"
   (instruction "bra" "$L5")
   (instruction "add" ".u32" "%r218" "%r218" "1")
   (instruction "mov" ".u32" "%r27" "%r198")
   "$L55:"
   (instruction "mov" ".u32" "%r29" "%r218")
   (instruction "setp" ".lt" ".s32" "%r255" "%r198" "%r40")
   "@%r255"
   (instruction "bra" "$L5")
   (instruction "add" ".u32" "%r218" "%r218" "1")
   (instruction "mov" ".u32" "%r27" "%r198")
   "$L54:"
   (instruction "mov" ".u32" "%r29" "%r218")
   (instruction "setp" ".lt" ".s32" "%r257" "%r198" "%r40")
   "@%r257"
   (instruction "bra" "$L5")
   (instruction "add" ".u32" "%r218" "%r218" "1")
   (instruction "mov" ".u32" "%r27" "%r198")
   "$L53:"
   (instruction "mov" ".u32" "%r29" "%r218")
   (instruction "setp" ".lt" ".s32" "%r259" "%r198" "%r40")
   "@%r259"
   (instruction "bra" "$L5")
   (instruction "add" ".u32" "%r218" "%r218" "1")
   (instruction "mov" ".u32" "%r27" "%r198")
   "$L52:"
   (instruction "mov" ".u32" "%r29" "%r218")
   (instruction "setp" ".lt" ".s32" "%r261" "%r198" "%r40")
   "@%r261"
   (instruction "bra" "$L5")
   (instruction "add" ".u32" "%r218" "%r218" "1")
   (instruction "mov" ".u32" "%r27" "%r198")
   "$L51:"
   (instruction "mov" ".u32" "%r29" "%r218")
   (instruction "setp" ".lt" ".s32" "%r263" "%r198" "%r40")
   "@%r263"
   (instruction "bra" "$L5")
   (instruction "add" ".u32" "%r218" "%r218" "1")
   (instruction "mov" ".u32" "%r27" "%r198")
   (instruction "setp" ".gt" ".s32" "%r264" "%r41" "%r218")
   "@%r264"
   (instruction "bra" "$L6")
   (instruction "bra" "$L67")
   "$L66:"
   (instruction "mov" ".u32" "%r87" "%r129")
   (instruction "add" ".u64" "%r284" "%r163" "%r128")
   (instruction "add" ".u64" "%r285" "%r284" "%r117")
   (instruction "add" ".u64" "%r286" "%r284" "%r115")
   (instruction "ld" ".f32" "%r287" "[%r285]")
   (instruction "ld" ".f32" "%r288" "[%r286]")
   (instruction "add" ".f32" "%r289" "%r287" "%r288")
   (instruction "add" ".u64" "%r290" "%r284" "%r113")
   (instruction "ld" ".f32" "%r291" "[%r290]")
   (instruction "add" ".f32" "%r292" "%r289" "%r291")
   (instruction "add" ".u64" "%r293" "%r284" "%r111")
   (instruction "ld" ".f32" "%r294" "[%r293]")
   (instruction "add" ".f32" "%r295" "%r292" "%r294")
   (instruction "ld" ".f32" "%r296" "[%r128+4]")
   (instruction "add" ".f32" "%r297" "%r295" "%r296")
   (instruction "ld" ".f32" "%r298" "[%r128+-4]")
   (instruction "add" ".f32" "%r299" "%r297" "%r298")
   (instruction "ld" ".f32" "%r300" "[%r128]")
   (instruction "mul" ".f32" "%r301" "%r47" "%r300")
   (instruction "neg" ".f32" "%r302" "%r301")
   (instruction "fma" ".rn" ".f32" "%r303" "%r46" "%r299" "%r302")
   (instruction "st" ".f32" "[%r122]" "%r303")
   (instruction "add" ".u32" "%r129" "%r87" "1")
   (instruction "add" ".u64" "%r128" "%r128" "4")
   (instruction "add" ".u64" "%r122" "%r122" "4")
   (instruction "setp" ".ne" ".u32" "%r304" "%r106" "%r129")
   "@%r304"
   (instruction "bra" "$L11")
   (instruction "bra" "$L68")))
  )

(define ptx-sample11
  #<<string-delimiter
.func ComputePhiMagCPU$_omp_fn$1 (.param.u64 %in_ar0)
{
        .reg.u64 %ar0;
        ld.param.u64 %ar0, [%in_ar0];
        .reg.u64 %stack;
        .reg.u64 %frame;
        .reg.u64 %sspslot;
        .reg.u64 %sspprev;
        {
                .reg.u32 %fstmp0;
                .reg.u64 %fstmp1;
                .reg.u64 %fstmp2;
                mov.u32 %fstmp0, %tid.y;
                mul.wide.u32 %fstmp1, %fstmp0, 8;
                mov.u64 %fstmp2, __nvptx_stacks;
                add.u64 %sspslot, %fstmp2, %fstmp1;
                ld.shared.u64 %sspprev, [%sspslot];
                sub.u64 %frame, %sspprev, 0;
                sub.u64 %stack, %frame, 0;
                st.shared.u64 [%sspslot], %stack;
        }
        .local.align 8 .b8 %simtstack_ar[136];
        .reg.u32 %r22;
        .reg.u32 %r23;
        .reg.u32 %r24;
        .reg.u32 %r25;
        .reg.u32 %r26;
        .reg.u64 %r28;
        .reg.u64 %r29;
        .reg.u64 %r30;
        .reg.u32 %r31;
        .reg.u32 %r34;
        .reg.u32 %r36;
        .reg.u32 %r37;
        .reg.u32 %r38;
        .reg.u64 %r39;
        .reg.u32 %r40;
        .reg.u32 %r43;
        .reg.u64 %r47;
        .reg.u32 %r48;
        .reg.u32 %r51;
        .reg.u32 %r54;
        .reg.u32 %r55;
        .reg.f32 %r57;
        .reg.f32 %r59;
        .reg.f32 %r61;
        .reg.u64 %r65;
        .reg.u32 %r68;
        .reg.u64 %r69;
        .reg.u32 %r70;
        .reg.u32 %r71;
        .reg.u32 %r72;
        .reg.pred %r73;
        .reg.pred %r75;
        .reg.pred %r76;
        .reg.pred %r80;
        .reg.pred %r81;
        .reg.u32 %r84;
        .reg.u64 %r85;
        .reg.u32 %r86;
        .reg.u32 %r87;
        .reg.u64 %r88;
        .reg.u64 %r89;
        .reg.u64 %r91;
        .reg.u64 %r92;
        .reg.u64 %r93;
        .reg.u64 %r94;
        .reg.f32 %r95;
        .reg.u64 %r96;
        .reg.u32 %r98;
        .reg.pred %r99;
        .reg.u64 %r101;
        .reg.u64 %r102;
        .reg.u64 %r103;
        .reg.u64 %r104;
        .reg.u64 %r105;
        .reg.pred %r106;
        .reg.pred %r107;
        .reg.pred %r108;
        .reg.u64 %r109;
        .reg.u64 %r111;
        .reg.f32 %r112;
        .reg.u64 %r113;
        .reg.f32 %r114;
        .reg.f32 %r115;
        .reg.f32 %r116;
        .reg.u64 %r117;
        .reg.u64 %r118;
        .reg.u64 %r120;
        .reg.f32 %r121;
        .reg.u64 %r122;
        .reg.f32 %r123;
        .reg.f32 %r124;
        .reg.f32 %r125;
        .reg.u64 %r126;
        .reg.u64 %r127;
        .reg.u64 %r129;
        .reg.f32 %r130;
        .reg.u64 %r131;
        .reg.f32 %r132;
        .reg.f32 %r133;
        .reg.f32 %r134;
        .reg.u64 %r135;
        .reg.pred %r136;
        .reg.u64 %r137;
        .reg.f32 %r138;
        .reg.u64 %r139;
        .reg.f32 %r140;
        .reg.f32 %r141;
        .reg.f32 %r142;
        .reg.u64 %r143;
        .reg.u64 %r145;
        .reg.f32 %r146;
        .reg.u64 %r147;
        .reg.f32 %r148;
        .reg.f32 %r149;
        .reg.f32 %r150;
        .reg.u64 %r151;
        .reg.u64 %r153;
        .reg.f32 %r154;
        .reg.u64 %r155;
        .reg.f32 %r156;
        .reg.f32 %r157;
        .reg.f32 %r158;
        .reg.u64 %r159;
        .reg.pred %r160;
        .reg.u64 %r162;
        {
                .reg.u32 %ustmp0;
                .reg.u64 %ustmp1;
                mov.u32 %ustmp0, %tid.y;
                mul.wide.u32 %ustmp1, %ustmp0, 4;
                mov.u64 %r162, __nvptx_uni;
                add.u64 %r162, %r162, %ustmp1;
        }
                mov.u64 %r69, %ar0;
                ld.u32  %r26, [%r69+36];
                ld.u32  %r31, [%r69+24];
        {
                .param.u32 %value_in;
                call (%value_in), omp_get_num_threads;
                ld.param.u32    %r70, [%value_in];
        }
        {
                .param.u32 %value_in;
                call (%value_in), omp_get_thread_num;
                ld.param.u32    %r71, [%value_in];
        }
                ld.u32  %r72, [%r69+32];
                sub.u32 %r34, %r72, %r26;
                div.s32 %r23, %r34, %r70;
                rem.s32 %r24, %r34, %r70;
                setp.lt.s32     %r73, %r71, %r24;
        @%r73   bra     $L2;
$L11:
                mad.lo.u32      %r36, %r23, %r71, %r24;
                add.u32 %r37, %r23, %r36;
                setp.ge.s32     %r75, %r36, %r37;
        @%r75   bra     $L12;
                ld.u64  %r28, [%r69+16];
                ld.u64  %r29, [%r69+8];
                ld.u64  %r30, [%r69];
                add.u32 %r38, %r26, %r36;
                add.u32 %r22, %r26, %r37;
        {
                .reg.u32 %ustmp2;
                mov.u32 %ustmp2, -1;
                st.shared.u32 [%r162], %ustmp2;
        }
        {
                cvta.local.u64 %r47, %simtstack_ar + 136;
                sub.u64 %r47, %r47, 0;
                st.u64 [%r47 + -8], %stack;
                sub.u64 %stack, %r47, 8;
        st.shared.u64   [%sspslot], %stack;
        }
                mov.u32 %r48, %laneid;
                add.u32 %r40, %r48, %r38;
                setp.gt.s32     %r76, %r22, %r40;
        @%r76   bra     $L4;
$L8:
                add.u32 %r51, %r40, -31;
                setp.eq.u32     %r80, %r31, %r51;
                vote.ballot.b32 %r54, %r80;
                setp.ne.u32     %r81, %r54, 0;
        @%r81   bra     $L5;
$L6:
        {
                .reg.u32 %ustmp2;
                mov.u32 %ustmp2, 0;
                st.shared.u32 [%r162], %ustmp2;
        }
        {
                ld.u64 %stack, [%r47 + -8];
        st.shared.u64   [%sspslot], %stack;
        }
                bra     $L3;
$L5:
                brev.b32        %r84, %r54;
                clz.b32 %r55, %r84;
                shfl.idx.b32    %r25, %r51, %r55, 31;
                bra     $L6;
$L4:
                cvt.s64.s32     %r85, %r40;
                shl.b64 %r65, %r85, 2;
                add.u32 %r86, %r22, -1;
                sub.u32 %r87, %r86, %r40;
                shr.u32 %r43, %r87, 5;
                cvt.u64.u32     %r88, %r43;
                shl.b64 %r89, %r88, 5;
                add.u64 %r91, %r85, 32;
                add.u64 %r92, %r89, %r91;
                shl.b64 %r39, %r92, 2;
                sub.u64 %r102, %r39, %r65;
                add.u64 %r103, %r102, -128;
                shr.u64 %r101, %r103, 7;
                add.u64 %r104, %r101, 1;
                and.b64 %r105, %r104, 3;
                setp.eq.u64     %r108, %r105, 0;
        @%r108  bra     $L7;
                setp.eq.u64     %r107, %r105, 1;
        @%r107  bra     $L23;
                setp.eq.u64     %r106, %r105, 2;
        @%r106  bra     $L24;
                bra     $L28;
$L7:
                add.u64 %r93, %r30, %r65;
                ld.f32  %r57, [%r93];
                add.u64 %r94, %r29, %r65;
                ld.f32  %r59, [%r94];
                mul.f32 %r95, %r59, %r59;
                fma.rn.f32      %r61, %r57, %r57, %r95;
                add.u64 %r96, %r28, %r65;
                st.f32  [%r96], %r61;
                add.u64 %r109, %r65, 128;
                add.u64 %r111, %r30, %r109;
                ld.f32  %r112, [%r111];
                add.u64 %r113, %r29, %r109;
                ld.f32  %r114, [%r113];
                mul.f32 %r115, %r114, %r114;
                fma.rn.f32      %r116, %r112, %r112, %r115;
                add.u64 %r117, %r28, %r109;
                st.f32  [%r117], %r116;
                add.u64 %r118, %r65, 256;
                add.u64 %r120, %r30, %r118;
                ld.f32  %r121, [%r120];
                add.u64 %r122, %r29, %r118;
                ld.f32  %r123, [%r122];
                mul.f32 %r124, %r123, %r123;
                fma.rn.f32      %r125, %r121, %r121, %r124;
                add.u64 %r126, %r28, %r118;
                st.f32  [%r126], %r125;
                add.u64 %r127, %r65, 384;
                add.u64 %r129, %r30, %r127;
                ld.f32  %r130, [%r129];
                add.u64 %r131, %r29, %r127;
                ld.f32  %r132, [%r131];
                mul.f32 %r133, %r132, %r132;
                fma.rn.f32      %r134, %r130, %r130, %r133;
                add.u64 %r135, %r28, %r127;
                st.f32  [%r135], %r134;
                add.u64 %r65, %r65, 512;
                setp.ne.u64     %r136, %r39, %r65;
        @%r136  bra     $L7;
$L29:
                add.u32 %r68, %r40, 32;
                shl.b32 %r98, %r43, 5;
                add.u32 %r40, %r98, %r68;
                bra     $L8;
$L12:
                mov.u32 %r22, 0;
$L3:
                setp.eq.u32     %r99, %r22, %r31;
        @!%r99  bra     $L1;
                st.u32  [%r69+28], %r25;
                bra     $L1;
$L2:
                add.u32 %r23, %r23, 1;
                mov.u32 %r24, 0;
                bra     $L11;
$L1:
        st.shared.u64   [%sspslot], %sspprev;
        ret;
$L28:
                add.u64 %r137, %r30, %r65;
                ld.f32  %r138, [%r137];
                add.u64 %r139, %r29, %r65;
                ld.f32  %r140, [%r139];
                mul.f32 %r141, %r140, %r140;
                fma.rn.f32      %r142, %r138, %r138, %r141;
                add.u64 %r143, %r28, %r65;
                st.f32  [%r143], %r142;
                add.u64 %r65, %r65, 128;
$L24:
                add.u64 %r145, %r30, %r65;
                ld.f32  %r146, [%r145];
                add.u64 %r147, %r29, %r65;
                ld.f32  %r148, [%r147];
                mul.f32 %r149, %r148, %r148;
                fma.rn.f32      %r150, %r146, %r146, %r149;
                add.u64 %r151, %r28, %r65;
                st.f32  [%r151], %r150;
                add.u64 %r65, %r65, 128;
$L23:
                add.u64 %r153, %r30, %r65;
                ld.f32  %r154, [%r153];
                add.u64 %r155, %r29, %r65;
                ld.f32  %r156, [%r155];
                mul.f32 %r157, %r156, %r156;
                fma.rn.f32      %r158, %r154, %r154, %r157;
                add.u64 %r159, %r28, %r65;
                st.f32  [%r159], %r158;
                add.u64 %r65, %r65, 128;
                setp.ne.u64     %r160, %r39, %r65;
        @%r160  bra     $L7;
                bra     $L29;
}
string-delimiter
      )

(define ptx-sample11-out
'((function
   "ComputePhiMagCPU$_omp_fn$1"
   (storage ".param" ".u64" "%in_ar0")
   (storageN ".reg" ".u64" "%ar0")
   (instruction "ld" ".param" ".u64" "%ar0" "[%in_ar0]")
   (storageN ".reg" ".u64" "%stack")
   (storageN ".reg" ".u64" "%frame")
   (storageN ".reg" ".u64" "%sspslot")
   (storageN ".reg" ".u64" "%sspprev")
   (group
    (storageN ".reg" ".u32" "%fstmp0")
    (storageN ".reg" ".u64" "%fstmp1")
    (storageN ".reg" ".u64" "%fstmp2")
    (instruction "mov" ".u32" "%fstmp0" "%tid.y")
    (instruction "mul" ".wide" ".u32" "%fstmp1" "%fstmp0" "8")
    (instruction "mov" ".u64" "%fstmp2" "__nvptx_stacks")
    (instruction "add" ".u64" "%sspslot" "%fstmp2" "%fstmp1")
    (instruction "ld" ".shared" ".u64" "%sspprev" "[%sspslot]")
    (instruction "sub" ".u64" "%frame" "%sspprev" "0")
    (instruction "sub" ".u64" "%stack" "%frame" "0")
    (instruction "st" ".shared" ".u64" "[%sspslot]" "%stack"))
   (storageN ".local" ".align 8" ".b8" "%simtstack_ar[136]")
   (storageN ".reg" ".u32" "%r22")
   (storageN ".reg" ".u32" "%r23")
   (storageN ".reg" ".u32" "%r24")
   (storageN ".reg" ".u32" "%r25")
   (storageN ".reg" ".u32" "%r26")
   (storageN ".reg" ".u64" "%r28")
   (storageN ".reg" ".u64" "%r29")
   (storageN ".reg" ".u64" "%r30")
   (storageN ".reg" ".u32" "%r31")
   (storageN ".reg" ".u32" "%r34")
   (storageN ".reg" ".u32" "%r36")
   (storageN ".reg" ".u32" "%r37")
   (storageN ".reg" ".u32" "%r38")
   (storageN ".reg" ".u64" "%r39")
   (storageN ".reg" ".u32" "%r40")
   (storageN ".reg" ".u32" "%r43")
   (storageN ".reg" ".u64" "%r47")
   (storageN ".reg" ".u32" "%r48")
   (storageN ".reg" ".u32" "%r51")
   (storageN ".reg" ".u32" "%r54")
   (storageN ".reg" ".u32" "%r55")
   (storageN ".reg" ".f32" "%r57")
   (storageN ".reg" ".f32" "%r59")
   (storageN ".reg" ".f32" "%r61")
   (storageN ".reg" ".u64" "%r65")
   (storageN ".reg" ".u32" "%r68")
   (storageN ".reg" ".u64" "%r69")
   (storageN ".reg" ".u32" "%r70")
   (storageN ".reg" ".u32" "%r71")
   (storageN ".reg" ".u32" "%r72")
   (storageN ".reg" ".pred" "%r73")
   (storageN ".reg" ".pred" "%r75")
   (storageN ".reg" ".pred" "%r76")
   (storageN ".reg" ".pred" "%r80")
   (storageN ".reg" ".pred" "%r81")
   (storageN ".reg" ".u32" "%r84")
   (storageN ".reg" ".u64" "%r85")
   (storageN ".reg" ".u32" "%r86")
   (storageN ".reg" ".u32" "%r87")
   (storageN ".reg" ".u64" "%r88")
   (storageN ".reg" ".u64" "%r89")
   (storageN ".reg" ".u64" "%r91")
   (storageN ".reg" ".u64" "%r92")
   (storageN ".reg" ".u64" "%r93")
   (storageN ".reg" ".u64" "%r94")
   (storageN ".reg" ".f32" "%r95")
   (storageN ".reg" ".u64" "%r96")
   (storageN ".reg" ".u32" "%r98")
   (storageN ".reg" ".pred" "%r99")
   (storageN ".reg" ".u64" "%r101")
   (storageN ".reg" ".u64" "%r102")
   (storageN ".reg" ".u64" "%r103")
   (storageN ".reg" ".u64" "%r104")
   (storageN ".reg" ".u64" "%r105")
   (storageN ".reg" ".pred" "%r106")
   (storageN ".reg" ".pred" "%r107")
   (storageN ".reg" ".pred" "%r108")
   (storageN ".reg" ".u64" "%r109")
   (storageN ".reg" ".u64" "%r111")
   (storageN ".reg" ".f32" "%r112")
   (storageN ".reg" ".u64" "%r113")
   (storageN ".reg" ".f32" "%r114")
   (storageN ".reg" ".f32" "%r115")
   (storageN ".reg" ".f32" "%r116")
   (storageN ".reg" ".u64" "%r117")
   (storageN ".reg" ".u64" "%r118")
   (storageN ".reg" ".u64" "%r120")
   (storageN ".reg" ".f32" "%r121")
   (storageN ".reg" ".u64" "%r122")
   (storageN ".reg" ".f32" "%r123")
   (storageN ".reg" ".f32" "%r124")
   (storageN ".reg" ".f32" "%r125")
   (storageN ".reg" ".u64" "%r126")
   (storageN ".reg" ".u64" "%r127")
   (storageN ".reg" ".u64" "%r129")
   (storageN ".reg" ".f32" "%r130")
   (storageN ".reg" ".u64" "%r131")
   (storageN ".reg" ".f32" "%r132")
   (storageN ".reg" ".f32" "%r133")
   (storageN ".reg" ".f32" "%r134")
   (storageN ".reg" ".u64" "%r135")
   (storageN ".reg" ".pred" "%r136")
   (storageN ".reg" ".u64" "%r137")
   (storageN ".reg" ".f32" "%r138")
   (storageN ".reg" ".u64" "%r139")
   (storageN ".reg" ".f32" "%r140")
   (storageN ".reg" ".f32" "%r141")
   (storageN ".reg" ".f32" "%r142")
   (storageN ".reg" ".u64" "%r143")
   (storageN ".reg" ".u64" "%r145")
   (storageN ".reg" ".f32" "%r146")
   (storageN ".reg" ".u64" "%r147")
   (storageN ".reg" ".f32" "%r148")
   (storageN ".reg" ".f32" "%r149")
   (storageN ".reg" ".f32" "%r150")
   (storageN ".reg" ".u64" "%r151")
   (storageN ".reg" ".u64" "%r153")
   (storageN ".reg" ".f32" "%r154")
   (storageN ".reg" ".u64" "%r155")
   (storageN ".reg" ".f32" "%r156")
   (storageN ".reg" ".f32" "%r157")
   (storageN ".reg" ".f32" "%r158")
   (storageN ".reg" ".u64" "%r159")
   (storageN ".reg" ".pred" "%r160")
   (storageN ".reg" ".u64" "%r162")
   (group
    (storageN ".reg" ".u32" "%ustmp0")
    (storageN ".reg" ".u64" "%ustmp1")
    (instruction "mov" ".u32" "%ustmp0" "%tid.y")
    (instruction "mul" ".wide" ".u32" "%ustmp1" "%ustmp0" "4")
    (instruction "mov" ".u64" "%r162" "__nvptx_uni")
    (instruction "add" ".u64" "%r162" "%r162" "%ustmp1"))
   (instruction "mov" ".u64" "%r69" "%ar0")
   (instruction "ld" ".u32" "%r26" "[%r69+36]")
   (instruction "ld" ".u32" "%r31" "[%r69+24]")
   (group
    (storageN ".param" ".u32" "%value_in")
    (instruction "call" "(%value_in)" "omp_get_num_threads")
    (instruction "ld" ".param" ".u32" "%r70" "[%value_in]"))
   (group
    (storageN ".param" ".u32" "%value_in")
    (instruction "call" "(%value_in)" "omp_get_thread_num")
    (instruction "ld" ".param" ".u32" "%r71" "[%value_in]"))
   (instruction "ld" ".u32" "%r72" "[%r69+32]")
   (instruction "sub" ".u32" "%r34" "%r72" "%r26")
   (instruction "div" ".s32" "%r23" "%r34" "%r70")
   (instruction "rem" ".s32" "%r24" "%r34" "%r70")
   (instruction "setp" ".lt" ".s32" "%r73" "%r71" "%r24")
   "@%r73"
   (instruction "bra" "$L2")
   "$L11:"
   (instruction "mad" ".lo" ".u32" "%r36" "%r23" "%r71" "%r24")
   (instruction "add" ".u32" "%r37" "%r23" "%r36")
   (instruction "setp" ".ge" ".s32" "%r75" "%r36" "%r37")
   "@%r75"
   (instruction "bra" "$L12")
   (instruction "ld" ".u64" "%r28" "[%r69+16]")
   (instruction "ld" ".u64" "%r29" "[%r69+8]")
   (instruction "ld" ".u64" "%r30" "[%r69]")
   (instruction "add" ".u32" "%r38" "%r26" "%r36")
   (instruction "add" ".u32" "%r22" "%r26" "%r37")
   (group
    (storageN ".reg" ".u32" "%ustmp2")
    (instruction "mov" ".u32" "%ustmp2" "-1")
    (instruction "st" ".shared" ".u32" "[%r162]" "%ustmp2"))
   (group
    (instruction "cvta" ".local" ".u64" "%r47" "%simtstack_ar+136")
    (instruction "sub" ".u64" "%r47" "%r47" "0")
    (instruction "st" ".u64" "[%r47+-8]" "%stack")
    (instruction "sub" ".u64" "%stack" "%r47" "8")
    (instruction "st" ".shared" ".u64" "[%sspslot]" "%stack"))
   (instruction "mov" ".u32" "%r48" "%laneid")
   (instruction "add" ".u32" "%r40" "%r48" "%r38")
   (instruction "setp" ".gt" ".s32" "%r76" "%r22" "%r40")
   "@%r76"
   (instruction "bra" "$L4")
   "$L8:"
   (instruction "add" ".u32" "%r51" "%r40" "-31")
   (instruction "setp" ".eq" ".u32" "%r80" "%r31" "%r51")
   (instruction "vote" ".ballot" ".b32" "%r54" "%r80")
   (instruction "setp" ".ne" ".u32" "%r81" "%r54" "0")
   "@%r81"
   (instruction "bra" "$L5")
   "$L6:"
   (group
    (storageN ".reg" ".u32" "%ustmp2")
    (instruction "mov" ".u32" "%ustmp2" "0")
    (instruction "st" ".shared" ".u32" "[%r162]" "%ustmp2"))
   (group
    (instruction "ld" ".u64" "%stack" "[%r47+-8]")
    (instruction "st" ".shared" ".u64" "[%sspslot]" "%stack"))
   (instruction "bra" "$L3")
   "$L5:"
   (instruction "brev" ".b32" "%r84" "%r54")
   (instruction "clz" ".b32" "%r55" "%r84")
   (instruction "shfl" ".idx" ".b32" "%r25" "%r51" "%r55" "31")
   (instruction "bra" "$L6")
   "$L4:"
   (instruction "cvt" ".s64" ".s32" "%r85" "%r40")
   (instruction "shl" ".b64" "%r65" "%r85" "2")
   (instruction "add" ".u32" "%r86" "%r22" "-1")
   (instruction "sub" ".u32" "%r87" "%r86" "%r40")
   (instruction "shr" ".u32" "%r43" "%r87" "5")
   (instruction "cvt" ".u64" ".u32" "%r88" "%r43")
   (instruction "shl" ".b64" "%r89" "%r88" "5")
   (instruction "add" ".u64" "%r91" "%r85" "32")
   (instruction "add" ".u64" "%r92" "%r89" "%r91")
   (instruction "shl" ".b64" "%r39" "%r92" "2")
   (instruction "sub" ".u64" "%r102" "%r39" "%r65")
   (instruction "add" ".u64" "%r103" "%r102" "-128")
   (instruction "shr" ".u64" "%r101" "%r103" "7")
   (instruction "add" ".u64" "%r104" "%r101" "1")
   (instruction "and" ".b64" "%r105" "%r104" "3")
   (instruction "setp" ".eq" ".u64" "%r108" "%r105" "0")
   "@%r108"
   (instruction "bra" "$L7")
   (instruction "setp" ".eq" ".u64" "%r107" "%r105" "1")
   "@%r107"
   (instruction "bra" "$L23")
   (instruction "setp" ".eq" ".u64" "%r106" "%r105" "2")
   "@%r106"
   (instruction "bra" "$L24")
   (instruction "bra" "$L28")
   "$L7:"
   (instruction "add" ".u64" "%r93" "%r30" "%r65")
   (instruction "ld" ".f32" "%r57" "[%r93]")
   (instruction "add" ".u64" "%r94" "%r29" "%r65")
   (instruction "ld" ".f32" "%r59" "[%r94]")
   (instruction "mul" ".f32" "%r95" "%r59" "%r59")
   (instruction "fma" ".rn" ".f32" "%r61" "%r57" "%r57" "%r95")
   (instruction "add" ".u64" "%r96" "%r28" "%r65")
   (instruction "st" ".f32" "[%r96]" "%r61")
   (instruction "add" ".u64" "%r109" "%r65" "128")
   (instruction "add" ".u64" "%r111" "%r30" "%r109")
   (instruction "ld" ".f32" "%r112" "[%r111]")
   (instruction "add" ".u64" "%r113" "%r29" "%r109")
   (instruction "ld" ".f32" "%r114" "[%r113]")
   (instruction "mul" ".f32" "%r115" "%r114" "%r114")
   (instruction "fma" ".rn" ".f32" "%r116" "%r112" "%r112" "%r115")
   (instruction "add" ".u64" "%r117" "%r28" "%r109")
   (instruction "st" ".f32" "[%r117]" "%r116")
   (instruction "add" ".u64" "%r118" "%r65" "256")
   (instruction "add" ".u64" "%r120" "%r30" "%r118")
   (instruction "ld" ".f32" "%r121" "[%r120]")
   (instruction "add" ".u64" "%r122" "%r29" "%r118")
   (instruction "ld" ".f32" "%r123" "[%r122]")
   (instruction "mul" ".f32" "%r124" "%r123" "%r123")
   (instruction "fma" ".rn" ".f32" "%r125" "%r121" "%r121" "%r124")
   (instruction "add" ".u64" "%r126" "%r28" "%r118")
   (instruction "st" ".f32" "[%r126]" "%r125")
   (instruction "add" ".u64" "%r127" "%r65" "384")
   (instruction "add" ".u64" "%r129" "%r30" "%r127")
   (instruction "ld" ".f32" "%r130" "[%r129]")
   (instruction "add" ".u64" "%r131" "%r29" "%r127")
   (instruction "ld" ".f32" "%r132" "[%r131]")
   (instruction "mul" ".f32" "%r133" "%r132" "%r132")
   (instruction "fma" ".rn" ".f32" "%r134" "%r130" "%r130" "%r133")
   (instruction "add" ".u64" "%r135" "%r28" "%r127")
   (instruction "st" ".f32" "[%r135]" "%r134")
   (instruction "add" ".u64" "%r65" "%r65" "512")
   (instruction "setp" ".ne" ".u64" "%r136" "%r39" "%r65")
   "@%r136"
   (instruction "bra" "$L7")
   "$L29:"
   (instruction "add" ".u32" "%r68" "%r40" "32")
   (instruction "shl" ".b32" "%r98" "%r43" "5")
   (instruction "add" ".u32" "%r40" "%r98" "%r68")
   (instruction "bra" "$L8")
   "$L12:"
   (instruction "mov" ".u32" "%r22" "0")
   "$L3:"
   (instruction "setp" ".eq" ".u32" "%r99" "%r22" "%r31")
   "@!%r99"
   (instruction "bra" "$L1")
   (instruction "st" ".u32" "[%r69+28]" "%r25")
   (instruction "bra" "$L1")
   "$L2:"
   (instruction "add" ".u32" "%r23" "%r23" "1")
   (instruction "mov" ".u32" "%r24" "0")
   (instruction "bra" "$L11")
   "$L1:"
   (instruction "st" ".shared" ".u64" "[%sspslot]" "%sspprev")
   (instruction "ret")
   "$L28:"
   (instruction "add" ".u64" "%r137" "%r30" "%r65")
   (instruction "ld" ".f32" "%r138" "[%r137]")
   (instruction "add" ".u64" "%r139" "%r29" "%r65")
   (instruction "ld" ".f32" "%r140" "[%r139]")
   (instruction "mul" ".f32" "%r141" "%r140" "%r140")
   (instruction "fma" ".rn" ".f32" "%r142" "%r138" "%r138" "%r141")
   (instruction "add" ".u64" "%r143" "%r28" "%r65")
   (instruction "st" ".f32" "[%r143]" "%r142")
   (instruction "add" ".u64" "%r65" "%r65" "128")
   "$L24:"
   (instruction "add" ".u64" "%r145" "%r30" "%r65")
   (instruction "ld" ".f32" "%r146" "[%r145]")
   (instruction "add" ".u64" "%r147" "%r29" "%r65")
   (instruction "ld" ".f32" "%r148" "[%r147]")
   (instruction "mul" ".f32" "%r149" "%r148" "%r148")
   (instruction "fma" ".rn" ".f32" "%r150" "%r146" "%r146" "%r149")
   (instruction "add" ".u64" "%r151" "%r28" "%r65")
   (instruction "st" ".f32" "[%r151]" "%r150")
   (instruction "add" ".u64" "%r65" "%r65" "128")
   "$L23:"
   (instruction "add" ".u64" "%r153" "%r30" "%r65")
   (instruction "ld" ".f32" "%r154" "[%r153]")
   (instruction "add" ".u64" "%r155" "%r29" "%r65")
   (instruction "ld" ".f32" "%r156" "[%r155]")
   (instruction "mul" ".f32" "%r157" "%r156" "%r156")
   (instruction "fma" ".rn" ".f32" "%r158" "%r154" "%r154" "%r157")
   (instruction "add" ".u64" "%r159" "%r28" "%r65")
   (instruction "st" ".f32" "[%r159]" "%r158")
   (instruction "add" ".u64" "%r65" "%r65" "128")
   (instruction "setp" ".ne" ".u64" "%r160" "%r39" "%r65")
   "@%r160"
   (instruction "bra" "$L7")
   (instruction "bra" "$L29")))
  )

(define ptx-sample12
  #<<string-delimiter
.weak .entry __omp_offloading_2e_736d7c30_cpu_stencil_l15(
        .param .u64 __omp_offloading_2e_736d7c30_cpu_stencil_l15_param_0,
        .param .u64 __omp_offloading_2e_736d7c30_cpu_stencil_l15_param_1,
        .param .u64 __omp_offloading_2e_736d7c30_cpu_stencil_l15_param_2,
        .param .u64 __omp_offloading_2e_736d7c30_cpu_stencil_l15_param_3,
        .param .u64 __omp_offloading_2e_736d7c30_cpu_stencil_l15_param_4,
        .param .u64 __omp_offloading_2e_736d7c30_cpu_stencil_l15_param_5,
        .param .u64 __omp_offloading_2e_736d7c30_cpu_stencil_l15_param_6
)
{
        .reg .pred      %p<29>;
        .reg .b16       %rs<6>;
        .reg .f32       %f<18>;
        .reg .b32       %r<98>;
        .reg .b64       %rd<162>;

        .shared .align 8 .b8 omptarget_nvptx_globalArgs[176];

        .shared .align 8 .b8 DataSharingState[896];

        .shared .align 4 .u32 usedSlotIdx;

        .shared .align 8 .u64 omptarget_nvptx_workFn;

        .shared .align 1 .b8 parallelLevel[32];

        .shared .align 8 .u64 omptarget_nvptx_threadPrivateContext;
        mov.u32         %r1, %tid.x;
        mov.u32         %r2, %ntid.x;
        mov.u32         %r3, WARP_SZ;
        sub.s32         %r23, %r2, %r3;
        setp.ge.u32     %p2, %r1, %r23;
        @%p2 bra        LBB0_11;
        cvt.s64.s32     %rd3, %r1;
        cvt.u16.u32     %rs1, %r1;
        shr.s32         %r85, %r1, 31;
        shr.u32         %r86, %r85, 27;
        add.s32         %r87, %r1, %r86;
        shr.s32         %r88, %r87, 5;
        cvt.u64.u32     %rd134, %r88;
        mov.u64         %rd135, parallelLevel;
        add.s64         %rd4, %rd135, %rd134;
        add.s32         %r89, %r2, -1;
        and.b32         %r90, %r89, -32;
        setp.lt.s32     %p20, %r1, %r90;
        selp.b32        %r91, %r1, 0, %p20;
        cvt.s64.s32     %rd5, %r91;
        mov.pred        %p21, 0;
        mov.u32         %r92, 0;
        shl.b64         %rd145, %rd5, 3;
        setp.gt.s32     %p24, %r1, -1;
        mov.pred        %p25, -1;
        bra.uni         LBB0_2;
LBB0_9:
        {
        .reg .b32 temp_param_reg;
        .param .b32 param0;
        st.param.b32    [param0+0], %r92;
        .param .b32 param1;
        st.param.b32    [param1+0], %r94;
        prototype_0 : .callprototype ()_ (.param .b32 _, .param .b32 _);
        call
        %rd6,
        (
        param0,
        param1
        )
        , prototype_0;
        }
        ld.shared.u64   %rd148, [omptarget_nvptx_threadPrivateContext];
        shl.b64         %rd149, %rd3, 3;
        add.s64         %rd150, %rd148, %rd149;
        ld.u64  %rd151, [%rd150+328832];
        ld.u64  %rd152, [%rd151+56];
        st.u64  [%rd150+328832], %rd152;
LBB0_10:
        bar.sync        0;
LBB0_2:
        bar.sync        0;
        ld.volatile.shared.u64  %rd6, [omptarget_nvptx_workFn];
        setp.eq.s64     %p22, %rd6, 0;
        mov.pred        %p28, %p21;
        @%p22 bra       LBB0_5;
        mov.pred        %p28, %p21;
        @%p24 bra       LBB0_5;
        ld.shared.u64   %rd7, [omptarget_nvptx_threadPrivateContext];
        shl.b64         %rd136, %rd3, 6;
        add.s64         %rd137, %rd7, %rd136;
        add.s64         %rd138, %rd137, 263296;
        ld.u64  %rd139, [%rd7+112];
        st.u64  [%rd137+263344], %rd139;
        ld.u64  %rd140, [%rd7+104];
        st.u64  [%rd137+263336], %rd140;
        ld.u64  %rd141, [%rd7+120];
        st.u64  [%rd137+263352], %rd141;
        st.u16  [%rd137+263338], %rs1;
        shl.b64         %rd142, %rd3, 3;
        add.s64         %rd143, %rd7, %rd142;
        st.u64  [%rd143+328832], %rd138;
        mov.pred        %p28, %p25;
LBB0_5:
        @%p22 bra       LBB0_37;
        @!%p28 bra      LBB0_10;
        bra.uni         LBB0_7;
LBB0_7:
        ld.shared.u8    %rs4, [%rd4];
        and.b16         %rs5, %rs4, 126;
        setp.ne.s16     %p27, %rs5, 0;
        mov.u32         %r94, %r92;
        @%p27 bra       LBB0_9;
        ld.shared.u64   %rd144, [omptarget_nvptx_threadPrivateContext];
        add.s64         %rd146, %rd144, %rd145;
        ld.u64  %rd147, [%rd146+328832];
        ld.u16  %r94, [%rd147+42];
        bra.uni         LBB0_9;
LBB0_11:
        add.s32         %r6, %r2, -1;
        neg.s32         %r24, %r3;
        and.b32         %r25, %r6, %r24;
        setp.ne.s32     %p3, %r1, %r25;
        @%p3 bra        LBB0_37;
        ld.param.u64    %rd56, [__omp_offloading_2e_736d7c30_cpu_stencil_l15_param_6];
        ld.param.u64    %rd55, [__omp_offloading_2e_736d7c30_cpu_stencil_l15_param_5];
        ld.param.u64    %rd54, [__omp_offloading_2e_736d7c30_cpu_stencil_l15_param_2];
        ld.param.u64    %rd53, [__omp_offloading_2e_736d7c30_cpu_stencil_l15_param_1];
        ld.param.u64    %rd52, [__omp_offloading_2e_736d7c30_cpu_stencil_l15_param_0];
        ld.param.u64    %rd57, [__omp_offloading_2e_736d7c30_cpu_stencil_l15_param_4];
        cvta.to.global.u64      %rd1, %rd57;
        ld.param.u64    %rd58, [__omp_offloading_2e_736d7c30_cpu_stencil_l15_param_3];
        cvta.to.global.u64      %rd2, %rd58;
        mov.u64         %rd153, 0;
        mov.u64         %rd60, parallelLevel;
        mov.u16         %rs2, 0;
LBB0_13:
        .pragma "nounroll";
        add.s64         %rd61, %rd60, %rd153;
        st.shared.u8    [%rd61], %rs2;
        add.s64         %rd153, %rd153, 1;
        cvt.u32.u64     %r26, %rd153;
        setp.eq.s32     %p4, %r26, 32;
        @%p4 bra        LBB0_14;
        bra.uni         LBB0_13;
LBB0_14:

        mov.u32 %r27, %smid;

        shr.u32         %r28, %r27, 2;
        mul.hi.u32      %r29, %r28, 818089009;
        shr.u32         %r30, %r29, 2;
        mul.lo.s32      %r31, %r30, 84;
        sub.s32         %r32, %r27, %r31;
        st.shared.u32   [usedSlotIdx], %r32;
        cvt.u64.u32     %rd8, %r32;
        mul.wide.u32    %rd62, %r32, 12030864;
        mov.u64         %rd63, omptarget_nvptx_device_State;
        add.s64         %rd64, %rd63, %rd62;
        add.s64         %rd65, %rd64, 12030720;
        atom.global.add.u32     %r33, [%rd65], 1;
        and.b32         %r34, %r33, 31;
        shr.u32         %r7, %r33, 4;
        and.b32         %r8, %r7, 268435454;
        cvt.u64.u32     %rd9, %r34;
        mul.wide.u32    %rd66, %r34, 4;
        add.s64         %rd67, %rd64, %rd66;
        add.s64         %rd10, %rd67, 12030724;
LBB0_15:
        .pragma "nounroll";
        atom.global.or.b32      %r35, [%rd10], 0;
        setp.eq.s32     %p5, %r35, %r8;
        @%p5 bra        LBB0_16;
        bra.uni         LBB0_15;
LBB0_16:
        mul.lo.s64      %rd70, %rd8, 12030864;
        add.s64         %rd72, %rd63, %rd70;
        shl.b64         %rd73, %rd9, 3;
        add.s64         %rd74, %rd72, %rd73;
        add.s64         %rd75, %rd74, 12030464;
        atom.global.or.b64      %rd76, [%rd75], 0;
        setp.eq.s64     %p6, %rd76, 0;
        mul.lo.s64      %rd77, %rd9, 375952;
        add.s64         %rd78, %rd72, %rd77;
        cvta.global.u64         %rd79, %rd78;
        selp.b64        %rd80, %rd79, %rd76, %p6;
        and.b32         %r36, %r7, 33554430;
        or.b32          %r37, %r36, 1;
        atom.global.exch.b32    %r38, [%rd10], %r37;
        st.shared.u64   [omptarget_nvptx_threadPrivateContext], %rd80;
        and.b32         %r39, %r6, -32;
        setp.lt.s32     %p7, %r1, %r39;
        selp.b32        %r40, %r1, 0, %p7;
        mul.wide.s32    %rd81, %r40, 8;
        add.s64         %rd82, %rd80, %rd81;
        mul.wide.s32    %rd83, %r40, 2;
        add.s64         %rd84, %rd80, %rd83;
        st.u16  [%rd84+337024], %rs2;
        st.u8   [%rd80+40], %rs2;
        st.u16  [%rd80+42], %rs2;
        mov.u64         %rd85, 1;
        st.u64  [%rd80+48], %rd85;
        st.u64  [%rd82+328832], %rd80;
        mov.u64         %rd86, DataSharingState;
        add.s64         %rd154, %rd86, 256;
        mov.u64         %rd69, 0;
        ld.shared.u64   %rd13, [omptarget_nvptx_threadPrivateContext];
        mov.u64         %rd155, %rd69;
LBB0_17:
        .pragma "nounroll";
        add.s64         %rd87, %rd13, %rd155;
        add.s64         %rd88, %rd87, 160;
        add.s64         %rd89, %rd87, 8352;
        add.s64         %rd90, %rd87, 128;
        st.v2.u64       [%rd87+128], {%rd69, %rd69};
        st.v2.u64       [%rd87+144], {%rd69, %rd89};
        st.shared.u64   [%rd154+-256], %rd90;
        st.shared.u64   [%rd154], %rd88;
        add.s64         %rd155, %rd155, 8224;
        cvt.u32.u64     %r41, %rd155;
        add.s64         %rd154, %rd154, 8;
        setp.ne.s32     %p8, %r41, 263168;
        @%p8 bra        LBB0_17;
        mov.u64         %rd92, omptarget_nvptx_globalArgs;
        cvta.shared.u64         %rd93, %rd92;
        st.shared.u64   [omptarget_nvptx_globalArgs+160], %rd93;
        mov.u32         %r42, 20;
        st.shared.u32   [omptarget_nvptx_globalArgs+168], %r42;
        cvt.u32.u64     %r43, %rd52;
        cvt.u32.u64     %r9, %rd53;
        setp.gt.s32     %p9, %r43, 2;
        setp.gt.s32     %p10, %r9, 2;
        and.pred        %p11, %p9, %p10;
        @!%p11 bra      LBB0_34;
        bra.uni         LBB0_19;
LBB0_19:
        shl.b64         %rd94, %rd52, 32;
        add.s64         %rd95, %rd94, -8589934592;
        shr.s64         %rd96, %rd95, 32;
        shl.b64         %rd97, %rd53, 32;
        add.s64         %rd98, %rd97, -8589934592;
        shr.s64         %rd18, %rd98, 32;
        mul.lo.s64      %rd19, %rd18, %rd96;
        mov.u32         %r46, %ctaid.x;
        cvt.s64.s32     %rd20, %r46;
        mov.u32         %r47, %nctaid.x;
        cvt.s64.s32     %rd21, %r47;
        or.b64          %rd99, %rd19, %rd21;
        and.b64         %rd100, %rd99, -4294967296;
        setp.ne.s64     %p12, %rd100, 0;
        @%p12 bra       LBB0_21;
        bra.uni         LBB0_20;
LBB0_21:
        div.s64         %rd156, %rd19, %rd21;
        bra.uni         LBB0_22;
LBB0_20:
        cvt.u32.u64     %r48, %rd21;
        cvt.u32.u64     %r49, %rd19;
        div.u32         %r50, %r49, %r48;
        cvt.u64.u32     %rd156, %r50;
LBB0_22:
        mul.lo.s64      %rd101, %rd156, %rd21;
        sub.s64         %rd25, %rd19, %rd101;
        setp.le.s64     %p13, %rd25, %rd20;
        @%p13 bra       LBB0_24;
        add.s64         %rd157, %rd156, 1;
        mul.lo.s64      %rd159, %rd157, %rd20;
        bra.uni         LBB0_25;
LBB0_24:
        mul.lo.s64      %rd102, %rd156, %rd20;
        add.s64         %rd159, %rd25, %rd102;
        mov.u64         %rd157, %rd156;
LBB0_25:
        add.s64         %rd103, %rd159, %rd157;
        min.s64         %rd31, %rd103, %rd19;
        setp.ge.s64     %p14, %rd159, %rd31;
        @%p14 bra       LBB0_34;
        cvt.u32.u64     %r44, %rd55;
        cvt.u32.u64     %r45, %rd56;
        cvt.u32.u64     %r10, %rd54;
        mov.b32         %f1, %r44;
        mov.b32         %f2, %r45;
        cvt.u32.u64     %r51, %rd20;
        add.s32         %r11, %r10, -2;
        add.s64         %rd32, %rd1, 4;
        cvt.u32.u64     %r52, %rd156;
        min.s64         %rd104, %rd25, %rd20;
        cvt.u32.u64     %r53, %rd104;
        mad.lo.s32      %r54, %r51, %r52, %r53;
        neg.s64         %rd33, %rd18;
        add.s32         %r96, %r54, 2;
        add.s32         %r95, %r54, 1;
        add.s64         %rd34, %rd2, 4;
        add.s64         %rd35, %rd1, 8;
        setp.lt.s32     %p16, %r10, 3;
        bra.uni         LBB0_27;
LBB0_33:
        add.s64         %rd159, %rd159, 1;
        add.s32         %r96, %r96, 1;
        add.s32         %r95, %r95, 1;
        setp.lt.s64     %p18, %rd159, %rd31;
        @%p18 bra       LBB0_27;
        bra.uni         LBB0_34;
LBB0_27:
        cvt.u32.u64     %r16, %rd159;
        or.b64          %rd105, %rd159, %rd18;
        and.b64         %rd106, %rd105, -4294967296;
        setp.ne.s64     %p15, %rd106, 0;
        @%p15 bra       LBB0_29;
        bra.uni         LBB0_28;
LBB0_29:
        div.s64         %rd160, %rd159, %rd18;
        bra.uni         LBB0_30;
LBB0_28:
        cvt.u32.u64     %r55, %rd18;
        div.u32         %r57, %r16, %r55;
        cvt.u64.u32     %rd160, %r57;
LBB0_30:
        @%p16 bra       LBB0_33;
        cvt.u32.u64     %r17, %rd160;
        add.s32         %r58, %r17, 2;
        mul.lo.s32      %r59, %r17, %r9;
        add.s32         %r60, %r59, %r9;
        add.s32         %r61, %r16, %r60;
        mul.lo.s64      %rd108, %rd33, %rd160;
        cvt.u32.u64     %r62, %rd108;
        add.s32         %r63, %r61, %r62;
        mul.lo.s32      %r64, %r10, %r63;
        mul.wide.s32    %rd109, %r64, 4;
        add.s64         %rd40, %rd32, %rd109;
        add.s32         %r65, %r96, %r60;
        add.s32         %r66, %r65, %r62;
        mul.lo.s32      %r67, %r10, %r66;
        mul.wide.s32    %rd110, %r67, 4;
        add.s64         %rd41, %rd32, %rd110;
        add.s32         %r68, %r95, %r59;
        add.s32         %r69, %r68, %r62;
        mul.lo.s32      %r70, %r10, %r69;
        mul.wide.s32    %rd111, %r70, 4;
        add.s64         %rd42, %rd32, %rd111;
        mad.lo.s32      %r71, %r9, %r58, %r95;
        add.s32         %r72, %r71, %r62;
        mul.lo.s32      %r73, %r10, %r72;
        mul.wide.s32    %rd112, %r73, 4;
        add.s64         %rd43, %rd32, %rd112;
        add.s32         %r74, %r95, %r60;
        add.s32         %r75, %r74, %r62;
        mul.lo.s32      %r76, %r10, %r75;
        mul.wide.s32    %rd113, %r76, 4;
        add.s64         %rd44, %rd34, %rd113;
        add.s64         %rd45, %rd35, %rd113;
        mov.u64         %rd161, 0;
        mov.u32         %r97, %r11;
LBB0_32:
        add.s64         %rd114, %rd43, %rd161;
        ld.global.f32   %f3, [%rd114];
        add.s64         %rd115, %rd42, %rd161;
        ld.global.f32   %f4, [%rd115];
        add.rn.f32      %f5, %f3, %f4;
        add.s64         %rd116, %rd41, %rd161;
        ld.global.f32   %f6, [%rd116];
        add.rn.f32      %f7, %f5, %f6;
        add.s64         %rd117, %rd40, %rd161;
        ld.global.f32   %f8, [%rd117];
        add.rn.f32      %f9, %f7, %f8;
        add.s64         %rd118, %rd45, %rd161;
        ld.global.f32   %f10, [%rd118];
        add.rn.f32      %f11, %f9, %f10;
        ld.global.f32   %f12, [%rd118+-8];
        add.rn.f32      %f13, %f11, %f12;
        mul.rn.f32      %f14, %f13, %f1;
        ld.global.f32   %f15, [%rd118+-4];
        mul.rn.f32      %f16, %f15, %f2;
        sub.rn.f32      %f17, %f14, %f16;
        add.s64         %rd119, %rd44, %rd161;
        st.global.f32   [%rd119], %f17;
        add.s64         %rd161, %rd161, 4;
        add.s32         %r97, %r97, -1;
        setp.ne.s32     %p17, %r97, 0;
        @%p17 bra       LBB0_32;
        bra.uni         LBB0_33;
LBB0_34:
        ld.shared.u32   %r77, [usedSlotIdx];
        cvt.s64.s32     %rd49, %r77;
        mul.wide.s32    %rd120, %r77, 12030864;
        add.s64         %rd122, %rd63, %rd120;
        add.s64         %rd123, %rd122, 12030852;
        atom.global.add.u32     %r78, [%rd123], 1;
        and.b32         %r79, %r78, 31;
        shr.u32         %r80, %r78, 4;
        or.b32          %r22, %r80, 1;
        cvt.u64.u32     %rd50, %r79;
        mul.wide.u32    %rd124, %r79, 4;
        add.s64         %rd125, %rd122, %rd124;
        add.s64         %rd51, %rd125, 12030724;
LBB0_35:
        .pragma "nounroll";
        atom.global.or.b32      %r81, [%rd51], 0;
        setp.ne.s32     %p19, %r81, %r22;
        @%p19 bra       LBB0_35;
        mul.lo.s64      %rd126, %rd49, 12030864;
        add.s64         %rd128, %rd63, %rd126;
        shl.b64         %rd129, %rd50, 3;
        add.s64         %rd130, %rd128, %rd129;
        add.s64         %rd131, %rd130, 12030464;
        atom.global.exch.b64    %rd132, [%rd131], %rd13;
        add.s32         %r82, %r22, 1;
        and.b32         %r83, %r82, 33554430;
        atom.global.exch.b32    %r84, [%rd51], %r83;
        mov.u64         %rd133, 0;
        st.volatile.shared.u64  [omptarget_nvptx_workFn], %rd133;
        bar.sync        0;
LBB0_37:
        ret;

}
string-delimiter
      )

(define ptx-sample12-out
'((linking
   ".weak"
   (kernel
    "__omp_offloading_2e_736d7c30_cpu_stencil_l15"
    (storage
     ".param"
     ".u64"
     "__omp_offloading_2e_736d7c30_cpu_stencil_l15_param_0")
    (storage
     ".param"
     ".u64"
     "__omp_offloading_2e_736d7c30_cpu_stencil_l15_param_1")
    (storage
     ".param"
     ".u64"
     "__omp_offloading_2e_736d7c30_cpu_stencil_l15_param_2")
    (storage
     ".param"
     ".u64"
     "__omp_offloading_2e_736d7c30_cpu_stencil_l15_param_3")
    (storage
     ".param"
     ".u64"
     "__omp_offloading_2e_736d7c30_cpu_stencil_l15_param_4")
    (storage
     ".param"
     ".u64"
     "__omp_offloading_2e_736d7c30_cpu_stencil_l15_param_5")
    (storage
     ".param"
     ".u64"
     "__omp_offloading_2e_736d7c30_cpu_stencil_l15_param_6")
    (storageN ".reg" ".pred" "%p<29>")
    (storageN ".reg" ".b16" "%rs<6>")
    (storageN ".reg" ".f32" "%f<18>")
    (storageN ".reg" ".b32" "%r<98>")
    (storageN ".reg" ".b64" "%rd<162>")
    (storageN ".shared" ".align 8" ".b8" "omptarget_nvptx_globalArgs[176]")
    (storageN ".shared" ".align 8" ".b8" "DataSharingState[896]")
    (storageN ".shared" ".align 4" ".u32" "usedSlotIdx")
    (storageN ".shared" ".align 8" ".u64" "omptarget_nvptx_workFn")
    (storageN ".shared" ".align 1" ".b8" "parallelLevel[32]")
    (storageN
     ".shared"
     ".align 8"
     ".u64"
     "omptarget_nvptx_threadPrivateContext")
    (instruction "mov" ".u32" "%r1" "%tid.x")
    (instruction "mov" ".u32" "%r2" "%ntid.x")
    (instruction "mov" ".u32" "%r3" "WARP_SZ")
    (instruction "sub" ".s32" "%r23" "%r2" "%r3")
    (instruction "setp" ".ge" ".u32" "%p2" "%r1" "%r23")
    "@%p2"
    (instruction "bra" "LBB0_11")
    (instruction "cvt" ".s64" ".s32" "%rd3" "%r1")
    (instruction "cvt" ".u16" ".u32" "%rs1" "%r1")
    (instruction "shr" ".s32" "%r85" "%r1" "31")
    (instruction "shr" ".u32" "%r86" "%r85" "27")
    (instruction "add" ".s32" "%r87" "%r1" "%r86")
    (instruction "shr" ".s32" "%r88" "%r87" "5")
    (instruction "cvt" ".u64" ".u32" "%rd134" "%r88")
    (instruction "mov" ".u64" "%rd135" "parallelLevel")
    (instruction "add" ".s64" "%rd4" "%rd135" "%rd134")
    (instruction "add" ".s32" "%r89" "%r2" "-1")
    (instruction "and" ".b32" "%r90" "%r89" "-32")
    (instruction "setp" ".lt" ".s32" "%p20" "%r1" "%r90")
    (instruction "selp" ".b32" "%r91" "%r1" "0" "%p20")
    (instruction "cvt" ".s64" ".s32" "%rd5" "%r91")
    (instruction "mov" ".pred" "%p21" "0")
    (instruction "mov" ".u32" "%r92" "0")
    (instruction "shl" ".b64" "%rd145" "%rd5" "3")
    (instruction "setp" ".gt" ".s32" "%p24" "%r1" "-1")
    (instruction "mov" ".pred" "%p25" "-1")
    (instruction "bra" ".uni" "LBB0_2")
    "LBB0_9:"
    (group
     (storageN ".reg" ".b32" "temp_param_reg")
     (storageN ".param" ".b32" "param0")
     (instruction "st" ".param" ".b32" "[param0+0]" "%r92")
     (storageN ".param" ".b32" "param1")
     (instruction "st" ".param" ".b32" "[param1+0]" "%r94")
     (prototype
      "prototype_0:"
      "_"
      (storage ".param" ".b32" "_")
      (storage ".param" ".b32" "_"))
     (instruction "call" "%rd6" "(param0,param1)" "prototype_0"))
    (instruction
     "ld"
     ".shared"
     ".u64"
     "%rd148"
     "[omptarget_nvptx_threadPrivateContext]")
    (instruction "shl" ".b64" "%rd149" "%rd3" "3")
    (instruction "add" ".s64" "%rd150" "%rd148" "%rd149")
    (instruction "ld" ".u64" "%rd151" "[%rd150+328832]")
    (instruction "ld" ".u64" "%rd152" "[%rd151+56]")
    (instruction "st" ".u64" "[%rd150+328832]" "%rd152")
    "LBB0_10:"
    (instruction "bar" ".sync" "0")
    "LBB0_2:"
    (instruction "bar" ".sync" "0")
    (instruction
     "ld"
     ".volatile"
     ".shared"
     ".u64"
     "%rd6"
     "[omptarget_nvptx_workFn]")
    (instruction "setp" ".eq" ".s64" "%p22" "%rd6" "0")
    (instruction "mov" ".pred" "%p28" "%p21")
    "@%p22"
    (instruction "bra" "LBB0_5")
    (instruction "mov" ".pred" "%p28" "%p21")
    "@%p24"
    (instruction "bra" "LBB0_5")
    (instruction
     "ld"
     ".shared"
     ".u64"
     "%rd7"
     "[omptarget_nvptx_threadPrivateContext]")
    (instruction "shl" ".b64" "%rd136" "%rd3" "6")
    (instruction "add" ".s64" "%rd137" "%rd7" "%rd136")
    (instruction "add" ".s64" "%rd138" "%rd137" "263296")
    (instruction "ld" ".u64" "%rd139" "[%rd7+112]")
    (instruction "st" ".u64" "[%rd137+263344]" "%rd139")
    (instruction "ld" ".u64" "%rd140" "[%rd7+104]")
    (instruction "st" ".u64" "[%rd137+263336]" "%rd140")
    (instruction "ld" ".u64" "%rd141" "[%rd7+120]")
    (instruction "st" ".u64" "[%rd137+263352]" "%rd141")
    (instruction "st" ".u16" "[%rd137+263338]" "%rs1")
    (instruction "shl" ".b64" "%rd142" "%rd3" "3")
    (instruction "add" ".s64" "%rd143" "%rd7" "%rd142")
    (instruction "st" ".u64" "[%rd143+328832]" "%rd138")
    (instruction "mov" ".pred" "%p28" "%p25")
    "LBB0_5:"
    "@%p22"
    (instruction "bra" "LBB0_37")
    "@!%p28"
    (instruction "bra" "LBB0_10")
    (instruction "bra" ".uni" "LBB0_7")
    "LBB0_7:"
    (instruction "ld" ".shared" ".u8" "%rs4" "[%rd4]")
    (instruction "and" ".b16" "%rs5" "%rs4" "126")
    (instruction "setp" ".ne" ".s16" "%p27" "%rs5" "0")
    (instruction "mov" ".u32" "%r94" "%r92")
    "@%p27"
    (instruction "bra" "LBB0_9")
    (instruction
     "ld"
     ".shared"
     ".u64"
     "%rd144"
     "[omptarget_nvptx_threadPrivateContext]")
    (instruction "add" ".s64" "%rd146" "%rd144" "%rd145")
    (instruction "ld" ".u64" "%rd147" "[%rd146+328832]")
    (instruction "ld" ".u16" "%r94" "[%rd147+42]")
    (instruction "bra" ".uni" "LBB0_9")
    "LBB0_11:"
    (instruction "add" ".s32" "%r6" "%r2" "-1")
    (instruction "neg" ".s32" "%r24" "%r3")
    (instruction "and" ".b32" "%r25" "%r6" "%r24")
    (instruction "setp" ".ne" ".s32" "%p3" "%r1" "%r25")
    "@%p3"
    (instruction "bra" "LBB0_37")
    (instruction
     "ld"
     ".param"
     ".u64"
     "%rd56"
     "[__omp_offloading_2e_736d7c30_cpu_stencil_l15_param_6]")
    (instruction
     "ld"
     ".param"
     ".u64"
     "%rd55"
     "[__omp_offloading_2e_736d7c30_cpu_stencil_l15_param_5]")
    (instruction
     "ld"
     ".param"
     ".u64"
     "%rd54"
     "[__omp_offloading_2e_736d7c30_cpu_stencil_l15_param_2]")
    (instruction
     "ld"
     ".param"
     ".u64"
     "%rd53"
     "[__omp_offloading_2e_736d7c30_cpu_stencil_l15_param_1]")
    (instruction
     "ld"
     ".param"
     ".u64"
     "%rd52"
     "[__omp_offloading_2e_736d7c30_cpu_stencil_l15_param_0]")
    (instruction
     "ld"
     ".param"
     ".u64"
     "%rd57"
     "[__omp_offloading_2e_736d7c30_cpu_stencil_l15_param_4]")
    (instruction "cvta" ".to" ".global" ".u64" "%rd1" "%rd57")
    (instruction
     "ld"
     ".param"
     ".u64"
     "%rd58"
     "[__omp_offloading_2e_736d7c30_cpu_stencil_l15_param_3]")
    (instruction "cvta" ".to" ".global" ".u64" "%rd2" "%rd58")
    (instruction "mov" ".u64" "%rd153" "0")
    (instruction "mov" ".u64" "%rd60" "parallelLevel")
    (instruction "mov" ".u16" "%rs2" "0")
    "LBB0_13:"
    (pragma "\"nounroll\"")
    (instruction "add" ".s64" "%rd61" "%rd60" "%rd153")
    (instruction "st" ".shared" ".u8" "[%rd61]" "%rs2")
    (instruction "add" ".s64" "%rd153" "%rd153" "1")
    (instruction "cvt" ".u32" ".u64" "%r26" "%rd153")
    (instruction "setp" ".eq" ".s32" "%p4" "%r26" "32")
    "@%p4"
    (instruction "bra" "LBB0_14")
    (instruction "bra" ".uni" "LBB0_13")
    "LBB0_14:"
    (instruction "mov" ".u32" "%r27" "%smid")
    (instruction "shr" ".u32" "%r28" "%r27" "2")
    (instruction "mul" ".hi" ".u32" "%r29" "%r28" "818089009")
    (instruction "shr" ".u32" "%r30" "%r29" "2")
    (instruction "mul" ".lo" ".s32" "%r31" "%r30" "84")
    (instruction "sub" ".s32" "%r32" "%r27" "%r31")
    (instruction "st" ".shared" ".u32" "[usedSlotIdx]" "%r32")
    (instruction "cvt" ".u64" ".u32" "%rd8" "%r32")
    (instruction "mul" ".wide" ".u32" "%rd62" "%r32" "12030864")
    (instruction "mov" ".u64" "%rd63" "omptarget_nvptx_device_State")
    (instruction "add" ".s64" "%rd64" "%rd63" "%rd62")
    (instruction "add" ".s64" "%rd65" "%rd64" "12030720")
    (instruction "atom" ".global" ".add" ".u32" "%r33" "[%rd65]" "1")
    (instruction "and" ".b32" "%r34" "%r33" "31")
    (instruction "shr" ".u32" "%r7" "%r33" "4")
    (instruction "and" ".b32" "%r8" "%r7" "268435454")
    (instruction "cvt" ".u64" ".u32" "%rd9" "%r34")
    (instruction "mul" ".wide" ".u32" "%rd66" "%r34" "4")
    (instruction "add" ".s64" "%rd67" "%rd64" "%rd66")
    (instruction "add" ".s64" "%rd10" "%rd67" "12030724")
    "LBB0_15:"
    (pragma "\"nounroll\"")
    (instruction "atom" ".global" ".or" ".b32" "%r35" "[%rd10]" "0")
    (instruction "setp" ".eq" ".s32" "%p5" "%r35" "%r8")
    "@%p5"
    (instruction "bra" "LBB0_16")
    (instruction "bra" ".uni" "LBB0_15")
    "LBB0_16:"
    (instruction "mul" ".lo" ".s64" "%rd70" "%rd8" "12030864")
    (instruction "add" ".s64" "%rd72" "%rd63" "%rd70")
    (instruction "shl" ".b64" "%rd73" "%rd9" "3")
    (instruction "add" ".s64" "%rd74" "%rd72" "%rd73")
    (instruction "add" ".s64" "%rd75" "%rd74" "12030464")
    (instruction "atom" ".global" ".or" ".b64" "%rd76" "[%rd75]" "0")
    (instruction "setp" ".eq" ".s64" "%p6" "%rd76" "0")
    (instruction "mul" ".lo" ".s64" "%rd77" "%rd9" "375952")
    (instruction "add" ".s64" "%rd78" "%rd72" "%rd77")
    (instruction "cvta" ".global" ".u64" "%rd79" "%rd78")
    (instruction "selp" ".b64" "%rd80" "%rd79" "%rd76" "%p6")
    (instruction "and" ".b32" "%r36" "%r7" "33554430")
    (instruction "or" ".b32" "%r37" "%r36" "1")
    (instruction "atom" ".global" ".exch" ".b32" "%r38" "[%rd10]" "%r37")
    (instruction
     "st"
     ".shared"
     ".u64"
     "[omptarget_nvptx_threadPrivateContext]"
     "%rd80")
    (instruction "and" ".b32" "%r39" "%r6" "-32")
    (instruction "setp" ".lt" ".s32" "%p7" "%r1" "%r39")
    (instruction "selp" ".b32" "%r40" "%r1" "0" "%p7")
    (instruction "mul" ".wide" ".s32" "%rd81" "%r40" "8")
    (instruction "add" ".s64" "%rd82" "%rd80" "%rd81")
    (instruction "mul" ".wide" ".s32" "%rd83" "%r40" "2")
    (instruction "add" ".s64" "%rd84" "%rd80" "%rd83")
    (instruction "st" ".u16" "[%rd84+337024]" "%rs2")
    (instruction "st" ".u8" "[%rd80+40]" "%rs2")
    (instruction "st" ".u16" "[%rd80+42]" "%rs2")
    (instruction "mov" ".u64" "%rd85" "1")
    (instruction "st" ".u64" "[%rd80+48]" "%rd85")
    (instruction "st" ".u64" "[%rd82+328832]" "%rd80")
    (instruction "mov" ".u64" "%rd86" "DataSharingState")
    (instruction "add" ".s64" "%rd154" "%rd86" "256")
    (instruction "mov" ".u64" "%rd69" "0")
    (instruction
     "ld"
     ".shared"
     ".u64"
     "%rd13"
     "[omptarget_nvptx_threadPrivateContext]")
    (instruction "mov" ".u64" "%rd155" "%rd69")
    "LBB0_17:"
    (pragma "\"nounroll\"")
    (instruction "add" ".s64" "%rd87" "%rd13" "%rd155")
    (instruction "add" ".s64" "%rd88" "%rd87" "160")
    (instruction "add" ".s64" "%rd89" "%rd87" "8352")
    (instruction "add" ".s64" "%rd90" "%rd87" "128")
    (instruction "st" ".v2" ".u64" "[%rd87+128]" "{%rd69,%rd69}")
    (instruction "st" ".v2" ".u64" "[%rd87+144]" "{%rd69,%rd89}")
    (instruction "st" ".shared" ".u64" "[%rd154+-256]" "%rd90")
    (instruction "st" ".shared" ".u64" "[%rd154]" "%rd88")
    (instruction "add" ".s64" "%rd155" "%rd155" "8224")
    (instruction "cvt" ".u32" ".u64" "%r41" "%rd155")
    (instruction "add" ".s64" "%rd154" "%rd154" "8")
    (instruction "setp" ".ne" ".s32" "%p8" "%r41" "263168")
    "@%p8"
    (instruction "bra" "LBB0_17")
    (instruction "mov" ".u64" "%rd92" "omptarget_nvptx_globalArgs")
    (instruction "cvta" ".shared" ".u64" "%rd93" "%rd92")
    (instruction
     "st"
     ".shared"
     ".u64"
     "[omptarget_nvptx_globalArgs+160]"
     "%rd93")
    (instruction "mov" ".u32" "%r42" "20")
    (instruction
     "st"
     ".shared"
     ".u32"
     "[omptarget_nvptx_globalArgs+168]"
     "%r42")
    (instruction "cvt" ".u32" ".u64" "%r43" "%rd52")
    (instruction "cvt" ".u32" ".u64" "%r9" "%rd53")
    (instruction "setp" ".gt" ".s32" "%p9" "%r43" "2")
    (instruction "setp" ".gt" ".s32" "%p10" "%r9" "2")
    (instruction "and" ".pred" "%p11" "%p9" "%p10")
    "@!%p11"
    (instruction "bra" "LBB0_34")
    (instruction "bra" ".uni" "LBB0_19")
    "LBB0_19:"
    (instruction "shl" ".b64" "%rd94" "%rd52" "32")
    (instruction "add" ".s64" "%rd95" "%rd94" "-8589934592")
    (instruction "shr" ".s64" "%rd96" "%rd95" "32")
    (instruction "shl" ".b64" "%rd97" "%rd53" "32")
    (instruction "add" ".s64" "%rd98" "%rd97" "-8589934592")
    (instruction "shr" ".s64" "%rd18" "%rd98" "32")
    (instruction "mul" ".lo" ".s64" "%rd19" "%rd18" "%rd96")
    (instruction "mov" ".u32" "%r46" "%ctaid.x")
    (instruction "cvt" ".s64" ".s32" "%rd20" "%r46")
    (instruction "mov" ".u32" "%r47" "%nctaid.x")
    (instruction "cvt" ".s64" ".s32" "%rd21" "%r47")
    (instruction "or" ".b64" "%rd99" "%rd19" "%rd21")
    (instruction "and" ".b64" "%rd100" "%rd99" "-4294967296")
    (instruction "setp" ".ne" ".s64" "%p12" "%rd100" "0")
    "@%p12"
    (instruction "bra" "LBB0_21")
    (instruction "bra" ".uni" "LBB0_20")
    "LBB0_21:"
    (instruction "div" ".s64" "%rd156" "%rd19" "%rd21")
    (instruction "bra" ".uni" "LBB0_22")
    "LBB0_20:"
    (instruction "cvt" ".u32" ".u64" "%r48" "%rd21")
    (instruction "cvt" ".u32" ".u64" "%r49" "%rd19")
    (instruction "div" ".u32" "%r50" "%r49" "%r48")
    (instruction "cvt" ".u64" ".u32" "%rd156" "%r50")
    "LBB0_22:"
    (instruction "mul" ".lo" ".s64" "%rd101" "%rd156" "%rd21")
    (instruction "sub" ".s64" "%rd25" "%rd19" "%rd101")
    (instruction "setp" ".le" ".s64" "%p13" "%rd25" "%rd20")
    "@%p13"
    (instruction "bra" "LBB0_24")
    (instruction "add" ".s64" "%rd157" "%rd156" "1")
    (instruction "mul" ".lo" ".s64" "%rd159" "%rd157" "%rd20")
    (instruction "bra" ".uni" "LBB0_25")
    "LBB0_24:"
    (instruction "mul" ".lo" ".s64" "%rd102" "%rd156" "%rd20")
    (instruction "add" ".s64" "%rd159" "%rd25" "%rd102")
    (instruction "mov" ".u64" "%rd157" "%rd156")
    "LBB0_25:"
    (instruction "add" ".s64" "%rd103" "%rd159" "%rd157")
    (instruction "min" ".s64" "%rd31" "%rd103" "%rd19")
    (instruction "setp" ".ge" ".s64" "%p14" "%rd159" "%rd31")
    "@%p14"
    (instruction "bra" "LBB0_34")
    (instruction "cvt" ".u32" ".u64" "%r44" "%rd55")
    (instruction "cvt" ".u32" ".u64" "%r45" "%rd56")
    (instruction "cvt" ".u32" ".u64" "%r10" "%rd54")
    (instruction "mov" ".b32" "%f1" "%r44")
    (instruction "mov" ".b32" "%f2" "%r45")
    (instruction "cvt" ".u32" ".u64" "%r51" "%rd20")
    (instruction "add" ".s32" "%r11" "%r10" "-2")
    (instruction "add" ".s64" "%rd32" "%rd1" "4")
    (instruction "cvt" ".u32" ".u64" "%r52" "%rd156")
    (instruction "min" ".s64" "%rd104" "%rd25" "%rd20")
    (instruction "cvt" ".u32" ".u64" "%r53" "%rd104")
    (instruction "mad" ".lo" ".s32" "%r54" "%r51" "%r52" "%r53")
    (instruction "neg" ".s64" "%rd33" "%rd18")
    (instruction "add" ".s32" "%r96" "%r54" "2")
    (instruction "add" ".s32" "%r95" "%r54" "1")
    (instruction "add" ".s64" "%rd34" "%rd2" "4")
    (instruction "add" ".s64" "%rd35" "%rd1" "8")
    (instruction "setp" ".lt" ".s32" "%p16" "%r10" "3")
    (instruction "bra" ".uni" "LBB0_27")
    "LBB0_33:"
    (instruction "add" ".s64" "%rd159" "%rd159" "1")
    (instruction "add" ".s32" "%r96" "%r96" "1")
    (instruction "add" ".s32" "%r95" "%r95" "1")
    (instruction "setp" ".lt" ".s64" "%p18" "%rd159" "%rd31")
    "@%p18"
    (instruction "bra" "LBB0_27")
    (instruction "bra" ".uni" "LBB0_34")
    "LBB0_27:"
    (instruction "cvt" ".u32" ".u64" "%r16" "%rd159")
    (instruction "or" ".b64" "%rd105" "%rd159" "%rd18")
    (instruction "and" ".b64" "%rd106" "%rd105" "-4294967296")
    (instruction "setp" ".ne" ".s64" "%p15" "%rd106" "0")
    "@%p15"
    (instruction "bra" "LBB0_29")
    (instruction "bra" ".uni" "LBB0_28")
    "LBB0_29:"
    (instruction "div" ".s64" "%rd160" "%rd159" "%rd18")
    (instruction "bra" ".uni" "LBB0_30")
    "LBB0_28:"
    (instruction "cvt" ".u32" ".u64" "%r55" "%rd18")
    (instruction "div" ".u32" "%r57" "%r16" "%r55")
    (instruction "cvt" ".u64" ".u32" "%rd160" "%r57")
    "LBB0_30:"
    "@%p16"
    (instruction "bra" "LBB0_33")
    (instruction "cvt" ".u32" ".u64" "%r17" "%rd160")
    (instruction "add" ".s32" "%r58" "%r17" "2")
    (instruction "mul" ".lo" ".s32" "%r59" "%r17" "%r9")
    (instruction "add" ".s32" "%r60" "%r59" "%r9")
    (instruction "add" ".s32" "%r61" "%r16" "%r60")
    (instruction "mul" ".lo" ".s64" "%rd108" "%rd33" "%rd160")
    (instruction "cvt" ".u32" ".u64" "%r62" "%rd108")
    (instruction "add" ".s32" "%r63" "%r61" "%r62")
    (instruction "mul" ".lo" ".s32" "%r64" "%r10" "%r63")
    (instruction "mul" ".wide" ".s32" "%rd109" "%r64" "4")
    (instruction "add" ".s64" "%rd40" "%rd32" "%rd109")
    (instruction "add" ".s32" "%r65" "%r96" "%r60")
    (instruction "add" ".s32" "%r66" "%r65" "%r62")
    (instruction "mul" ".lo" ".s32" "%r67" "%r10" "%r66")
    (instruction "mul" ".wide" ".s32" "%rd110" "%r67" "4")
    (instruction "add" ".s64" "%rd41" "%rd32" "%rd110")
    (instruction "add" ".s32" "%r68" "%r95" "%r59")
    (instruction "add" ".s32" "%r69" "%r68" "%r62")
    (instruction "mul" ".lo" ".s32" "%r70" "%r10" "%r69")
    (instruction "mul" ".wide" ".s32" "%rd111" "%r70" "4")
    (instruction "add" ".s64" "%rd42" "%rd32" "%rd111")
    (instruction "mad" ".lo" ".s32" "%r71" "%r9" "%r58" "%r95")
    (instruction "add" ".s32" "%r72" "%r71" "%r62")
    (instruction "mul" ".lo" ".s32" "%r73" "%r10" "%r72")
    (instruction "mul" ".wide" ".s32" "%rd112" "%r73" "4")
    (instruction "add" ".s64" "%rd43" "%rd32" "%rd112")
    (instruction "add" ".s32" "%r74" "%r95" "%r60")
    (instruction "add" ".s32" "%r75" "%r74" "%r62")
    (instruction "mul" ".lo" ".s32" "%r76" "%r10" "%r75")
    (instruction "mul" ".wide" ".s32" "%rd113" "%r76" "4")
    (instruction "add" ".s64" "%rd44" "%rd34" "%rd113")
    (instruction "add" ".s64" "%rd45" "%rd35" "%rd113")
    (instruction "mov" ".u64" "%rd161" "0")
    (instruction "mov" ".u32" "%r97" "%r11")
    "LBB0_32:"
    (instruction "add" ".s64" "%rd114" "%rd43" "%rd161")
    (instruction "ld" ".global" ".f32" "%f3" "[%rd114]")
    (instruction "add" ".s64" "%rd115" "%rd42" "%rd161")
    (instruction "ld" ".global" ".f32" "%f4" "[%rd115]")
    (instruction "add" ".rn" ".f32" "%f5" "%f3" "%f4")
    (instruction "add" ".s64" "%rd116" "%rd41" "%rd161")
    (instruction "ld" ".global" ".f32" "%f6" "[%rd116]")
    (instruction "add" ".rn" ".f32" "%f7" "%f5" "%f6")
    (instruction "add" ".s64" "%rd117" "%rd40" "%rd161")
    (instruction "ld" ".global" ".f32" "%f8" "[%rd117]")
    (instruction "add" ".rn" ".f32" "%f9" "%f7" "%f8")
    (instruction "add" ".s64" "%rd118" "%rd45" "%rd161")
    (instruction "ld" ".global" ".f32" "%f10" "[%rd118]")
    (instruction "add" ".rn" ".f32" "%f11" "%f9" "%f10")
    (instruction "ld" ".global" ".f32" "%f12" "[%rd118+-8]")
    (instruction "add" ".rn" ".f32" "%f13" "%f11" "%f12")
    (instruction "mul" ".rn" ".f32" "%f14" "%f13" "%f1")
    (instruction "ld" ".global" ".f32" "%f15" "[%rd118+-4]")
    (instruction "mul" ".rn" ".f32" "%f16" "%f15" "%f2")
    (instruction "sub" ".rn" ".f32" "%f17" "%f14" "%f16")
    (instruction "add" ".s64" "%rd119" "%rd44" "%rd161")
    (instruction "st" ".global" ".f32" "[%rd119]" "%f17")
    (instruction "add" ".s64" "%rd161" "%rd161" "4")
    (instruction "add" ".s32" "%r97" "%r97" "-1")
    (instruction "setp" ".ne" ".s32" "%p17" "%r97" "0")
    "@%p17"
    (instruction "bra" "LBB0_32")
    (instruction "bra" ".uni" "LBB0_33")
    "LBB0_34:"
    (instruction "ld" ".shared" ".u32" "%r77" "[usedSlotIdx]")
    (instruction "cvt" ".s64" ".s32" "%rd49" "%r77")
    (instruction "mul" ".wide" ".s32" "%rd120" "%r77" "12030864")
    (instruction "add" ".s64" "%rd122" "%rd63" "%rd120")
    (instruction "add" ".s64" "%rd123" "%rd122" "12030852")
    (instruction "atom" ".global" ".add" ".u32" "%r78" "[%rd123]" "1")
    (instruction "and" ".b32" "%r79" "%r78" "31")
    (instruction "shr" ".u32" "%r80" "%r78" "4")
    (instruction "or" ".b32" "%r22" "%r80" "1")
    (instruction "cvt" ".u64" ".u32" "%rd50" "%r79")
    (instruction "mul" ".wide" ".u32" "%rd124" "%r79" "4")
    (instruction "add" ".s64" "%rd125" "%rd122" "%rd124")
    (instruction "add" ".s64" "%rd51" "%rd125" "12030724")
    "LBB0_35:"
    (pragma "\"nounroll\"")
    (instruction "atom" ".global" ".or" ".b32" "%r81" "[%rd51]" "0")
    (instruction "setp" ".ne" ".s32" "%p19" "%r81" "%r22")
    "@%p19"
    (instruction "bra" "LBB0_35")
    (instruction "mul" ".lo" ".s64" "%rd126" "%rd49" "12030864")
    (instruction "add" ".s64" "%rd128" "%rd63" "%rd126")
    (instruction "shl" ".b64" "%rd129" "%rd50" "3")
    (instruction "add" ".s64" "%rd130" "%rd128" "%rd129")
    (instruction "add" ".s64" "%rd131" "%rd130" "12030464")
    (instruction "atom" ".global" ".exch" ".b64" "%rd132" "[%rd131]" "%rd13")
    (instruction "add" ".s32" "%r82" "%r22" "1")
    (instruction "and" ".b32" "%r83" "%r82" "33554430")
    (instruction "atom" ".global" ".exch" ".b32" "%r84" "[%rd51]" "%r83")
    (instruction "mov" ".u64" "%rd133" "0")
    (instruction
     "st"
     ".volatile"
     ".shared"
     ".u64"
     "[omptarget_nvptx_workFn]"
     "%rd133")
    (instruction "bar" ".sync" "0")
    "LBB0_37:"
    (instruction "ret"))))
  )

(define ptx-sample13
  #<<string-delimiter
.version	3.1
.target	sm_35
.address_size 64
.entry main$_omp_fn$0 (.param .u64 %in_ar0) ;
.entry main$_omp_fn$0 (.param .u64 %in_ar0) {
.reg .u64 %ar0;
ld.param.u64 %ar0, [%in_ar0];
.reg .u64 %r23;
.reg .u32 %r24;
.reg .u32 %r26;
.reg .u32 %r27;
.reg .u64 %r35;
.reg .u32 %r36;
.reg .u32 %r39;
.reg .u32 %r47;
.reg .u32 %r48;
.reg .u32 %r49;
.reg .u64 %r52;
.reg .u64 %r54;
.reg .u64 %r55;
.reg .u32 %r56;
.reg .u32 %r57;
.reg .u32 %r58;
.reg .u32 %r59;
.reg .pred %r60;
.reg .u64 %r61;
.reg .u64 %r62;
.reg .u32 %r63;
.reg .u64 %r64;
.reg .u64 %r65;
.reg .u32 %r66;
.reg .u32 %r67;
.reg .u32 %r68;
.reg .u32 %r69;
.reg .u32 %r70;
.reg .pred %r71;
.reg .u32 %r72;
.reg .u64 %r73;
.reg .u64 %r74;
.reg .u32 %r75;
.reg .u32 %r76;
.reg .u32 %r77;
.reg .u32 %r78;
.reg .u32 %r79;
.reg .u32 %r80;
.reg .u32 %r81;
.reg .u32 %r82;
.reg .pred %r83;
{
.reg .u32 %x;
mov.u32 %x, %tid.x;
setp.ne.u32 %r83, %x, 0;
}
@%r83 bra $L3;
mov.u64 %r55, %ar0;
ld.u64 %r23, [%r55];
$L3:
mov.b64 {%r81,%r82}, %r23;
shfl.idx.b32 %r81, %r81, 0, 31;
shfl.idx.b32 %r82, %r82, 0, 31;
mov.b64 %r23, {%r81,%r82};
mov.u32 %r47, %nctaid.x;
mov.u32 %r48, %ctaid.x;
mov.u32 %r49, %tid.x;
shl.b32 %r36, %r47, 5;
add.u32 %r56, %r36, 49;
div.s32 %r39, %r56, %r36;
mul.lo.u32 %r57, %r39, %r48;
shl.b32 %r58, %r57, 5;
add.u32 %r26, %r58, %r49;
shl.b32 %r59, %r39, 5;
add.u32 %r27, %r59, %r26;
min.s32 %r80, %r27, 50;
setp.ge.s32 %r60, %r26, %r80;
@%r60 bra $L2;
cvt.s64.s32 %r61, %r26;
shl.b64 %r62, %r61, 2;
add.u64 %r35, %r23, %r62;
add.u32 %r63, %r26, %r26;
cvt.s64.s32 %r64, %r63;
shl.b64 %r65, %r64, 2;
add.u64 %r52, %r23, %r65;
ld.u32 %r67, [%r35];
add.u32 %r66, %r67, %r26;
st.u32 [%r52], %r66;
ld.u32 %r69, [%r35+4];
add.u32 %r68, %r26, %r69;
add.u32 %r70, %r68, 1;
st.u32 [%r52+4], %r70;
add.u32 %r24, %r26, 32;
setp.ge.s32 %r71, %r24, %r80;
@%r71 bra $L2;
add.u32 %r72, %r63, 64;
cvt.s64.s32 %r73, %r72;
shl.b64 %r74, %r73, 2;
add.u64 %r54, %r23, %r74;
ld.u32 %r76, [%r35+128];
add.u32 %r75, %r76, %r24;
st.u32 [%r54], %r75;
ld.u32 %r78, [%r35+132];
add.u32 %r77, %r24, %r78;
add.u32 %r79, %r77, 1;
st.u32 [%r54+4], %r79;
$L2:
ret ;
}
// BEGIN PREAMBLE
// BEGIN FUNCTION DECL: main$_omp_fn$0
// BEGIN FUNCTION DEF: main$_omp_fn$0
//:FUNC_MAP "main$_omp_fn$0", 0x1, 0x1, 0x20
string-delimiter
      )

(define ptx-sample14
  #<<string-delimiter
// BEGIN PREAMBLE
	.version	3.1
	.target	sm_35
	.address_size 64
// END PREAMBLE


// BEGIN FUNCTION DECL: cpu_stencil$_omp_fn$0
.entry cpu_stencil$_omp_fn$0 (.param.u64 %in_ar0);

// BEGIN FUNCTION DEF: cpu_stencil$_omp_fn$0
.entry cpu_stencil$_omp_fn$0 (.param.u64 %in_ar0)
{
	.reg.u64 %ar0;
	ld.param.u64 %ar0, [%in_ar0];
	.reg.u32 %r22;
	.reg.u32 %r26;
	.reg.u32 %r28;
	.reg.f32 %r30;
	.reg.f32 %r32;
	.reg.u64 %r33;
	.reg.u64 %r34;
	.reg.u32 %r37;
	.reg.u32 %r40;
	.reg.u32 %r41;
	.reg.u32 %r44;
	.reg.u32 %r45;
	.reg.u32 %r51;
	.reg.u32 %r58;
	.reg.u32 %r64;
	.reg.f32 %r81;
	.reg.u64 %r82;
	.reg.u32 %r85;
	.reg.u32 %r87;
	.reg.u32 %r88;
	.reg.u32 %r89;
	.reg.u64 %r91;
	.reg.u64 %r103;
	.reg.u64 %r105;
	.reg.u32 %r106;
	.reg.u64 %r108;
	.reg.u64 %r109;
	.reg.u64 %r116;
	.reg.u64 %r119;
	.reg.u64 %r120;
	.reg.u64 %r121;
	.reg.u64 %r126;
	.reg.u64 %r127;
	.reg.u64 %r128;
	.reg.u64 %r129;
	.reg.u64 %r130;
	.reg.u32 %r131;
	.reg.u32 %r132;
	.reg.u32 %r133;
	.reg.u32 %r134;
	.reg.u32 %r135;
	.reg.pred %r136;
	.reg.u64 %r137;
	.reg.u64 %r138;
	.reg.u64 %r139;
	.reg.pred %r140;
	.reg.u32 %r142;
	.reg.u32 %r143;
	.reg.u32 %r144;
	.reg.u32 %r145;
	.reg.u32 %r146;
	.reg.u64 %r147;
	.reg.u64 %r148;
	.reg.u64 %r149;
	.reg.u32 %r150;
	.reg.u32 %r151;
	.reg.u64 %r152;
	.reg.u64 %r153;
	.reg.u64 %r154;
	.reg.u64 %r155;
	.reg.u32 %r156;
	.reg.u32 %r157;
	.reg.u32 %r158;
	.reg.u64 %r159;
	.reg.u64 %r160;
	.reg.u64 %r161;
	.reg.u64 %r162;
	.reg.u64 %r163;
	.reg.u64 %r165;
	.reg.u64 %r166;
	.reg.u32 %r167;
	.reg.u32 %r168;
	.reg.u64 %r169;
	.reg.u32 %r170;
	.reg.u32 %r171;
	.reg.u32 %r172;
	.reg.u64 %r173;
	.reg.u32 %r174;
	.reg.u32 %r175;
	.reg.u64 %r176;
	.reg.u64 %r177;
	.reg.f32 %r178;
	.reg.f32 %r179;
	.reg.f32 %r180;
	.reg.u64 %r181;
	.reg.f32 %r182;
	.reg.f32 %r183;
	.reg.u64 %r184;
	.reg.f32 %r185;
	.reg.f32 %r186;
	.reg.f32 %r187;
	.reg.f32 %r188;
	.reg.f32 %r189;
	.reg.f32 %r190;
	.reg.f32 %r191;
	.reg.f32 %r192;
	.reg.f32 %r193;
	.reg.pred %r195;
	.reg.u64 %r196;
	.reg.u64 %r197;
	.reg.u64 %r198;
	.reg.u64 %r200;
	.reg.pred %r201;
	.reg.u64 %r202;
	.reg.u64 %r203;
	.reg.u64 %r208;
	.reg.u64 %r209;
	.reg.f32 %r210;
	.reg.f32 %r211;
	.reg.f32 %r212;
	.reg.u64 %r213;
	.reg.f32 %r214;
	.reg.f32 %r215;
	.reg.u64 %r216;
	.reg.f32 %r217;
	.reg.f32 %r218;
	.reg.f32 %r219;
	.reg.f32 %r220;
	.reg.f32 %r221;
	.reg.f32 %r222;
	.reg.f32 %r223;
	.reg.f32 %r224;
	.reg.f32 %r225;
	.reg.f32 %r226;
	.reg.pred %r227;
	.reg.u64 %r228;
	.reg.u64 %r229;
	.reg.f32 %r230;
	.reg.f32 %r231;
	.reg.f32 %r232;
	.reg.u64 %r233;
	.reg.f32 %r234;
	.reg.f32 %r235;
	.reg.u64 %r236;
	.reg.f32 %r237;
	.reg.f32 %r238;
	.reg.f32 %r239;
	.reg.f32 %r240;
	.reg.f32 %r241;
	.reg.f32 %r242;
	.reg.f32 %r243;
	.reg.f32 %r244;
	.reg.f32 %r245;
	.reg.f32 %r246;
	.reg.pred %r247;
	.reg.u32 %r248;
	.reg.u32 %r249;
	.reg.u32 %r250;
	.reg.u32 %r251;
	.reg.pred %r252;
	.reg.pred %r253;
	.reg.u32 %r254;
	.reg.pred %r255;
	.reg.u32 %r256;
	{
		.reg.u32	%x;
		mov.u32	%x, %tid.x;
		setp.ne.u32	%r252, %x, 0;
	}
		setp.eq.u32	%r255, 1, 0;
	@%r252	bra	$L18;
		mov.u64	%r128, %ar0;
		ld.u64	%r129, [%r128+24];
		ld.u32	%r26, [%r129];
		add.u32	%r37, %r26, -2;
		ld.u64	%r130, [%r128+16];
		ld.u32	%r132, [%r130];
		add.u32	%r131, %r132, -2;
		mul.lo.u32	%r40, %r131, %r37;
		mov.u32	%r87, %nctaid.x;
		mov.u32	%r88, %ctaid.x;
		add.u32	%r133, %r40, -1;
		add.u32	%r134, %r133, %r87;
		div.s32	%r85, %r134, %r87;
		mul.lo.u32	%r22, %r85, %r88;
		add.u32	%r135, %r22, %r85;
		min.s32	%r41, %r135, %r40;
		setp.lt.s32	%r136, %r22, %r41;
		mov.pred	%r255, %r136;
$L18:
		mov.pred	%r136, %r255;
		selp.u32	%r256, 1, 0, %r136;
		shfl.idx.b32	%r256, %r256, 0, 31;
		setp.ne.u32	%r136, %r256, 0;
	@!%r136	bra.uni	$L1;
	@%r252	bra	$L17;
		ld.u64	%r137, [%r128+32];
		ld.u32	%r28, [%r137];
		ld.u64	%r138, [%r128+40];
		ld.f32	%r30, [%r138];
		ld.u64	%r139, [%r128+48];
		ld.f32	%r32, [%r139];
		ld.u64	%r33, [%r128];
		ld.u64	%r34, [%r128+8];
		add.u32	%r106, %r28, -2;
$L17:
$L7:
	// fork 4;
	// forked 4;
		shfl.idx.b32	%r22, %r22, 0, 31;
		shfl.idx.b32	%r26, %r26, 0, 31;
		shfl.idx.b32	%r28, %r28, 0, 31;
		shfl.idx.b32	%r30, %r30, 0, 31;
		shfl.idx.b32	%r32, %r32, 0, 31;
		mov.b64	{%r248,%r249}, %r33;
		shfl.idx.b32	%r248, %r248, 0, 31;
		shfl.idx.b32	%r249, %r249, 0, 31;
		mov.b64	%r33, {%r248,%r249};
		mov.b64	{%r250,%r251}, %r34;
		shfl.idx.b32	%r250, %r250, 0, 31;
		shfl.idx.b32	%r251, %r251, 0, 31;
		mov.b64	%r34, {%r250,%r251};
		shfl.idx.b32	%r37, %r37, 0, 31;
		shfl.idx.b32	%r41, %r41, 0, 31;
		shfl.idx.b32	%r106, %r106, 0, 31;
		mov.u32	%r89, %tid.x;
		setp.lt.s32	%r140, %r89, %r106;
	@%r140	bra	$L3;
$L6:
	// joining 4;
		setp.eq.u32	%r253, 1, 0;
	// join 4;
	@%r252	bra	$L16;
		add.u32	%r22, %r22, 1;
		setp.ne.u32	%r195, %r41, %r22;
		mov.pred	%r253, %r195;
$L16:
		mov.pred	%r195, %r253;
		selp.u32	%r254, 1, 0, %r195;
		shfl.idx.b32	%r254, %r254, 0, 31;
		setp.ne.u32	%r195, %r254, 0;
	@%r195	bra.uni	$L7;
		bra	$L1;
$L3:
		rem.u32	%r44, %r22, %r37;
		add.u32	%r45, %r44, 1;
		div.u32	%r142, %r22, %r37;
		add.u32	%r143, %r142, 2;
		mul.lo.u32	%r51, %r143, %r26;
		add.u32	%r144, %r26, %r26;
		sub.u32	%r58, %r51, %r144;
		add.u32	%r64, %r26, %r58;
		cvt.s64.s32	%r127, %r89;
		add.u32	%r145, %r45, %r51;
		mul.lo.u32	%r146, %r145, %r28;
		cvt.s64.s32	%r126, %r146;
		add.u64	%r147, %r126, 1;
		add.u64	%r148, %r147, %r127;
		shl.b64	%r149, %r148, 2;
		add.u64	%r82, %r34, %r149;
		add.u32	%r150, %r45, %r64;
		mul.lo.u32	%r151, %r150, %r28;
		cvt.s64.s32	%r120, %r151;
		add.u64	%r119, %r120, %r127;
		shl.b64	%r152, %r119, 2;
		add.u64	%r121, %r34, %r152;
		add.u64	%r153, %r120, 1;
		add.u64	%r154, %r153, %r127;
		shl.b64	%r155, %r154, 2;
		add.u64	%r116, %r33, %r155;
		add.u32	%r156, %r28, -3;
		sub.u32	%r157, %r156, %r89;
		shr.u32	%r158, %r157, 5;
		cvt.u64.u32	%r159, %r158;
		shl.b64	%r160, %r159, 5;
		add.u64	%r161, %r160, %r119;
		shl.b64	%r162, %r161, 2;
		add.u64	%r163, %r34, 128;
		add.u64	%r91, %r162, %r163;
		neg.s64	%r165, %r126;
		shl.b64	%r166, %r165, 2;
		add.u32	%r167, %r45, %r58;
		mul.lo.u32	%r168, %r167, %r28;
		cvt.s64.s32	%r169, %r168;
		shl.b64	%r108, %r169, 2;
		add.u32	%r170, %r44, 2;
		add.u32	%r171, %r170, %r64;
		mul.lo.u32	%r172, %r171, %r28;
		cvt.s64.s32	%r173, %r172;
		shl.b64	%r105, %r173, 2;
		add.u32	%r174, %r44, %r64;
		mul.lo.u32	%r175, %r174, %r28;
		cvt.s64.s32	%r176, %r175;
		shl.b64	%r103, %r176, 2;
		sub.u64	%r197, %r91, %r121;
		add.u64	%r198, %r197, -128;
		shr.u64	%r196, %r198, 7;
		and.b64	%r200, %r196, 1;
		setp.ne.u64	%r201, %r200, 0;
	@!%r201	bra	$L15;
$L5:
		add.u64	%r109, %r82, %r166;
		add.u64	%r177, %r109, %r108;
		ld.f32	%r179, [%r177];
		ld.f32	%r180, [%r82];
		add.f32	%r178, %r179, %r180;
		add.u64	%r181, %r109, %r105;
		ld.f32	%r183, [%r181];
		add.f32	%r182, %r178, %r183;
		add.u64	%r184, %r109, %r103;
		ld.f32	%r186, [%r184];
		add.f32	%r185, %r182, %r186;
		ld.f32	%r188, [%r121+8];
		add.f32	%r187, %r185, %r188;
		ld.f32	%r190, [%r121];
		add.f32	%r189, %r187, %r190;
		ld.f32	%r192, [%r121+4];
		mul.f32	%r191, %r32, %r192;
		neg.f32	%r193, %r191;
		fma.rn.f32	%r81, %r30, %r189, %r193;
		st.f32	[%r116], %r81;
		add.u64	%r202, %r82, 128;
		add.u64	%r203, %r121, 128;
		add.u64	%r208, %r202, %r166;
		add.u64	%r209, %r208, %r108;
		ld.f32	%r210, [%r209];
		ld.f32	%r211, [%r202];
		add.f32	%r212, %r210, %r211;
		add.u64	%r213, %r208, %r105;
		ld.f32	%r214, [%r213];
		add.f32	%r215, %r212, %r214;
		add.u64	%r216, %r208, %r103;
		ld.f32	%r217, [%r216];
		add.f32	%r218, %r215, %r217;
		ld.f32	%r219, [%r203+8];
		add.f32	%r220, %r218, %r219;
		ld.f32	%r221, [%r203];
		add.f32	%r222, %r220, %r221;
		ld.f32	%r223, [%r203+4];
		mul.f32	%r224, %r32, %r223;
		neg.f32	%r225, %r224;
		fma.rn.f32	%r226, %r30, %r222, %r225;
		st.f32	[%r116+128], %r226;
		add.u64	%r82, %r82, 256;
		add.u64	%r121, %r121, 256;
		add.u64	%r116, %r116, 256;
		setp.ne.u64	%r227, %r91, %r121;
	@%r227	bra	$L5;
		bra	$L6;
$L1:
	ret;
$L15:
		add.u64	%r228, %r82, %r166;
		add.u64	%r229, %r228, %r108;
		ld.f32	%r230, [%r229];
		ld.f32	%r231, [%r82];
		add.f32	%r232, %r230, %r231;
		add.u64	%r233, %r228, %r105;
		ld.f32	%r234, [%r233];
		add.f32	%r235, %r232, %r234;
		add.u64	%r236, %r228, %r103;
		ld.f32	%r237, [%r236];
		add.f32	%r238, %r235, %r237;
		ld.f32	%r239, [%r121+8];
		add.f32	%r240, %r238, %r239;
		ld.f32	%r241, [%r121];
		add.f32	%r242, %r240, %r241;
		ld.f32	%r243, [%r121+4];
		mul.f32	%r244, %r32, %r243;
		neg.f32	%r245, %r244;
		fma.rn.f32	%r246, %r30, %r242, %r245;
		st.f32	[%r116], %r246;
		add.u64	%r82, %r82, 128;
		add.u64	%r121, %r121, 128;
		add.u64	%r116, %r116, 128;
		setp.ne.u64	%r247, %r91, %r121;
	@%r247	bra	$L5;
		bra	$L6;
}
//:FUNC_MAP "cpu_stencil$_omp_fn$0", 0, 0x1, 0x20
string-delimiter
  )

(define ptx-sample15
  #<<string-delimiter
// BEGIN PREAMBLE
	.version	3.1
	.target	sm_35
	.address_size 64
// END PREAMBLE


// BEGIN FUNCTION DECL: LBM_performStreamCollide$_omp_fn$0
.entry LBM_performStreamCollide$_omp_fn$0 (.param.u64 %in_ar0);

// BEGIN FUNCTION DEF: LBM_performStreamCollide$_omp_fn$0
.entry LBM_performStreamCollide$_omp_fn$0 (.param.u64 %in_ar0)
{
	.reg.u64 %ar0;
	ld.param.u64 %ar0, [%in_ar0];
	.reg.u32 %r22;
	.reg.u64 %r23;
	.reg.u64 %r24;
	.reg.u32 %r26;
	.reg.u32 %r27;
	.reg.f64 %r29;
	.reg.f64 %r31;
	.reg.f64 %r33;
	.reg.f64 %r35;
	.reg.f64 %r37;
	.reg.f64 %r39;
	.reg.f64 %r41;
	.reg.f64 %r43;
	.reg.f64 %r45;
	.reg.f64 %r47;
	.reg.f64 %r49;
	.reg.f64 %r51;
	.reg.f64 %r53;
	.reg.f64 %r55;
	.reg.f64 %r57;
	.reg.f64 %r59;
	.reg.f64 %r61;
	.reg.f64 %r63;
	.reg.f64 %r64;
	.reg.f64 %r73;
	.reg.f64 %r82;
	.reg.f64 %r91;
	.reg.f64 %r92;
	.reg.f64 %r93;
	.reg.f64 %r94;
	.reg.f64 %r98;
	.reg.f64 %r100;
	.reg.f64 %r102;
	.reg.f64 %r105;
	.reg.f64 %r108;
	.reg.f64 %r111;
	.reg.f64 %r114;
	.reg.f64 %r117;
	.reg.f64 %r119;
	.reg.f64 %r121;
	.reg.f64 %r124;
	.reg.f64 %r127;
	.reg.f64 %r130;
	.reg.f64 %r133;
	.reg.f64 %r136;
	.reg.f64 %r139;
	.reg.f64 %r142;
	.reg.f64 %r145;
	.reg.f64 %r148;
	.reg.f64 %r151;
	.reg.f64 %r154;
	.reg.f64 %r155;
	.reg.f64 %r156;
	.reg.f64 %r157;
	.reg.f64 %r158;
	.reg.f64 %r159;
	.reg.f64 %r160;
	.reg.f64 %r161;
	.reg.f64 %r162;
	.reg.f64 %r163;
	.reg.f64 %r164;
	.reg.f64 %r165;
	.reg.f64 %r166;
	.reg.f64 %r167;
	.reg.f64 %r168;
	.reg.f64 %r169;
	.reg.f64 %r170;
	.reg.f64 %r171;
	.reg.f64 %r172;
	.reg.u64 %r174;
	.reg.u32 %r177;
	.reg.u32 %r182;
	.reg.u32 %r183;
	.reg.u32 %r184;
	.reg.u64 %r194;
	.reg.u64 %r195;
	.reg.u64 %r196;
	.reg.f64 %r208;
	.reg.f64 %r209;
	.reg.f64 %r210;
	.reg.f64 %r211;
	.reg.f64 %r212;
	.reg.f64 %r213;
	.reg.f64 %r214;
	.reg.f64 %r215;
	.reg.f64 %r216;
	.reg.f64 %r217;
	.reg.f64 %r218;
	.reg.f64 %r219;
	.reg.f64 %r220;
	.reg.f64 %r221;
	.reg.f64 %r222;
	.reg.f64 %r223;
	.reg.f64 %r224;
	.reg.f64 %r225;
	.reg.f64 %r226;
	.reg.f64 %r227;
	.reg.f64 %r228;
	.reg.f64 %r229;
	.reg.f64 %r230;
	.reg.f64 %r231;
	.reg.f64 %r232;
	.reg.f64 %r233;
	.reg.f64 %r234;
	.reg.f64 %r235;
	.reg.f64 %r236;
	.reg.f64 %r237;
	.reg.f64 %r238;
	.reg.f64 %r239;
	.reg.f64 %r240;
	.reg.f64 %r241;
	.reg.f64 %r242;
	.reg.f64 %r243;
	.reg.f64 %r244;
	.reg.f64 %r245;
	.reg.f64 %r246;
	.reg.f64 %r247;
	.reg.f64 %r248;
	.reg.f64 %r249;
	.reg.f64 %r250;
	.reg.f64 %r251;
	.reg.f64 %r252;
	.reg.f64 %r253;
	.reg.f64 %r254;
	.reg.f64 %r255;
	.reg.f64 %r256;
	.reg.f64 %r257;
	.reg.f64 %r259;
	.reg.f64 %r260;
	.reg.f64 %r261;
	.reg.f64 %r262;
	.reg.f64 %r263;
	.reg.f64 %r264;
	.reg.f64 %r265;
	.reg.f64 %r266;
	.reg.f64 %r267;
	.reg.f64 %r268;
	.reg.f64 %r269;
	.reg.f64 %r270;
	.reg.f64 %r271;
	.reg.f64 %r272;
	.reg.f64 %r273;
	.reg.f64 %r274;
	.reg.f64 %r275;
	.reg.f64 %r276;
	.reg.f64 %r277;
	.reg.f64 %r278;
	.reg.f64 %r279;
	.reg.u64 %r280;
	.reg.u32 %r282;
	.reg.u32 %r283;
	.reg.u32 %r284;
	.reg.u32 %r285;
	.reg.u32 %r286;
	.reg.u32 %r287;
	.reg.u32 %r288;
	.reg.u32 %r290;
	.reg.u32 %r291;
	.reg.u32 %r294;
	.reg.u32 %r295;
	.reg.u32 %r296;
	.reg.pred %r297;
	.reg.u64 %r298;
	.reg.u32 %r299;
	.reg.pred %r300;
	.reg.pred %r301;
	.reg.f64 %r302;
	.reg.f64 %r303;
	.reg.f64 %r304;
	.reg.f64 %r305;
	.reg.f64 %r306;
	.reg.f64 %r307;
	.reg.f64 %r308;
	.reg.f64 %r309;
	.reg.f64 %r310;
	.reg.f64 %r311;
	.reg.f64 %r312;
	.reg.f64 %r313;
	.reg.f64 %r314;
	.reg.f64 %r315;
	.reg.f64 %r316;
	.reg.f64 %r317;
	.reg.f64 %r318;
	.reg.u32 %r319;
	.reg.pred %r320;
	.reg.f64 %r321;
	.reg.f64 %r322;
	.reg.f64 %r323;
	.reg.f64 %r324;
	.reg.f64 %r325;
	.reg.f64 %r326;
	.reg.f64 %r327;
	.reg.f64 %r328;
	.reg.f64 %r329;
	.reg.f64 %r330;
	.reg.f64 %r331;
	.reg.f64 %r332;
	.reg.f64 %r333;
	.reg.f64 %r334;
	.reg.f64 %r335;
	.reg.f64 %r336;
	.reg.f64 %r337;
	.reg.f64 %r338;
	.reg.f64 %r339;
	.reg.f64 %r340;
	.reg.f64 %r341;
	.reg.f64 %r342;
	.reg.f64 %r343;
	.reg.f64 %r344;
	.reg.f64 %r345;
	.reg.f64 %r360;
	.reg.f64 %r366;
	.reg.f64 %r367;
	.reg.f64 %r368;
	.reg.f64 %r369;
	.reg.f64 %r370;
	.reg.f64 %r371;
	.reg.f64 %r372;
	.reg.f64 %r373;
	.reg.f64 %r374;
	.reg.f64 %r375;
	.reg.f64 %r376;
	.reg.f64 %r377;
	.reg.f64 %r378;
	.reg.f64 %r379;
	.reg.f64 %r380;
	.reg.f64 %r381;
	.reg.f64 %r382;
	.reg.f64 %r383;
	.reg.f64 %r384;
	.reg.f64 %r385;
	.reg.f64 %r386;
	.reg.f64 %r387;
	.reg.f64 %r388;
	.reg.f64 %r389;
	.reg.f64 %r390;
	.reg.f64 %r391;
	.reg.f64 %r392;
	.reg.f64 %r393;
	.reg.f64 %r394;
	.reg.f64 %r395;
	.reg.f64 %r396;
	.reg.f64 %r397;
	.reg.f64 %r398;
	.reg.f64 %r399;
	.reg.f64 %r400;
	.reg.f64 %r401;
	.reg.f64 %r402;
	.reg.f64 %r403;
	.reg.u32 %r404;
	.reg.u32 %r405;
	.reg.u32 %r406;
	.reg.u32 %r407;
	.reg.u32 %r408;
	.reg.pred %r409;
	{
		.reg.u32	%x;
		mov.u32	%x, %tid.x;
		setp.ne.u32	%r409, %x, 0;
	}
	@%r409	bra	$L11;
		mov.u64	%r280, %ar0;
		ld.u64	%r23, [%r280+40];
		ld.u64	%r24, [%r280+48];
	// fork 4;
$L11:
	// forked 4;
		mov.b64	{%r405,%r406}, %r23;
		shfl.idx.b32	%r405, %r405, 0, 31;
		shfl.idx.b32	%r406, %r406, 0, 31;
		mov.b64	%r23, {%r405,%r406};
		mov.b64	{%r407,%r408}, %r24;
		shfl.idx.b32	%r407, %r407, 0, 31;
		shfl.idx.b32	%r408, %r408, 0, 31;
		mov.b64	%r24, {%r407,%r408};
		mov.u32	%r182, %nctaid.x;
		mov.u32	%r183, %ctaid.x;
		mov.u32	%r184, %tid.x;
		shl.b32	%r282, %r182, 2;
		add.u32	%r283, %r282, %r182;
		shl.b32	%r284, %r283, 7;
		add.u32	%r285, %r284, 25999999;
		div.s32	%r177, %r285, %r284;
		mul.lo.u32	%r286, %r177, %r183;
		shl.b32	%r287, %r286, 5;
		add.u32	%r288, %r287, %r184;
		shl.b32	%r290, %r288, 2;
		add.u32	%r291, %r290, %r288;
		shl.b32	%r22, %r291, 2;
		shl.b32	%r294, %r177, 2;
		add.u32	%r295, %r294, %r177;
		shl.b32	%r296, %r295, 7;
		add.u32	%r26, %r296, %r22;
		min.s32	%r404, %r26, 26000000;
		setp.ge.s32	%r297, %r22, %r404;
	@%r297	bra	$L2;
		cvt.s64.s32	%r298, %r22;
		shl.b64	%r174, %r298, 3;
$L5:
		add.u64	%r196, %r24, %r174;
		ld.u32	%r27, [%r196+152];
		ld.f64	%r279, [%r196];
		and.b32	%r299, %r27, 1;
		setp.ne.u32	%r300, %r299, 0;
	@!%r300	bra	$L10;
		bra	$L3;
$L7:
		add.u32	%r22, %r22, 640;
		add.u64	%r174, %r174, 5120;
		setp.gt.s32	%r301, %r404, %r22;
	@%r301	bra	$L5;
		bra	$L2;
$L10:
		ld.f64	%r29, [%r196+8];
		ld.f64	%r31, [%r196+16];
		ld.f64	%r33, [%r196+24];
		ld.f64	%r35, [%r196+32];
		ld.f64	%r37, [%r196+40];
		ld.f64	%r39, [%r196+48];
		ld.f64	%r41, [%r196+56];
		ld.f64	%r43, [%r196+64];
		ld.f64	%r45, [%r196+72];
		ld.f64	%r47, [%r196+80];
		ld.f64	%r49, [%r196+88];
		ld.f64	%r51, [%r196+96];
		ld.f64	%r53, [%r196+104];
		ld.f64	%r55, [%r196+112];
		ld.f64	%r57, [%r196+120];
		ld.f64	%r59, [%r196+128];
		ld.f64	%r61, [%r196+136];
		ld.f64	%r63, [%r196+144];
		add.f64	%r302, %r29, %r279;
		add.f64	%r303, %r302, %r31;
		add.f64	%r304, %r303, %r33;
		add.f64	%r305, %r304, %r35;
		add.f64	%r306, %r305, %r37;
		add.f64	%r307, %r306, %r39;
		add.f64	%r308, %r307, %r41;
		add.f64	%r309, %r308, %r43;
		add.f64	%r310, %r309, %r45;
		add.f64	%r311, %r310, %r47;
		add.f64	%r312, %r311, %r49;
		add.f64	%r313, %r312, %r51;
		add.f64	%r314, %r313, %r53;
		add.f64	%r315, %r314, %r55;
		add.f64	%r316, %r315, %r57;
		add.f64	%r317, %r316, %r59;
		add.f64	%r318, %r317, %r61;
		add.f64	%r64, %r318, %r63;
		and.b32	%r319, %r27, 2;
		setp.ne.u32	%r320, %r319, 0;
	@%r320	bra	$L8;
		sub.f64	%r321, %r33, %r35;
		add.f64	%r322, %r321, %r41;
		sub.f64	%r323, %r322, %r43;
		add.f64	%r324, %r323, %r45;
		sub.f64	%r325, %r324, %r47;
		add.f64	%r326, %r325, %r57;
		add.f64	%r327, %r326, %r59;
		sub.f64	%r328, %r327, %r61;
		sub.f64	%r73, %r328, %r63;
		div.rn.f64	%r92, %r73, %r64;
		sub.f64	%r329, %r29, %r31;
		add.f64	%r330, %r329, %r41;
		add.f64	%r331, %r330, %r43;
		sub.f64	%r332, %r331, %r45;
		sub.f64	%r333, %r332, %r47;
		add.f64	%r334, %r333, %r49;
		add.f64	%r335, %r334, %r51;
		sub.f64	%r336, %r335, %r53;
		sub.f64	%r82, %r336, %r55;
		div.rn.f64	%r93, %r82, %r64;
		sub.f64	%r337, %r37, %r39;
		add.f64	%r338, %r337, %r49;
		sub.f64	%r339, %r338, %r51;
		add.f64	%r340, %r339, %r53;
		sub.f64	%r341, %r340, %r55;
		add.f64	%r342, %r341, %r57;
		sub.f64	%r343, %r342, %r59;
		add.f64	%r344, %r343, %r61;
		sub.f64	%r91, %r344, %r63;
		div.rn.f64	%r94, %r91, %r64;
		mul.f64	%r345, %r93, %r93;
		fma.rn.f64	%r208, %r92, %r92, %r345;
		fma.rn.f64	%r209, %r94, %r94, %r208;
		fma.rn.f64	%r210, %r209, 0dbff8000000000000, 0d3ff0000000000000;
		fma.rn.f64	%r211, %r93, 0d4012000000000000, 0d4008000000000000;
		fma.rn.f64	%r212, %r93, %r211, 0d3ff0000000000000;
		fma.rn.f64	%r213, %r209, 0dbff8000000000000, %r212;
		fma.rn.f64	%r214, %r93, 0d4012000000000000, 0dc008000000000000;
		fma.rn.f64	%r215, %r93, %r214, 0d3ff0000000000000;
		fma.rn.f64	%r216, %r209, 0dbff8000000000000, %r215;
		fma.rn.f64	%r217, %r92, 0d4012000000000000, 0d4008000000000000;
		fma.rn.f64	%r218, %r92, %r217, 0d3ff0000000000000;
		fma.rn.f64	%r219, %r209, 0dbff8000000000000, %r218;
		fma.rn.f64	%r220, %r92, 0d4012000000000000, 0dc008000000000000;
		fma.rn.f64	%r221, %r92, %r220, 0d3ff0000000000000;
		fma.rn.f64	%r222, %r209, 0dbff8000000000000, %r221;
		fma.rn.f64	%r223, %r94, 0d4012000000000000, 0d4008000000000000;
		fma.rn.f64	%r224, %r94, %r223, 0d3ff0000000000000;
		fma.rn.f64	%r225, %r209, 0dbff8000000000000, %r224;
		fma.rn.f64	%r226, %r94, 0d4012000000000000, 0dc008000000000000;
		fma.rn.f64	%r227, %r94, %r226, 0d3ff0000000000000;
		fma.rn.f64	%r228, %r209, 0dbff8000000000000, %r227;
		add.f64	%r229, %r92, %r93;
		fma.rn.f64	%r230, %r229, 0d4012000000000000, 0d4008000000000000;
		fma.rn.f64	%r231, %r229, %r230, 0d3ff0000000000000;
		fma.rn.f64	%r232, %r209, 0dbff8000000000000, %r231;
		sub.f64	%r233, %r93, %r92;
		fma.rn.f64	%r234, %r233, 0d4012000000000000, 0d4008000000000000;
		fma.rn.f64	%r235, %r233, %r234, 0d3ff0000000000000;
		fma.rn.f64	%r236, %r209, 0dbff8000000000000, %r235;
		sub.f64	%r237, %r92, %r93;
		fma.rn.f64	%r238, %r237, 0d4012000000000000, 0d4008000000000000;
		fma.rn.f64	%r239, %r237, %r238, 0d3ff0000000000000;
		fma.rn.f64	%r240, %r209, 0dbff8000000000000, %r239;
		neg.f64	%r241, %r92;
		sub.f64	%r242, %r241, %r93;
		fma.rn.f64	%r243, %r242, 0d4012000000000000, 0d4008000000000000;
		fma.rn.f64	%r244, %r242, %r243, 0d3ff0000000000000;
		fma.rn.f64	%r245, %r209, 0dbff8000000000000, %r244;
		add.f64	%r246, %r93, %r94;
		fma.rn.f64	%r247, %r246, 0d4012000000000000, 0d4008000000000000;
		fma.rn.f64	%r248, %r246, %r247, 0d3ff0000000000000;
		fma.rn.f64	%r249, %r209, 0dbff8000000000000, %r248;
		sub.f64	%r250, %r93, %r94;
		fma.rn.f64	%r251, %r250, 0d4012000000000000, 0d4008000000000000;
		fma.rn.f64	%r252, %r250, %r251, 0d3ff0000000000000;
		fma.rn.f64	%r253, %r209, 0dbff8000000000000, %r252;
		sub.f64	%r254, %r94, %r93;
		fma.rn.f64	%r255, %r254, 0d4012000000000000, 0d4008000000000000;
		fma.rn.f64	%r256, %r254, %r255, 0d3ff0000000000000;
		fma.rn.f64	%r257, %r209, 0dbff8000000000000, %r256;
		neg.f64	%r360, %r93;
		sub.f64	%r259, %r360, %r94;
		fma.rn.f64	%r260, %r259, 0d4012000000000000, 0d4008000000000000;
		fma.rn.f64	%r261, %r259, %r260, 0d3ff0000000000000;
		fma.rn.f64	%r262, %r209, 0dbff8000000000000, %r261;
		add.f64	%r263, %r92, %r94;
		fma.rn.f64	%r264, %r263, 0d4012000000000000, 0d4008000000000000;
		fma.rn.f64	%r265, %r263, %r264, 0d3ff0000000000000;
		fma.rn.f64	%r266, %r209, 0dbff8000000000000, %r265;
		sub.f64	%r267, %r92, %r94;
		fma.rn.f64	%r268, %r267, 0d4012000000000000, 0d4008000000000000;
		fma.rn.f64	%r269, %r267, %r268, 0d3ff0000000000000;
		fma.rn.f64	%r270, %r209, 0dbff8000000000000, %r269;
		sub.f64	%r271, %r94, %r92;
		fma.rn.f64	%r272, %r271, 0d4012000000000000, 0d4008000000000000;
		fma.rn.f64	%r273, %r271, %r272, 0d3ff0000000000000;
		fma.rn.f64	%r274, %r209, 0dbff8000000000000, %r273;
		sub.f64	%r275, %r241, %r94;
		fma.rn.f64	%r276, %r275, 0d4012000000000000, 0d4008000000000000;
		fma.rn.f64	%r277, %r275, %r276, 0d3ff0000000000000;
		fma.rn.f64	%r278, %r209, 0dbff8000000000000, %r277;
		bra	$L6;
$L8:
		mov.f64	%r278, 0d3fef85af6c69b5a6;
		mov.f64	%r274, %r278;
		mov.f64	%r270, 0d3ff03db8fde2ef4e;
		mov.f64	%r266, %r270;
		mov.f64	%r262, 0d3fefcea39c51dabe;
		mov.f64	%r257, %r262;
		mov.f64	%r253, 0d3ff01878b7a1c25d;
		mov.f64	%r249, %r253;
		mov.f64	%r245, 0d3fef556b00ffda41;
		mov.f64	%r240, 0d3ff024da09cc319c;
		mov.f64	%r236, 0d3fefb63f572de43f;
		mov.f64	%r232, 0d3ff056bdb1a6d699;
		mov.f64	%r228, 0d3fefffa4c61d8623;
		mov.f64	%r225, %r228;
		mov.f64	%r222, %r278;
		mov.f64	%r219, %r270;
		mov.f64	%r216, %r262;
		mov.f64	%r213, %r253;
		mov.f64	%r210, %r228;
$L6:
		mul.f64	%r366, %r64, 0d3fe4cccccccccccc;
		mul.f64	%r367, %r366, %r210;
		fma.rn.f64	%r98, %r279, 0dbfee666666666666, %r367;
		add.u64	%r195, %r23, %r174;
		st.f64	[%r195], %r98;
		mul.f64	%r100, %r64, 0d3fbbbbbbbbbbbbbb;
		mul.f64	%r368, %r100, %r213;
		ld.f64	%r369, [%r196+8];
		fma.rn.f64	%r102, %r369, 0dbfee666666666666, %r368;
		st.f64	[%r195+16008], %r102;
		mul.f64	%r370, %r100, %r216;
		ld.f64	%r371, [%r196+16];
		fma.rn.f64	%r105, %r371, 0dbfee666666666666, %r370;
		st.f64	[%r195+-15984], %r105;
		mul.f64	%r372, %r100, %r219;
		ld.f64	%r373, [%r196+24];
		fma.rn.f64	%r108, %r373, 0dbfee666666666666, %r372;
		st.f64	[%r195+184], %r108;
		mul.f64	%r374, %r100, %r222;
		ld.f64	%r375, [%r196+32];
		fma.rn.f64	%r111, %r375, 0dbfee666666666666, %r374;
		st.f64	[%r195+-128], %r111;
		mul.f64	%r376, %r100, %r225;
		ld.f64	%r377, [%r196+40];
		fma.rn.f64	%r114, %r377, 0dbfee666666666666, %r376;
		st.f64	[%r195+1600040], %r114;
		mul.f64	%r378, %r100, %r228;
		ld.f64	%r379, [%r196+48];
		fma.rn.f64	%r117, %r379, 0dbfee666666666666, %r378;
		st.f64	[%r195+-1599952], %r117;
		mul.f64	%r119, %r64, 0d3fabbbbbbbbbbbbb;
		mul.f64	%r380, %r119, %r232;
		ld.f64	%r381, [%r196+56];
		fma.rn.f64	%r121, %r381, 0dbfee666666666666, %r380;
		st.f64	[%r195+16216], %r121;
		mul.f64	%r382, %r119, %r236;
		ld.f64	%r383, [%r196+64];
		fma.rn.f64	%r124, %r383, 0dbfee666666666666, %r382;
		st.f64	[%r195+15904], %r124;
		mul.f64	%r384, %r119, %r240;
		ld.f64	%r385, [%r196+72];
		fma.rn.f64	%r127, %r385, 0dbfee666666666666, %r384;
		st.f64	[%r195+-15768], %r127;
		mul.f64	%r386, %r119, %r245;
		ld.f64	%r387, [%r196+80];
		fma.rn.f64	%r130, %r387, 0dbfee666666666666, %r386;
		st.f64	[%r195+-16080], %r130;
		mul.f64	%r388, %r119, %r249;
		ld.f64	%r389, [%r196+88];
		fma.rn.f64	%r133, %r389, 0dbfee666666666666, %r388;
		st.f64	[%r195+1616088], %r133;
		mul.f64	%r390, %r119, %r253;
		ld.f64	%r391, [%r196+96];
		fma.rn.f64	%r136, %r391, 0dbfee666666666666, %r390;
		st.f64	[%r195+-1583904], %r136;
		mul.f64	%r392, %r119, %r257;
		ld.f64	%r393, [%r196+104];
		fma.rn.f64	%r139, %r393, 0dbfee666666666666, %r392;
		st.f64	[%r195+1584104], %r139;
		mul.f64	%r394, %r119, %r262;
		ld.f64	%r395, [%r196+112];
		fma.rn.f64	%r142, %r395, 0dbfee666666666666, %r394;
		st.f64	[%r195+-1615888], %r142;
		mul.f64	%r396, %r119, %r266;
		ld.f64	%r397, [%r196+120];
		fma.rn.f64	%r145, %r397, 0dbfee666666666666, %r396;
		st.f64	[%r195+1600280], %r145;
		mul.f64	%r398, %r119, %r270;
		ld.f64	%r399, [%r196+128];
		fma.rn.f64	%r148, %r399, 0dbfee666666666666, %r398;
		st.f64	[%r195+-1599712], %r148;
		mul.f64	%r400, %r119, %r274;
		ld.f64	%r401, [%r196+136];
		fma.rn.f64	%r151, %r401, 0dbfee666666666666, %r400;
		st.f64	[%r195+1599976], %r151;
		mul.f64	%r402, %r119, %r278;
		ld.f64	%r403, [%r196+144];
		fma.rn.f64	%r154, %r403, 0dbfee666666666666, %r402;
		st.f64	[%r195+-1600016], %r154;
		bra	$L7;
$L3:
		add.u64	%r194, %r23, %r174;
		st.f64	[%r194], %r279;
		ld.f64	%r155, [%r196+8];
		st.f64	[%r194+-15984], %r155;
		ld.f64	%r156, [%r196+16];
		st.f64	[%r194+16008], %r156;
		ld.f64	%r157, [%r196+24];
		st.f64	[%r194+-128], %r157;
		ld.f64	%r158, [%r196+32];
		st.f64	[%r194+184], %r158;
		ld.f64	%r159, [%r196+40];
		st.f64	[%r194+-1599952], %r159;
		ld.f64	%r160, [%r196+48];
		st.f64	[%r194+1600040], %r160;
		ld.f64	%r161, [%r196+56];
		st.f64	[%r194+-16080], %r161;
		ld.f64	%r162, [%r196+64];
		st.f64	[%r194+-15768], %r162;
		ld.f64	%r163, [%r196+72];
		st.f64	[%r194+15904], %r163;
		ld.f64	%r164, [%r196+80];
		st.f64	[%r194+16216], %r164;
		ld.f64	%r165, [%r196+88];
		st.f64	[%r194+-1615888], %r165;
		ld.f64	%r166, [%r196+96];
		st.f64	[%r194+1584104], %r166;
		ld.f64	%r167, [%r196+104];
		st.f64	[%r194+-1583904], %r167;
		ld.f64	%r168, [%r196+112];
		st.f64	[%r194+1616088], %r168;
		ld.f64	%r169, [%r196+120];
		st.f64	[%r194+-1600016], %r169;
		ld.f64	%r170, [%r196+128];
		st.f64	[%r194+1599976], %r170;
		ld.f64	%r171, [%r196+136];
		st.f64	[%r194+-1599712], %r171;
		ld.f64	%r172, [%r196+144];
		st.f64	[%r194+1600280], %r172;
		bra	$L7;
$L2:
	// joining 4;
	// join 4;
	ret;
}

// BEGIN FUNCTION DECL: LBM_handleInOutFlow$_omp_fn$0
.entry LBM_handleInOutFlow$_omp_fn$0 (.param.u64 %in_ar0);

// BEGIN FUNCTION DEF: LBM_handleInOutFlow$_omp_fn$0
.entry LBM_handleInOutFlow$_omp_fn$0 (.param.u64 %in_ar0)
{
	.reg.u64 %ar0;
	ld.param.u64 %ar0, [%in_ar0];
	.reg.u64 %r23;
	.reg.f64 %r24;
	.reg.u32 %r27;
	.reg.f64 %r102;
	.reg.f64 %r107;
	.reg.f64 %r111;
	.reg.f64 %r112;
	.reg.f64 %r114;
	.reg.f64 %r115;
	.reg.f64 %r116;
	.reg.f64 %r118;
	.reg.f64 %r120;
	.reg.f64 %r121;
	.reg.f64 %r122;
	.reg.f64 %r123;
	.reg.f64 %r124;
	.reg.f64 %r126;
	.reg.f64 %r127;
	.reg.f64 %r128;
	.reg.f64 %r130;
	.reg.f64 %r131;
	.reg.f64 %r132;
	.reg.f64 %r133;
	.reg.f64 %r134;
	.reg.f64 %r135;
	.reg.f64 %r136;
	.reg.f64 %r137;
	.reg.f64 %r138;
	.reg.f64 %r139;
	.reg.f64 %r140;
	.reg.f64 %r141;
	.reg.f64 %r142;
	.reg.f64 %r144;
	.reg.f64 %r145;
	.reg.f64 %r146;
	.reg.u32 %r148;
	.reg.u32 %r151;
	.reg.u32 %r156;
	.reg.u32 %r157;
	.reg.u32 %r158;
	.reg.u64 %r173;
	.reg.u64 %r174;
	.reg.u32 %r176;
	.reg.u32 %r177;
	.reg.u32 %r178;
	.reg.u32 %r179;
	.reg.u32 %r180;
	.reg.u32 %r181;
	.reg.u32 %r182;
	.reg.u32 %r184;
	.reg.u32 %r185;
	.reg.u32 %r186;
	.reg.u32 %r188;
	.reg.u32 %r189;
	.reg.u32 %r190;
	.reg.pred %r191;
	.reg.u64 %r192;
	.reg.u64 %r193;
	.reg.f64 %r194;
	.reg.f64 %r195;
	.reg.f64 %r196;
	.reg.f64 %r197;
	.reg.f64 %r198;
	.reg.f64 %r199;
	.reg.f64 %r200;
	.reg.f64 %r201;
	.reg.f64 %r202;
	.reg.f64 %r203;
	.reg.f64 %r204;
	.reg.f64 %r205;
	.reg.f64 %r206;
	.reg.f64 %r207;
	.reg.f64 %r208;
	.reg.f64 %r209;
	.reg.f64 %r210;
	.reg.f64 %r211;
	.reg.f64 %r212;
	.reg.f64 %r213;
	.reg.f64 %r214;
	.reg.f64 %r215;
	.reg.f64 %r216;
	.reg.f64 %r217;
	.reg.f64 %r218;
	.reg.f64 %r219;
	.reg.f64 %r220;
	.reg.f64 %r221;
	.reg.f64 %r222;
	.reg.f64 %r223;
	.reg.f64 %r224;
	.reg.f64 %r225;
	.reg.f64 %r226;
	.reg.f64 %r227;
	.reg.f64 %r228;
	.reg.f64 %r229;
	.reg.f64 %r230;
	.reg.f64 %r231;
	.reg.f64 %r232;
	.reg.f64 %r233;
	.reg.f64 %r234;
	.reg.f64 %r235;
	.reg.f64 %r236;
	.reg.f64 %r237;
	.reg.f64 %r238;
	.reg.f64 %r239;
	.reg.f64 %r240;
	.reg.f64 %r241;
	.reg.f64 %r242;
	.reg.f64 %r243;
	.reg.f64 %r244;
	.reg.f64 %r245;
	.reg.f64 %r246;
	.reg.f64 %r247;
	.reg.f64 %r248;
	.reg.f64 %r249;
	.reg.f64 %r250;
	.reg.f64 %r251;
	.reg.f64 %r252;
	.reg.f64 %r253;
	.reg.f64 %r254;
	.reg.f64 %r255;
	.reg.f64 %r256;
	.reg.f64 %r257;
	.reg.f64 %r258;
	.reg.f64 %r259;
	.reg.f64 %r260;
	.reg.f64 %r261;
	.reg.f64 %r262;
	.reg.f64 %r263;
	.reg.f64 %r264;
	.reg.f64 %r265;
	.reg.f64 %r266;
	.reg.f64 %r267;
	.reg.f64 %r268;
	.reg.u32 %r272;
	.reg.u32 %r276;
	.reg.f64 %r277;
	.reg.f64 %r278;
	.reg.f64 %r279;
	.reg.u32 %r283;
	.reg.f64 %r284;
	.reg.f64 %r285;
	.reg.f64 %r287;
	.reg.f64 %r288;
	.reg.f64 %r289;
	.reg.f64 %r291;
	.reg.f64 %r292;
	.reg.f64 %r294;
	.reg.f64 %r296;
	.reg.f64 %r298;
	.reg.f64 %r300;
	.reg.pred %r303;
	.reg.u32 %r304;
	.reg.u32 %r305;
	.reg.u32 %r306;
	.reg.pred %r307;
	{
		.reg.u32	%x;
		mov.u32	%x, %tid.x;
		setp.ne.u32	%r307, %x, 0;
	}
	@%r307	bra	$L16;
		mov.u64	%r174, %ar0;
		ld.u64	%r23, [%r174+72];
	// fork 4;
$L16:
	// forked 4;
		mov.b64	{%r305,%r306}, %r23;
		shfl.idx.b32	%r305, %r305, 0, 31;
		shfl.idx.b32	%r306, %r306, 0, 31;
		mov.b64	%r23, {%r305,%r306};
		mov.u32	%r156, %nctaid.x;
		mov.u32	%r157, %ctaid.x;
		mov.u32	%r158, %tid.x;
		shl.b32	%r176, %r156, 2;
		add.u32	%r177, %r176, %r156;
		shl.b32	%r178, %r177, 7;
		add.u32	%r179, %r178, 199999;
		div.s32	%r151, %r179, %r178;
		mul.lo.u32	%r180, %r151, %r157;
		shl.b32	%r181, %r180, 5;
		add.u32	%r182, %r181, %r158;
		shl.b32	%r184, %r182, 2;
		add.u32	%r185, %r184, %r182;
		shl.b32	%r186, %r185, 2;
		shl.b32	%r188, %r151, 2;
		add.u32	%r189, %r188, %r151;
		shl.b32	%r190, %r189, 7;
		add.u32	%r27, %r190, %r186;
		min.s32	%r304, %r27, 200000;
		setp.ge.s32	%r191, %r186, %r304;
	@%r191	bra	$L13;
		mov.u32	%r148, %r186;
		cvt.s64.s32	%r192, %r148;
		shl.b64	%r193, %r192, 3;
		add.u64	%r173, %r23, %r193;
$L14:
		ld.f64	%r195, [%r173+1600000];
		ld.f64	%r196, [%r173+1600008];
		add.f64	%r194, %r195, %r196;
		ld.f64	%r198, [%r173+1600016];
		add.f64	%r197, %r194, %r198;
		ld.f64	%r200, [%r173+1600024];
		add.f64	%r199, %r197, %r200;
		ld.f64	%r202, [%r173+1600032];
		add.f64	%r201, %r199, %r202;
		ld.f64	%r204, [%r173+1600040];
		add.f64	%r203, %r201, %r204;
		ld.f64	%r206, [%r173+1600048];
		add.f64	%r205, %r203, %r206;
		ld.f64	%r208, [%r173+1600056];
		add.f64	%r207, %r205, %r208;
		ld.f64	%r210, [%r173+1600064];
		add.f64	%r209, %r207, %r210;
		ld.f64	%r212, [%r173+1600072];
		add.f64	%r211, %r209, %r212;
		ld.f64	%r214, [%r173+1600080];
		add.f64	%r213, %r211, %r214;
		ld.f64	%r216, [%r173+1600088];
		add.f64	%r215, %r213, %r216;
		ld.f64	%r218, [%r173+1600096];
		add.f64	%r217, %r215, %r218;
		ld.f64	%r220, [%r173+1600104];
		add.f64	%r219, %r217, %r220;
		ld.f64	%r222, [%r173+1600112];
		add.f64	%r221, %r219, %r222;
		ld.f64	%r224, [%r173+1600120];
		add.f64	%r223, %r221, %r224;
		ld.f64	%r226, [%r173+1600128];
		add.f64	%r225, %r223, %r226;
		ld.f64	%r228, [%r173+1600136];
		add.f64	%r227, %r225, %r228;
		ld.f64	%r230, [%r173+1600144];
		add.f64	%r229, %r227, %r230;
		ld.f64	%r232, [%r173+3200000];
		ld.f64	%r233, [%r173+3200008];
		add.f64	%r231, %r232, %r233;
		ld.f64	%r235, [%r173+3200016];
		add.f64	%r234, %r231, %r235;
		ld.f64	%r237, [%r173+3200024];
		add.f64	%r236, %r234, %r237;
		ld.f64	%r239, [%r173+3200032];
		add.f64	%r238, %r236, %r239;
		ld.f64	%r241, [%r173+3200040];
		add.f64	%r240, %r238, %r241;
		ld.f64	%r243, [%r173+3200048];
		add.f64	%r242, %r240, %r243;
		ld.f64	%r245, [%r173+3200056];
		add.f64	%r244, %r242, %r245;
		ld.f64	%r247, [%r173+3200064];
		add.f64	%r246, %r244, %r247;
		ld.f64	%r249, [%r173+3200072];
		add.f64	%r248, %r246, %r249;
		ld.f64	%r251, [%r173+3200080];
		add.f64	%r250, %r248, %r251;
		ld.f64	%r253, [%r173+3200088];
		add.f64	%r252, %r250, %r253;
		ld.f64	%r255, [%r173+3200096];
		add.f64	%r254, %r252, %r255;
		ld.f64	%r257, [%r173+3200104];
		add.f64	%r256, %r254, %r257;
		ld.f64	%r259, [%r173+3200112];
		add.f64	%r258, %r256, %r259;
		ld.f64	%r261, [%r173+3200120];
		add.f64	%r260, %r258, %r261;
		ld.f64	%r263, [%r173+3200128];
		add.f64	%r262, %r260, %r263;
		ld.f64	%r265, [%r173+3200136];
		add.f64	%r264, %r262, %r265;
		ld.f64	%r267, [%r173+3200144];
		add.f64	%r266, %r264, %r267;
		neg.f64	%r268, %r266;
		fma.rn.f64	%r102, %r229, 0d4000000000000000, %r268;
		div.s32	%r272, %r148, 20;
		rem.s32	%r276, %r272, 100;
		cvt.rn.f64.s32	%r277, %r276;
		div.rn.f64	%r278, %r277, 0d4048c00000000000;
		mov.f64	%r279, 0d3ff0000000000000;
		sub.f64	%r107, %r278, %r279;
		div.s32	%r283, %r148, 2000;
		cvt.rn.f64.s32	%r284, %r283;
		div.rn.f64	%r285, %r284, 0d4048c00000000000;
		sub.f64	%r111, %r285, %r279;
		neg.f64	%r287, %r107;
		fma.rn.f64	%r112, %r287, %r107, 0d3ff0000000000000;
		neg.f64	%r288, %r111;
		fma.rn.f64	%r114, %r288, %r111, 0d3ff0000000000000;
		mul.f64	%r289, %r112, 0d3f847ae147ae147b;
		mul.f64	%r115, %r289, %r114;
		fma.rn.f64	%r116, %r115, %r115, 0d0000000000000000;
		fma.rn.f64	%r118, %r116, 0dbff8000000000000, 0d3ff0000000000000;
		mul.f64	%r291, %r102, 0d3fd5555555555555;
		mul.f64	%r292, %r291, %r118;
		st.f64	[%r173], %r292;
		mul.f64	%r120, %r102, 0d3fac71c71c71c71c;
		mul.f64	%r121, %r118, %r120;
		st.f64	[%r173+8], %r121;
		st.f64	[%r173+16], %r121;
		st.f64	[%r173+24], %r121;
		st.f64	[%r173+32], %r121;
		fma.rn.f64	%r122, %r115, 0d4012000000000000, 0d4008000000000000;
		fma.rn.f64	%r123, %r115, %r122, 0d3ff0000000000000;
		fma.rn.f64	%r124, %r116, 0dbff8000000000000, %r123;
		mul.f64	%r294, %r120, %r124;
		st.f64	[%r173+40], %r294;
		fma.rn.f64	%r126, %r115, 0d4012000000000000, 0dc008000000000000;
		fma.rn.f64	%r127, %r115, %r126, 0d3ff0000000000000;
		fma.rn.f64	%r128, %r116, 0dbff8000000000000, %r127;
		mul.f64	%r296, %r120, %r128;
		st.f64	[%r173+48], %r296;
		mul.f64	%r130, %r102, 0d3f9c71c71c71c71c;
		mul.f64	%r131, %r118, %r130;
		st.f64	[%r173+56], %r131;
		st.f64	[%r173+64], %r131;
		st.f64	[%r173+72], %r131;
		st.f64	[%r173+80], %r131;
		add.f64	%r132, %r115, 0d0000000000000000;
		fma.rn.f64	%r133, %r132, 0d4012000000000000, 0d4008000000000000;
		fma.rn.f64	%r134, %r132, %r133, 0d3ff0000000000000;
		fma.rn.f64	%r135, %r116, 0dbff8000000000000, %r134;
		mul.f64	%r136, %r130, %r135;
		st.f64	[%r173+88], %r136;
		mov.f64	%r298, 0d0000000000000000;
		sub.f64	%r137, %r298, %r115;
		fma.rn.f64	%r138, %r137, 0d4012000000000000, 0d4008000000000000;
		fma.rn.f64	%r139, %r137, %r138, 0d3ff0000000000000;
		fma.rn.f64	%r140, %r116, 0dbff8000000000000, %r139;
		mul.f64	%r141, %r130, %r140;
		st.f64	[%r173+96], %r141;
		mul.f64	%r142, %r124, %r130;
		st.f64	[%r173+104], %r142;
		neg.f64	%r300, %r115;
		fma.rn.f64	%r24, %r115, 0dc012000000000000, 0d4008000000000000;
		fma.rn.f64	%r144, %r24, %r300, 0d3ff0000000000000;
		fma.rn.f64	%r145, %r116, 0dbff8000000000000, %r144;
		mul.f64	%r146, %r130, %r145;
		st.f64	[%r173+112], %r146;
		st.f64	[%r173+120], %r136;
		st.f64	[%r173+128], %r141;
		st.f64	[%r173+136], %r142;
		st.f64	[%r173+144], %r146;
		add.u32	%r148, %r148, 640;
		add.u64	%r173, %r173, 5120;
		setp.gt.s32	%r303, %r304, %r148;
	@%r303	bra	$L14;
$L13:
	// joining 4;
	// join 4;
	ret;
}

// BEGIN FUNCTION DECL: LBM_handleInOutFlow$_omp_fn$1
.entry LBM_handleInOutFlow$_omp_fn$1 (.param.u64 %in_ar0);

// BEGIN FUNCTION DEF: LBM_handleInOutFlow$_omp_fn$1
.entry LBM_handleInOutFlow$_omp_fn$1 (.param.u64 %in_ar0)
{
	.reg.u64 %ar0;
	ld.param.u64 %ar0, [%in_ar0];
	.reg.u32 %r22;
	.reg.u64 %r23;
	.reg.u32 %r25;
	.reg.f64 %r27;
	.reg.f64 %r29;
	.reg.f64 %r31;
	.reg.f64 %r33;
	.reg.f64 %r35;
	.reg.f64 %r37;
	.reg.f64 %r39;
	.reg.f64 %r41;
	.reg.f64 %r43;
	.reg.f64 %r45;
	.reg.f64 %r47;
	.reg.f64 %r49;
	.reg.f64 %r51;
	.reg.f64 %r53;
	.reg.f64 %r55;
	.reg.f64 %r57;
	.reg.f64 %r59;
	.reg.f64 %r61;
	.reg.f64 %r62;
	.reg.f64 %r71;
	.reg.f64 %r80;
	.reg.f64 %r89;
	.reg.f64 %r91;
	.reg.f64 %r92;
	.reg.f64 %r94;
	.reg.f64 %r96;
	.reg.f64 %r98;
	.reg.f64 %r100;
	.reg.f64 %r102;
	.reg.f64 %r104;
	.reg.f64 %r106;
	.reg.f64 %r108;
	.reg.f64 %r110;
	.reg.f64 %r112;
	.reg.f64 %r114;
	.reg.f64 %r116;
	.reg.f64 %r118;
	.reg.f64 %r120;
	.reg.f64 %r122;
	.reg.f64 %r124;
	.reg.f64 %r126;
	.reg.f64 %r128;
	.reg.f64 %r129;
	.reg.f64 %r138;
	.reg.f64 %r147;
	.reg.f64 %r156;
	.reg.f64 %r158;
	.reg.f64 %r159;
	.reg.f64 %r160;
	.reg.f64 %r161;
	.reg.f64 %r162;
	.reg.f64 %r164;
	.reg.f64 %r165;
	.reg.f64 %r166;
	.reg.f64 %r168;
	.reg.f64 %r169;
	.reg.f64 %r170;
	.reg.f64 %r172;
	.reg.f64 %r173;
	.reg.f64 %r174;
	.reg.f64 %r176;
	.reg.f64 %r177;
	.reg.f64 %r178;
	.reg.f64 %r180;
	.reg.f64 %r181;
	.reg.f64 %r182;
	.reg.f64 %r184;
	.reg.f64 %r185;
	.reg.f64 %r186;
	.reg.f64 %r188;
	.reg.f64 %r189;
	.reg.f64 %r190;
	.reg.f64 %r192;
	.reg.f64 %r193;
	.reg.f64 %r194;
	.reg.f64 %r195;
	.reg.f64 %r197;
	.reg.f64 %r198;
	.reg.f64 %r199;
	.reg.f64 %r200;
	.reg.f64 %r202;
	.reg.f64 %r203;
	.reg.f64 %r204;
	.reg.f64 %r205;
	.reg.f64 %r207;
	.reg.f64 %r208;
	.reg.f64 %r209;
	.reg.f64 %r210;
	.reg.f64 %r211;
	.reg.f64 %r213;
	.reg.f64 %r214;
	.reg.f64 %r215;
	.reg.f64 %r216;
	.reg.f64 %r218;
	.reg.f64 %r219;
	.reg.f64 %r220;
	.reg.f64 %r221;
	.reg.f64 %r223;
	.reg.f64 %r224;
	.reg.f64 %r225;
	.reg.f64 %r226;
	.reg.f64 %r229;
	.reg.f64 %r230;
	.reg.f64 %r231;
	.reg.f64 %r232;
	.reg.f64 %r234;
	.reg.f64 %r235;
	.reg.f64 %r236;
	.reg.f64 %r237;
	.reg.f64 %r239;
	.reg.f64 %r240;
	.reg.f64 %r241;
	.reg.f64 %r242;
	.reg.f64 %r244;
	.reg.f64 %r245;
	.reg.f64 %r246;
	.reg.f64 %r247;
	.reg.f64 %r249;
	.reg.f64 %r250;
	.reg.f64 %r251;
	.reg.f64 %r252;
	.reg.u64 %r255;
	.reg.u32 %r258;
	.reg.u32 %r263;
	.reg.u32 %r264;
	.reg.u32 %r265;
	.reg.u64 %r292;
	.reg.u32 %r294;
	.reg.u32 %r295;
	.reg.u32 %r296;
	.reg.u32 %r297;
	.reg.u32 %r298;
	.reg.u32 %r299;
	.reg.u32 %r300;
	.reg.u32 %r302;
	.reg.u32 %r303;
	.reg.u32 %r306;
	.reg.u32 %r307;
	.reg.u32 %r308;
	.reg.pred %r309;
	.reg.u32 %r310;
	.reg.u64 %r311;
	.reg.u64 %r312;
	.reg.f64 %r313;
	.reg.f64 %r314;
	.reg.f64 %r315;
	.reg.f64 %r316;
	.reg.f64 %r317;
	.reg.f64 %r318;
	.reg.f64 %r319;
	.reg.f64 %r320;
	.reg.f64 %r321;
	.reg.f64 %r322;
	.reg.f64 %r323;
	.reg.f64 %r324;
	.reg.f64 %r325;
	.reg.f64 %r326;
	.reg.f64 %r327;
	.reg.f64 %r328;
	.reg.f64 %r329;
	.reg.f64 %r330;
	.reg.f64 %r331;
	.reg.f64 %r332;
	.reg.f64 %r333;
	.reg.f64 %r334;
	.reg.f64 %r335;
	.reg.f64 %r336;
	.reg.f64 %r337;
	.reg.f64 %r338;
	.reg.f64 %r339;
	.reg.f64 %r340;
	.reg.f64 %r341;
	.reg.f64 %r342;
	.reg.f64 %r343;
	.reg.f64 %r344;
	.reg.f64 %r345;
	.reg.f64 %r346;
	.reg.f64 %r347;
	.reg.f64 %r348;
	.reg.f64 %r349;
	.reg.f64 %r350;
	.reg.f64 %r351;
	.reg.f64 %r352;
	.reg.f64 %r353;
	.reg.f64 %r354;
	.reg.f64 %r355;
	.reg.f64 %r356;
	.reg.f64 %r357;
	.reg.f64 %r358;
	.reg.f64 %r359;
	.reg.f64 %r360;
	.reg.f64 %r361;
	.reg.f64 %r362;
	.reg.f64 %r363;
	.reg.f64 %r364;
	.reg.f64 %r365;
	.reg.f64 %r366;
	.reg.f64 %r367;
	.reg.f64 %r368;
	.reg.f64 %r369;
	.reg.f64 %r370;
	.reg.f64 %r371;
	.reg.f64 %r372;
	.reg.f64 %r373;
	.reg.f64 %r374;
	.reg.f64 %r375;
	.reg.f64 %r376;
	.reg.f64 %r377;
	.reg.f64 %r378;
	.reg.f64 %r379;
	.reg.f64 %r380;
	.reg.f64 %r381;
	.reg.f64 %r382;
	.reg.f64 %r383;
	.reg.f64 %r384;
	.reg.f64 %r385;
	.reg.f64 %r386;
	.reg.f64 %r387;
	.reg.f64 %r388;
	.reg.f64 %r389;
	.reg.f64 %r390;
	.reg.f64 %r391;
	.reg.f64 %r392;
	.reg.f64 %r393;
	.reg.f64 %r394;
	.reg.f64 %r395;
	.reg.f64 %r396;
	.reg.f64 %r397;
	.reg.f64 %r398;
	.reg.f64 %r399;
	.reg.f64 %r400;
	.reg.f64 %r401;
	.reg.f64 %r402;
	.reg.f64 %r404;
	.reg.f64 %r406;
	.reg.f64 %r408;
	.reg.f64 %r410;
	.reg.f64 %r412;
	.reg.f64 %r414;
	.reg.f64 %r416;
	.reg.f64 %r418;
	.reg.f64 %r420;
	.reg.f64 %r422;
	.reg.f64 %r424;
	.reg.f64 %r426;
	.reg.f64 %r428;
	.reg.f64 %r430;
	.reg.f64 %r431;
	.reg.f64 %r433;
	.reg.f64 %r435;
	.reg.f64 %r437;
	.reg.f64 %r439;
	.reg.f64 %r441;
	.reg.pred %r442;
	.reg.u32 %r443;
	.reg.u32 %r444;
	.reg.u32 %r445;
	.reg.pred %r446;
	{
		.reg.u32	%x;
		mov.u32	%x, %tid.x;
		setp.ne.u32	%r446, %x, 0;
	}
	@%r446	bra	$L21;
		mov.u64	%r292, %ar0;
		ld.u64	%r23, [%r292+104];
	// fork 4;
$L21:
	// forked 4;
		mov.b64	{%r444,%r445}, %r23;
		shfl.idx.b32	%r444, %r444, 0, 31;
		shfl.idx.b32	%r445, %r445, 0, 31;
		mov.b64	%r23, {%r444,%r445};
		mov.u32	%r263, %nctaid.x;
		mov.u32	%r264, %ctaid.x;
		mov.u32	%r265, %tid.x;
		shl.b32	%r294, %r263, 2;
		add.u32	%r295, %r294, %r263;
		shl.b32	%r296, %r295, 7;
		add.u32	%r297, %r296, 199999;
		div.s32	%r258, %r297, %r296;
		mul.lo.u32	%r298, %r258, %r264;
		shl.b32	%r299, %r298, 5;
		add.u32	%r300, %r299, %r265;
		shl.b32	%r302, %r300, 2;
		add.u32	%r303, %r302, %r300;
		shl.b32	%r22, %r303, 2;
		shl.b32	%r306, %r258, 2;
		add.u32	%r307, %r306, %r258;
		shl.b32	%r308, %r307, 7;
		add.u32	%r25, %r308, %r22;
		min.s32	%r443, %r25, 200000;
		setp.ge.s32	%r309, %r22, %r443;
	@%r309	bra	$L18;
		add.u32	%r310, %r22, 25400000;
		cvt.s64.s32	%r311, %r310;
		shl.b64	%r312, %r311, 3;
		add.u64	%r255, %r23, %r312;
$L19:
		ld.f64	%r27, [%r255+1600008];
		ld.f64	%r29, [%r255+1600016];
		ld.f64	%r31, [%r255+1600024];
		ld.f64	%r33, [%r255+1600032];
		ld.f64	%r35, [%r255+1600040];
		ld.f64	%r37, [%r255+1600048];
		ld.f64	%r39, [%r255+1600056];
		ld.f64	%r41, [%r255+1600064];
		ld.f64	%r43, [%r255+1600072];
		ld.f64	%r45, [%r255+1600080];
		ld.f64	%r47, [%r255+1600088];
		ld.f64	%r49, [%r255+1600096];
		ld.f64	%r51, [%r255+1600104];
		ld.f64	%r53, [%r255+1600112];
		ld.f64	%r55, [%r255+1600120];
		ld.f64	%r57, [%r255+1600128];
		ld.f64	%r59, [%r255+1600136];
		ld.f64	%r61, [%r255+1600144];
		ld.f64	%r314, [%r255+1600000];
		add.f64	%r313, %r27, %r314;
		add.f64	%r315, %r313, %r29;
		add.f64	%r316, %r315, %r31;
		add.f64	%r317, %r316, %r33;
		add.f64	%r318, %r317, %r35;
		add.f64	%r319, %r318, %r37;
		add.f64	%r320, %r319, %r39;
		add.f64	%r321, %r320, %r41;
		add.f64	%r322, %r321, %r43;
		add.f64	%r323, %r322, %r45;
		add.f64	%r324, %r323, %r47;
		add.f64	%r325, %r324, %r49;
		add.f64	%r326, %r325, %r51;
		add.f64	%r327, %r326, %r53;
		add.f64	%r328, %r327, %r55;
		add.f64	%r329, %r328, %r57;
		add.f64	%r330, %r329, %r59;
		add.f64	%r62, %r330, %r61;
		sub.f64	%r331, %r31, %r33;
		add.f64	%r332, %r331, %r39;
		sub.f64	%r333, %r332, %r41;
		add.f64	%r334, %r333, %r43;
		sub.f64	%r335, %r334, %r45;
		add.f64	%r336, %r335, %r55;
		add.f64	%r337, %r336, %r57;
		sub.f64	%r338, %r337, %r59;
		sub.f64	%r71, %r338, %r61;
		sub.f64	%r339, %r27, %r29;
		add.f64	%r340, %r339, %r39;
		add.f64	%r341, %r340, %r41;
		sub.f64	%r342, %r341, %r43;
		sub.f64	%r343, %r342, %r45;
		add.f64	%r344, %r343, %r47;
		add.f64	%r345, %r344, %r49;
		sub.f64	%r346, %r345, %r51;
		sub.f64	%r80, %r346, %r53;
		sub.f64	%r347, %r35, %r37;
		add.f64	%r348, %r347, %r47;
		sub.f64	%r349, %r348, %r49;
		add.f64	%r350, %r349, %r51;
		sub.f64	%r351, %r350, %r53;
		add.f64	%r352, %r351, %r55;
		sub.f64	%r353, %r352, %r57;
		add.f64	%r354, %r353, %r59;
		sub.f64	%r89, %r354, %r61;
		div.rn.f64	%r91, %r80, %r62;
		div.rn.f64	%r92, %r89, %r62;
		ld.f64	%r94, [%r255+8];
		ld.f64	%r96, [%r255+16];
		ld.f64	%r98, [%r255+24];
		ld.f64	%r100, [%r255+32];
		ld.f64	%r102, [%r255+40];
		ld.f64	%r104, [%r255+48];
		ld.f64	%r106, [%r255+56];
		ld.f64	%r108, [%r255+64];
		ld.f64	%r110, [%r255+72];
		ld.f64	%r112, [%r255+80];
		ld.f64	%r114, [%r255+88];
		ld.f64	%r116, [%r255+96];
		ld.f64	%r118, [%r255+104];
		ld.f64	%r120, [%r255+112];
		ld.f64	%r122, [%r255+120];
		ld.f64	%r124, [%r255+128];
		ld.f64	%r126, [%r255+136];
		ld.f64	%r128, [%r255+144];
		ld.f64	%r356, [%r255];
		add.f64	%r355, %r94, %r356;
		add.f64	%r357, %r355, %r96;
		add.f64	%r358, %r357, %r98;
		add.f64	%r359, %r358, %r100;
		add.f64	%r360, %r359, %r102;
		add.f64	%r361, %r360, %r104;
		add.f64	%r362, %r361, %r106;
		add.f64	%r363, %r362, %r108;
		add.f64	%r364, %r363, %r110;
		add.f64	%r365, %r364, %r112;
		add.f64	%r366, %r365, %r114;
		add.f64	%r367, %r366, %r116;
		add.f64	%r368, %r367, %r118;
		add.f64	%r369, %r368, %r120;
		add.f64	%r370, %r369, %r122;
		add.f64	%r371, %r370, %r124;
		add.f64	%r372, %r371, %r126;
		add.f64	%r129, %r372, %r128;
		sub.f64	%r373, %r98, %r100;
		add.f64	%r374, %r373, %r106;
		sub.f64	%r375, %r374, %r108;
		add.f64	%r376, %r375, %r110;
		sub.f64	%r377, %r376, %r112;
		add.f64	%r378, %r377, %r122;
		add.f64	%r379, %r378, %r124;
		sub.f64	%r380, %r379, %r126;
		sub.f64	%r138, %r380, %r128;
		sub.f64	%r381, %r94, %r96;
		add.f64	%r382, %r381, %r106;
		add.f64	%r383, %r382, %r108;
		sub.f64	%r384, %r383, %r110;
		sub.f64	%r385, %r384, %r112;
		add.f64	%r386, %r385, %r114;
		add.f64	%r387, %r386, %r116;
		sub.f64	%r388, %r387, %r118;
		sub.f64	%r147, %r388, %r120;
		sub.f64	%r389, %r102, %r104;
		add.f64	%r390, %r389, %r114;
		sub.f64	%r391, %r390, %r116;
		add.f64	%r392, %r391, %r118;
		sub.f64	%r393, %r392, %r120;
		add.f64	%r394, %r393, %r122;
		sub.f64	%r395, %r394, %r124;
		add.f64	%r396, %r395, %r126;
		sub.f64	%r156, %r396, %r128;
		div.rn.f64	%r158, %r147, %r129;
		div.rn.f64	%r159, %r156, %r129;
		div.rn.f64	%r397, %r71, %r62;
		div.rn.f64	%r398, %r138, %r129;
		neg.f64	%r399, %r398;
		fma.rn.f64	%r160, %r397, 0d4000000000000000, %r399;
		neg.f64	%r400, %r158;
		fma.rn.f64	%r161, %r91, 0d4000000000000000, %r400;
		neg.f64	%r401, %r159;
		fma.rn.f64	%r162, %r92, 0d4000000000000000, %r401;
		mul.f64	%r402, %r161, %r161;
		fma.rn.f64	%r164, %r160, %r160, %r402;
		fma.rn.f64	%r165, %r162, %r162, %r164;
		fma.rn.f64	%r166, %r165, 0dbff8000000000000, 0d3ff0000000000000;
		mul.f64	%r404, %r166, 0d3fd5555555555555;
		st.f64	[%r255+3200000], %r404;
		fma.rn.f64	%r168, %r161, 0d4012000000000000, 0d4008000000000000;
		fma.rn.f64	%r169, %r161, %r168, 0d3ff0000000000000;
		fma.rn.f64	%r170, %r165, 0dbff8000000000000, %r169;
		mul.f64	%r406, %r170, 0d3fac71c71c71c71c;
		st.f64	[%r255+3200008], %r406;
		fma.rn.f64	%r172, %r161, 0d4012000000000000, 0dc008000000000000;
		fma.rn.f64	%r173, %r161, %r172, 0d3ff0000000000000;
		fma.rn.f64	%r174, %r165, 0dbff8000000000000, %r173;
		mul.f64	%r408, %r174, 0d3fac71c71c71c71c;
		st.f64	[%r255+3200016], %r408;
		fma.rn.f64	%r176, %r160, 0d4012000000000000, 0d4008000000000000;
		fma.rn.f64	%r177, %r160, %r176, 0d3ff0000000000000;
		fma.rn.f64	%r178, %r165, 0dbff8000000000000, %r177;
		mul.f64	%r410, %r178, 0d3fac71c71c71c71c;
		st.f64	[%r255+3200024], %r410;
		fma.rn.f64	%r180, %r160, 0d4012000000000000, 0dc008000000000000;
		fma.rn.f64	%r181, %r160, %r180, 0d3ff0000000000000;
		fma.rn.f64	%r182, %r165, 0dbff8000000000000, %r181;
		mul.f64	%r412, %r182, 0d3fac71c71c71c71c;
		st.f64	[%r255+3200032], %r412;
		fma.rn.f64	%r184, %r162, 0d4012000000000000, 0d4008000000000000;
		fma.rn.f64	%r185, %r162, %r184, 0d3ff0000000000000;
		fma.rn.f64	%r186, %r165, 0dbff8000000000000, %r185;
		mul.f64	%r414, %r186, 0d3fac71c71c71c71c;
		st.f64	[%r255+3200040], %r414;
		fma.rn.f64	%r188, %r162, 0d4012000000000000, 0dc008000000000000;
		fma.rn.f64	%r189, %r162, %r188, 0d3ff0000000000000;
		fma.rn.f64	%r190, %r165, 0dbff8000000000000, %r189;
		mul.f64	%r416, %r190, 0d3fac71c71c71c71c;
		st.f64	[%r255+3200048], %r416;
		add.f64	%r192, %r160, %r161;
		fma.rn.f64	%r193, %r192, 0d4012000000000000, 0d4008000000000000;
		fma.rn.f64	%r194, %r192, %r193, 0d3ff0000000000000;
		fma.rn.f64	%r195, %r165, 0dbff8000000000000, %r194;
		mul.f64	%r418, %r195, 0d3f9c71c71c71c71c;
		st.f64	[%r255+3200056], %r418;
		sub.f64	%r197, %r161, %r160;
		fma.rn.f64	%r198, %r197, 0d4012000000000000, 0d4008000000000000;
		fma.rn.f64	%r199, %r197, %r198, 0d3ff0000000000000;
		fma.rn.f64	%r200, %r165, 0dbff8000000000000, %r199;
		mul.f64	%r420, %r200, 0d3f9c71c71c71c71c;
		st.f64	[%r255+3200064], %r420;
		sub.f64	%r202, %r160, %r161;
		fma.rn.f64	%r203, %r202, 0d4012000000000000, 0d4008000000000000;
		fma.rn.f64	%r204, %r202, %r203, 0d3ff0000000000000;
		fma.rn.f64	%r205, %r165, 0dbff8000000000000, %r204;
		mul.f64	%r422, %r205, 0d3f9c71c71c71c71c;
		st.f64	[%r255+3200072], %r422;
		neg.f64	%r207, %r160;
		sub.f64	%r208, %r207, %r161;
		fma.rn.f64	%r209, %r208, 0d4012000000000000, 0d4008000000000000;
		fma.rn.f64	%r210, %r208, %r209, 0d3ff0000000000000;
		fma.rn.f64	%r211, %r165, 0dbff8000000000000, %r210;
		mul.f64	%r424, %r211, 0d3f9c71c71c71c71c;
		st.f64	[%r255+3200080], %r424;
		add.f64	%r213, %r161, %r162;
		fma.rn.f64	%r214, %r213, 0d4012000000000000, 0d4008000000000000;
		fma.rn.f64	%r215, %r213, %r214, 0d3ff0000000000000;
		fma.rn.f64	%r216, %r165, 0dbff8000000000000, %r215;
		mul.f64	%r426, %r216, 0d3f9c71c71c71c71c;
		st.f64	[%r255+3200088], %r426;
		sub.f64	%r218, %r161, %r162;
		fma.rn.f64	%r219, %r218, 0d4012000000000000, 0d4008000000000000;
		fma.rn.f64	%r220, %r218, %r219, 0d3ff0000000000000;
		fma.rn.f64	%r221, %r165, 0dbff8000000000000, %r220;
		mul.f64	%r428, %r221, 0d3f9c71c71c71c71c;
		st.f64	[%r255+3200096], %r428;
		sub.f64	%r223, %r162, %r161;
		fma.rn.f64	%r224, %r223, 0d4012000000000000, 0d4008000000000000;
		fma.rn.f64	%r225, %r223, %r224, 0d3ff0000000000000;
		fma.rn.f64	%r226, %r165, 0dbff8000000000000, %r225;
		mul.f64	%r430, %r226, 0d3f9c71c71c71c71c;
		st.f64	[%r255+3200104], %r430;
		neg.f64	%r431, %r161;
		sub.f64	%r229, %r431, %r162;
		fma.rn.f64	%r230, %r229, 0d4012000000000000, 0d4008000000000000;
		fma.rn.f64	%r231, %r229, %r230, 0d3ff0000000000000;
		fma.rn.f64	%r232, %r165, 0dbff8000000000000, %r231;
		mul.f64	%r433, %r232, 0d3f9c71c71c71c71c;
		st.f64	[%r255+3200112], %r433;
		add.f64	%r234, %r160, %r162;
		fma.rn.f64	%r235, %r234, 0d4012000000000000, 0d4008000000000000;
		fma.rn.f64	%r236, %r234, %r235, 0d3ff0000000000000;
		fma.rn.f64	%r237, %r165, 0dbff8000000000000, %r236;
		mul.f64	%r435, %r237, 0d3f9c71c71c71c71c;
		st.f64	[%r255+3200120], %r435;
		sub.f64	%r239, %r160, %r162;
		fma.rn.f64	%r240, %r239, 0d4012000000000000, 0d4008000000000000;
		fma.rn.f64	%r241, %r239, %r240, 0d3ff0000000000000;
		fma.rn.f64	%r242, %r165, 0dbff8000000000000, %r241;
		mul.f64	%r437, %r242, 0d3f9c71c71c71c71c;
		st.f64	[%r255+3200128], %r437;
		sub.f64	%r244, %r162, %r160;
		fma.rn.f64	%r245, %r244, 0d4012000000000000, 0d4008000000000000;
		fma.rn.f64	%r246, %r244, %r245, 0d3ff0000000000000;
		fma.rn.f64	%r247, %r165, 0dbff8000000000000, %r246;
		mul.f64	%r439, %r247, 0d3f9c71c71c71c71c;
		st.f64	[%r255+3200136], %r439;
		sub.f64	%r249, %r207, %r162;
		fma.rn.f64	%r250, %r249, 0d4012000000000000, 0d4008000000000000;
		fma.rn.f64	%r251, %r249, %r250, 0d3ff0000000000000;
		fma.rn.f64	%r252, %r165, 0dbff8000000000000, %r251;
		mul.f64	%r441, %r252, 0d3f9c71c71c71c71c;
		st.f64	[%r255+3200144], %r441;
		add.u32	%r22, %r22, 640;
		add.u64	%r255, %r255, 5120;
		setp.gt.s32	%r442, %r443, %r22;
	@%r442	bra	$L19;
$L18:
	// joining 4;
	// join 4;
	ret;
}
//:FUNC_MAP "LBM_performStreamCollide$_omp_fn$0", 0, 0x1, 0x20
//:FUNC_MAP "LBM_handleInOutFlow$_omp_fn$1", 0, 0x1, 0x20
//:FUNC_MAP "LBM_handleInOutFlow$_omp_fn$0", 0, 0x1, 0x20
string-delimiter
  )

(define ptx-sample16
  #<<string-delimiter
//
// Generated by LLVM NVPTX Back-End
//

.version 6.5
.target sm_70
.address_size 64

	// .weak	__omp_offloading_30_21f42c63_cpu_stencil_l16
.weak .global .align 1 .u8 __omp_offloading_30_21f42c63_cpu_stencil_l16_exec_mode;
.global .align 4 .u32 _ZL3Cnt;
.global .align 8 .u64 __ZL3Cnt$ref = generic(_ZL3Cnt);
.global .align 4 .u32 _ZL7IterCnt;
.global .align 8 .u64 __ZL7IterCnt$ref = generic(_ZL7IterCnt);
.global .align 8 .u64 _ZL8AllLanes = -1;
.global .align 8 .u64 __ZL8AllLanes$ref = generic(_ZL8AllLanes);
// parallelLevel has been demoted

.weak .entry __omp_offloading_30_21f42c63_cpu_stencil_l16(
	.param .u64 __omp_offloading_30_21f42c63_cpu_stencil_l16_param_0,
	.param .u64 __omp_offloading_30_21f42c63_cpu_stencil_l16_param_1,
	.param .u64 __omp_offloading_30_21f42c63_cpu_stencil_l16_param_2,
	.param .u64 __omp_offloading_30_21f42c63_cpu_stencil_l16_param_3,
	.param .u64 __omp_offloading_30_21f42c63_cpu_stencil_l16_param_4,
	.param .u64 __omp_offloading_30_21f42c63_cpu_stencil_l16_param_5,
	.param .u64 __omp_offloading_30_21f42c63_cpu_stencil_l16_param_6,
	.param .u64 __omp_offloading_30_21f42c63_cpu_stencil_l16_param_7,
	.param .u64 __omp_offloading_30_21f42c63_cpu_stencil_l16_param_8,
	.param .u64 __omp_offloading_30_21f42c63_cpu_stencil_l16_param_9
)
{
	.reg .pred 	%p<23>;
	.reg .b16 	%rs<5>;
	.reg .f32 	%f<18>;
	.reg .b32 	%r<65>;
	.reg .b64 	%rd<101>;
	// demoted variable
	.shared .align 1 .b8 parallelLevel[32];
	ld.param.u64 	%rd41, [__omp_offloading_30_21f42c63_cpu_stencil_l16_param_1];
	cvt.u32.u64 	%r1, %rd41;
	ld.param.u32 	%r2, [__omp_offloading_30_21f42c63_cpu_stencil_l16_param_3];
	ld.param.u32 	%r3, [__omp_offloading_30_21f42c63_cpu_stencil_l16_param_5];
	mov.u32 	%r4, %tid.x;
	setp.ne.s32 	%p1, %r4, 0;
	shr.s32 	%r64, %r4, 31;
	mov.u64 	%rd91, parallelLevel;
	@%p1 bra 	LBB0_2;
	bra.uni 	LBB0_1;
LBB0_2:
	and.b32  	%r8, %r4, 31;
	setp.ne.s32 	%p2, %r8, 0;
	@%p2 bra 	LBB0_4;
	mov.u32 	%r9, %ntid.x;
	setp.gt.s32 	%p3, %r9, 1;
	selp.b16 	%rs3, -127, 1, %p3;
	shr.u32 	%r11, %r64, 27;
	add.s32 	%r12, %r4, %r11;
	shr.s32 	%r13, %r12, 5;
	cvt.u64.u32 	%rd44, %r13;
	add.s64 	%rd46, %rd91, %rd44;
	st.shared.u8 	[%rd46], %rs3;
	bra.uni 	LBB0_4;
LBB0_1:
	mov.u32 	%r14, %ntid.x;
	setp.gt.s32 	%p4, %r14, 1;
	selp.b16 	%rs4, -127, 1, %p4;
	st.shared.u8 	[parallelLevel], %rs4;
LBB0_4:
	bar.sync 	0;
	setp.lt.s32 	%p5, %r1, 3;
	setp.lt.s32 	%p6, %r2, 3;
	or.pred  	%p7, %p5, %p6;
	setp.lt.s32 	%p8, %r3, 3;
	or.pred  	%p9, %p7, %p8;
	@%p9 bra 	LBB0_24;
	shl.b64 	%rd50, %rd41, 32;
	add.s64 	%rd51, %rd50, -8589934592;
	shr.s64 	%rd52, %rd51, 32;
	add.s32 	%r5, %r2, -2;
	cvt.s64.s32 	%rd53, %r5;
	mul.lo.s64 	%rd54, %rd52, %rd53;
	add.s32 	%r19, %r3, -2;
	cvt.s64.s32 	%rd3, %r19;
	mul.lo.s64 	%rd4, %rd54, %rd3;
	mov.u32 	%r20, %ntid.x;
	cvt.u64.u32 	%rd6, %r20;
	setp.eq.s32 	%p10, %r20, 0;
	mov.u32 	%r21, %ctaid.x;
	cvt.s64.s32 	%rd7, %r21;
	mov.u32 	%r22, %nctaid.x;
	cvt.s64.s32 	%rd8, %r22;
	@%p10 bra 	LBB0_7;
	mul.lo.s64 	%rd95, %rd8, %rd6;
	mul.lo.s64 	%rd94, %rd7, %rd6;
	mov.u64 	%rd93, %rd6;
	bra.uni 	LBB0_13;
LBB0_7:
	or.b64  	%rd55, %rd4, %rd8;
	and.b64  	%rd56, %rd55, -4294967296;
	setp.ne.s64 	%p11, %rd56, 0;
	@%p11 bra 	LBB0_9;
	bra.uni 	LBB0_8;
LBB0_9:
	div.s64 	%rd93, %rd4, %rd8;
	bra.uni 	LBB0_10;
LBB0_8:
	cvt.u32.u64 	%r23, %rd8;
	cvt.u32.u64 	%r24, %rd4;
	div.u32 	%r25, %r24, %r23;
	cvt.u64.u32 	%rd93, %r25;
LBB0_10:
	mul.lo.s64 	%rd57, %rd93, %rd8;
	sub.s64 	%rd14, %rd4, %rd57;
	setp.le.s64 	%p12, %rd14, %rd7;
	@%p12 bra 	LBB0_12;
	add.s64 	%rd93, %rd93, 1;
	mul.lo.s64 	%rd94, %rd93, %rd7;
	mov.u64 	%rd95, %rd4;
	bra.uni 	LBB0_13;
LBB0_12:
	mul.lo.s64 	%rd58, %rd93, %rd7;
	add.s64 	%rd94, %rd14, %rd58;
	mov.u64 	%rd95, %rd4;
LBB0_13:
	setp.ge.s64 	%p14, %rd94, %rd4;
	@%p14 bra 	LBB0_24;
	shr.u32 	%r16, %r64, 27;
	add.s32 	%r17, %r4, %r16;
	shr.s32 	%r18, %r17, 5;
	cvt.u64.u32 	%rd47, %r18;
	add.s64 	%rd49, %rd91, %rd47;
	ld.shared.u8 	%rs1, [%rd49];
	ld.param.u64 	%rd42, [__omp_offloading_30_21f42c63_cpu_stencil_l16_param_7];
	ld.param.u64 	%rd43, [__omp_offloading_30_21f42c63_cpu_stencil_l16_param_6];
	and.b16  	%rs2, %rs1, 126;
	cvta.to.global.u64 	%rd1, %rd42;
	cvta.to.global.u64 	%rd2, %rd43;
	ld.param.f32 	%f1, [__omp_offloading_30_21f42c63_cpu_stencil_l16_param_8];
	ld.param.f32 	%f2, [__omp_offloading_30_21f42c63_cpu_stencil_l16_param_9];
	add.s64 	%rd5, %rd4, -1;
	cvt.u32.u64 	%r26, %rd3;
	setp.eq.s16 	%p13, %rs2, 0;
	add.s64 	%rd59, %rd93, %rd94;
	add.s64 	%rd21, %rd59, -1;
	cvt.s64.s32 	%rd60, %r4;
	selp.b64 	%rd22, %rd60, 0, %p13;
	mul.lo.s32 	%r27, %r26, %r5;
	cvt.s64.s32 	%rd23, %r27;
	setp.eq.s16 	%p15, %rs1, 129;
	setp.lt.s64 	%p16, %rd21, %rd4;
	selp.b64 	%rd96, %rd21, %rd5, %p16;
	cvt.s64.s32 	%rd61, %rd6;
	selp.b64 	%rd25, %rd61, 1, %p15;
	neg.s32 	%r6, %r5;
	neg.s64 	%rd26, %rd23;
	cvt.u32.u64 	%r28, %rd23;
	bra.uni 	LBB0_15;
LBB0_23:
	add.s64 	%rd94, %rd94, %rd95;
	add.s64 	%rd90, %rd96, %rd95;
	setp.lt.s64 	%p21, %rd90, %rd4;
	selp.b64 	%rd96, %rd90, %rd5, %p21;
	setp.lt.s64 	%p22, %rd94, %rd4;
	@%p22 bra 	LBB0_15;
	bra.uni 	LBB0_24;
LBB0_15:
	add.s64 	%rd98, %rd94, %rd22;
	setp.gt.u64 	%p17, %rd98, %rd96;
	@%p17 bra 	LBB0_23;
	bra.uni 	LBB0_16;
LBB0_21:
	div.s64 	%rd100, %rd34, %rd3;
LBB0_22:
	cvt.u32.u64 	%r35, %rd100;
	add.s32 	%r36, %r7, 2;
	mul.lo.s32 	%r37, %r6, %r7;
	sub.s32 	%r38, %r37, %r35;
	mul.lo.s32 	%r39, %r26, %r38;
	mad.lo.s32 	%r40, %r2, %r36, %r35;
	add.s32 	%r41, %r40, 1;
	mad.lo.s32 	%r42, %r3, %r41, %r39;
	cvt.u64.u32 	%rd67, %r42;
	add.s64 	%rd68, %rd98, %rd67;
	cvt.u32.u64 	%r43, %rd68;
	add.s32 	%r44, %r43, 1;
	mul.wide.s32 	%rd69, %r44, 4;
	add.s64 	%rd70, %rd1, %rd69;
	ld.global.f32 	%f3, [%rd70];
	mul.lo.s32 	%r45, %r7, %r2;
	add.s32 	%r46, %r45, %r35;
	add.s32 	%r47, %r46, 1;
	mad.lo.s32 	%r48, %r3, %r47, %r39;
	cvt.u64.u32 	%rd71, %r48;
	add.s64 	%rd72, %rd98, %rd71;
	cvt.u32.u64 	%r49, %rd72;
	add.s32 	%r50, %r49, 1;
	mul.wide.s32 	%rd73, %r50, 4;
	add.s64 	%rd74, %rd1, %rd73;
	ld.global.f32 	%f4, [%rd74];
	add.rn.f32 	%f5, %f3, %f4;
	add.s32 	%r51, %r45, %r2;
	add.s32 	%r52, %r51, %r35;
	add.s32 	%r53, %r52, 2;
	mad.lo.s32 	%r54, %r3, %r53, %r39;
	cvt.u64.u32 	%rd75, %r54;
	add.s64 	%rd76, %rd98, %rd75;
	cvt.u32.u64 	%r55, %rd76;
	add.s32 	%r56, %r55, 1;
	mul.wide.s32 	%rd77, %r56, 4;
	add.s64 	%rd78, %rd1, %rd77;
	ld.global.f32 	%f6, [%rd78];
	add.rn.f32 	%f7, %f5, %f6;
	mad.lo.s32 	%r57, %r3, %r52, %r39;
	cvt.u64.u32 	%rd79, %r57;
	add.s64 	%rd80, %rd98, %rd79;
	cvt.u32.u64 	%r58, %rd80;
	add.s32 	%r59, %r58, 1;
	mul.wide.s32 	%rd81, %r59, 4;
	add.s64 	%rd82, %rd1, %rd81;
	ld.global.f32 	%f8, [%rd82];
	add.rn.f32 	%f9, %f7, %f8;
	add.s32 	%r60, %r52, 1;
	mad.lo.s32 	%r61, %r3, %r60, %r39;
	cvt.u64.u32 	%rd83, %r61;
	add.s64 	%rd84, %rd98, %rd83;
	cvt.u32.u64 	%r62, %rd84;
	mul.wide.s32 	%rd85, %r62, 4;
	add.s64 	%rd86, %rd1, %rd85;
	ld.global.f32 	%f10, [%rd86+8];
	add.rn.f32 	%f11, %f9, %f10;
	ld.global.f32 	%f12, [%rd86];
	add.rn.f32 	%f13, %f11, %f12;
	mul.rn.f32 	%f14, %f13, %f1;
	add.s32 	%r63, %r62, 1;
	mul.wide.s32 	%rd87, %r63, 4;
	add.s64 	%rd88, %rd1, %rd87;
	ld.global.f32 	%f15, [%rd88];
	mul.rn.f32 	%f16, %f15, %f2;
	sub.rn.f32 	%f17, %f14, %f16;
	add.s64 	%rd89, %rd2, %rd87;
	st.global.f32 	[%rd89], %f17;
	add.s64 	%rd98, %rd98, %rd25;
	setp.le.u64 	%p20, %rd98, %rd96;
	@%p20 bra 	LBB0_16;
	bra.uni 	LBB0_23;
LBB0_16:
	or.b64  	%rd62, %rd98, %rd23;
	and.b64  	%rd63, %rd62, -4294967296;
	setp.ne.s64 	%p18, %rd63, 0;
	@%p18 bra 	LBB0_18;
	bra.uni 	LBB0_17;
LBB0_18:
	div.s64 	%rd99, %rd98, %rd23;
	bra.uni 	LBB0_19;
LBB0_17:
	cvt.u32.u64 	%r29, %rd98;
	div.u32 	%r30, %r29, %r28;
	cvt.u64.u32 	%rd99, %r30;
LBB0_19:
	cvt.u32.u64 	%r7, %rd99;
	mul.lo.s64 	%rd64, %rd26, %rd99;
	add.s64 	%rd34, %rd98, %rd64;
	or.b64  	%rd65, %rd34, %rd3;
	and.b64  	%rd66, %rd65, -4294967296;
	setp.ne.s64 	%p19, %rd66, 0;
	@%p19 bra 	LBB0_21;
	cvt.u32.u64 	%r32, %rd34;
	div.u32 	%r33, %r32, %r26;
	cvt.u64.u32 	%rd100, %r33;
	bra.uni 	LBB0_22;
LBB0_24:
	ret;

}
string-delimiter
  )

(define ptx-sample17
  #<<string-delimiter
.version 6.5
.target sm_70
.address_size 64

	// .globl	add_52_gpu

.visible .entry add_52_gpu(
	.param .u32 add_52_gpu_param_0,
	.param .u32 add_52_gpu_param_1,
	.param .u32 add_52_gpu_param_2,
	.param .u64 add_52_gpu_param_3,
	.param .u64 add_52_gpu_param_4
)
.maxntid 128, 1, 1
{
	.reg .pred 	%p<4>;
	.reg .b32 	%r<42>;
	.reg .f64 	%fd<16>;
	.reg .b64 	%rd<14>;


	ld.param.u32 	%r13, [add_52_gpu_param_0];
	ld.param.u32 	%r14, [add_52_gpu_param_1];
	ld.param.u32 	%r15, [add_52_gpu_param_2];
	ld.param.u64 	%rd1, [add_52_gpu_param_3];
	ld.param.u64 	%rd2, [add_52_gpu_param_4];
	mul.lo.s32 	%r16, %r14, %r13;
	mad.lo.s32 	%r1, %r16, %r15, -1;
	setp.lt.s32	%p1, %r1, 0;
	@%p1 bra 	BB0_5;

	mov.u32 	%r18, %ctaid.x;
	shl.b32 	%r19, %r18, 7;
	mov.u32 	%r20, %tid.x;
	add.s32 	%r39, %r19, %r20;
	mul.lo.s32 	%r41, %r16, %r15;
	sub.s32 	%r40, %r39, %r1;
	mov.u32 	%r38, 0;
	cvta.to.global.u64 	%rd10, %rd1;
	cvta.to.global.u64 	%rd12, %rd2;

BB0_2:
	setp.gt.s32	%p2, %r40, 0;
	@%p2 bra 	BB0_4;

	div.s32 	%r22, %r39, %r13;
	div.s32 	%r23, %r22, %r14;
	add.s32 	%r24, %r23, 1;
	mul.wide.s32 	%rd3, %r24, 103;
	mul.lo.s32 	%r25, %r23, %r14;
	add.s32 	%r26, %r22, 1;
	sub.s32 	%r27, %r26, %r25;
	cvt.s64.s32	%rd4, %r27;
	add.s32 	%r31, %r19, %r20;
	add.s32 	%r32, %r31, %r38;
	add.s32 	%r33, %r32, 1;
	mul.lo.s32 	%r34, %r22, %r13;
	sub.s32 	%r35, %r33, %r34;
	cvt.s64.s32	%rd5, %r35;
	add.s64 	%rd6, %rd3, %rd4;
	mul.lo.s64 	%rd7, %rd6, 103;
	add.s64 	%rd8, %rd7, %rd5;
	mul.lo.s64 	%rd9, %rd8, 40;
	add.s64 	%rd11, %rd10, %rd9;
	add.s64 	%rd13, %rd12, %rd9;
	ld.global.f64 	%fd1, [%rd13];
	ld.global.f64 	%fd2, [%rd11];
	add.f64 	%fd3, %fd2, %fd1;
	st.global.f64 	[%rd13], %fd3;
	ld.global.f64 	%fd4, [%rd13+8];
	ld.global.f64 	%fd5, [%rd11+8];
	add.f64 	%fd6, %fd5, %fd4;
	st.global.f64 	[%rd13+8], %fd6;
	ld.global.f64 	%fd7, [%rd13+16];
	ld.global.f64 	%fd8, [%rd11+16];
	add.f64 	%fd9, %fd8, %fd7;
	st.global.f64 	[%rd13+16], %fd9;
	ld.global.f64 	%fd10, [%rd13+24];
	ld.global.f64 	%fd11, [%rd11+24];
	add.f64 	%fd12, %fd11, %fd10;
	st.global.f64 	[%rd13+24], %fd12;
	ld.global.f64 	%fd13, [%rd13+32];
	ld.global.f64 	%fd14, [%rd11+32];
	add.f64 	%fd15, %fd14, %fd13;
	st.global.f64 	[%rd13+32], %fd15;

BB0_4:
	mov.u32 	%r36, %nctaid.x;
	shl.b32 	%r37, %r36, 7;
	add.s32 	%r38, %r38, %r37;
	add.s32 	%r39, %r39, %r37;
	add.s32 	%r40, %r40, %r37;
	sub.s32 	%r41, %r41, %r37;
	setp.gt.s32	%p3, %r41, 0;
	@%p3 bra 	BB0_2;

BB0_5:
	ret;
}
string-delimiter
  )

(define ptx-sample18
  #<<string-delimiter
// BEGIN PREAMBLE
	.version	3.1
	.target	sm_35
	.address_size 64
// END PREAMBLE


// BEGIN FUNCTION DECL: x_solve$_omp_fn$0
.entry x_solve$_omp_fn$0 (.param.u64 %in_ar0);

// BEGIN FUNCTION DEF: x_solve$_omp_fn$0
.entry x_solve$_omp_fn$0 (.param.u64 %in_ar0)
{
	.reg.u64 %ar0;
	ld.param.u64 %ar0, [%in_ar0];
	.reg.f64 %r23;
	.reg.u32 %r27;
	.reg.u32 %r29;
	.reg.u32 %r31;
	.reg.f64 %r33;
	.reg.f64 %r35;
	.reg.f64 %r37;
	.reg.f64 %r39;
	.reg.f64 %r41;
	.reg.f64 %r42;
	.reg.u64 %r44;
	.reg.u32 %r48;
	.reg.u32 %r49;
	.reg.f64 %r51;
	.reg.f64 %r52;
	.reg.f64 %r53;
	.reg.u64 %r58;
	.reg.f64 %r59;
	.reg.f64 %r60;
	.reg.f64 %r61;
	.reg.u64 %r62;
	.reg.u64 %r63;
	.reg.u64 %r65;
	.reg.f64 %r66;
	.reg.f64 %r69;
	.reg.f64 %r99;
	.reg.u64 %r100;
	.reg.f64 %r104;
	.reg.f64 %r109;
	.reg.f64 %r110;
	.reg.f64 %r113;
	.reg.f64 %r115;
	.reg.u64 %r129;
	.reg.f64 %r131;
	.reg.f64 %r136;
	.reg.f64 %r139;
	.reg.f64 %r142;
	.reg.f64 %r143;
	.reg.f64 %r145;
	.reg.f64 %r148;
	.reg.f64 %r149;
	.reg.f64 %r152;
	.reg.f64 %r153;
	.reg.f64 %r155;
	.reg.f64 %r158;
	.reg.f64 %r162;
	.reg.u64 %r172;
	.reg.u64 %r173;
	.reg.u32 %r175;
	.reg.u64 %r178;
	.reg.u32 %r180;
	.reg.u32 %r181;
	.reg.u32 %r183;
	.reg.u32 %r184;
	.reg.u64 %r185;
	.reg.u64 %r186;
	.reg.u64 %r188;
	.reg.u64 %r196;
	.reg.u32 %r197;
	.reg.u32 %r202;
	.reg.u64 %r203;
	.reg.u64 %r208;
	.reg.u64 %r209;
	.reg.u64 %r216;
	.reg.u64 %r217;
	.reg.u32 %r218;
	.reg.u32 %r219;
	.reg.u32 %r220;
	.reg.pred %r221;
	.reg.u64 %r222;
	.reg.u64 %r223;
	.reg.u64 %r224;
	.reg.u64 %r225;
	.reg.u64 %r226;
	.reg.u64 %r227;
	.reg.u64 %r228;
	.reg.u32 %r229;
	.reg.u32 %r230;
	.reg.u64 %r231;
	.reg.pred %r233;
	.reg.u32 %r234;
	.reg.u32 %r235;
	.reg.u32 %r236;
	.reg.u32 %r237;
	.reg.pred %r238;
	.reg.f64 %r239;
	.reg.f64 %r240;
	.reg.u64 %r241;
	.reg.u64 %r243;
	.reg.u64 %r244;
	.reg.u64 %r245;
	.reg.u64 %r247;
	.reg.u64 %r248;
	.reg.u64 %r250;
	.reg.u64 %r251;
	.reg.u64 %r252;
	.reg.u64 %r253;
	.reg.u64 %r254;
	.reg.u64 %r255;
	.reg.u64 %r256;
	.reg.u32 %r257;
	.reg.u32 %r258;
	.reg.u32 %r259;
	.reg.u64 %r260;
	.reg.u64 %r261;
	.reg.u64 %r262;
	.reg.u64 %r263;
	.reg.u64 %r264;
	.reg.u64 %r265;
	.reg.u64 %r266;
	.reg.f64 %r267;
	.reg.f64 %r268;
	.reg.f64 %r272;
	.reg.f64 %r273;
	.reg.f64 %r274;
	.reg.f64 %r275;
	.reg.f64 %r276;
	.reg.f64 %r277;
	.reg.f64 %r278;
	.reg.f64 %r279;
	.reg.f64 %r280;
	.reg.f64 %r281;
	.reg.f64 %r282;
	.reg.f64 %r283;
	.reg.f64 %r284;
	.reg.f64 %r285;
	.reg.f64 %r286;
	.reg.f64 %r287;
	.reg.f64 %r288;
	.reg.f64 %r289;
	.reg.f64 %r290;
	.reg.f64 %r291;
	.reg.f64 %r292;
	.reg.f64 %r293;
	.reg.f64 %r294;
	.reg.f64 %r297;
	.reg.f64 %r298;
	.reg.f64 %r299;
	.reg.f64 %r300;
	.reg.f64 %r301;
	.reg.f64 %r302;
	.reg.f64 %r303;
	.reg.f64 %r305;
	.reg.f64 %r306;
	.reg.u64 %r308;
	.reg.f64 %r309;
	.reg.f64 %r310;
	.reg.f64 %r311;
	.reg.f64 %r312;
	.reg.f64 %r313;
	.reg.f64 %r314;
	.reg.f64 %r315;
	.reg.f64 %r316;
	.reg.f64 %r317;
	.reg.f64 %r318;
	.reg.f64 %r319;
	.reg.f64 %r320;
	.reg.f64 %r321;
	.reg.f64 %r322;
	.reg.f64 %r323;
	.reg.f64 %r324;
	.reg.f64 %r325;
	.reg.f64 %r326;
	.reg.f64 %r327;
	.reg.f64 %r328;
	.reg.f64 %r329;
	.reg.f64 %r330;
	.reg.f64 %r331;
	.reg.f64 %r332;
	.reg.f64 %r333;
	.reg.f64 %r339;
	.reg.f64 %r340;
	.reg.f64 %r341;
	.reg.f64 %r342;
	.reg.f64 %r346;
	.reg.f64 %r347;
	.reg.f64 %r351;
	.reg.f64 %r352;
	.reg.f64 %r356;
	.reg.f64 %r357;
	.reg.f64 %r358;
	.reg.f64 %r359;
	.reg.f64 %r360;
	.reg.f64 %r361;
	.reg.f64 %r362;
	.reg.f64 %r363;
	.reg.f64 %r364;
	.reg.f64 %r365;
	.reg.f64 %r366;
	.reg.f64 %r367;
	.reg.f64 %r368;
	.reg.f64 %r369;
	.reg.f64 %r370;
	.reg.f64 %r371;
	.reg.f64 %r372;
	.reg.f64 %r373;
	.reg.pred %r374;
	.reg.pred %r375;
	.reg.pred %r376;
	.reg.u64 %r377;
	.reg.u32 %r378;
	.reg.u32 %r379;
	.reg.u32 %r380;
	.reg.u32 %r381;
	.reg.u32 %r382;
	.reg.u32 %r383;
	.reg.u32 %r384;
	.reg.u32 %r385;
	.reg.u32 %r386;
	.reg.u32 %r387;
	.reg.u32 %r388;
	.reg.u32 %r389;
	.reg.u32 %r390;
	.reg.u32 %r391;
	.reg.u32 %r392;
	.reg.u32 %r393;
	.reg.u32 %r394;
	.reg.u32 %r395;
	.reg.u32 %r396;
	.reg.u32 %r397;
	.reg.u64 %r398;
	.reg.u64 %r399;
	.reg.pred %r400;
	.reg.pred %r401;
	.reg.u32 %r402;
	.reg.pred %r403;
	.reg.u32 %r404;
	.reg.pred %r405;
	.reg.u32 %r406;
	.reg.u32 %r407;
	.reg.u32 %r408;
	.reg.u32 %r409;
	{
		.reg.u32	%y;
		mov.u32	%y, %tid.y;
		setp.ne.u32	%r405, %y, 0;
	}
	{
		.reg.u32	%x;
		mov.u32	%x, %tid.x;
		setp.ne.u32	%r400, %x, 0;
	}
	@%r405	bra.uni	$L27;
	@%r400	bra	$L28;
		mov.u64	%r216, %ar0;
		ld.u64	%r217, [%r216+56];
		ld.u32	%r31, [%r217];
		mov.u32	%r180, %nctaid.x;
		mov.u32	%r181, %ctaid.x;
		add.u32	%r218, %r31, %r180;
		div.s32	%r175, %r218, %r180;
		mul.lo.u32	%r48, %r175, %r181;
		add.u32	%r219, %r31, 1;
		add.u32	%r220, %r48, %r175;
		min.s32	%r49, %r219, %r220;
		setp.lt.s32	%r221, %r48, %r49;
		selp.u32	%r408, 1, 0, %r221;
		st.shared.u32	[__oacc_bcast], %r408;
$L28:
$L27:
		bar.sync	0;
		ld.shared.u32	%r409, [__oacc_bcast];
		setp.ne.u32	%r221, %r409, 0;
		bar.sync	0;
	@!%r221	bra.uni	$L1;
	@%r405	bra.uni	$L25;
	@%r400	bra	$L26;
		ld.u64	%r222, [%r216+40];
		ld.u32	%r27, [%r222];
		ld.u64	%r223, [%r216+48];
		ld.u32	%r29, [%r223];
		ld.u64	%r224, [%r216+96];
		ld.f64	%r33, [%r224];
		ld.u64	%r225, [%r216+104];
		ld.f64	%r35, [%r225];
		ld.u64	%r226, [%r216+112];
		ld.f64	%r37, [%r226];
		ld.u64	%r227, [%r216+120];
		ld.f64	%r39, [%r227];
		ld.u64	%r228, [%r216+128];
		ld.f64	%r41, [%r228];
		cvt.s64.s32	%r203, %r48;
		sub.u32	%r229, %r49, %r48;
		add.u32	%r230, %r229, -1;
		cvt.u64.u32	%r231, %r230;
		add.u64	%r377, %r203, 1;
		add.u64	%r208, %r231, %r377;
$L26:
$L25:
$L11:
	// fork 2;
	@%r405	bra.uni	$L23;
	@%r400	bra	$L24;
		cvta.shared.u64	%r399, __oacc_bcast;
		st.u32	[%r399], %r27;
		st.u32	[%r399+4], %r29;
		st.f64	[%r399+8], %r33;
		st.f64	[%r399+16], %r35;
		st.f64	[%r399+24], %r37;
		st.f64	[%r399+32], %r39;
		st.f64	[%r399+40], %r41;
		st.u64	[%r399+48], %r203;
		st.u64	[%r399+56], %r208;
		st.u64	[%r399+64], %r216;
		st.u64	[%r399+72], %r377;
$L24:
$L23:
		setp.eq.u32	%r403, 1, 0;
		bar.sync	0;
	// forked 2;
	@%r400	bra	$L18;
		cvta.shared.u64	%r398, __oacc_bcast;
		ld.u32	%r27, [%r398];
		ld.u32	%r29, [%r398+4];
		ld.f64	%r33, [%r398+8];
		ld.f64	%r35, [%r398+16];
		ld.f64	%r37, [%r398+24];
		ld.f64	%r39, [%r398+32];
		ld.f64	%r41, [%r398+40];
		ld.u64	%r203, [%r398+48];
		ld.u64	%r208, [%r398+56];
		ld.u64	%r216, [%r398+64];
		ld.u64	%r377, [%r398+72];
		mov.u32	%r183, %tid.y;
		setp.gt.s32	%r233, %r27, %r183;
		mov.pred	%r403, %r233;
$L18:
		mov.pred	%r233, %r403;
		selp.u32	%r404, 1, 0, %r233;
		shfl.idx.b32	%r404, %r404, 0, 31;
		setp.ne.u32	%r233, %r404, 0;
	@%r233	bra.uni	$L3;
$L10:
	// joining 2;
		bar.sync	0;
	// join 2;
	@%r405	bra.uni	$L19;
	@%r400	bra	$L20;
		mov.u64	%r203, %r377;
		setp.ne.u64	%r376, %r377, %r208;
		selp.u32	%r406, 1, 0, %r376;
		st.shared.u32	[__oacc_bcast], %r406;
$L20:
$L19:
		bar.sync	0;
		ld.shared.u32	%r407, [__oacc_bcast];
		setp.ne.u32	%r376, %r407, 0;
		bar.sync	0;
	@%r376	bra.uni	$L13;
		bra	$L1;
$L3:
	@%r400	bra	$L17;
		add.u32	%r197, %r183, 1;
		add.u32	%r234, %r27, -1;
		sub.u32	%r235, %r234, %r183;
		and.b32	%r236, %r235, -8;
		add.u32	%r237, %r183, 9;
		add.u32	%r202, %r236, %r237;
		mul.lo.u64	%r209, %r203, 25921;
$L17:
$L9:
	// fork 4;
	// forked 4;
		shfl.idx.b32	%r27, %r27, 0, 31;
		shfl.idx.b32	%r29, %r29, 0, 31;
		mov.b64	{%r378,%r379}, %r33;
		shfl.idx.b32	%r378, %r378, 0, 31;
		shfl.idx.b32	%r379, %r379, 0, 31;
		mov.b64	%r33, {%r378,%r379};
		mov.b64	{%r380,%r381}, %r35;
		shfl.idx.b32	%r380, %r380, 0, 31;
		shfl.idx.b32	%r381, %r381, 0, 31;
		mov.b64	%r35, {%r380,%r381};
		mov.b64	{%r382,%r383}, %r37;
		shfl.idx.b32	%r382, %r382, 0, 31;
		shfl.idx.b32	%r383, %r383, 0, 31;
		mov.b64	%r37, {%r382,%r383};
		mov.b64	{%r384,%r385}, %r39;
		shfl.idx.b32	%r384, %r384, 0, 31;
		shfl.idx.b32	%r385, %r385, 0, 31;
		mov.b64	%r39, {%r384,%r385};
		mov.b64	{%r386,%r387}, %r41;
		shfl.idx.b32	%r386, %r386, 0, 31;
		shfl.idx.b32	%r387, %r387, 0, 31;
		mov.b64	%r41, {%r386,%r387};
		shfl.idx.b32	%r197, %r197, 0, 31;
		shfl.idx.b32	%r202, %r202, 0, 31;
		mov.b64	{%r388,%r389}, %r203;
		shfl.idx.b32	%r388, %r388, 0, 31;
		shfl.idx.b32	%r389, %r389, 0, 31;
		mov.b64	%r203, {%r388,%r389};
		mov.b64	{%r390,%r391}, %r208;
		shfl.idx.b32	%r390, %r390, 0, 31;
		shfl.idx.b32	%r391, %r391, 0, 31;
		mov.b64	%r208, {%r390,%r391};
		mov.b64	{%r392,%r393}, %r209;
		shfl.idx.b32	%r392, %r392, 0, 31;
		shfl.idx.b32	%r393, %r393, 0, 31;
		mov.b64	%r209, {%r392,%r393};
		mov.b64	{%r394,%r395}, %r216;
		shfl.idx.b32	%r394, %r394, 0, 31;
		shfl.idx.b32	%r395, %r395, 0, 31;
		mov.b64	%r216, {%r394,%r395};
		mov.b64	{%r396,%r397}, %r377;
		shfl.idx.b32	%r396, %r396, 0, 31;
		shfl.idx.b32	%r397, %r397, 0, 31;
		mov.b64	%r377, {%r396,%r397};
		mov.u32	%r184, %tid.x;
		setp.gt.s32	%r238, %r29, %r184;
	@%r238	bra	$L5;
$L8:
	// joining 4;
		setp.eq.u32	%r401, 1, 0;
	// join 4;
	@%r400	bra	$L16;
		add.u32	%r197, %r197, 8;
		setp.ne.u32	%r375, %r197, %r202;
		mov.pred	%r401, %r375;
$L16:
		mov.pred	%r375, %r401;
		selp.u32	%r402, 1, 0, %r375;
		shfl.idx.b32	%r402, %r402, 0, 31;
		setp.ne.u32	%r375, %r402, 0;
	@%r375	bra.uni	$L9;
		bra	$L10;
$L5:
		ld.u64	%r58, [%r216+80];
		ld.u64	%r62, [%r216+32];
		ld.u64	%r63, [%r216+88];
		ld.u64	%r65, [%r216+64];
		add.f64	%r99, %r35, %r35;
		ld.u64	%r100, [%r216+72];
		ld.u64	%r129, [%r216+24];
		neg.f64	%r239, %r33;
		mul.f64	%r131, %r239, %r41;
		neg.f64	%r42, %r131;
		sub.f64	%r142, %r42, %r39;
		neg.f64	%r143, %r142;
		mov.f64	%r240, 0d4000000000000000;
		sub.f64	%r51, %r240, %r35;
		neg.f64	%r52, %r35;
		neg.f64	%r23, %r41;
		sub.f64	%r53, %r41, %r39;
		cvt.s64.s32	%r178, %r184;
		cvt.s64.s32	%r241, %r197;
		add.u64	%r243, %r203, 26569;
		mad.lo.u64	%r244, %r241, 163, %r243;
		cvt.s64.s32	%r245, %r184;
		mad.lo.u64	%r247, %r245, 26569, %r244;
		shl.b64	%r173, %r247, 3;
		cvt.s64.s32	%r248, %r197;
		shl.b64	%r250, %r248, 2;
		add.u64	%r251, %r250, %r248;
		shl.b64	%r252, %r251, 5;
		add.u64	%r253, %r252, %r248;
		add.u64	%r254, %r209, 1;
		add.u64	%r255, %r254, %r253;
		add.u64	%r256, %r255, %r178;
		shl.b64	%r172, %r256, 3;
		add.u32	%r257, %r29, -1;
		sub.u32	%r258, %r257, %r184;
		shr.u32	%r259, %r258, 5;
		cvt.u64.u32	%r260, %r259;
		shl.b64	%r261, %r260, 5;
		add.u64	%r262, %r209, 33;
		add.u64	%r263, %r262, %r253;
		add.u64	%r264, %r263, %r178;
		add.u64	%r265, %r261, %r264;
		shl.b64	%r196, %r265, 3;
$L7:
		add.u64	%r266, %r58, %r173;
		ld.f64	%r59, [%r266];
		mul.f64	%r60, %r59, %r59;
		mul.f64	%r61, %r59, %r60;
		add.u64	%r44, %r62, %r172;
		mov.f64	%r267, 0d0000000000000000;
		st.f64	[%r44], %r267;
		mov.f64	%r268, 0d3ff0000000000000;
		st.f64	[%r44+33800984], %r268;
		st.f64	[%r44+67601968], %r267;
		st.f64	[%r44+101402952], %r267;
		st.f64	[%r44+135203936], %r267;
		add.u64	%r185, %r63, %r173;
		add.u64	%r186, %r65, %r173;
		ld.f64	%r66, [%r186+34433424];
		mul.f64	%r272, %r60, %r66;
		mul.f64	%r273, %r272, %r66;
		neg.f64	%r274, %r273;
		ld.f64	%r275, [%r185];
		fma.rn.f64	%r69, %r35, %r275, %r274;
		st.f64	[%r44+169004920], %r69;
		ld.f64	%r277, [%r186+34433424];
		ld.f64	%r278, [%r186];
		div.rn.f64	%r276, %r277, %r278;
		mul.f64	%r279, %r276, %r51;
		st.f64	[%r44+202805904], %r279;
		ld.f64	%r281, [%r186+68866848];
		mul.f64	%r280, %r59, %r281;
		mul.f64	%r282, %r280, %r52;
		st.f64	[%r44+236606888], %r282;
		ld.f64	%r284, [%r186+103300272];
		mul.f64	%r283, %r59, %r284;
		mul.f64	%r285, %r283, %r52;
		st.f64	[%r44+270407872], %r285;
		st.f64	[%r44+304208856], %r35;
		ld.f64	%r287, [%r186+34433424];
		ld.f64	%r288, [%r186+68866848];
		mul.f64	%r286, %r287, %r288;
		neg.f64	%r289, %r286;
		mul.f64	%r290, %r289, %r60;
		st.f64	[%r44+338009840], %r290;
		ld.f64	%r292, [%r186+68866848];
		mul.f64	%r291, %r292, %r59;
		st.f64	[%r44+371810824], %r291;
		ld.f64	%r294, [%r186+34433424];
		mul.f64	%r293, %r294, %r59;
		st.f64	[%r44+405611808], %r293;
		st.f64	[%r44+439412792], %r267;
		st.f64	[%r44+473213776], %r267;
		ld.f64	%r298, [%r186+34433424];
		ld.f64	%r299, [%r186+103300272];
		mul.f64	%r297, %r298, %r299;
		neg.f64	%r300, %r297;
		mul.f64	%r301, %r300, %r60;
		st.f64	[%r44+507014760], %r301;
		ld.f64	%r303, [%r186+103300272];
		mul.f64	%r302, %r303, %r59;
		st.f64	[%r44+540815744], %r302;
		st.f64	[%r44+574616728], %r267;
		ld.f64	%r306, [%r186+34433424];
		mul.f64	%r305, %r306, %r59;
		st.f64	[%r44+608417712], %r305;
		st.f64	[%r44+642218696], %r267;
		add.u64	%r308, %r100, %r173;
		ld.f64	%r310, [%r186+137733696];
		mul.f64	%r309, %r37, %r310;
		neg.f64	%r311, %r309;
		ld.f64	%r312, [%r308];
		fma.rn.f64	%r104, %r99, %r312, %r311;
		ld.f64	%r314, [%r186+34433424];
		mul.f64	%r313, %r60, %r314;
		mul.f64	%r315, %r313, %r104;
		st.f64	[%r44+676019680], %r315;
		ld.f64	%r316, [%r186+137733696];
		mul.f64	%r109, %r37, %r316;
		ld.f64	%r110, [%r186+34433424];
		mul.f64	%r317, %r110, %r110;
		ld.f64	%r318, [%r185];
		fma.rn.f64	%r113, %r60, %r317, %r318;
		mul.f64	%r319, %r35, %r113;
		neg.f64	%r320, %r319;
		fma.rn.f64	%r115, %r59, %r109, %r320;
		st.f64	[%r44+709820664], %r115;
		ld.f64	%r322, [%r186+68866848];
		ld.f64	%r323, [%r186+34433424];
		mul.f64	%r321, %r322, %r323;
		mul.f64	%r324, %r321, %r52;
		mul.f64	%r325, %r324, %r60;
		st.f64	[%r44+743621648], %r325;
		ld.f64	%r327, [%r186+103300272];
		ld.f64	%r328, [%r186+34433424];
		mul.f64	%r326, %r327, %r328;
		mul.f64	%r329, %r326, %r52;
		mul.f64	%r330, %r329, %r60;
		st.f64	[%r44+777422632], %r330;
		ld.f64	%r332, [%r186+34433424];
		mul.f64	%r331, %r59, %r332;
		mul.f64	%r333, %r331, %r37;
		st.f64	[%r44+811223616], %r333;
		add.u64	%r188, %r129, %r172;
		st.f64	[%r188], %r267;
		st.f64	[%r188+33800984], %r267;
		st.f64	[%r188+67601968], %r267;
		st.f64	[%r188+101402952], %r267;
		st.f64	[%r188+135203936], %r267;
		mul.f64	%r339, %r60, %r131;
		ld.f64	%r341, [%r186+34433424];
		mul.f64	%r340, %r339, %r341;
		st.f64	[%r188+169004920], %r340;
		mul.f64	%r342, %r42, %r59;
		st.f64	[%r188+202805904], %r342;
		st.f64	[%r188+236606888], %r267;
		st.f64	[%r188+270407872], %r267;
		st.f64	[%r188+304208856], %r267;
		mul.f64	%r136, %r23, %r60;
		ld.f64	%r347, [%r186+68866848];
		mul.f64	%r346, %r347, %r136;
		st.f64	[%r188+338009840], %r346;
		st.f64	[%r188+371810824], %r267;
		mul.f64	%r139, %r41, %r59;
		st.f64	[%r188+405611808], %r139;
		st.f64	[%r188+439412792], %r267;
		st.f64	[%r188+473213776], %r267;
		ld.f64	%r352, [%r186+103300272];
		mul.f64	%r351, %r352, %r136;
		st.f64	[%r188+507014760], %r351;
		st.f64	[%r188+540815744], %r267;
		st.f64	[%r188+574616728], %r267;
		st.f64	[%r188+608417712], %r139;
		st.f64	[%r188+642218696], %r267;
		ld.f64	%r145, [%r186+34433424];
		mul.f64	%r148, %r53, %r61;
		ld.f64	%r149, [%r186+68866848];
		mul.f64	%r356, %r61, %r143;
		mul.f64	%r357, %r145, %r145;
		mul.f64	%r358, %r149, %r149;
		mul.f64	%r359, %r358, %r148;
		neg.f64	%r360, %r359;
		fma.rn.f64	%r152, %r356, %r357, %r360;
		ld.f64	%r153, [%r186+103300272];
		neg.f64	%r361, %r148;
		mul.f64	%r362, %r153, %r153;
		fma.rn.f64	%r155, %r361, %r362, %r152;
		mul.f64	%r363, %r39, %r60;
		neg.f64	%r364, %r363;
		ld.f64	%r365, [%r186+137733696];
		fma.rn.f64	%r158, %r364, %r365, %r155;
		st.f64	[%r188+676019680], %r158;
		mul.f64	%r366, %r60, %r142;
		ld.f64	%r368, [%r186+34433424];
		mul.f64	%r367, %r366, %r368;
		st.f64	[%r188+709820664], %r367;
		mul.f64	%r162, %r53, %r60;
		ld.f64	%r370, [%r186+68866848];
		mul.f64	%r369, %r370, %r162;
		st.f64	[%r188+743621648], %r369;
		ld.f64	%r372, [%r186+103300272];
		mul.f64	%r371, %r372, %r162;
		st.f64	[%r188+777422632], %r371;
		mul.f64	%r373, %r39, %r59;
		st.f64	[%r188+811223616], %r373;
		add.u64	%r173, %r173, 6801664;
		add.u64	%r172, %r172, 256;
		setp.ne.u64	%r374, %r172, %r196;
	@%r374	bra	$L7;
		bra	$L8;
$L13:
	@%r405	bra.uni	$L21;
	@%r400	bra	$L22;
		add.u64	%r377, %r377, 1;
$L22:
$L21:
		bra	$L11;
$L1:
	ret;
}

// BEGIN FUNCTION DECL: x_solve$_omp_fn$1
.entry x_solve$_omp_fn$1 (.param.u64 %in_ar0);

// BEGIN FUNCTION DEF: x_solve$_omp_fn$1
.entry x_solve$_omp_fn$1 (.param.u64 %in_ar0)
{
	.reg.u64 %ar0;
	ld.param.u64 %ar0, [%in_ar0];
	.reg.u32 %r22;
	.reg.u32 %r25;
	.reg.u32 %r27;
	.reg.u32 %r29;
	.reg.u32 %r30;
	.reg.u32 %r33;
	.reg.u32 %r34;
	.reg.u32 %r41;
	.reg.u32 %r44;
	.reg.u32 %r45;
	.reg.u32 %r47;
	.reg.u32 %r48;
	.reg.u64 %r49;
	.reg.u64 %r54;
	.reg.u64 %r55;
	.reg.u64 %r56;
	.reg.u32 %r57;
	.reg.u32 %r58;
	.reg.u32 %r59;
	.reg.pred %r60;
	.reg.u64 %r61;
	.reg.u64 %r62;
	.reg.u32 %r63;
	.reg.pred %r64;
	.reg.u64 %r65;
	.reg.u64 %r66;
	.reg.u64 %r67;
	.reg.u64 %r68;
	.reg.u64 %r69;
	.reg.u64 %r70;
	.reg.f64 %r71;
	.reg.u64 %r83;
	.reg.u64 %r87;
	.reg.u64 %r88;
	.reg.u64 %r89;
	.reg.u64 %r90;
	.reg.u64 %r92;
	.reg.u64 %r94;
	.reg.u64 %r95;
	.reg.u64 %r96;
	.reg.pred %r243;
	.reg.u64 %r244;
	.reg.u64 %r245;
	.reg.pred %r246;
	.reg.pred %r247;
	.reg.u32 %r248;
	.reg.u32 %r249;
	.reg.u32 %r250;
	.reg.u32 %r251;
	{
		.reg.u32	%y;
		mov.u32	%y, %tid.y;
		setp.ne.u32	%r246, %y, 0;
	}
	{
		.reg.u32	%x;
		mov.u32	%x, %tid.x;
		setp.ne.u32	%r247, %x, 0;
	}
	@%r246	bra.uni	$L40;
	@%r247	bra	$L41;
		mov.u64	%r55, %ar0;
		ld.u64	%r56, [%r55+8];
		ld.u32	%r25, [%r56];
		mov.u32	%r44, %nctaid.x;
		mov.u32	%r45, %ctaid.x;
		add.u32	%r57, %r25, -1;
		add.u32	%r58, %r57, %r44;
		div.s32	%r41, %r58, %r44;
		mul.lo.u32	%r22, %r41, %r45;
		add.u32	%r59, %r22, %r41;
		min.s32	%r30, %r59, %r25;
		setp.ge.s32	%r60, %r22, %r30;
		selp.u32	%r250, 1, 0, %r60;
		st.shared.u32	[__oacc_bcast], %r250;
$L41:
$L40:
		bar.sync	0;
		ld.shared.u32	%r251, [__oacc_bcast];
		setp.ne.u32	%r60, %r251, 0;
		bar.sync	0;
	@%r60	bra.uni	$L29;
	@%r246	bra.uni	$L38;
	@%r247	bra	$L39;
		ld.u64	%r61, [%r55+16];
		ld.u32	%r27, [%r61];
		ld.u64	%r62, [%r55+24];
		ld.u32	%r29, [%r62];
$L39:
$L38:
$L32:
	@%r246	bra.uni	$L36;
	@%r247	bra	$L37;
		add.u32	%r22, %r22, 1;
	// fork 2;
		cvta.shared.u64	%r245, __oacc_bcast;
		st.u32	[%r245], %r22;
		st.u32	[%r245+4], %r27;
		st.u32	[%r245+8], %r29;
		st.u32	[%r245+12], %r30;
		st.u64	[%r245+16], %r55;
$L37:
$L36:
		bar.sync	0;
	// forked 2;
		cvta.shared.u64	%r244, __oacc_bcast;
		ld.u32	%r22, [%r244];
		ld.u32	%r27, [%r244+4];
		ld.u32	%r29, [%r244+8];
		ld.u32	%r30, [%r244+12];
		ld.u64	%r55, [%r244+16];
	// fork 4;
	// forked 4;
		mov.u32	%r47, %tid.y;
		mov.u32	%r48, %tid.x;
		shl.b32	%r63, %r47, 5;
		add.u32	%r33, %r63, %r48;
		setp.le.s32	%r64, %r27, %r33;
	@%r64	bra	$L31;
		ld.u64	%r49, [%r55];
		add.u32	%r34, %r33, 1;
		cvt.s64.s32	%r65, %r34;
		cvt.s64.s32	%r66, %r22;
		mul.lo.u64	%r67, %r66, 161;
		add.u64	%r68, %r67, %r65;
		shl.b64	%r69, %r68, 3;
		add.u64	%r70, %r49, %r69;
		mov.f64	%r71, 0d0000000000000000;
		st.f64	[%r70], %r71;
		st.f64	[%r70+33593616], %r71;
		st.f64	[%r70+67187232], %r71;
		cvt.s64.s32	%r83, %r29;
		mad.lo.u64	%r87, %r83, 25921, %r67;
		add.u64	%r88, %r87, %r65;
		shl.b64	%r89, %r88, 3;
		add.u64	%r90, %r49, %r89;
		st.f64	[%r90], %r71;
		cvt.s64.s32	%r92, %r29;
		mad.lo.u64	%r94, %r92, 25921, %r67;
		add.u64	%r95, %r94, %r65;
		shl.b64	%r96, %r95, 3;
		add.u64	%r54, %r49, %r96;
		st.f64	[%r54+33593616], %r71;
		st.f64	[%r54+67187232], %r71;
		st.f64	[%r70+503904240], %r71;
		st.f64	[%r70+537497856], %r71;
		st.f64	[%r70+571091472], %r71;
		st.f64	[%r54+503904240], %r71;
		st.f64	[%r54+537497856], %r71;
		st.f64	[%r54+571091472], %r71;
		st.f64	[%r70+1007808480], %r71;
		st.f64	[%r70+1041402096], %r71;
		st.f64	[%r70+1074995712], %r71;
		st.f64	[%r54+1007808480], %r71;
		st.f64	[%r54+1041402096], %r71;
		st.f64	[%r54+1074995712], %r71;
		st.f64	[%r70+1511712720], %r71;
		st.f64	[%r70+1545306336], %r71;
		st.f64	[%r70+1578899952], %r71;
		st.f64	[%r54+1511712720], %r71;
		st.f64	[%r54+1545306336], %r71;
		st.f64	[%r54+1578899952], %r71;
		st.f64	[%r70+2015616960], %r71;
		st.f64	[%r70+2049210576], %r71;
		st.f64	[%r70+2082804192], %r71;
		st.f64	[%r54+2015616960], %r71;
		st.f64	[%r54+2049210576], %r71;
		st.f64	[%r54+2082804192], %r71;
		st.f64	[%r70+100780848], %r71;
		st.f64	[%r70+134374464], %r71;
		st.f64	[%r70+167968080], %r71;
		st.f64	[%r54+100780848], %r71;
		st.f64	[%r54+134374464], %r71;
		st.f64	[%r54+167968080], %r71;
		st.f64	[%r70+604685088], %r71;
		st.f64	[%r70+638278704], %r71;
		st.f64	[%r70+671872320], %r71;
		st.f64	[%r54+604685088], %r71;
		st.f64	[%r54+638278704], %r71;
		st.f64	[%r54+671872320], %r71;
		st.f64	[%r70+1108589328], %r71;
		st.f64	[%r70+1142182944], %r71;
		st.f64	[%r70+1175776560], %r71;
		st.f64	[%r54+1108589328], %r71;
		st.f64	[%r54+1142182944], %r71;
		st.f64	[%r54+1175776560], %r71;
		st.f64	[%r70+1612493568], %r71;
		st.f64	[%r70+1646087184], %r71;
		st.f64	[%r70+1679680800], %r71;
		st.f64	[%r54+1612493568], %r71;
		st.f64	[%r54+1646087184], %r71;
		st.f64	[%r54+1679680800], %r71;
		st.f64	[%r70+2116397808], %r71;
		st.f64	[%r70+2149991424], %r71;
		st.f64	[%r70+2183585040], %r71;
		st.f64	[%r54+2116397808], %r71;
		st.f64	[%r54+2149991424], %r71;
		st.f64	[%r54+2183585040], %r71;
		st.f64	[%r70+201561696], %r71;
		st.f64	[%r70+235155312], %r71;
		st.f64	[%r70+268748928], %r71;
		st.f64	[%r54+201561696], %r71;
		st.f64	[%r54+235155312], %r71;
		st.f64	[%r54+268748928], %r71;
		st.f64	[%r70+705465936], %r71;
		st.f64	[%r70+739059552], %r71;
		st.f64	[%r70+772653168], %r71;
		st.f64	[%r54+705465936], %r71;
		st.f64	[%r54+739059552], %r71;
		st.f64	[%r54+772653168], %r71;
		st.f64	[%r70+1209370176], %r71;
		st.f64	[%r70+1242963792], %r71;
		st.f64	[%r70+1276557408], %r71;
		st.f64	[%r54+1209370176], %r71;
		st.f64	[%r54+1242963792], %r71;
		st.f64	[%r54+1276557408], %r71;
		st.f64	[%r70+1713274416], %r71;
		st.f64	[%r70+1746868032], %r71;
		st.f64	[%r70+1780461648], %r71;
		st.f64	[%r54+1713274416], %r71;
		st.f64	[%r54+1746868032], %r71;
		st.f64	[%r54+1780461648], %r71;
		st.f64	[%r70+2217178656], %r71;
		st.f64	[%r70+2250772272], %r71;
		st.f64	[%r70+2284365888], %r71;
		st.f64	[%r54+2217178656], %r71;
		st.f64	[%r54+2250772272], %r71;
		st.f64	[%r54+2284365888], %r71;
		st.f64	[%r70+302342544], %r71;
		st.f64	[%r70+335936160], %r71;
		st.f64	[%r70+369529776], %r71;
		st.f64	[%r54+302342544], %r71;
		st.f64	[%r54+335936160], %r71;
		st.f64	[%r54+369529776], %r71;
		st.f64	[%r70+806246784], %r71;
		st.f64	[%r70+839840400], %r71;
		st.f64	[%r70+873434016], %r71;
		st.f64	[%r54+806246784], %r71;
		st.f64	[%r54+839840400], %r71;
		st.f64	[%r54+873434016], %r71;
		st.f64	[%r70+1310151024], %r71;
		st.f64	[%r70+1343744640], %r71;
		st.f64	[%r70+1377338256], %r71;
		st.f64	[%r54+1310151024], %r71;
		st.f64	[%r54+1343744640], %r71;
		st.f64	[%r54+1377338256], %r71;
		st.f64	[%r70+1814055264], %r71;
		st.f64	[%r70+1847648880], %r71;
		st.f64	[%r70+1881242496], %r71;
		st.f64	[%r54+1814055264], %r71;
		st.f64	[%r54+1847648880], %r71;
		st.f64	[%r54+1881242496], %r71;
		st.f64	[%r70+2317959504], %r71;
		st.f64	[%r70+2351553120], %r71;
		st.f64	[%r70+2385146736], %r71;
		st.f64	[%r54+2317959504], %r71;
		st.f64	[%r54+2351553120], %r71;
		st.f64	[%r54+2385146736], %r71;
		st.f64	[%r70+403123392], %r71;
		st.f64	[%r70+436717008], %r71;
		st.f64	[%r70+470310624], %r71;
		st.f64	[%r54+403123392], %r71;
		st.f64	[%r54+436717008], %r71;
		st.f64	[%r54+470310624], %r71;
		st.f64	[%r70+907027632], %r71;
		st.f64	[%r70+940621248], %r71;
		st.f64	[%r70+974214864], %r71;
		st.f64	[%r54+907027632], %r71;
		st.f64	[%r54+940621248], %r71;
		st.f64	[%r54+974214864], %r71;
		st.f64	[%r70+1410931872], %r71;
		st.f64	[%r70+1444525488], %r71;
		st.f64	[%r70+1478119104], %r71;
		st.f64	[%r54+1410931872], %r71;
		st.f64	[%r54+1444525488], %r71;
		st.f64	[%r54+1478119104], %r71;
		st.f64	[%r70+1914836112], %r71;
		st.f64	[%r70+1948429728], %r71;
		st.f64	[%r70+1982023344], %r71;
		st.f64	[%r54+1914836112], %r71;
		st.f64	[%r54+1948429728], %r71;
		st.f64	[%r54+1982023344], %r71;
		st.f64	[%r70+2418740352], %r71;
		st.f64	[%r70+2452333968], %r71;
		st.f64	[%r70+2485927584], %r71;
		st.f64	[%r54+2418740352], %r71;
		st.f64	[%r54+2452333968], %r71;
		st.f64	[%r54+2485927584], %r71;
$L31:
	// joining 4;
	// join 4;
	// joining 2;
		bar.sync	0;
	// join 2;
	@%r246	bra.uni	$L34;
	@%r247	bra	$L35;
		setp.ne.u32	%r243, %r30, %r22;
		selp.u32	%r248, 1, 0, %r243;
		st.shared.u32	[__oacc_bcast], %r248;
$L35:
$L34:
		bar.sync	0;
		ld.shared.u32	%r249, [__oacc_bcast];
		setp.ne.u32	%r243, %r249, 0;
		bar.sync	0;
	@%r243	bra.uni	$L32;
$L29:
	ret;
}

// BEGIN FUNCTION DECL: x_solve$_omp_fn$2
.entry x_solve$_omp_fn$2 (.param.u64 %in_ar0);

// BEGIN FUNCTION DEF: x_solve$_omp_fn$2
.entry x_solve$_omp_fn$2 (.param.u64 %in_ar0)
{
	.reg.u64 %ar0;
	ld.param.u64 %ar0, [%in_ar0];
	.reg.u32 %r22;
	.reg.u32 %r25;
	.reg.u32 %r27;
	.reg.u32 %r29;
	.reg.u32 %r30;
	.reg.u32 %r33;
	.reg.u64 %r35;
	.reg.u64 %r36;
	.reg.u32 %r44;
	.reg.u32 %r47;
	.reg.u32 %r48;
	.reg.u64 %r49;
	.reg.u32 %r50;
	.reg.u32 %r51;
	.reg.u64 %r54;
	.reg.u64 %r55;
	.reg.u64 %r56;
	.reg.u32 %r57;
	.reg.u32 %r58;
	.reg.u32 %r59;
	.reg.pred %r60;
	.reg.u64 %r61;
	.reg.u64 %r62;
	.reg.u32 %r63;
	.reg.pred %r64;
	.reg.u32 %r65;
	.reg.u64 %r66;
	.reg.u64 %r68;
	.reg.u64 %r69;
	.reg.u64 %r70;
	.reg.u64 %r71;
	.reg.u64 %r72;
	.reg.u64 %r73;
	.reg.f64 %r74;
	.reg.u64 %r75;
	.reg.u64 %r77;
	.reg.u64 %r78;
	.reg.u64 %r79;
	.reg.pred %r89;
	.reg.u64 %r90;
	.reg.u64 %r91;
	.reg.pred %r92;
	.reg.pred %r93;
	.reg.u32 %r94;
	.reg.u32 %r95;
	.reg.u32 %r96;
	.reg.u32 %r97;
	{
		.reg.u32	%y;
		mov.u32	%y, %tid.y;
		setp.ne.u32	%r92, %y, 0;
	}
	{
		.reg.u32	%x;
		mov.u32	%x, %tid.x;
		setp.ne.u32	%r93, %x, 0;
	}
	@%r92	bra.uni	$L53;
	@%r93	bra	$L54;
		mov.u64	%r55, %ar0;
		ld.u64	%r56, [%r55+8];
		ld.u32	%r25, [%r56];
		mov.u32	%r47, %nctaid.x;
		mov.u32	%r48, %ctaid.x;
		add.u32	%r57, %r25, -1;
		add.u32	%r58, %r57, %r47;
		div.s32	%r44, %r58, %r47;
		mul.lo.u32	%r22, %r44, %r48;
		add.u32	%r59, %r22, %r44;
		min.s32	%r30, %r59, %r25;
		setp.ge.s32	%r60, %r22, %r30;
		selp.u32	%r96, 1, 0, %r60;
		st.shared.u32	[__oacc_bcast], %r96;
$L54:
$L53:
		bar.sync	0;
		ld.shared.u32	%r97, [__oacc_bcast];
		setp.ne.u32	%r60, %r97, 0;
		bar.sync	0;
	@%r60	bra.uni	$L42;
	@%r92	bra.uni	$L51;
	@%r93	bra	$L52;
		ld.u64	%r61, [%r55+16];
		ld.u32	%r27, [%r61];
		ld.u64	%r62, [%r55+24];
		ld.u32	%r29, [%r62];
$L52:
$L51:
$L45:
	@%r92	bra.uni	$L49;
	@%r93	bra	$L50;
		add.u32	%r22, %r22, 1;
	// fork 2;
		cvta.shared.u64	%r91, __oacc_bcast;
		st.u32	[%r91], %r22;
		st.u32	[%r91+4], %r27;
		st.u32	[%r91+8], %r29;
		st.u32	[%r91+12], %r30;
		st.u64	[%r91+16], %r55;
$L50:
$L49:
		bar.sync	0;
	// forked 2;
		cvta.shared.u64	%r90, __oacc_bcast;
		ld.u32	%r22, [%r90];
		ld.u32	%r27, [%r90+4];
		ld.u32	%r29, [%r90+8];
		ld.u32	%r30, [%r90+12];
		ld.u64	%r55, [%r90+16];
	// fork 4;
	// forked 4;
		mov.u32	%r50, %tid.y;
		mov.u32	%r51, %tid.x;
		shl.b32	%r63, %r50, 5;
		add.u32	%r33, %r63, %r51;
		setp.le.s32	%r64, %r27, %r33;
	@%r64	bra	$L44;
		ld.u64	%r35, [%r55];
		add.u32	%r65, %r33, 1;
		cvt.s64.s32	%r36, %r65;
		cvt.s64.s32	%r66, %r22;
		shl.b64	%r68, %r66, 2;
		add.u64	%r69, %r68, %r66;
		shl.b64	%r70, %r69, 5;
		add.u64	%r71, %r70, %r66;
		add.u64	%r72, %r71, %r36;
		shl.b64	%r73, %r72, 3;
		add.u64	%r49, %r35, %r73;
		mov.f64	%r74, 0d3ff0000000000000;
		st.f64	[%r49+33593616], %r74;
		cvt.s64.s32	%r75, %r29;
		mad.lo.u64	%r77, %r75, 25921, %r71;
		add.u64	%r78, %r77, %r36;
		shl.b64	%r79, %r78, 3;
		add.u64	%r54, %r35, %r79;
		st.f64	[%r54+33593616], %r74;
		st.f64	[%r49+638278704], %r74;
		st.f64	[%r54+638278704], %r74;
		st.f64	[%r49+1242963792], %r74;
		st.f64	[%r54+1242963792], %r74;
		st.f64	[%r49+1847648880], %r74;
		st.f64	[%r54+1847648880], %r74;
		st.f64	[%r49+2452333968], %r74;
		st.f64	[%r54+2452333968], %r74;
$L44:
	// joining 4;
	// join 4;
	// joining 2;
		bar.sync	0;
	// join 2;
	@%r92	bra.uni	$L47;
	@%r93	bra	$L48;
		setp.ne.u32	%r89, %r30, %r22;
		selp.u32	%r94, 1, 0, %r89;
		st.shared.u32	[__oacc_bcast], %r94;
$L48:
$L47:
		bar.sync	0;
		ld.shared.u32	%r95, [__oacc_bcast];
		setp.ne.u32	%r89, %r95, 0;
		bar.sync	0;
	@%r89	bra.uni	$L45;
$L42:
	ret;
}

// BEGIN FUNCTION DECL: x_solve$_omp_fn$3
.entry x_solve$_omp_fn$3 (.param.u64 %in_ar0);

// BEGIN FUNCTION DEF: x_solve$_omp_fn$3
.entry x_solve$_omp_fn$3 (.param.u64 %in_ar0)
{
	.reg.u64 %ar0;
	ld.param.u64 %ar0, [%in_ar0];
	.reg.u32 %r22;
	.reg.u32 %r26;
	.reg.u32 %r28;
	.reg.u32 %r30;
	.reg.f64 %r32;
	.reg.f64 %r34;
	.reg.f64 %r36;
	.reg.f64 %r38;
	.reg.f64 %r40;
	.reg.f64 %r42;
	.reg.f64 %r44;
	.reg.f64 %r46;
	.reg.u64 %r48;
	.reg.u32 %r50;
	.reg.u64 %r53;
	.reg.u64 %r56;
	.reg.u64 %r58;
	.reg.f64 %r60;
	.reg.f64 %r61;
	.reg.f64 %r62;
	.reg.u64 %r63;
	.reg.u64 %r65;
	.reg.f64 %r68;
	.reg.f64 %r69;
	.reg.u64 %r71;
	.reg.f64 %r75;
	.reg.f64 %r79;
	.reg.f64 %r83;
	.reg.f64 %r87;
	.reg.f64 %r91;
	.reg.f64 %r95;
	.reg.f64 %r96;
	.reg.f64 %r101;
	.reg.f64 %r105;
	.reg.f64 %r109;
	.reg.f64 %r113;
	.reg.f64 %r117;
	.reg.f64 %r121;
	.reg.f64 %r122;
	.reg.f64 %r127;
	.reg.f64 %r131;
	.reg.f64 %r135;
	.reg.f64 %r139;
	.reg.f64 %r143;
	.reg.f64 %r147;
	.reg.f64 %r148;
	.reg.f64 %r153;
	.reg.f64 %r157;
	.reg.f64 %r161;
	.reg.f64 %r165;
	.reg.f64 %r169;
	.reg.f64 %r173;
	.reg.f64 %r174;
	.reg.f64 %r176;
	.reg.f64 %r178;
	.reg.f64 %r179;
	.reg.f64 %r192;
	.reg.f64 %r193;
	.reg.f64 %r206;
	.reg.f64 %r207;
	.reg.f64 %r220;
	.reg.f64 %r221;
	.reg.f64 %r234;
	.reg.f64 %r235;
	.reg.f64 %r240;
	.reg.f64 %r245;
	.reg.f64 %r249;
	.reg.f64 %r253;
	.reg.f64 %r257;
	.reg.f64 %r261;
	.reg.f64 %r265;
	.reg.f64 %r270;
	.reg.f64 %r274;
	.reg.f64 %r278;
	.reg.f64 %r282;
	.reg.f64 %r286;
	.reg.f64 %r290;
	.reg.f64 %r295;
	.reg.f64 %r299;
	.reg.f64 %r303;
	.reg.f64 %r307;
	.reg.f64 %r311;
	.reg.f64 %r315;
	.reg.f64 %r320;
	.reg.f64 %r324;
	.reg.f64 %r328;
	.reg.f64 %r332;
	.reg.f64 %r336;
	.reg.f64 %r340;
	.reg.u64 %r349;
	.reg.u32 %r352;
	.reg.u32 %r356;
	.reg.u32 %r357;
	.reg.u64 %r358;
	.reg.u32 %r359;
	.reg.u32 %r360;
	.reg.u64 %r374;
	.reg.u64 %r391;
	.reg.u64 %r408;
	.reg.u64 %r409;
	.reg.u64 %r410;
	.reg.u64 %r418;
	.reg.u32 %r419;
	.reg.u32 %r424;
	.reg.u64 %r425;
	.reg.u32 %r426;
	.reg.u64 %r435;
	.reg.u64 %r436;
	.reg.u32 %r437;
	.reg.u32 %r438;
	.reg.u32 %r439;
	.reg.u32 %r440;
	.reg.pred %r441;
	.reg.u64 %r442;
	.reg.u64 %r443;
	.reg.u64 %r444;
	.reg.u64 %r445;
	.reg.u64 %r446;
	.reg.u64 %r447;
	.reg.u64 %r448;
	.reg.u64 %r449;
	.reg.u64 %r450;
	.reg.u64 %r451;
	.reg.u32 %r452;
	.reg.pred %r453;
	.reg.u32 %r454;
	.reg.u32 %r455;
	.reg.u32 %r456;
	.reg.u32 %r457;
	.reg.u32 %r458;
	.reg.u32 %r459;
	.reg.pred %r460;
	.reg.u64 %r461;
	.reg.u64 %r463;
	.reg.u64 %r464;
	.reg.u64 %r465;
	.reg.u64 %r466;
	.reg.u64 %r467;
	.reg.u64 %r468;
	.reg.u64 %r469;
	.reg.u64 %r470;
	.reg.u64 %r471;
	.reg.u64 %r472;
	.reg.u64 %r473;
	.reg.u64 %r474;
	.reg.u64 %r475;
	.reg.u32 %r476;
	.reg.u32 %r477;
	.reg.u32 %r478;
	.reg.u64 %r479;
	.reg.u64 %r480;
	.reg.u64 %r481;
	.reg.u64 %r482;
	.reg.u64 %r483;
	.reg.u64 %r484;
	.reg.f64 %r485;
	.reg.f64 %r486;
	.reg.f64 %r487;
	.reg.f64 %r488;
	.reg.f64 %r489;
	.reg.f64 %r490;
	.reg.f64 %r491;
	.reg.f64 %r492;
	.reg.f64 %r493;
	.reg.f64 %r494;
	.reg.f64 %r495;
	.reg.f64 %r496;
	.reg.f64 %r497;
	.reg.f64 %r498;
	.reg.f64 %r499;
	.reg.f64 %r500;
	.reg.f64 %r501;
	.reg.f64 %r502;
	.reg.f64 %r503;
	.reg.f64 %r504;
	.reg.f64 %r505;
	.reg.f64 %r506;
	.reg.f64 %r507;
	.reg.f64 %r508;
	.reg.f64 %r509;
	.reg.f64 %r510;
	.reg.f64 %r511;
	.reg.f64 %r512;
	.reg.f64 %r513;
	.reg.f64 %r514;
	.reg.f64 %r515;
	.reg.f64 %r516;
	.reg.f64 %r517;
	.reg.f64 %r518;
	.reg.f64 %r519;
	.reg.f64 %r520;
	.reg.f64 %r521;
	.reg.f64 %r522;
	.reg.f64 %r523;
	.reg.f64 %r524;
	.reg.f64 %r525;
	.reg.f64 %r526;
	.reg.f64 %r527;
	.reg.f64 %r528;
	.reg.f64 %r529;
	.reg.f64 %r530;
	.reg.f64 %r531;
	.reg.f64 %r532;
	.reg.f64 %r533;
	.reg.f64 %r534;
	.reg.f64 %r535;
	.reg.f64 %r536;
	.reg.f64 %r537;
	.reg.f64 %r538;
	.reg.f64 %r539;
	.reg.f64 %r540;
	.reg.f64 %r541;
	.reg.f64 %r542;
	.reg.f64 %r543;
	.reg.f64 %r544;
	.reg.f64 %r545;
	.reg.f64 %r546;
	.reg.f64 %r547;
	.reg.f64 %r548;
	.reg.f64 %r549;
	.reg.f64 %r550;
	.reg.f64 %r551;
	.reg.f64 %r552;
	.reg.f64 %r553;
	.reg.f64 %r554;
	.reg.f64 %r555;
	.reg.f64 %r556;
	.reg.f64 %r557;
	.reg.f64 %r558;
	.reg.f64 %r559;
	.reg.f64 %r560;
	.reg.f64 %r561;
	.reg.f64 %r562;
	.reg.f64 %r563;
	.reg.f64 %r564;
	.reg.f64 %r565;
	.reg.f64 %r566;
	.reg.f64 %r567;
	.reg.f64 %r568;
	.reg.f64 %r569;
	.reg.f64 %r570;
	.reg.f64 %r571;
	.reg.f64 %r572;
	.reg.f64 %r573;
	.reg.f64 %r574;
	.reg.f64 %r575;
	.reg.f64 %r576;
	.reg.f64 %r577;
	.reg.f64 %r578;
	.reg.f64 %r579;
	.reg.f64 %r580;
	.reg.f64 %r581;
	.reg.f64 %r582;
	.reg.f64 %r583;
	.reg.f64 %r584;
	.reg.f64 %r585;
	.reg.f64 %r586;
	.reg.f64 %r587;
	.reg.f64 %r588;
	.reg.f64 %r589;
	.reg.f64 %r590;
	.reg.f64 %r591;
	.reg.f64 %r592;
	.reg.f64 %r593;
	.reg.f64 %r594;
	.reg.f64 %r595;
	.reg.f64 %r596;
	.reg.f64 %r597;
	.reg.f64 %r598;
	.reg.f64 %r599;
	.reg.f64 %r600;
	.reg.f64 %r601;
	.reg.f64 %r602;
	.reg.f64 %r603;
	.reg.f64 %r604;
	.reg.f64 %r605;
	.reg.f64 %r606;
	.reg.f64 %r607;
	.reg.f64 %r608;
	.reg.f64 %r609;
	.reg.f64 %r610;
	.reg.f64 %r611;
	.reg.f64 %r612;
	.reg.f64 %r613;
	.reg.f64 %r614;
	.reg.f64 %r615;
	.reg.f64 %r616;
	.reg.f64 %r617;
	.reg.f64 %r618;
	.reg.f64 %r619;
	.reg.f64 %r620;
	.reg.f64 %r621;
	.reg.f64 %r622;
	.reg.f64 %r623;
	.reg.f64 %r624;
	.reg.f64 %r625;
	.reg.f64 %r626;
	.reg.f64 %r627;
	.reg.f64 %r628;
	.reg.f64 %r629;
	.reg.f64 %r630;
	.reg.f64 %r631;
	.reg.f64 %r632;
	.reg.f64 %r633;
	.reg.f64 %r634;
	.reg.f64 %r635;
	.reg.f64 %r636;
	.reg.f64 %r637;
	.reg.f64 %r638;
	.reg.f64 %r639;
	.reg.f64 %r640;
	.reg.f64 %r641;
	.reg.f64 %r642;
	.reg.f64 %r643;
	.reg.f64 %r644;
	.reg.f64 %r645;
	.reg.f64 %r646;
	.reg.f64 %r647;
	.reg.f64 %r648;
	.reg.f64 %r649;
	.reg.f64 %r650;
	.reg.f64 %r651;
	.reg.f64 %r652;
	.reg.f64 %r653;
	.reg.f64 %r654;
	.reg.f64 %r655;
	.reg.f64 %r656;
	.reg.f64 %r657;
	.reg.f64 %r658;
	.reg.f64 %r659;
	.reg.f64 %r660;
	.reg.f64 %r661;
	.reg.f64 %r662;
	.reg.f64 %r663;
	.reg.f64 %r664;
	.reg.f64 %r665;
	.reg.f64 %r666;
	.reg.f64 %r667;
	.reg.f64 %r668;
	.reg.f64 %r669;
	.reg.f64 %r670;
	.reg.f64 %r671;
	.reg.f64 %r672;
	.reg.f64 %r673;
	.reg.f64 %r674;
	.reg.f64 %r675;
	.reg.f64 %r676;
	.reg.f64 %r677;
	.reg.f64 %r678;
	.reg.f64 %r679;
	.reg.f64 %r680;
	.reg.f64 %r681;
	.reg.f64 %r682;
	.reg.f64 %r683;
	.reg.f64 %r684;
	.reg.f64 %r685;
	.reg.f64 %r686;
	.reg.f64 %r687;
	.reg.f64 %r688;
	.reg.f64 %r689;
	.reg.f64 %r690;
	.reg.f64 %r691;
	.reg.f64 %r692;
	.reg.f64 %r693;
	.reg.f64 %r694;
	.reg.f64 %r695;
	.reg.f64 %r696;
	.reg.f64 %r697;
	.reg.f64 %r698;
	.reg.f64 %r699;
	.reg.f64 %r700;
	.reg.f64 %r701;
	.reg.f64 %r702;
	.reg.f64 %r703;
	.reg.f64 %r704;
	.reg.f64 %r705;
	.reg.f64 %r706;
	.reg.f64 %r707;
	.reg.f64 %r708;
	.reg.f64 %r709;
	.reg.f64 %r710;
	.reg.f64 %r711;
	.reg.f64 %r712;
	.reg.f64 %r713;
	.reg.f64 %r714;
	.reg.f64 %r715;
	.reg.f64 %r716;
	.reg.f64 %r717;
	.reg.f64 %r718;
	.reg.f64 %r719;
	.reg.f64 %r720;
	.reg.f64 %r721;
	.reg.f64 %r722;
	.reg.f64 %r723;
	.reg.f64 %r724;
	.reg.f64 %r725;
	.reg.f64 %r726;
	.reg.f64 %r727;
	.reg.f64 %r728;
	.reg.f64 %r729;
	.reg.f64 %r730;
	.reg.f64 %r731;
	.reg.f64 %r732;
	.reg.f64 %r733;
	.reg.f64 %r734;
	.reg.f64 %r735;
	.reg.f64 %r736;
	.reg.f64 %r737;
	.reg.f64 %r738;
	.reg.f64 %r739;
	.reg.f64 %r740;
	.reg.f64 %r741;
	.reg.f64 %r742;
	.reg.f64 %r743;
	.reg.f64 %r744;
	.reg.pred %r745;
	.reg.pred %r746;
	.reg.pred %r747;
	.reg.u32 %r748;
	.reg.u32 %r749;
	.reg.u32 %r750;
	.reg.u32 %r751;
	.reg.u32 %r752;
	.reg.u32 %r753;
	.reg.u32 %r754;
	.reg.u32 %r755;
	.reg.u32 %r756;
	.reg.u32 %r757;
	.reg.u32 %r758;
	.reg.u32 %r759;
	.reg.u32 %r760;
	.reg.u32 %r761;
	.reg.u32 %r762;
	.reg.u32 %r763;
	.reg.u32 %r764;
	.reg.u32 %r765;
	.reg.u32 %r766;
	.reg.u32 %r767;
	.reg.u32 %r768;
	.reg.u32 %r769;
	.reg.u64 %r770;
	.reg.u64 %r771;
	.reg.pred %r772;
	.reg.pred %r773;
	.reg.u32 %r774;
	.reg.pred %r775;
	.reg.u32 %r776;
	.reg.pred %r777;
	.reg.u32 %r778;
	.reg.u32 %r779;
	.reg.u32 %r780;
	.reg.u32 %r781;
	{
		.reg.u32	%y;
		mov.u32	%y, %tid.y;
		setp.ne.u32	%r777, %y, 0;
	}
	{
		.reg.u32	%x;
		mov.u32	%x, %tid.x;
		setp.ne.u32	%r772, %x, 0;
	}
	@%r777	bra.uni	$L79;
	@%r772	bra	$L80;
		mov.u64	%r435, %ar0;
		ld.u64	%r436, [%r435+56];
		ld.u32	%r30, [%r436];
		mov.u32	%r356, %nctaid.x;
		mov.u32	%r357, %ctaid.x;
		add.u32	%r437, %r30, -2;
		add.u32	%r438, %r437, %r356;
		div.s32	%r352, %r438, %r356;
		mul.lo.u32	%r22, %r352, %r357;
		add.u32	%r439, %r30, -1;
		add.u32	%r440, %r22, %r352;
		min.s32	%r50, %r439, %r440;
		setp.lt.s32	%r441, %r22, %r50;
		selp.u32	%r780, 1, 0, %r441;
		st.shared.u32	[__oacc_bcast], %r780;
$L80:
$L79:
		bar.sync	0;
		ld.shared.u32	%r781, [__oacc_bcast];
		setp.ne.u32	%r441, %r781, 0;
		bar.sync	0;
	@!%r441	bra.uni	$L55;
	@%r777	bra.uni	$L77;
	@%r772	bra	$L78;
		ld.u64	%r442, [%r435+40];
		ld.u32	%r26, [%r442];
		ld.u64	%r443, [%r435+48];
		ld.u32	%r28, [%r443];
		ld.u64	%r444, [%r435+64];
		ld.f64	%r32, [%r444];
		ld.u64	%r445, [%r435+72];
		ld.f64	%r34, [%r445];
		ld.u64	%r446, [%r435+80];
		ld.f64	%r36, [%r446];
		ld.u64	%r447, [%r435+88];
		ld.f64	%r38, [%r447];
		ld.u64	%r448, [%r435+96];
		ld.f64	%r40, [%r448];
		ld.u64	%r449, [%r435+104];
		ld.f64	%r42, [%r449];
		ld.u64	%r450, [%r435+112];
		ld.f64	%r44, [%r450];
		ld.u64	%r451, [%r435+120];
		ld.f64	%r46, [%r451];
		mov.u32	%r452, 25921;
		mul.wide.s32	%r425, %r22, %r452;
$L78:
$L77:
$L65:
	@%r777	bra.uni	$L75;
	@%r772	bra	$L76;
		mov.u32	%r426, %r22;
		add.u32	%r22, %r22, 1;
	// fork 2;
		cvta.shared.u64	%r771, __oacc_bcast;
		st.u32	[%r771], %r22;
		st.u32	[%r771+4], %r26;
		st.u32	[%r771+8], %r28;
		st.f64	[%r771+16], %r32;
		st.f64	[%r771+24], %r34;
		st.f64	[%r771+32], %r36;
		st.f64	[%r771+40], %r38;
		st.f64	[%r771+48], %r40;
		st.f64	[%r771+56], %r42;
		st.f64	[%r771+64], %r44;
		st.f64	[%r771+72], %r46;
		st.u32	[%r771+80], %r50;
		st.u64	[%r771+88], %r425;
		st.u32	[%r771+96], %r426;
		st.u64	[%r771+104], %r435;
$L76:
$L75:
		setp.eq.u32	%r775, 1, 0;
		bar.sync	0;
	// forked 2;
	@%r772	bra	$L72;
		cvta.shared.u64	%r770, __oacc_bcast;
		ld.u32	%r22, [%r770];
		ld.u32	%r26, [%r770+4];
		ld.u32	%r28, [%r770+8];
		ld.f64	%r32, [%r770+16];
		ld.f64	%r34, [%r770+24];
		ld.f64	%r36, [%r770+32];
		ld.f64	%r38, [%r770+40];
		ld.f64	%r40, [%r770+48];
		ld.f64	%r42, [%r770+56];
		ld.f64	%r44, [%r770+64];
		ld.f64	%r46, [%r770+72];
		ld.u32	%r50, [%r770+80];
		ld.u64	%r425, [%r770+88];
		ld.u32	%r426, [%r770+96];
		ld.u64	%r435, [%r770+104];
		mov.u32	%r359, %tid.y;
		setp.gt.s32	%r453, %r26, %r359;
		mov.pred	%r775, %r453;
$L72:
		mov.pred	%r453, %r775;
		selp.u32	%r776, 1, 0, %r453;
		shfl.idx.b32	%r776, %r776, 0, 31;
		setp.ne.u32	%r453, %r776, 0;
	@%r453	bra.uni	$L57;
$L64:
	// joining 2;
		bar.sync	0;
	// join 2;
	@%r777	bra.uni	$L73;
	@%r772	bra	$L74;
		add.u64	%r425, %r425, 25921;
		setp.ne.u32	%r747, %r50, %r22;
		selp.u32	%r778, 1, 0, %r747;
		st.shared.u32	[__oacc_bcast], %r778;
$L74:
$L73:
		bar.sync	0;
		ld.shared.u32	%r779, [__oacc_bcast];
		setp.ne.u32	%r747, %r779, 0;
		bar.sync	0;
	@%r747	bra.uni	$L65;
		bra	$L55;
$L57:
	@%r772	bra	$L71;
		add.u32	%r419, %r359, 1;
		add.u32	%r454, %r26, -1;
		sub.u32	%r455, %r454, %r359;
		and.b32	%r456, %r455, -8;
		add.u32	%r457, %r359, 9;
		add.u32	%r424, %r456, %r457;
		add.u32	%r458, %r426, 2;
		mov.u32	%r459, 25921;
		mul.wide.s32	%r56, %r458, %r459;
$L71:
$L63:
	// fork 4;
	// forked 4;
		shfl.idx.b32	%r22, %r22, 0, 31;
		shfl.idx.b32	%r26, %r26, 0, 31;
		shfl.idx.b32	%r28, %r28, 0, 31;
		mov.b64	{%r748,%r749}, %r32;
		shfl.idx.b32	%r748, %r748, 0, 31;
		shfl.idx.b32	%r749, %r749, 0, 31;
		mov.b64	%r32, {%r748,%r749};
		mov.b64	{%r750,%r751}, %r34;
		shfl.idx.b32	%r750, %r750, 0, 31;
		shfl.idx.b32	%r751, %r751, 0, 31;
		mov.b64	%r34, {%r750,%r751};
		mov.b64	{%r752,%r753}, %r36;
		shfl.idx.b32	%r752, %r752, 0, 31;
		shfl.idx.b32	%r753, %r753, 0, 31;
		mov.b64	%r36, {%r752,%r753};
		mov.b64	{%r754,%r755}, %r38;
		shfl.idx.b32	%r754, %r754, 0, 31;
		shfl.idx.b32	%r755, %r755, 0, 31;
		mov.b64	%r38, {%r754,%r755};
		mov.b64	{%r756,%r757}, %r40;
		shfl.idx.b32	%r756, %r756, 0, 31;
		shfl.idx.b32	%r757, %r757, 0, 31;
		mov.b64	%r40, {%r756,%r757};
		mov.b64	{%r758,%r759}, %r42;
		shfl.idx.b32	%r758, %r758, 0, 31;
		shfl.idx.b32	%r759, %r759, 0, 31;
		mov.b64	%r42, {%r758,%r759};
		mov.b64	{%r760,%r761}, %r44;
		shfl.idx.b32	%r760, %r760, 0, 31;
		shfl.idx.b32	%r761, %r761, 0, 31;
		mov.b64	%r44, {%r760,%r761};
		mov.b64	{%r762,%r763}, %r46;
		shfl.idx.b32	%r762, %r762, 0, 31;
		shfl.idx.b32	%r763, %r763, 0, 31;
		mov.b64	%r46, {%r762,%r763};
		shfl.idx.b32	%r50, %r50, 0, 31;
		mov.b64	{%r764,%r765}, %r56;
		shfl.idx.b32	%r764, %r764, 0, 31;
		shfl.idx.b32	%r765, %r765, 0, 31;
		mov.b64	%r56, {%r764,%r765};
		shfl.idx.b32	%r419, %r419, 0, 31;
		shfl.idx.b32	%r424, %r424, 0, 31;
		mov.b64	{%r766,%r767}, %r425;
		shfl.idx.b32	%r766, %r766, 0, 31;
		shfl.idx.b32	%r767, %r767, 0, 31;
		mov.b64	%r425, {%r766,%r767};
		mov.b64	{%r768,%r769}, %r435;
		shfl.idx.b32	%r768, %r768, 0, 31;
		shfl.idx.b32	%r769, %r769, 0, 31;
		mov.b64	%r435, {%r768,%r769};
		mov.u32	%r360, %tid.x;
		setp.gt.s32	%r460, %r28, %r360;
	@%r460	bra	$L59;
$L62:
	// joining 4;
		setp.eq.u32	%r773, 1, 0;
	// join 4;
	@%r772	bra	$L70;
		add.u32	%r419, %r419, 8;
		setp.ne.u32	%r746, %r419, %r424;
		mov.pred	%r773, %r746;
$L70:
		mov.pred	%r746, %r773;
		selp.u32	%r774, 1, 0, %r746;
		shfl.idx.b32	%r774, %r774, 0, 31;
		setp.ne.u32	%r746, %r774, 0;
	@%r746	bra.uni	$L63;
		bra	$L64;
$L59:
		mul.f64	%r60, %r32, %r46;
		mul.f64	%r61, %r32, %r44;
		neg.f64	%r62, %r61;
		ld.u64	%r63, [%r435+32];
		ld.u64	%r65, [%r435+24];
		mul.f64	%r69, %r42, %r60;
		ld.u64	%r71, [%r435+16];
		mul.f64	%r96, %r40, %r60;
		mul.f64	%r122, %r38, %r60;
		mul.f64	%r148, %r36, %r60;
		mul.f64	%r174, %r34, %r60;
		add.f64	%r176, %r60, %r60;
		mul.f64	%r179, %r42, %r176;
		mul.f64	%r193, %r40, %r176;
		mul.f64	%r207, %r38, %r176;
		mul.f64	%r221, %r36, %r176;
		mul.f64	%r235, %r34, %r176;
		cvt.s64.s32	%r358, %r360;
		cvt.s64.s32	%r461, %r419;
		shl.b64	%r463, %r461, 2;
		add.u64	%r464, %r463, %r461;
		shl.b64	%r465, %r464, 5;
		add.u64	%r466, %r465, %r461;
		add.u64	%r467, %r425, 1;
		add.u64	%r468, %r467, %r466;
		add.u64	%r469, %r468, %r358;
		shl.b64	%r349, %r469, 3;
		add.u64	%r470, %r425, 25922;
		add.u64	%r471, %r470, %r466;
		add.u64	%r472, %r471, %r358;
		shl.b64	%r48, %r472, 3;
		add.u64	%r473, %r56, 1;
		add.u64	%r474, %r473, %r466;
		add.u64	%r475, %r474, %r358;
		shl.b64	%r53, %r475, 3;
		add.u32	%r476, %r28, -1;
		sub.u32	%r477, %r476, %r360;
		shr.u32	%r478, %r477, 5;
		cvt.u64.u32	%r479, %r478;
		shl.b64	%r480, %r479, 5;
		add.u64	%r481, %r425, 25954;
		add.u64	%r482, %r481, %r466;
		add.u64	%r483, %r482, %r358;
		add.u64	%r484, %r480, %r483;
		shl.b64	%r418, %r484, 3;
$L61:
		add.u64	%r58, %r63, %r349;
		add.u64	%r374, %r65, %r349;
		ld.f64	%r486, [%r374];
		mul.f64	%r485, %r60, %r486;
		neg.f64	%r487, %r485;
		ld.f64	%r488, [%r58];
		fma.rn.f64	%r68, %r62, %r488, %r487;
		add.u64	%r391, %r71, %r48;
		sub.f64	%r489, %r68, %r69;
		st.f64	[%r391], %r489;
		ld.f64	%r491, [%r374+33800984];
		mul.f64	%r490, %r60, %r491;
		neg.f64	%r492, %r490;
		ld.f64	%r493, [%r58+33800984];
		fma.rn.f64	%r75, %r62, %r493, %r492;
		st.f64	[%r391+100780848], %r75;
		ld.f64	%r495, [%r374+67601968];
		mul.f64	%r494, %r60, %r495;
		neg.f64	%r496, %r494;
		ld.f64	%r497, [%r58+67601968];
		fma.rn.f64	%r79, %r62, %r497, %r496;
		st.f64	[%r391+201561696], %r79;
		ld.f64	%r499, [%r374+101402952];
		mul.f64	%r498, %r60, %r499;
		neg.f64	%r500, %r498;
		ld.f64	%r501, [%r58+101402952];
		fma.rn.f64	%r83, %r62, %r501, %r500;
		st.f64	[%r391+302342544], %r83;
		ld.f64	%r503, [%r374+135203936];
		mul.f64	%r502, %r60, %r503;
		neg.f64	%r504, %r502;
		ld.f64	%r505, [%r58+135203936];
		fma.rn.f64	%r87, %r62, %r505, %r504;
		st.f64	[%r391+403123392], %r87;
		ld.f64	%r507, [%r374+169004920];
		mul.f64	%r506, %r60, %r507;
		neg.f64	%r508, %r506;
		ld.f64	%r509, [%r58+169004920];
		fma.rn.f64	%r91, %r62, %r509, %r508;
		st.f64	[%r391+503904240], %r91;
		ld.f64	%r511, [%r374+202805904];
		mul.f64	%r510, %r60, %r511;
		neg.f64	%r512, %r510;
		ld.f64	%r513, [%r58+202805904];
		fma.rn.f64	%r95, %r62, %r513, %r512;
		sub.f64	%r514, %r95, %r96;
		st.f64	[%r391+604685088], %r514;
		ld.f64	%r516, [%r374+236606888];
		mul.f64	%r515, %r60, %r516;
		neg.f64	%r517, %r515;
		ld.f64	%r518, [%r58+236606888];
		fma.rn.f64	%r101, %r62, %r518, %r517;
		st.f64	[%r391+705465936], %r101;
		ld.f64	%r520, [%r374+270407872];
		mul.f64	%r519, %r60, %r520;
		neg.f64	%r521, %r519;
		ld.f64	%r522, [%r58+270407872];
		fma.rn.f64	%r105, %r62, %r522, %r521;
		st.f64	[%r391+806246784], %r105;
		ld.f64	%r524, [%r374+304208856];
		mul.f64	%r523, %r60, %r524;
		neg.f64	%r525, %r523;
		ld.f64	%r526, [%r58+304208856];
		fma.rn.f64	%r109, %r62, %r526, %r525;
		st.f64	[%r391+907027632], %r109;
		ld.f64	%r528, [%r374+338009840];
		mul.f64	%r527, %r60, %r528;
		neg.f64	%r529, %r527;
		ld.f64	%r530, [%r58+338009840];
		fma.rn.f64	%r113, %r62, %r530, %r529;
		st.f64	[%r391+1007808480], %r113;
		ld.f64	%r532, [%r374+371810824];
		mul.f64	%r531, %r60, %r532;
		neg.f64	%r533, %r531;
		ld.f64	%r534, [%r58+371810824];
		fma.rn.f64	%r117, %r62, %r534, %r533;
		st.f64	[%r391+1108589328], %r117;
		ld.f64	%r536, [%r374+405611808];
		mul.f64	%r535, %r60, %r536;
		neg.f64	%r537, %r535;
		ld.f64	%r538, [%r58+405611808];
		fma.rn.f64	%r121, %r62, %r538, %r537;
		sub.f64	%r539, %r121, %r122;
		st.f64	[%r391+1209370176], %r539;
		ld.f64	%r541, [%r374+439412792];
		mul.f64	%r540, %r60, %r541;
		neg.f64	%r542, %r540;
		ld.f64	%r543, [%r58+439412792];
		fma.rn.f64	%r127, %r62, %r543, %r542;
		st.f64	[%r391+1310151024], %r127;
		ld.f64	%r545, [%r374+473213776];
		mul.f64	%r544, %r60, %r545;
		neg.f64	%r546, %r544;
		ld.f64	%r547, [%r58+473213776];
		fma.rn.f64	%r131, %r62, %r547, %r546;
		st.f64	[%r391+1410931872], %r131;
		ld.f64	%r549, [%r374+507014760];
		mul.f64	%r548, %r60, %r549;
		neg.f64	%r550, %r548;
		ld.f64	%r551, [%r58+507014760];
		fma.rn.f64	%r135, %r62, %r551, %r550;
		st.f64	[%r391+1511712720], %r135;
		ld.f64	%r553, [%r374+540815744];
		mul.f64	%r552, %r60, %r553;
		neg.f64	%r554, %r552;
		ld.f64	%r555, [%r58+540815744];
		fma.rn.f64	%r139, %r62, %r555, %r554;
		st.f64	[%r391+1612493568], %r139;
		ld.f64	%r557, [%r374+574616728];
		mul.f64	%r556, %r60, %r557;
		neg.f64	%r558, %r556;
		ld.f64	%r559, [%r58+574616728];
		fma.rn.f64	%r143, %r62, %r559, %r558;
		st.f64	[%r391+1713274416], %r143;
		ld.f64	%r561, [%r374+608417712];
		mul.f64	%r560, %r60, %r561;
		neg.f64	%r562, %r560;
		ld.f64	%r563, [%r58+608417712];
		fma.rn.f64	%r147, %r62, %r563, %r562;
		sub.f64	%r564, %r147, %r148;
		st.f64	[%r391+1814055264], %r564;
		ld.f64	%r566, [%r374+642218696];
		mul.f64	%r565, %r60, %r566;
		neg.f64	%r567, %r565;
		ld.f64	%r568, [%r58+642218696];
		fma.rn.f64	%r153, %r62, %r568, %r567;
		st.f64	[%r391+1914836112], %r153;
		ld.f64	%r570, [%r374+676019680];
		mul.f64	%r569, %r60, %r570;
		neg.f64	%r571, %r569;
		ld.f64	%r572, [%r58+676019680];
		fma.rn.f64	%r157, %r62, %r572, %r571;
		st.f64	[%r391+2015616960], %r157;
		ld.f64	%r574, [%r374+709820664];
		mul.f64	%r573, %r60, %r574;
		neg.f64	%r575, %r573;
		ld.f64	%r576, [%r58+709820664];
		fma.rn.f64	%r161, %r62, %r576, %r575;
		st.f64	[%r391+2116397808], %r161;
		ld.f64	%r578, [%r374+743621648];
		mul.f64	%r577, %r60, %r578;
		neg.f64	%r579, %r577;
		ld.f64	%r580, [%r58+743621648];
		fma.rn.f64	%r165, %r62, %r580, %r579;
		st.f64	[%r391+2217178656], %r165;
		ld.f64	%r582, [%r374+777422632];
		mul.f64	%r581, %r60, %r582;
		neg.f64	%r583, %r581;
		ld.f64	%r584, [%r58+777422632];
		fma.rn.f64	%r169, %r62, %r584, %r583;
		st.f64	[%r391+2317959504], %r169;
		ld.f64	%r586, [%r374+811223616];
		mul.f64	%r585, %r60, %r586;
		neg.f64	%r587, %r585;
		ld.f64	%r588, [%r58+811223616];
		fma.rn.f64	%r173, %r62, %r588, %r587;
		sub.f64	%r589, %r173, %r174;
		st.f64	[%r391+2418740352], %r589;
		add.u64	%r408, %r65, %r48;
		ld.f64	%r590, [%r408];
		fma.rn.f64	%r178, %r176, %r590, 0d3ff0000000000000;
		add.f64	%r591, %r178, %r179;
		st.f64	[%r391+33593616], %r591;
		ld.f64	%r593, [%r408+33800984];
		mul.f64	%r592, %r593, %r176;
		st.f64	[%r391+134374464], %r592;
		ld.f64	%r595, [%r408+67601968];
		mul.f64	%r594, %r595, %r176;
		st.f64	[%r391+235155312], %r594;
		ld.f64	%r597, [%r408+101402952];
		mul.f64	%r596, %r597, %r176;
		st.f64	[%r391+335936160], %r596;
		ld.f64	%r599, [%r408+135203936];
		mul.f64	%r598, %r599, %r176;
		st.f64	[%r391+436717008], %r598;
		ld.f64	%r601, [%r408+169004920];
		mul.f64	%r600, %r601, %r176;
		st.f64	[%r391+537497856], %r600;
		ld.f64	%r602, [%r408+202805904];
		fma.rn.f64	%r192, %r176, %r602, 0d3ff0000000000000;
		add.f64	%r603, %r192, %r193;
		st.f64	[%r391+638278704], %r603;
		ld.f64	%r605, [%r408+236606888];
		mul.f64	%r604, %r605, %r176;
		st.f64	[%r391+739059552], %r604;
		ld.f64	%r607, [%r408+270407872];
		mul.f64	%r606, %r607, %r176;
		st.f64	[%r391+839840400], %r606;
		ld.f64	%r609, [%r408+304208856];
		mul.f64	%r608, %r609, %r176;
		st.f64	[%r391+940621248], %r608;
		ld.f64	%r611, [%r408+338009840];
		mul.f64	%r610, %r611, %r176;
		st.f64	[%r391+1041402096], %r610;
		ld.f64	%r613, [%r408+371810824];
		mul.f64	%r612, %r613, %r176;
		st.f64	[%r391+1142182944], %r612;
		ld.f64	%r614, [%r408+405611808];
		fma.rn.f64	%r206, %r176, %r614, 0d3ff0000000000000;
		add.f64	%r615, %r206, %r207;
		st.f64	[%r391+1242963792], %r615;
		ld.f64	%r617, [%r408+439412792];
		mul.f64	%r616, %r617, %r176;
		st.f64	[%r391+1343744640], %r616;
		ld.f64	%r619, [%r408+473213776];
		mul.f64	%r618, %r619, %r176;
		st.f64	[%r391+1444525488], %r618;
		ld.f64	%r621, [%r408+507014760];
		mul.f64	%r620, %r621, %r176;
		st.f64	[%r391+1545306336], %r620;
		ld.f64	%r623, [%r408+540815744];
		mul.f64	%r622, %r623, %r176;
		st.f64	[%r391+1646087184], %r622;
		ld.f64	%r625, [%r408+574616728];
		mul.f64	%r624, %r625, %r176;
		st.f64	[%r391+1746868032], %r624;
		ld.f64	%r626, [%r408+608417712];
		fma.rn.f64	%r220, %r176, %r626, 0d3ff0000000000000;
		add.f64	%r627, %r220, %r221;
		st.f64	[%r391+1847648880], %r627;
		ld.f64	%r629, [%r408+642218696];
		mul.f64	%r628, %r629, %r176;
		st.f64	[%r391+1948429728], %r628;
		ld.f64	%r631, [%r408+676019680];
		mul.f64	%r630, %r631, %r176;
		st.f64	[%r391+2049210576], %r630;
		ld.f64	%r633, [%r408+709820664];
		mul.f64	%r632, %r633, %r176;
		st.f64	[%r391+2149991424], %r632;
		ld.f64	%r635, [%r408+743621648];
		mul.f64	%r634, %r635, %r176;
		st.f64	[%r391+2250772272], %r634;
		ld.f64	%r637, [%r408+777422632];
		mul.f64	%r636, %r637, %r176;
		st.f64	[%r391+2351553120], %r636;
		ld.f64	%r638, [%r408+811223616];
		fma.rn.f64	%r234, %r176, %r638, 0d3ff0000000000000;
		add.f64	%r639, %r234, %r235;
		st.f64	[%r391+2452333968], %r639;
		add.u64	%r409, %r63, %r53;
		add.u64	%r410, %r65, %r53;
		ld.f64	%r641, [%r410];
		mul.f64	%r640, %r60, %r641;
		neg.f64	%r642, %r640;
		ld.f64	%r643, [%r409];
		fma.rn.f64	%r240, %r61, %r643, %r642;
		sub.f64	%r644, %r240, %r69;
		st.f64	[%r391+67187232], %r644;
		ld.f64	%r646, [%r410+33800984];
		mul.f64	%r645, %r60, %r646;
		neg.f64	%r647, %r645;
		ld.f64	%r648, [%r409+33800984];
		fma.rn.f64	%r245, %r61, %r648, %r647;
		st.f64	[%r391+167968080], %r245;
		ld.f64	%r650, [%r410+67601968];
		mul.f64	%r649, %r60, %r650;
		neg.f64	%r651, %r649;
		ld.f64	%r652, [%r409+67601968];
		fma.rn.f64	%r249, %r61, %r652, %r651;
		st.f64	[%r391+268748928], %r249;
		ld.f64	%r654, [%r410+101402952];
		mul.f64	%r653, %r60, %r654;
		neg.f64	%r655, %r653;
		ld.f64	%r656, [%r409+101402952];
		fma.rn.f64	%r253, %r61, %r656, %r655;
		st.f64	[%r391+369529776], %r253;
		ld.f64	%r658, [%r410+135203936];
		mul.f64	%r657, %r60, %r658;
		neg.f64	%r659, %r657;
		ld.f64	%r660, [%r409+135203936];
		fma.rn.f64	%r257, %r61, %r660, %r659;
		st.f64	[%r391+470310624], %r257;
		ld.f64	%r662, [%r410+169004920];
		mul.f64	%r661, %r60, %r662;
		neg.f64	%r663, %r661;
		ld.f64	%r664, [%r409+169004920];
		fma.rn.f64	%r261, %r61, %r664, %r663;
		st.f64	[%r391+571091472], %r261;
		ld.f64	%r666, [%r410+202805904];
		mul.f64	%r665, %r60, %r666;
		neg.f64	%r667, %r665;
		ld.f64	%r668, [%r409+202805904];
		fma.rn.f64	%r265, %r61, %r668, %r667;
		sub.f64	%r669, %r265, %r96;
		st.f64	[%r391+671872320], %r669;
		ld.f64	%r671, [%r410+236606888];
		mul.f64	%r670, %r60, %r671;
		neg.f64	%r672, %r670;
		ld.f64	%r673, [%r409+236606888];
		fma.rn.f64	%r270, %r61, %r673, %r672;
		st.f64	[%r391+772653168], %r270;
		ld.f64	%r675, [%r410+270407872];
		mul.f64	%r674, %r60, %r675;
		neg.f64	%r676, %r674;
		ld.f64	%r677, [%r409+270407872];
		fma.rn.f64	%r274, %r61, %r677, %r676;
		st.f64	[%r391+873434016], %r274;
		ld.f64	%r679, [%r410+304208856];
		mul.f64	%r678, %r60, %r679;
		neg.f64	%r680, %r678;
		ld.f64	%r681, [%r409+304208856];
		fma.rn.f64	%r278, %r61, %r681, %r680;
		st.f64	[%r391+974214864], %r278;
		ld.f64	%r683, [%r410+338009840];
		mul.f64	%r682, %r60, %r683;
		neg.f64	%r684, %r682;
		ld.f64	%r685, [%r409+338009840];
		fma.rn.f64	%r282, %r61, %r685, %r684;
		st.f64	[%r391+1074995712], %r282;
		ld.f64	%r687, [%r410+371810824];
		mul.f64	%r686, %r60, %r687;
		neg.f64	%r688, %r686;
		ld.f64	%r689, [%r409+371810824];
		fma.rn.f64	%r286, %r61, %r689, %r688;
		st.f64	[%r391+1175776560], %r286;
		ld.f64	%r691, [%r410+405611808];
		mul.f64	%r690, %r60, %r691;
		neg.f64	%r692, %r690;
		ld.f64	%r693, [%r409+405611808];
		fma.rn.f64	%r290, %r61, %r693, %r692;
		sub.f64	%r694, %r290, %r122;
		st.f64	[%r391+1276557408], %r694;
		ld.f64	%r696, [%r410+439412792];
		mul.f64	%r695, %r60, %r696;
		neg.f64	%r697, %r695;
		ld.f64	%r698, [%r409+439412792];
		fma.rn.f64	%r295, %r61, %r698, %r697;
		st.f64	[%r391+1377338256], %r295;
		ld.f64	%r700, [%r410+473213776];
		mul.f64	%r699, %r60, %r700;
		neg.f64	%r701, %r699;
		ld.f64	%r702, [%r409+473213776];
		fma.rn.f64	%r299, %r61, %r702, %r701;
		st.f64	[%r391+1478119104], %r299;
		ld.f64	%r704, [%r410+507014760];
		mul.f64	%r703, %r60, %r704;
		neg.f64	%r705, %r703;
		ld.f64	%r706, [%r409+507014760];
		fma.rn.f64	%r303, %r61, %r706, %r705;
		st.f64	[%r391+1578899952], %r303;
		ld.f64	%r708, [%r410+540815744];
		mul.f64	%r707, %r60, %r708;
		neg.f64	%r709, %r707;
		ld.f64	%r710, [%r409+540815744];
		fma.rn.f64	%r307, %r61, %r710, %r709;
		st.f64	[%r391+1679680800], %r307;
		ld.f64	%r712, [%r410+574616728];
		mul.f64	%r711, %r60, %r712;
		neg.f64	%r713, %r711;
		ld.f64	%r714, [%r409+574616728];
		fma.rn.f64	%r311, %r61, %r714, %r713;
		st.f64	[%r391+1780461648], %r311;
		ld.f64	%r716, [%r410+608417712];
		mul.f64	%r715, %r60, %r716;
		neg.f64	%r717, %r715;
		ld.f64	%r718, [%r409+608417712];
		fma.rn.f64	%r315, %r61, %r718, %r717;
		sub.f64	%r719, %r315, %r148;
		st.f64	[%r391+1881242496], %r719;
		ld.f64	%r721, [%r410+642218696];
		mul.f64	%r720, %r60, %r721;
		neg.f64	%r722, %r720;
		ld.f64	%r723, [%r409+642218696];
		fma.rn.f64	%r320, %r61, %r723, %r722;
		st.f64	[%r391+1982023344], %r320;
		ld.f64	%r725, [%r410+676019680];
		mul.f64	%r724, %r60, %r725;
		neg.f64	%r726, %r724;
		ld.f64	%r727, [%r409+676019680];
		fma.rn.f64	%r324, %r61, %r727, %r726;
		st.f64	[%r391+2082804192], %r324;
		ld.f64	%r729, [%r410+709820664];
		mul.f64	%r728, %r60, %r729;
		neg.f64	%r730, %r728;
		ld.f64	%r731, [%r409+709820664];
		fma.rn.f64	%r328, %r61, %r731, %r730;
		st.f64	[%r391+2183585040], %r328;
		ld.f64	%r733, [%r410+743621648];
		mul.f64	%r732, %r60, %r733;
		neg.f64	%r734, %r732;
		ld.f64	%r735, [%r409+743621648];
		fma.rn.f64	%r332, %r61, %r735, %r734;
		st.f64	[%r391+2284365888], %r332;
		ld.f64	%r737, [%r410+777422632];
		mul.f64	%r736, %r60, %r737;
		neg.f64	%r738, %r736;
		ld.f64	%r739, [%r409+777422632];
		fma.rn.f64	%r336, %r61, %r739, %r738;
		st.f64	[%r391+2385146736], %r336;
		ld.f64	%r741, [%r410+811223616];
		mul.f64	%r740, %r60, %r741;
		neg.f64	%r742, %r740;
		ld.f64	%r743, [%r409+811223616];
		fma.rn.f64	%r340, %r61, %r743, %r742;
		sub.f64	%r744, %r340, %r174;
		st.f64	[%r391+2485927584], %r744;
		add.u64	%r349, %r349, 256;
		add.u64	%r48, %r48, 256;
		add.u64	%r53, %r53, 256;
		setp.ne.u64	%r745, %r48, %r418;
	@%r745	bra	$L61;
		bra	$L62;
$L55:
	ret;
}

// BEGIN FUNCTION DECL: x_solve$_omp_fn$4
.entry x_solve$_omp_fn$4 (.param.u64 %in_ar0);

// BEGIN FUNCTION DEF: x_solve$_omp_fn$4
.entry x_solve$_omp_fn$4 (.param.u64 %in_ar0)
{
	.reg.u64 %ar0;
	ld.param.u64 %ar0, [%in_ar0];
	.reg.u32 %r24;
	.reg.u32 %r26;
	.reg.u32 %r28;
	.reg.u32 %r33;
	.reg.u32 %r34;
	.reg.f64 %r47;
	.reg.f64 %r69;
	.reg.f64 %r72;
	.reg.f64 %r75;
	.reg.f64 %r78;
	.reg.f64 %r81;
	.reg.f64 %r84;
	.reg.f64 %r87;
	.reg.f64 %r90;
	.reg.f64 %r93;
	.reg.f64 %r96;
	.reg.f64 %r99;
	.reg.f64 %r100;
	.reg.f64 %r103;
	.reg.f64 %r106;
	.reg.f64 %r109;
	.reg.f64 %r112;
	.reg.f64 %r115;
	.reg.f64 %r118;
	.reg.f64 %r121;
	.reg.f64 %r124;
	.reg.f64 %r127;
	.reg.f64 %r130;
	.reg.f64 %r131;
	.reg.f64 %r134;
	.reg.f64 %r137;
	.reg.f64 %r140;
	.reg.f64 %r143;
	.reg.f64 %r146;
	.reg.f64 %r149;
	.reg.f64 %r152;
	.reg.f64 %r155;
	.reg.f64 %r158;
	.reg.f64 %r161;
	.reg.f64 %r162;
	.reg.f64 %r165;
	.reg.f64 %r168;
	.reg.f64 %r171;
	.reg.f64 %r174;
	.reg.f64 %r177;
	.reg.f64 %r180;
	.reg.f64 %r183;
	.reg.f64 %r186;
	.reg.f64 %r189;
	.reg.f64 %r192;
	.reg.f64 %r194;
	.reg.f64 %r213;
	.reg.f64 %r216;
	.reg.f64 %r219;
	.reg.f64 %r222;
	.reg.f64 %r225;
	.reg.f64 %r228;
	.reg.f64 %r231;
	.reg.f64 %r234;
	.reg.f64 %r237;
	.reg.f64 %r240;
	.reg.f64 %r241;
	.reg.f64 %r244;
	.reg.f64 %r247;
	.reg.f64 %r250;
	.reg.f64 %r253;
	.reg.f64 %r256;
	.reg.f64 %r259;
	.reg.f64 %r262;
	.reg.f64 %r265;
	.reg.f64 %r268;
	.reg.f64 %r269;
	.reg.f64 %r272;
	.reg.f64 %r275;
	.reg.f64 %r278;
	.reg.f64 %r281;
	.reg.f64 %r284;
	.reg.f64 %r287;
	.reg.f64 %r290;
	.reg.f64 %r293;
	.reg.f64 %r296;
	.reg.f64 %r297;
	.reg.f64 %r300;
	.reg.f64 %r303;
	.reg.f64 %r306;
	.reg.f64 %r309;
	.reg.f64 %r312;
	.reg.f64 %r315;
	.reg.f64 %r318;
	.reg.f64 %r321;
	.reg.f64 %r324;
	.reg.f64 %r326;
	.reg.f64 %r343;
	.reg.f64 %r346;
	.reg.f64 %r349;
	.reg.f64 %r352;
	.reg.f64 %r355;
	.reg.f64 %r358;
	.reg.f64 %r361;
	.reg.f64 %r364;
	.reg.f64 %r367;
	.reg.f64 %r368;
	.reg.f64 %r371;
	.reg.f64 %r374;
	.reg.f64 %r377;
	.reg.f64 %r380;
	.reg.f64 %r383;
	.reg.f64 %r386;
	.reg.f64 %r389;
	.reg.f64 %r392;
	.reg.f64 %r393;
	.reg.f64 %r396;
	.reg.f64 %r399;
	.reg.f64 %r402;
	.reg.f64 %r405;
	.reg.f64 %r408;
	.reg.f64 %r411;
	.reg.f64 %r414;
	.reg.f64 %r417;
	.reg.f64 %r418;
	.reg.f64 %r421;
	.reg.f64 %r424;
	.reg.f64 %r427;
	.reg.f64 %r430;
	.reg.f64 %r433;
	.reg.f64 %r436;
	.reg.f64 %r439;
	.reg.f64 %r442;
	.reg.f64 %r444;
	.reg.f64 %r459;
	.reg.f64 %r462;
	.reg.f64 %r465;
	.reg.f64 %r468;
	.reg.f64 %r471;
	.reg.f64 %r474;
	.reg.f64 %r477;
	.reg.f64 %r480;
	.reg.f64 %r481;
	.reg.f64 %r484;
	.reg.f64 %r487;
	.reg.f64 %r490;
	.reg.f64 %r493;
	.reg.f64 %r496;
	.reg.f64 %r499;
	.reg.f64 %r502;
	.reg.f64 %r503;
	.reg.f64 %r506;
	.reg.f64 %r509;
	.reg.f64 %r512;
	.reg.f64 %r515;
	.reg.f64 %r518;
	.reg.f64 %r521;
	.reg.f64 %r524;
	.reg.f64 %r525;
	.reg.f64 %r528;
	.reg.f64 %r531;
	.reg.f64 %r534;
	.reg.f64 %r537;
	.reg.f64 %r540;
	.reg.f64 %r543;
	.reg.f64 %r546;
	.reg.f64 %r548;
	.reg.f64 %r561;
	.reg.f64 %r564;
	.reg.f64 %r567;
	.reg.f64 %r570;
	.reg.f64 %r573;
	.reg.f64 %r576;
	.reg.f64 %r579;
	.reg.f64 %r580;
	.reg.f64 %r583;
	.reg.f64 %r586;
	.reg.f64 %r589;
	.reg.f64 %r592;
	.reg.f64 %r595;
	.reg.f64 %r598;
	.reg.f64 %r599;
	.reg.f64 %r602;
	.reg.f64 %r605;
	.reg.f64 %r608;
	.reg.f64 %r611;
	.reg.f64 %r614;
	.reg.f64 %r617;
	.reg.f64 %r618;
	.reg.f64 %r621;
	.reg.f64 %r624;
	.reg.f64 %r627;
	.reg.f64 %r630;
	.reg.f64 %r633;
	.reg.f64 %r636;
	.reg.u64 %r639;
	.reg.u64 %r640;
	.reg.u32 %r643;
	.reg.u32 %r650;
	.reg.u32 %r651;
	.reg.u32 %r654;
	.reg.u32 %r655;
	.reg.u64 %r804;
	.reg.u64 %r805;
	.reg.u64 %r806;
	.reg.u64 %r807;
	.reg.u64 %r817;
	.reg.u64 %r818;
	.reg.u64 %r819;
	.reg.u32 %r820;
	.reg.u32 %r821;
	.reg.u32 %r822;
	.reg.pred %r823;
	.reg.u64 %r824;
	.reg.u32 %r825;
	.reg.u32 %r826;
	.reg.u64 %r827;
	.reg.u64 %r828;
	.reg.u32 %r830;
	.reg.pred %r831;
	.reg.u64 %r832;
	.reg.u64 %r833;
	.reg.u64 %r834;
	.reg.u64 %r835;
	.reg.u64 %r836;
	.reg.u64 %r837;
	.reg.u64 %r839;
	.reg.u64 %r840;
	.reg.u64 %r841;
	.reg.f64 %r842;
	.reg.f64 %r843;
	.reg.f64 %r844;
	.reg.f64 %r845;
	.reg.f64 %r846;
	.reg.f64 %r847;
	.reg.f64 %r848;
	.reg.f64 %r849;
	.reg.f64 %r850;
	.reg.f64 %r851;
	.reg.f64 %r852;
	.reg.f64 %r853;
	.reg.f64 %r854;
	.reg.f64 %r855;
	.reg.f64 %r856;
	.reg.f64 %r857;
	.reg.f64 %r858;
	.reg.f64 %r859;
	.reg.f64 %r860;
	.reg.f64 %r861;
	.reg.f64 %r862;
	.reg.f64 %r863;
	.reg.f64 %r864;
	.reg.f64 %r865;
	.reg.f64 %r866;
	.reg.f64 %r868;
	.reg.f64 %r869;
	.reg.f64 %r871;
	.reg.f64 %r872;
	.reg.f64 %r874;
	.reg.f64 %r875;
	.reg.f64 %r877;
	.reg.f64 %r878;
	.reg.f64 %r880;
	.reg.f64 %r881;
	.reg.f64 %r883;
	.reg.f64 %r884;
	.reg.f64 %r886;
	.reg.f64 %r887;
	.reg.f64 %r889;
	.reg.f64 %r890;
	.reg.f64 %r892;
	.reg.f64 %r893;
	.reg.f64 %r894;
	.reg.f64 %r895;
	.reg.f64 %r896;
	.reg.f64 %r898;
	.reg.f64 %r899;
	.reg.f64 %r901;
	.reg.f64 %r902;
	.reg.f64 %r904;
	.reg.f64 %r905;
	.reg.f64 %r907;
	.reg.f64 %r908;
	.reg.f64 %r910;
	.reg.f64 %r911;
	.reg.f64 %r913;
	.reg.f64 %r914;
	.reg.f64 %r916;
	.reg.f64 %r917;
	.reg.f64 %r919;
	.reg.f64 %r920;
	.reg.f64 %r922;
	.reg.f64 %r923;
	.reg.f64 %r924;
	.reg.f64 %r925;
	.reg.f64 %r926;
	.reg.f64 %r928;
	.reg.f64 %r929;
	.reg.f64 %r931;
	.reg.f64 %r932;
	.reg.f64 %r934;
	.reg.f64 %r935;
	.reg.f64 %r937;
	.reg.f64 %r938;
	.reg.f64 %r940;
	.reg.f64 %r941;
	.reg.f64 %r943;
	.reg.f64 %r944;
	.reg.f64 %r946;
	.reg.f64 %r947;
	.reg.f64 %r949;
	.reg.f64 %r950;
	.reg.f64 %r952;
	.reg.f64 %r953;
	.reg.f64 %r954;
	.reg.f64 %r955;
	.reg.f64 %r956;
	.reg.f64 %r958;
	.reg.f64 %r959;
	.reg.f64 %r961;
	.reg.f64 %r962;
	.reg.f64 %r964;
	.reg.f64 %r965;
	.reg.f64 %r967;
	.reg.f64 %r968;
	.reg.f64 %r970;
	.reg.f64 %r971;
	.reg.f64 %r973;
	.reg.f64 %r974;
	.reg.f64 %r976;
	.reg.f64 %r977;
	.reg.f64 %r979;
	.reg.f64 %r980;
	.reg.f64 %r982;
	.reg.f64 %r983;
	.reg.f64 %r985;
	.reg.f64 %r986;
	.reg.f64 %r987;
	.reg.f64 %r988;
	.reg.f64 %r989;
	.reg.f64 %r990;
	.reg.f64 %r991;
	.reg.f64 %r992;
	.reg.f64 %r993;
	.reg.f64 %r994;
	.reg.f64 %r995;
	.reg.f64 %r996;
	.reg.f64 %r997;
	.reg.f64 %r998;
	.reg.f64 %r999;
	.reg.f64 %r1000;
	.reg.f64 %r1001;
	.reg.f64 %r1002;
	.reg.f64 %r1003;
	.reg.f64 %r1004;
	.reg.f64 %r1005;
	.reg.f64 %r1006;
	.reg.f64 %r1008;
	.reg.f64 %r1009;
	.reg.f64 %r1011;
	.reg.f64 %r1012;
	.reg.f64 %r1014;
	.reg.f64 %r1015;
	.reg.f64 %r1017;
	.reg.f64 %r1018;
	.reg.f64 %r1020;
	.reg.f64 %r1021;
	.reg.f64 %r1023;
	.reg.f64 %r1024;
	.reg.f64 %r1026;
	.reg.f64 %r1027;
	.reg.f64 %r1029;
	.reg.f64 %r1030;
	.reg.f64 %r1031;
	.reg.f64 %r1032;
	.reg.f64 %r1033;
	.reg.f64 %r1035;
	.reg.f64 %r1036;
	.reg.f64 %r1038;
	.reg.f64 %r1039;
	.reg.f64 %r1041;
	.reg.f64 %r1042;
	.reg.f64 %r1044;
	.reg.f64 %r1045;
	.reg.f64 %r1047;
	.reg.f64 %r1048;
	.reg.f64 %r1050;
	.reg.f64 %r1051;
	.reg.f64 %r1053;
	.reg.f64 %r1054;
	.reg.f64 %r1056;
	.reg.f64 %r1057;
	.reg.f64 %r1058;
	.reg.f64 %r1059;
	.reg.f64 %r1060;
	.reg.f64 %r1062;
	.reg.f64 %r1063;
	.reg.f64 %r1065;
	.reg.f64 %r1066;
	.reg.f64 %r1068;
	.reg.f64 %r1069;
	.reg.f64 %r1071;
	.reg.f64 %r1072;
	.reg.f64 %r1074;
	.reg.f64 %r1075;
	.reg.f64 %r1077;
	.reg.f64 %r1078;
	.reg.f64 %r1080;
	.reg.f64 %r1081;
	.reg.f64 %r1083;
	.reg.f64 %r1084;
	.reg.f64 %r1085;
	.reg.f64 %r1086;
	.reg.f64 %r1087;
	.reg.f64 %r1089;
	.reg.f64 %r1090;
	.reg.f64 %r1092;
	.reg.f64 %r1093;
	.reg.f64 %r1095;
	.reg.f64 %r1096;
	.reg.f64 %r1098;
	.reg.f64 %r1099;
	.reg.f64 %r1101;
	.reg.f64 %r1102;
	.reg.f64 %r1104;
	.reg.f64 %r1105;
	.reg.f64 %r1107;
	.reg.f64 %r1108;
	.reg.f64 %r1110;
	.reg.f64 %r1111;
	.reg.f64 %r1113;
	.reg.f64 %r1114;
	.reg.f64 %r1115;
	.reg.f64 %r1116;
	.reg.f64 %r1117;
	.reg.f64 %r1118;
	.reg.f64 %r1119;
	.reg.f64 %r1120;
	.reg.f64 %r1121;
	.reg.f64 %r1122;
	.reg.f64 %r1123;
	.reg.f64 %r1124;
	.reg.f64 %r1125;
	.reg.f64 %r1126;
	.reg.f64 %r1127;
	.reg.f64 %r1128;
	.reg.f64 %r1129;
	.reg.f64 %r1130;
	.reg.f64 %r1131;
	.reg.f64 %r1132;
	.reg.f64 %r1134;
	.reg.f64 %r1135;
	.reg.f64 %r1137;
	.reg.f64 %r1138;
	.reg.f64 %r1140;
	.reg.f64 %r1141;
	.reg.f64 %r1143;
	.reg.f64 %r1144;
	.reg.f64 %r1146;
	.reg.f64 %r1147;
	.reg.f64 %r1149;
	.reg.f64 %r1150;
	.reg.f64 %r1152;
	.reg.f64 %r1153;
	.reg.f64 %r1154;
	.reg.f64 %r1155;
	.reg.f64 %r1156;
	.reg.f64 %r1158;
	.reg.f64 %r1159;
	.reg.f64 %r1161;
	.reg.f64 %r1162;
	.reg.f64 %r1164;
	.reg.f64 %r1165;
	.reg.f64 %r1167;
	.reg.f64 %r1168;
	.reg.f64 %r1170;
	.reg.f64 %r1171;
	.reg.f64 %r1173;
	.reg.f64 %r1174;
	.reg.f64 %r1176;
	.reg.f64 %r1177;
	.reg.f64 %r1178;
	.reg.f64 %r1179;
	.reg.f64 %r1180;
	.reg.f64 %r1182;
	.reg.f64 %r1183;
	.reg.f64 %r1185;
	.reg.f64 %r1186;
	.reg.f64 %r1188;
	.reg.f64 %r1189;
	.reg.f64 %r1191;
	.reg.f64 %r1192;
	.reg.f64 %r1194;
	.reg.f64 %r1195;
	.reg.f64 %r1197;
	.reg.f64 %r1198;
	.reg.f64 %r1200;
	.reg.f64 %r1201;
	.reg.f64 %r1202;
	.reg.f64 %r1203;
	.reg.f64 %r1204;
	.reg.f64 %r1206;
	.reg.f64 %r1207;
	.reg.f64 %r1209;
	.reg.f64 %r1210;
	.reg.f64 %r1212;
	.reg.f64 %r1213;
	.reg.f64 %r1215;
	.reg.f64 %r1216;
	.reg.f64 %r1218;
	.reg.f64 %r1219;
	.reg.f64 %r1221;
	.reg.f64 %r1222;
	.reg.f64 %r1224;
	.reg.f64 %r1225;
	.reg.f64 %r1227;
	.reg.f64 %r1228;
	.reg.f64 %r1229;
	.reg.f64 %r1230;
	.reg.f64 %r1231;
	.reg.f64 %r1232;
	.reg.f64 %r1233;
	.reg.f64 %r1234;
	.reg.f64 %r1235;
	.reg.f64 %r1236;
	.reg.f64 %r1237;
	.reg.f64 %r1238;
	.reg.f64 %r1239;
	.reg.f64 %r1240;
	.reg.f64 %r1241;
	.reg.f64 %r1242;
	.reg.f64 %r1243;
	.reg.f64 %r1244;
	.reg.f64 %r1246;
	.reg.f64 %r1247;
	.reg.f64 %r1249;
	.reg.f64 %r1250;
	.reg.f64 %r1252;
	.reg.f64 %r1253;
	.reg.f64 %r1255;
	.reg.f64 %r1256;
	.reg.f64 %r1258;
	.reg.f64 %r1259;
	.reg.f64 %r1261;
	.reg.f64 %r1262;
	.reg.f64 %r1263;
	.reg.f64 %r1264;
	.reg.f64 %r1265;
	.reg.f64 %r1267;
	.reg.f64 %r1268;
	.reg.f64 %r1270;
	.reg.f64 %r1271;
	.reg.f64 %r1273;
	.reg.f64 %r1274;
	.reg.f64 %r1276;
	.reg.f64 %r1277;
	.reg.f64 %r1279;
	.reg.f64 %r1280;
	.reg.f64 %r1282;
	.reg.f64 %r1283;
	.reg.f64 %r1284;
	.reg.f64 %r1285;
	.reg.f64 %r1286;
	.reg.f64 %r1288;
	.reg.f64 %r1289;
	.reg.f64 %r1291;
	.reg.f64 %r1292;
	.reg.f64 %r1294;
	.reg.f64 %r1295;
	.reg.f64 %r1297;
	.reg.f64 %r1298;
	.reg.f64 %r1300;
	.reg.f64 %r1301;
	.reg.f64 %r1303;
	.reg.f64 %r1304;
	.reg.f64 %r1305;
	.reg.f64 %r1306;
	.reg.f64 %r1307;
	.reg.f64 %r1309;
	.reg.f64 %r1310;
	.reg.f64 %r1312;
	.reg.f64 %r1313;
	.reg.f64 %r1315;
	.reg.f64 %r1316;
	.reg.f64 %r1318;
	.reg.f64 %r1319;
	.reg.f64 %r1321;
	.reg.f64 %r1322;
	.reg.f64 %r1324;
	.reg.f64 %r1325;
	.reg.f64 %r1327;
	.reg.f64 %r1328;
	.reg.f64 %r1329;
	.reg.f64 %r1330;
	.reg.f64 %r1331;
	.reg.f64 %r1332;
	.reg.f64 %r1333;
	.reg.f64 %r1334;
	.reg.f64 %r1335;
	.reg.f64 %r1336;
	.reg.f64 %r1337;
	.reg.f64 %r1338;
	.reg.f64 %r1339;
	.reg.f64 %r1340;
	.reg.f64 %r1341;
	.reg.f64 %r1342;
	.reg.f64 %r1344;
	.reg.f64 %r1345;
	.reg.f64 %r1347;
	.reg.f64 %r1348;
	.reg.f64 %r1350;
	.reg.f64 %r1351;
	.reg.f64 %r1353;
	.reg.f64 %r1354;
	.reg.f64 %r1356;
	.reg.f64 %r1357;
	.reg.f64 %r1358;
	.reg.f64 %r1359;
	.reg.f64 %r1360;
	.reg.f64 %r1362;
	.reg.f64 %r1363;
	.reg.f64 %r1365;
	.reg.f64 %r1366;
	.reg.f64 %r1368;
	.reg.f64 %r1369;
	.reg.f64 %r1371;
	.reg.f64 %r1372;
	.reg.f64 %r1374;
	.reg.f64 %r1375;
	.reg.f64 %r1376;
	.reg.f64 %r1377;
	.reg.f64 %r1378;
	.reg.f64 %r1380;
	.reg.f64 %r1381;
	.reg.f64 %r1383;
	.reg.f64 %r1384;
	.reg.f64 %r1386;
	.reg.f64 %r1387;
	.reg.f64 %r1389;
	.reg.f64 %r1390;
	.reg.f64 %r1392;
	.reg.f64 %r1393;
	.reg.f64 %r1394;
	.reg.f64 %r1395;
	.reg.f64 %r1396;
	.reg.f64 %r1398;
	.reg.f64 %r1399;
	.reg.f64 %r1401;
	.reg.f64 %r1402;
	.reg.f64 %r1404;
	.reg.f64 %r1405;
	.reg.f64 %r1407;
	.reg.f64 %r1408;
	.reg.f64 %r1410;
	.reg.f64 %r1411;
	.reg.pred %r1412;
	.reg.pred %r1413;
	.reg.u64 %r1414;
	.reg.u64 %r1415;
	.reg.pred %r1416;
	.reg.pred %r1417;
	.reg.u32 %r1418;
	.reg.u32 %r1419;
	.reg.u32 %r1420;
	.reg.u32 %r1421;
	{
		.reg.u32	%y;
		mov.u32	%y, %tid.y;
		setp.ne.u32	%r1416, %y, 0;
	}
	{
		.reg.u32	%x;
		mov.u32	%x, %tid.x;
		setp.ne.u32	%r1417, %x, 0;
	}
	@%r1416	bra.uni	$L94;
	@%r1417	bra	$L95;
		mov.u64	%r818, %ar0;
		ld.u64	%r819, [%r818+24];
		ld.u32	%r26, [%r819];
		mov.u32	%r650, %nctaid.x;
		mov.u32	%r651, %ctaid.x;
		add.u32	%r820, %r26, -1;
		add.u32	%r821, %r820, %r650;
		div.s32	%r643, %r821, %r650;
		mul.lo.u32	%r33, %r643, %r651;
		add.u32	%r822, %r33, %r643;
		min.s32	%r34, %r822, %r26;
		setp.ge.s32	%r823, %r33, %r34;
		selp.u32	%r1420, 1, 0, %r823;
		st.shared.u32	[__oacc_bcast], %r1420;
$L95:
$L94:
		bar.sync	0;
		ld.shared.u32	%r1421, [__oacc_bcast];
		setp.ne.u32	%r823, %r1421, 0;
		bar.sync	0;
	@%r823	bra.uni	$L81;
	@%r1416	bra.uni	$L92;
	@%r1417	bra	$L93;
		ld.u64	%r824, [%r818+32];
		ld.u32	%r28, [%r824];
		cvt.s64.s32	%r805, %r33;
		add.u64	%r806, %r805, 1;
		mul.lo.u64	%r804, %r806, 161;
		mul.lo.u64	%r807, %r806, 1304;
		sub.u32	%r825, %r34, %r33;
		add.u32	%r826, %r825, -1;
		cvt.u64.u32	%r827, %r826;
		add.u64	%r828, %r827, %r805;
		mad.lo.u64	%r817, %r828, 161, 322;
$L93:
$L92:
$L85:
	// fork 2;
	@%r1416	bra.uni	$L90;
	@%r1417	bra	$L91;
		cvta.shared.u64	%r1415, __oacc_bcast;
		st.u32	[%r1415], %r28;
		st.u64	[%r1415+8], %r804;
		st.u64	[%r1415+16], %r807;
		st.u64	[%r1415+24], %r817;
		st.u64	[%r1415+32], %r818;
$L91:
$L90:
		bar.sync	0;
	// forked 2;
		cvta.shared.u64	%r1414, __oacc_bcast;
		ld.u32	%r28, [%r1414];
		ld.u64	%r804, [%r1414+8];
		ld.u64	%r807, [%r1414+16];
		ld.u64	%r817, [%r1414+24];
		ld.u64	%r818, [%r1414+32];
	// fork 4;
	// forked 4;
		mov.u32	%r654, %tid.y;
		mov.u32	%r655, %tid.x;
		shl.b32	%r830, %r654, 5;
		add.u32	%r24, %r830, %r655;
		setp.le.s32	%r831, %r28, %r24;
	@%r831	bra	$L83;
		add.u64	%r832, %r804, 4199203;
		cvt.s64.s32	%r833, %r24;
		add.u64	%r834, %r832, %r833;
		shl.b64	%r835, %r834, 3;
		ld.u64	%r836, [%r818+16];
		add.u64	%r640, %r836, %r835;
		cvt.s64.s32	%r837, %r24;
		add.u64	%r839, %r807, 212552;
		mad.lo.u64	%r840, %r837, 212552, %r839;
		ld.u64	%r841, [%r818+40];
		add.u64	%r639, %r841, %r840;
$L84:
		mov.f64	%r842, 0d3ff0000000000000;
		ld.f64	%r843, [%r640];
		div.rn.f64	%r47, %r842, %r843;
		ld.f64	%r845, [%r640+100780848];
		mul.f64	%r844, %r845, %r47;
		st.f64	[%r640+100780848], %r844;
		ld.f64	%r847, [%r640+201561696];
		mul.f64	%r846, %r847, %r47;
		st.f64	[%r640+201561696], %r846;
		ld.f64	%r849, [%r640+302342544];
		mul.f64	%r848, %r849, %r47;
		st.f64	[%r640+302342544], %r848;
		ld.f64	%r851, [%r640+403123392];
		mul.f64	%r850, %r851, %r47;
		st.f64	[%r640+403123392], %r850;
		ld.f64	%r853, [%r640+33593616];
		mul.f64	%r852, %r853, %r47;
		st.f64	[%r640+33593616], %r852;
		ld.f64	%r855, [%r640+134374464];
		mul.f64	%r854, %r855, %r47;
		st.f64	[%r640+134374464], %r854;
		ld.f64	%r857, [%r640+235155312];
		mul.f64	%r856, %r857, %r47;
		st.f64	[%r640+235155312], %r856;
		ld.f64	%r859, [%r640+335936160];
		mul.f64	%r858, %r859, %r47;
		st.f64	[%r640+335936160], %r858;
		ld.f64	%r861, [%r640+436717008];
		mul.f64	%r860, %r861, %r47;
		st.f64	[%r640+436717008], %r860;
		ld.f64	%r863, [%r639];
		mul.f64	%r862, %r863, %r47;
		st.f64	[%r639], %r862;
		ld.f64	%r69, [%r640+503904240];
		neg.f64	%r864, %r69;
		ld.f64	%r865, [%r640+100780848];
		ld.f64	%r866, [%r640+604685088];
		fma.rn.f64	%r72, %r864, %r865, %r866;
		st.f64	[%r640+604685088], %r72;
		ld.f64	%r868, [%r640+201561696];
		ld.f64	%r869, [%r640+705465936];
		fma.rn.f64	%r75, %r864, %r868, %r869;
		st.f64	[%r640+705465936], %r75;
		ld.f64	%r871, [%r640+302342544];
		ld.f64	%r872, [%r640+806246784];
		fma.rn.f64	%r78, %r864, %r871, %r872;
		st.f64	[%r640+806246784], %r78;
		ld.f64	%r874, [%r640+403123392];
		ld.f64	%r875, [%r640+907027632];
		fma.rn.f64	%r81, %r864, %r874, %r875;
		st.f64	[%r640+907027632], %r81;
		ld.f64	%r877, [%r640+33593616];
		ld.f64	%r878, [%r640+537497856];
		fma.rn.f64	%r84, %r864, %r877, %r878;
		st.f64	[%r640+537497856], %r84;
		ld.f64	%r880, [%r640+134374464];
		ld.f64	%r881, [%r640+638278704];
		fma.rn.f64	%r87, %r864, %r880, %r881;
		st.f64	[%r640+638278704], %r87;
		ld.f64	%r883, [%r640+235155312];
		ld.f64	%r884, [%r640+739059552];
		fma.rn.f64	%r90, %r864, %r883, %r884;
		st.f64	[%r640+739059552], %r90;
		ld.f64	%r886, [%r640+335936160];
		ld.f64	%r887, [%r640+839840400];
		fma.rn.f64	%r93, %r864, %r886, %r887;
		st.f64	[%r640+839840400], %r93;
		ld.f64	%r889, [%r640+436717008];
		ld.f64	%r890, [%r640+940621248];
		fma.rn.f64	%r96, %r864, %r889, %r890;
		st.f64	[%r640+940621248], %r96;
		ld.f64	%r892, [%r639];
		ld.f64	%r893, [%r639+34433424];
		fma.rn.f64	%r99, %r864, %r892, %r893;
		st.f64	[%r639+34433424], %r99;
		ld.f64	%r100, [%r640+1007808480];
		neg.f64	%r894, %r100;
		ld.f64	%r895, [%r640+100780848];
		ld.f64	%r896, [%r640+1108589328];
		fma.rn.f64	%r103, %r894, %r895, %r896;
		st.f64	[%r640+1108589328], %r103;
		ld.f64	%r898, [%r640+201561696];
		ld.f64	%r899, [%r640+1209370176];
		fma.rn.f64	%r106, %r894, %r898, %r899;
		st.f64	[%r640+1209370176], %r106;
		ld.f64	%r901, [%r640+302342544];
		ld.f64	%r902, [%r640+1310151024];
		fma.rn.f64	%r109, %r894, %r901, %r902;
		st.f64	[%r640+1310151024], %r109;
		ld.f64	%r904, [%r640+403123392];
		ld.f64	%r905, [%r640+1410931872];
		fma.rn.f64	%r112, %r894, %r904, %r905;
		st.f64	[%r640+1410931872], %r112;
		ld.f64	%r907, [%r640+33593616];
		ld.f64	%r908, [%r640+1041402096];
		fma.rn.f64	%r115, %r894, %r907, %r908;
		st.f64	[%r640+1041402096], %r115;
		ld.f64	%r910, [%r640+134374464];
		ld.f64	%r911, [%r640+1142182944];
		fma.rn.f64	%r118, %r894, %r910, %r911;
		st.f64	[%r640+1142182944], %r118;
		ld.f64	%r913, [%r640+235155312];
		ld.f64	%r914, [%r640+1242963792];
		fma.rn.f64	%r121, %r894, %r913, %r914;
		st.f64	[%r640+1242963792], %r121;
		ld.f64	%r916, [%r640+335936160];
		ld.f64	%r917, [%r640+1343744640];
		fma.rn.f64	%r124, %r894, %r916, %r917;
		st.f64	[%r640+1343744640], %r124;
		ld.f64	%r919, [%r640+436717008];
		ld.f64	%r920, [%r640+1444525488];
		fma.rn.f64	%r127, %r894, %r919, %r920;
		st.f64	[%r640+1444525488], %r127;
		ld.f64	%r922, [%r639];
		ld.f64	%r923, [%r639+68866848];
		fma.rn.f64	%r130, %r894, %r922, %r923;
		st.f64	[%r639+68866848], %r130;
		ld.f64	%r131, [%r640+1511712720];
		neg.f64	%r924, %r131;
		ld.f64	%r925, [%r640+100780848];
		ld.f64	%r926, [%r640+1612493568];
		fma.rn.f64	%r134, %r924, %r925, %r926;
		st.f64	[%r640+1612493568], %r134;
		ld.f64	%r928, [%r640+201561696];
		ld.f64	%r929, [%r640+1713274416];
		fma.rn.f64	%r137, %r924, %r928, %r929;
		st.f64	[%r640+1713274416], %r137;
		ld.f64	%r931, [%r640+302342544];
		ld.f64	%r932, [%r640+1814055264];
		fma.rn.f64	%r140, %r924, %r931, %r932;
		st.f64	[%r640+1814055264], %r140;
		ld.f64	%r934, [%r640+403123392];
		ld.f64	%r935, [%r640+1914836112];
		fma.rn.f64	%r143, %r924, %r934, %r935;
		st.f64	[%r640+1914836112], %r143;
		ld.f64	%r937, [%r640+33593616];
		ld.f64	%r938, [%r640+1545306336];
		fma.rn.f64	%r146, %r924, %r937, %r938;
		st.f64	[%r640+1545306336], %r146;
		ld.f64	%r940, [%r640+134374464];
		ld.f64	%r941, [%r640+1646087184];
		fma.rn.f64	%r149, %r924, %r940, %r941;
		st.f64	[%r640+1646087184], %r149;
		ld.f64	%r943, [%r640+235155312];
		ld.f64	%r944, [%r640+1746868032];
		fma.rn.f64	%r152, %r924, %r943, %r944;
		st.f64	[%r640+1746868032], %r152;
		ld.f64	%r946, [%r640+335936160];
		ld.f64	%r947, [%r640+1847648880];
		fma.rn.f64	%r155, %r924, %r946, %r947;
		st.f64	[%r640+1847648880], %r155;
		ld.f64	%r949, [%r640+436717008];
		ld.f64	%r950, [%r640+1948429728];
		fma.rn.f64	%r158, %r924, %r949, %r950;
		st.f64	[%r640+1948429728], %r158;
		ld.f64	%r952, [%r639];
		ld.f64	%r953, [%r639+103300272];
		fma.rn.f64	%r161, %r924, %r952, %r953;
		st.f64	[%r639+103300272], %r161;
		ld.f64	%r162, [%r640+2015616960];
		neg.f64	%r954, %r162;
		ld.f64	%r955, [%r640+100780848];
		ld.f64	%r956, [%r640+2116397808];
		fma.rn.f64	%r165, %r954, %r955, %r956;
		st.f64	[%r640+2116397808], %r165;
		ld.f64	%r958, [%r640+201561696];
		ld.f64	%r959, [%r640+2217178656];
		fma.rn.f64	%r168, %r954, %r958, %r959;
		st.f64	[%r640+2217178656], %r168;
		ld.f64	%r961, [%r640+302342544];
		ld.f64	%r962, [%r640+2317959504];
		fma.rn.f64	%r171, %r954, %r961, %r962;
		st.f64	[%r640+2317959504], %r171;
		ld.f64	%r964, [%r640+403123392];
		ld.f64	%r965, [%r640+2418740352];
		fma.rn.f64	%r174, %r954, %r964, %r965;
		st.f64	[%r640+2418740352], %r174;
		ld.f64	%r967, [%r640+33593616];
		ld.f64	%r968, [%r640+2049210576];
		fma.rn.f64	%r177, %r954, %r967, %r968;
		st.f64	[%r640+2049210576], %r177;
		ld.f64	%r970, [%r640+134374464];
		ld.f64	%r971, [%r640+2149991424];
		fma.rn.f64	%r180, %r954, %r970, %r971;
		st.f64	[%r640+2149991424], %r180;
		ld.f64	%r973, [%r640+235155312];
		ld.f64	%r974, [%r640+2250772272];
		fma.rn.f64	%r183, %r954, %r973, %r974;
		st.f64	[%r640+2250772272], %r183;
		ld.f64	%r976, [%r640+335936160];
		ld.f64	%r977, [%r640+2351553120];
		fma.rn.f64	%r186, %r954, %r976, %r977;
		st.f64	[%r640+2351553120], %r186;
		ld.f64	%r979, [%r640+436717008];
		ld.f64	%r980, [%r640+2452333968];
		fma.rn.f64	%r189, %r954, %r979, %r980;
		st.f64	[%r640+2452333968], %r189;
		ld.f64	%r982, [%r639];
		ld.f64	%r983, [%r639+137733696];
		fma.rn.f64	%r192, %r954, %r982, %r983;
		st.f64	[%r639+137733696], %r192;
		ld.f64	%r985, [%r640+604685088];
		div.rn.f64	%r194, %r842, %r985;
		ld.f64	%r987, [%r640+705465936];
		mul.f64	%r986, %r987, %r194;
		st.f64	[%r640+705465936], %r986;
		ld.f64	%r989, [%r640+806246784];
		mul.f64	%r988, %r989, %r194;
		st.f64	[%r640+806246784], %r988;
		ld.f64	%r991, [%r640+907027632];
		mul.f64	%r990, %r991, %r194;
		st.f64	[%r640+907027632], %r990;
		ld.f64	%r993, [%r640+537497856];
		mul.f64	%r992, %r993, %r194;
		st.f64	[%r640+537497856], %r992;
		ld.f64	%r995, [%r640+638278704];
		mul.f64	%r994, %r995, %r194;
		st.f64	[%r640+638278704], %r994;
		ld.f64	%r997, [%r640+739059552];
		mul.f64	%r996, %r997, %r194;
		st.f64	[%r640+739059552], %r996;
		ld.f64	%r999, [%r640+839840400];
		mul.f64	%r998, %r999, %r194;
		st.f64	[%r640+839840400], %r998;
		ld.f64	%r1001, [%r640+940621248];
		mul.f64	%r1000, %r1001, %r194;
		st.f64	[%r640+940621248], %r1000;
		ld.f64	%r1003, [%r639+34433424];
		mul.f64	%r1002, %r1003, %r194;
		st.f64	[%r639+34433424], %r1002;
		ld.f64	%r213, [%r640+100780848];
		neg.f64	%r1004, %r213;
		ld.f64	%r1005, [%r640+705465936];
		ld.f64	%r1006, [%r640+201561696];
		fma.rn.f64	%r216, %r1004, %r1005, %r1006;
		st.f64	[%r640+201561696], %r216;
		ld.f64	%r1008, [%r640+806246784];
		ld.f64	%r1009, [%r640+302342544];
		fma.rn.f64	%r219, %r1004, %r1008, %r1009;
		st.f64	[%r640+302342544], %r219;
		ld.f64	%r1011, [%r640+907027632];
		ld.f64	%r1012, [%r640+403123392];
		fma.rn.f64	%r222, %r1004, %r1011, %r1012;
		st.f64	[%r640+403123392], %r222;
		ld.f64	%r1014, [%r640+537497856];
		ld.f64	%r1015, [%r640+33593616];
		fma.rn.f64	%r225, %r1004, %r1014, %r1015;
		st.f64	[%r640+33593616], %r225;
		ld.f64	%r1017, [%r640+638278704];
		ld.f64	%r1018, [%r640+134374464];
		fma.rn.f64	%r228, %r1004, %r1017, %r1018;
		st.f64	[%r640+134374464], %r228;
		ld.f64	%r1020, [%r640+739059552];
		ld.f64	%r1021, [%r640+235155312];
		fma.rn.f64	%r231, %r1004, %r1020, %r1021;
		st.f64	[%r640+235155312], %r231;
		ld.f64	%r1023, [%r640+839840400];
		ld.f64	%r1024, [%r640+335936160];
		fma.rn.f64	%r234, %r1004, %r1023, %r1024;
		st.f64	[%r640+335936160], %r234;
		ld.f64	%r1026, [%r640+940621248];
		ld.f64	%r1027, [%r640+436717008];
		fma.rn.f64	%r237, %r1004, %r1026, %r1027;
		st.f64	[%r640+436717008], %r237;
		ld.f64	%r1029, [%r639+34433424];
		ld.f64	%r1030, [%r639];
		fma.rn.f64	%r240, %r1004, %r1029, %r1030;
		st.f64	[%r639], %r240;
		ld.f64	%r241, [%r640+1108589328];
		neg.f64	%r1031, %r241;
		ld.f64	%r1032, [%r640+705465936];
		ld.f64	%r1033, [%r640+1209370176];
		fma.rn.f64	%r244, %r1031, %r1032, %r1033;
		st.f64	[%r640+1209370176], %r244;
		ld.f64	%r1035, [%r640+806246784];
		ld.f64	%r1036, [%r640+1310151024];
		fma.rn.f64	%r247, %r1031, %r1035, %r1036;
		st.f64	[%r640+1310151024], %r247;
		ld.f64	%r1038, [%r640+907027632];
		ld.f64	%r1039, [%r640+1410931872];
		fma.rn.f64	%r250, %r1031, %r1038, %r1039;
		st.f64	[%r640+1410931872], %r250;
		ld.f64	%r1041, [%r640+537497856];
		ld.f64	%r1042, [%r640+1041402096];
		fma.rn.f64	%r253, %r1031, %r1041, %r1042;
		st.f64	[%r640+1041402096], %r253;
		ld.f64	%r1044, [%r640+638278704];
		ld.f64	%r1045, [%r640+1142182944];
		fma.rn.f64	%r256, %r1031, %r1044, %r1045;
		st.f64	[%r640+1142182944], %r256;
		ld.f64	%r1047, [%r640+739059552];
		ld.f64	%r1048, [%r640+1242963792];
		fma.rn.f64	%r259, %r1031, %r1047, %r1048;
		st.f64	[%r640+1242963792], %r259;
		ld.f64	%r1050, [%r640+839840400];
		ld.f64	%r1051, [%r640+1343744640];
		fma.rn.f64	%r262, %r1031, %r1050, %r1051;
		st.f64	[%r640+1343744640], %r262;
		ld.f64	%r1053, [%r640+940621248];
		ld.f64	%r1054, [%r640+1444525488];
		fma.rn.f64	%r265, %r1031, %r1053, %r1054;
		st.f64	[%r640+1444525488], %r265;
		ld.f64	%r1056, [%r639+34433424];
		ld.f64	%r1057, [%r639+68866848];
		fma.rn.f64	%r268, %r1031, %r1056, %r1057;
		st.f64	[%r639+68866848], %r268;
		ld.f64	%r269, [%r640+1612493568];
		neg.f64	%r1058, %r269;
		ld.f64	%r1059, [%r640+705465936];
		ld.f64	%r1060, [%r640+1713274416];
		fma.rn.f64	%r272, %r1058, %r1059, %r1060;
		st.f64	[%r640+1713274416], %r272;
		ld.f64	%r1062, [%r640+806246784];
		ld.f64	%r1063, [%r640+1814055264];
		fma.rn.f64	%r275, %r1058, %r1062, %r1063;
		st.f64	[%r640+1814055264], %r275;
		ld.f64	%r1065, [%r640+907027632];
		ld.f64	%r1066, [%r640+1914836112];
		fma.rn.f64	%r278, %r1058, %r1065, %r1066;
		st.f64	[%r640+1914836112], %r278;
		ld.f64	%r1068, [%r640+537497856];
		ld.f64	%r1069, [%r640+1545306336];
		fma.rn.f64	%r281, %r1058, %r1068, %r1069;
		st.f64	[%r640+1545306336], %r281;
		ld.f64	%r1071, [%r640+638278704];
		ld.f64	%r1072, [%r640+1646087184];
		fma.rn.f64	%r284, %r1058, %r1071, %r1072;
		st.f64	[%r640+1646087184], %r284;
		ld.f64	%r1074, [%r640+739059552];
		ld.f64	%r1075, [%r640+1746868032];
		fma.rn.f64	%r287, %r1058, %r1074, %r1075;
		st.f64	[%r640+1746868032], %r287;
		ld.f64	%r1077, [%r640+839840400];
		ld.f64	%r1078, [%r640+1847648880];
		fma.rn.f64	%r290, %r1058, %r1077, %r1078;
		st.f64	[%r640+1847648880], %r290;
		ld.f64	%r1080, [%r640+940621248];
		ld.f64	%r1081, [%r640+1948429728];
		fma.rn.f64	%r293, %r1058, %r1080, %r1081;
		st.f64	[%r640+1948429728], %r293;
		ld.f64	%r1083, [%r639+34433424];
		ld.f64	%r1084, [%r639+103300272];
		fma.rn.f64	%r296, %r1058, %r1083, %r1084;
		st.f64	[%r639+103300272], %r296;
		ld.f64	%r297, [%r640+2116397808];
		neg.f64	%r1085, %r297;
		ld.f64	%r1086, [%r640+705465936];
		ld.f64	%r1087, [%r640+2217178656];
		fma.rn.f64	%r300, %r1085, %r1086, %r1087;
		st.f64	[%r640+2217178656], %r300;
		ld.f64	%r1089, [%r640+806246784];
		ld.f64	%r1090, [%r640+2317959504];
		fma.rn.f64	%r303, %r1085, %r1089, %r1090;
		st.f64	[%r640+2317959504], %r303;
		ld.f64	%r1092, [%r640+907027632];
		ld.f64	%r1093, [%r640+2418740352];
		fma.rn.f64	%r306, %r1085, %r1092, %r1093;
		st.f64	[%r640+2418740352], %r306;
		ld.f64	%r1095, [%r640+537497856];
		ld.f64	%r1096, [%r640+2049210576];
		fma.rn.f64	%r309, %r1085, %r1095, %r1096;
		st.f64	[%r640+2049210576], %r309;
		ld.f64	%r1098, [%r640+638278704];
		ld.f64	%r1099, [%r640+2149991424];
		fma.rn.f64	%r312, %r1085, %r1098, %r1099;
		st.f64	[%r640+2149991424], %r312;
		ld.f64	%r1101, [%r640+739059552];
		ld.f64	%r1102, [%r640+2250772272];
		fma.rn.f64	%r315, %r1085, %r1101, %r1102;
		st.f64	[%r640+2250772272], %r315;
		ld.f64	%r1104, [%r640+839840400];
		ld.f64	%r1105, [%r640+2351553120];
		fma.rn.f64	%r318, %r1085, %r1104, %r1105;
		st.f64	[%r640+2351553120], %r318;
		ld.f64	%r1107, [%r640+940621248];
		ld.f64	%r1108, [%r640+2452333968];
		fma.rn.f64	%r321, %r1085, %r1107, %r1108;
		st.f64	[%r640+2452333968], %r321;
		ld.f64	%r1110, [%r639+34433424];
		ld.f64	%r1111, [%r639+137733696];
		fma.rn.f64	%r324, %r1085, %r1110, %r1111;
		st.f64	[%r639+137733696], %r324;
		ld.f64	%r1113, [%r640+1209370176];
		div.rn.f64	%r326, %r842, %r1113;
		ld.f64	%r1115, [%r640+1310151024];
		mul.f64	%r1114, %r1115, %r326;
		st.f64	[%r640+1310151024], %r1114;
		ld.f64	%r1117, [%r640+1410931872];
		mul.f64	%r1116, %r1117, %r326;
		st.f64	[%r640+1410931872], %r1116;
		ld.f64	%r1119, [%r640+1041402096];
		mul.f64	%r1118, %r1119, %r326;
		st.f64	[%r640+1041402096], %r1118;
		ld.f64	%r1121, [%r640+1142182944];
		mul.f64	%r1120, %r1121, %r326;
		st.f64	[%r640+1142182944], %r1120;
		ld.f64	%r1123, [%r640+1242963792];
		mul.f64	%r1122, %r1123, %r326;
		st.f64	[%r640+1242963792], %r1122;
		ld.f64	%r1125, [%r640+1343744640];
		mul.f64	%r1124, %r1125, %r326;
		st.f64	[%r640+1343744640], %r1124;
		ld.f64	%r1127, [%r640+1444525488];
		mul.f64	%r1126, %r1127, %r326;
		st.f64	[%r640+1444525488], %r1126;
		ld.f64	%r1129, [%r639+68866848];
		mul.f64	%r1128, %r1129, %r326;
		st.f64	[%r639+68866848], %r1128;
		ld.f64	%r343, [%r640+201561696];
		neg.f64	%r1130, %r343;
		ld.f64	%r1131, [%r640+1310151024];
		ld.f64	%r1132, [%r640+302342544];
		fma.rn.f64	%r346, %r1130, %r1131, %r1132;
		st.f64	[%r640+302342544], %r346;
		ld.f64	%r1134, [%r640+1410931872];
		ld.f64	%r1135, [%r640+403123392];
		fma.rn.f64	%r349, %r1130, %r1134, %r1135;
		st.f64	[%r640+403123392], %r349;
		ld.f64	%r1137, [%r640+1041402096];
		ld.f64	%r1138, [%r640+33593616];
		fma.rn.f64	%r352, %r1130, %r1137, %r1138;
		st.f64	[%r640+33593616], %r352;
		ld.f64	%r1140, [%r640+1142182944];
		ld.f64	%r1141, [%r640+134374464];
		fma.rn.f64	%r355, %r1130, %r1140, %r1141;
		st.f64	[%r640+134374464], %r355;
		ld.f64	%r1143, [%r640+1242963792];
		ld.f64	%r1144, [%r640+235155312];
		fma.rn.f64	%r358, %r1130, %r1143, %r1144;
		st.f64	[%r640+235155312], %r358;
		ld.f64	%r1146, [%r640+1343744640];
		ld.f64	%r1147, [%r640+335936160];
		fma.rn.f64	%r361, %r1130, %r1146, %r1147;
		st.f64	[%r640+335936160], %r361;
		ld.f64	%r1149, [%r640+1444525488];
		ld.f64	%r1150, [%r640+436717008];
		fma.rn.f64	%r364, %r1130, %r1149, %r1150;
		st.f64	[%r640+436717008], %r364;
		ld.f64	%r1152, [%r639+68866848];
		ld.f64	%r1153, [%r639];
		fma.rn.f64	%r367, %r1130, %r1152, %r1153;
		st.f64	[%r639], %r367;
		ld.f64	%r368, [%r640+705465936];
		neg.f64	%r1154, %r368;
		ld.f64	%r1155, [%r640+1310151024];
		ld.f64	%r1156, [%r640+806246784];
		fma.rn.f64	%r371, %r1154, %r1155, %r1156;
		st.f64	[%r640+806246784], %r371;
		ld.f64	%r1158, [%r640+1410931872];
		ld.f64	%r1159, [%r640+907027632];
		fma.rn.f64	%r374, %r1154, %r1158, %r1159;
		st.f64	[%r640+907027632], %r374;
		ld.f64	%r1161, [%r640+1041402096];
		ld.f64	%r1162, [%r640+537497856];
		fma.rn.f64	%r377, %r1154, %r1161, %r1162;
		st.f64	[%r640+537497856], %r377;
		ld.f64	%r1164, [%r640+1142182944];
		ld.f64	%r1165, [%r640+638278704];
		fma.rn.f64	%r380, %r1154, %r1164, %r1165;
		st.f64	[%r640+638278704], %r380;
		ld.f64	%r1167, [%r640+1242963792];
		ld.f64	%r1168, [%r640+739059552];
		fma.rn.f64	%r383, %r1154, %r1167, %r1168;
		st.f64	[%r640+739059552], %r383;
		ld.f64	%r1170, [%r640+1343744640];
		ld.f64	%r1171, [%r640+839840400];
		fma.rn.f64	%r386, %r1154, %r1170, %r1171;
		st.f64	[%r640+839840400], %r386;
		ld.f64	%r1173, [%r640+1444525488];
		ld.f64	%r1174, [%r640+940621248];
		fma.rn.f64	%r389, %r1154, %r1173, %r1174;
		st.f64	[%r640+940621248], %r389;
		ld.f64	%r1176, [%r639+68866848];
		ld.f64	%r1177, [%r639+34433424];
		fma.rn.f64	%r392, %r1154, %r1176, %r1177;
		st.f64	[%r639+34433424], %r392;
		ld.f64	%r393, [%r640+1713274416];
		neg.f64	%r1178, %r393;
		ld.f64	%r1179, [%r640+1310151024];
		ld.f64	%r1180, [%r640+1814055264];
		fma.rn.f64	%r396, %r1178, %r1179, %r1180;
		st.f64	[%r640+1814055264], %r396;
		ld.f64	%r1182, [%r640+1410931872];
		ld.f64	%r1183, [%r640+1914836112];
		fma.rn.f64	%r399, %r1178, %r1182, %r1183;
		st.f64	[%r640+1914836112], %r399;
		ld.f64	%r1185, [%r640+1041402096];
		ld.f64	%r1186, [%r640+1545306336];
		fma.rn.f64	%r402, %r1178, %r1185, %r1186;
		st.f64	[%r640+1545306336], %r402;
		ld.f64	%r1188, [%r640+1142182944];
		ld.f64	%r1189, [%r640+1646087184];
		fma.rn.f64	%r405, %r1178, %r1188, %r1189;
		st.f64	[%r640+1646087184], %r405;
		ld.f64	%r1191, [%r640+1242963792];
		ld.f64	%r1192, [%r640+1746868032];
		fma.rn.f64	%r408, %r1178, %r1191, %r1192;
		st.f64	[%r640+1746868032], %r408;
		ld.f64	%r1194, [%r640+1343744640];
		ld.f64	%r1195, [%r640+1847648880];
		fma.rn.f64	%r411, %r1178, %r1194, %r1195;
		st.f64	[%r640+1847648880], %r411;
		ld.f64	%r1197, [%r640+1444525488];
		ld.f64	%r1198, [%r640+1948429728];
		fma.rn.f64	%r414, %r1178, %r1197, %r1198;
		st.f64	[%r640+1948429728], %r414;
		ld.f64	%r1200, [%r639+68866848];
		ld.f64	%r1201, [%r639+103300272];
		fma.rn.f64	%r417, %r1178, %r1200, %r1201;
		st.f64	[%r639+103300272], %r417;
		ld.f64	%r418, [%r640+2217178656];
		neg.f64	%r1202, %r418;
		ld.f64	%r1203, [%r640+1310151024];
		ld.f64	%r1204, [%r640+2317959504];
		fma.rn.f64	%r421, %r1202, %r1203, %r1204;
		st.f64	[%r640+2317959504], %r421;
		ld.f64	%r1206, [%r640+1410931872];
		ld.f64	%r1207, [%r640+2418740352];
		fma.rn.f64	%r424, %r1202, %r1206, %r1207;
		st.f64	[%r640+2418740352], %r424;
		ld.f64	%r1209, [%r640+1041402096];
		ld.f64	%r1210, [%r640+2049210576];
		fma.rn.f64	%r427, %r1202, %r1209, %r1210;
		st.f64	[%r640+2049210576], %r427;
		ld.f64	%r1212, [%r640+1142182944];
		ld.f64	%r1213, [%r640+2149991424];
		fma.rn.f64	%r430, %r1202, %r1212, %r1213;
		st.f64	[%r640+2149991424], %r430;
		ld.f64	%r1215, [%r640+1242963792];
		ld.f64	%r1216, [%r640+2250772272];
		fma.rn.f64	%r433, %r1202, %r1215, %r1216;
		st.f64	[%r640+2250772272], %r433;
		ld.f64	%r1218, [%r640+1343744640];
		ld.f64	%r1219, [%r640+2351553120];
		fma.rn.f64	%r436, %r1202, %r1218, %r1219;
		st.f64	[%r640+2351553120], %r436;
		ld.f64	%r1221, [%r640+1444525488];
		ld.f64	%r1222, [%r640+2452333968];
		fma.rn.f64	%r439, %r1202, %r1221, %r1222;
		st.f64	[%r640+2452333968], %r439;
		ld.f64	%r1224, [%r639+68866848];
		ld.f64	%r1225, [%r639+137733696];
		fma.rn.f64	%r442, %r1202, %r1224, %r1225;
		st.f64	[%r639+137733696], %r442;
		ld.f64	%r1227, [%r640+1814055264];
		div.rn.f64	%r444, %r842, %r1227;
		ld.f64	%r1229, [%r640+1914836112];
		mul.f64	%r1228, %r1229, %r444;
		st.f64	[%r640+1914836112], %r1228;
		ld.f64	%r1231, [%r640+1545306336];
		mul.f64	%r1230, %r1231, %r444;
		st.f64	[%r640+1545306336], %r1230;
		ld.f64	%r1233, [%r640+1646087184];
		mul.f64	%r1232, %r1233, %r444;
		st.f64	[%r640+1646087184], %r1232;
		ld.f64	%r1235, [%r640+1746868032];
		mul.f64	%r1234, %r1235, %r444;
		st.f64	[%r640+1746868032], %r1234;
		ld.f64	%r1237, [%r640+1847648880];
		mul.f64	%r1236, %r1237, %r444;
		st.f64	[%r640+1847648880], %r1236;
		ld.f64	%r1239, [%r640+1948429728];
		mul.f64	%r1238, %r1239, %r444;
		st.f64	[%r640+1948429728], %r1238;
		ld.f64	%r1241, [%r639+103300272];
		mul.f64	%r1240, %r1241, %r444;
		st.f64	[%r639+103300272], %r1240;
		ld.f64	%r459, [%r640+302342544];
		neg.f64	%r1242, %r459;
		ld.f64	%r1243, [%r640+1914836112];
		ld.f64	%r1244, [%r640+403123392];
		fma.rn.f64	%r462, %r1242, %r1243, %r1244;
		st.f64	[%r640+403123392], %r462;
		ld.f64	%r1246, [%r640+1545306336];
		ld.f64	%r1247, [%r640+33593616];
		fma.rn.f64	%r465, %r1242, %r1246, %r1247;
		st.f64	[%r640+33593616], %r465;
		ld.f64	%r1249, [%r640+1646087184];
		ld.f64	%r1250, [%r640+134374464];
		fma.rn.f64	%r468, %r1242, %r1249, %r1250;
		st.f64	[%r640+134374464], %r468;
		ld.f64	%r1252, [%r640+1746868032];
		ld.f64	%r1253, [%r640+235155312];
		fma.rn.f64	%r471, %r1242, %r1252, %r1253;
		st.f64	[%r640+235155312], %r471;
		ld.f64	%r1255, [%r640+1847648880];
		ld.f64	%r1256, [%r640+335936160];
		fma.rn.f64	%r474, %r1242, %r1255, %r1256;
		st.f64	[%r640+335936160], %r474;
		ld.f64	%r1258, [%r640+1948429728];
		ld.f64	%r1259, [%r640+436717008];
		fma.rn.f64	%r477, %r1242, %r1258, %r1259;
		st.f64	[%r640+436717008], %r477;
		ld.f64	%r1261, [%r639+103300272];
		ld.f64	%r1262, [%r639];
		fma.rn.f64	%r480, %r1242, %r1261, %r1262;
		st.f64	[%r639], %r480;
		ld.f64	%r481, [%r640+806246784];
		neg.f64	%r1263, %r481;
		ld.f64	%r1264, [%r640+1914836112];
		ld.f64	%r1265, [%r640+907027632];
		fma.rn.f64	%r484, %r1263, %r1264, %r1265;
		st.f64	[%r640+907027632], %r484;
		ld.f64	%r1267, [%r640+1545306336];
		ld.f64	%r1268, [%r640+537497856];
		fma.rn.f64	%r487, %r1263, %r1267, %r1268;
		st.f64	[%r640+537497856], %r487;
		ld.f64	%r1270, [%r640+1646087184];
		ld.f64	%r1271, [%r640+638278704];
		fma.rn.f64	%r490, %r1263, %r1270, %r1271;
		st.f64	[%r640+638278704], %r490;
		ld.f64	%r1273, [%r640+1746868032];
		ld.f64	%r1274, [%r640+739059552];
		fma.rn.f64	%r493, %r1263, %r1273, %r1274;
		st.f64	[%r640+739059552], %r493;
		ld.f64	%r1276, [%r640+1847648880];
		ld.f64	%r1277, [%r640+839840400];
		fma.rn.f64	%r496, %r1263, %r1276, %r1277;
		st.f64	[%r640+839840400], %r496;
		ld.f64	%r1279, [%r640+1948429728];
		ld.f64	%r1280, [%r640+940621248];
		fma.rn.f64	%r499, %r1263, %r1279, %r1280;
		st.f64	[%r640+940621248], %r499;
		ld.f64	%r1282, [%r639+103300272];
		ld.f64	%r1283, [%r639+34433424];
		fma.rn.f64	%r502, %r1263, %r1282, %r1283;
		st.f64	[%r639+34433424], %r502;
		ld.f64	%r503, [%r640+1310151024];
		neg.f64	%r1284, %r503;
		ld.f64	%r1285, [%r640+1914836112];
		ld.f64	%r1286, [%r640+1410931872];
		fma.rn.f64	%r506, %r1284, %r1285, %r1286;
		st.f64	[%r640+1410931872], %r506;
		ld.f64	%r1288, [%r640+1545306336];
		ld.f64	%r1289, [%r640+1041402096];
		fma.rn.f64	%r509, %r1284, %r1288, %r1289;
		st.f64	[%r640+1041402096], %r509;
		ld.f64	%r1291, [%r640+1646087184];
		ld.f64	%r1292, [%r640+1142182944];
		fma.rn.f64	%r512, %r1284, %r1291, %r1292;
		st.f64	[%r640+1142182944], %r512;
		ld.f64	%r1294, [%r640+1746868032];
		ld.f64	%r1295, [%r640+1242963792];
		fma.rn.f64	%r515, %r1284, %r1294, %r1295;
		st.f64	[%r640+1242963792], %r515;
		ld.f64	%r1297, [%r640+1847648880];
		ld.f64	%r1298, [%r640+1343744640];
		fma.rn.f64	%r518, %r1284, %r1297, %r1298;
		st.f64	[%r640+1343744640], %r518;
		ld.f64	%r1300, [%r640+1948429728];
		ld.f64	%r1301, [%r640+1444525488];
		fma.rn.f64	%r521, %r1284, %r1300, %r1301;
		st.f64	[%r640+1444525488], %r521;
		ld.f64	%r1303, [%r639+103300272];
		ld.f64	%r1304, [%r639+68866848];
		fma.rn.f64	%r524, %r1284, %r1303, %r1304;
		st.f64	[%r639+68866848], %r524;
		ld.f64	%r525, [%r640+2317959504];
		neg.f64	%r1305, %r525;
		ld.f64	%r1306, [%r640+1914836112];
		ld.f64	%r1307, [%r640+2418740352];
		fma.rn.f64	%r528, %r1305, %r1306, %r1307;
		st.f64	[%r640+2418740352], %r528;
		ld.f64	%r1309, [%r640+1545306336];
		ld.f64	%r1310, [%r640+2049210576];
		fma.rn.f64	%r531, %r1305, %r1309, %r1310;
		st.f64	[%r640+2049210576], %r531;
		ld.f64	%r1312, [%r640+1646087184];
		ld.f64	%r1313, [%r640+2149991424];
		fma.rn.f64	%r534, %r1305, %r1312, %r1313;
		st.f64	[%r640+2149991424], %r534;
		ld.f64	%r1315, [%r640+1746868032];
		ld.f64	%r1316, [%r640+2250772272];
		fma.rn.f64	%r537, %r1305, %r1315, %r1316;
		st.f64	[%r640+2250772272], %r537;
		ld.f64	%r1318, [%r640+1847648880];
		ld.f64	%r1319, [%r640+2351553120];
		fma.rn.f64	%r540, %r1305, %r1318, %r1319;
		st.f64	[%r640+2351553120], %r540;
		ld.f64	%r1321, [%r640+1948429728];
		ld.f64	%r1322, [%r640+2452333968];
		fma.rn.f64	%r543, %r1305, %r1321, %r1322;
		st.f64	[%r640+2452333968], %r543;
		ld.f64	%r1324, [%r639+103300272];
		ld.f64	%r1325, [%r639+137733696];
		fma.rn.f64	%r546, %r1305, %r1324, %r1325;
		st.f64	[%r639+137733696], %r546;
		ld.f64	%r1327, [%r640+2418740352];
		div.rn.f64	%r548, %r842, %r1327;
		ld.f64	%r1329, [%r640+2049210576];
		mul.f64	%r1328, %r1329, %r548;
		st.f64	[%r640+2049210576], %r1328;
		ld.f64	%r1331, [%r640+2149991424];
		mul.f64	%r1330, %r1331, %r548;
		st.f64	[%r640+2149991424], %r1330;
		ld.f64	%r1333, [%r640+2250772272];
		mul.f64	%r1332, %r1333, %r548;
		st.f64	[%r640+2250772272], %r1332;
		ld.f64	%r1335, [%r640+2351553120];
		mul.f64	%r1334, %r1335, %r548;
		st.f64	[%r640+2351553120], %r1334;
		ld.f64	%r1337, [%r640+2452333968];
		mul.f64	%r1336, %r1337, %r548;
		st.f64	[%r640+2452333968], %r1336;
		ld.f64	%r1339, [%r639+137733696];
		mul.f64	%r1338, %r1339, %r548;
		st.f64	[%r639+137733696], %r1338;
		ld.f64	%r561, [%r640+403123392];
		neg.f64	%r1340, %r561;
		ld.f64	%r1341, [%r640+2049210576];
		ld.f64	%r1342, [%r640+33593616];
		fma.rn.f64	%r564, %r1340, %r1341, %r1342;
		st.f64	[%r640+33593616], %r564;
		ld.f64	%r1344, [%r640+2149991424];
		ld.f64	%r1345, [%r640+134374464];
		fma.rn.f64	%r567, %r1340, %r1344, %r1345;
		st.f64	[%r640+134374464], %r567;
		ld.f64	%r1347, [%r640+2250772272];
		ld.f64	%r1348, [%r640+235155312];
		fma.rn.f64	%r570, %r1340, %r1347, %r1348;
		st.f64	[%r640+235155312], %r570;
		ld.f64	%r1350, [%r640+2351553120];
		ld.f64	%r1351, [%r640+335936160];
		fma.rn.f64	%r573, %r1340, %r1350, %r1351;
		st.f64	[%r640+335936160], %r573;
		ld.f64	%r1353, [%r640+2452333968];
		ld.f64	%r1354, [%r640+436717008];
		fma.rn.f64	%r576, %r1340, %r1353, %r1354;
		st.f64	[%r640+436717008], %r576;
		ld.f64	%r1356, [%r639+137733696];
		ld.f64	%r1357, [%r639];
		fma.rn.f64	%r579, %r1340, %r1356, %r1357;
		st.f64	[%r639], %r579;
		ld.f64	%r580, [%r640+907027632];
		neg.f64	%r1358, %r580;
		ld.f64	%r1359, [%r640+2049210576];
		ld.f64	%r1360, [%r640+537497856];
		fma.rn.f64	%r583, %r1358, %r1359, %r1360;
		st.f64	[%r640+537497856], %r583;
		ld.f64	%r1362, [%r640+2149991424];
		ld.f64	%r1363, [%r640+638278704];
		fma.rn.f64	%r586, %r1358, %r1362, %r1363;
		st.f64	[%r640+638278704], %r586;
		ld.f64	%r1365, [%r640+2250772272];
		ld.f64	%r1366, [%r640+739059552];
		fma.rn.f64	%r589, %r1358, %r1365, %r1366;
		st.f64	[%r640+739059552], %r589;
		ld.f64	%r1368, [%r640+2351553120];
		ld.f64	%r1369, [%r640+839840400];
		fma.rn.f64	%r592, %r1358, %r1368, %r1369;
		st.f64	[%r640+839840400], %r592;
		ld.f64	%r1371, [%r640+2452333968];
		ld.f64	%r1372, [%r640+940621248];
		fma.rn.f64	%r595, %r1358, %r1371, %r1372;
		st.f64	[%r640+940621248], %r595;
		ld.f64	%r1374, [%r639+137733696];
		ld.f64	%r1375, [%r639+34433424];
		fma.rn.f64	%r598, %r1358, %r1374, %r1375;
		st.f64	[%r639+34433424], %r598;
		ld.f64	%r599, [%r640+1410931872];
		neg.f64	%r1376, %r599;
		ld.f64	%r1377, [%r640+2049210576];
		ld.f64	%r1378, [%r640+1041402096];
		fma.rn.f64	%r602, %r1376, %r1377, %r1378;
		st.f64	[%r640+1041402096], %r602;
		ld.f64	%r1380, [%r640+2149991424];
		ld.f64	%r1381, [%r640+1142182944];
		fma.rn.f64	%r605, %r1376, %r1380, %r1381;
		st.f64	[%r640+1142182944], %r605;
		ld.f64	%r1383, [%r640+2250772272];
		ld.f64	%r1384, [%r640+1242963792];
		fma.rn.f64	%r608, %r1376, %r1383, %r1384;
		st.f64	[%r640+1242963792], %r608;
		ld.f64	%r1386, [%r640+2351553120];
		ld.f64	%r1387, [%r640+1343744640];
		fma.rn.f64	%r611, %r1376, %r1386, %r1387;
		st.f64	[%r640+1343744640], %r611;
		ld.f64	%r1389, [%r640+2452333968];
		ld.f64	%r1390, [%r640+1444525488];
		fma.rn.f64	%r614, %r1376, %r1389, %r1390;
		st.f64	[%r640+1444525488], %r614;
		ld.f64	%r1392, [%r639+137733696];
		ld.f64	%r1393, [%r639+68866848];
		fma.rn.f64	%r617, %r1376, %r1392, %r1393;
		st.f64	[%r639+68866848], %r617;
		ld.f64	%r618, [%r640+1914836112];
		neg.f64	%r1394, %r618;
		ld.f64	%r1395, [%r640+2049210576];
		ld.f64	%r1396, [%r640+1545306336];
		fma.rn.f64	%r621, %r1394, %r1395, %r1396;
		st.f64	[%r640+1545306336], %r621;
		ld.f64	%r1398, [%r640+2149991424];
		ld.f64	%r1399, [%r640+1646087184];
		fma.rn.f64	%r624, %r1394, %r1398, %r1399;
		st.f64	[%r640+1646087184], %r624;
		ld.f64	%r1401, [%r640+2250772272];
		ld.f64	%r1402, [%r640+1746868032];
		fma.rn.f64	%r627, %r1394, %r1401, %r1402;
		st.f64	[%r640+1746868032], %r627;
		ld.f64	%r1404, [%r640+2351553120];
		ld.f64	%r1405, [%r640+1847648880];
		fma.rn.f64	%r630, %r1394, %r1404, %r1405;
		st.f64	[%r640+1847648880], %r630;
		ld.f64	%r1407, [%r640+2452333968];
		ld.f64	%r1408, [%r640+1948429728];
		fma.rn.f64	%r633, %r1394, %r1407, %r1408;
		st.f64	[%r640+1948429728], %r633;
		ld.f64	%r1410, [%r639+137733696];
		ld.f64	%r1411, [%r639+103300272];
		fma.rn.f64	%r636, %r1394, %r1410, %r1411;
		st.f64	[%r639+103300272], %r636;
		add.u32	%r24, %r24, 128;
		add.u64	%r640, %r640, 1024;
		add.u64	%r639, %r639, 27206656;
		setp.gt.s32	%r1412, %r28, %r24;
	@%r1412	bra	$L84;
$L83:
	// joining 4;
	// join 4;
	// joining 2;
		bar.sync	0;
	// join 2;
	@%r1416	bra.uni	$L88;
	@%r1417	bra	$L89;
		add.u64	%r804, %r804, 161;
		add.u64	%r807, %r807, 1304;
		setp.ne.u64	%r1413, %r804, %r817;
		selp.u32	%r1418, 1, 0, %r1413;
		st.shared.u32	[__oacc_bcast], %r1418;
$L89:
$L88:
		bar.sync	0;
		ld.shared.u32	%r1419, [__oacc_bcast];
		setp.ne.u32	%r1413, %r1419, 0;
		bar.sync	0;
	@%r1413	bra.uni	$L85;
$L81:
	ret;
}

// BEGIN FUNCTION DECL: x_solve$_omp_fn$5
.entry x_solve$_omp_fn$5 (.param.u64 %in_ar0);

// BEGIN FUNCTION DEF: x_solve$_omp_fn$5
.entry x_solve$_omp_fn$5 (.param.u64 %in_ar0)
{
	.reg.u64 %ar0;
	ld.param.u64 %ar0, [%in_ar0];
	.reg.u32 %r24;
	.reg.u32 %r27;
	.reg.u32 %r29;
	.reg.u32 %r31;
	.reg.u32 %r32;
	.reg.u32 %r35;
	.reg.u64 %r36;
	.reg.u64 %r38;
	.reg.f64 %r40;
	.reg.f64 %r41;
	.reg.f64 %r43;
	.reg.f64 %r44;
	.reg.f64 %r46;
	.reg.f64 %r47;
	.reg.f64 %r49;
	.reg.f64 %r50;
	.reg.f64 %r52;
	.reg.f64 %r53;
	.reg.f64 %r57;
	.reg.f64 %r60;
	.reg.f64 %r63;
	.reg.f64 %r66;
	.reg.f64 %r69;
	.reg.f64 %r73;
	.reg.f64 %r76;
	.reg.f64 %r79;
	.reg.f64 %r81;
	.reg.f64 %r83;
	.reg.u32 %r86;
	.reg.f64 %r87;
	.reg.f64 %r89;
	.reg.f64 %r92;
	.reg.f64 %r94;
	.reg.f64 %r96;
	.reg.f64 %r99;
	.reg.f64 %r101;
	.reg.f64 %r103;
	.reg.f64 %r106;
	.reg.f64 %r108;
	.reg.f64 %r110;
	.reg.f64 %r111;
	.reg.f64 %r112;
	.reg.f64 %r113;
	.reg.f64 %r114;
	.reg.f64 %r115;
	.reg.f64 %r116;
	.reg.f64 %r117;
	.reg.f64 %r118;
	.reg.f64 %r119;
	.reg.f64 %r120;
	.reg.f64 %r121;
	.reg.f64 %r122;
	.reg.f64 %r123;
	.reg.f64 %r124;
	.reg.f64 %r126;
	.reg.f64 %r127;
	.reg.f64 %r128;
	.reg.f64 %r129;
	.reg.f64 %r130;
	.reg.f64 %r131;
	.reg.f64 %r132;
	.reg.f64 %r133;
	.reg.f64 %r134;
	.reg.f64 %r135;
	.reg.f64 %r137;
	.reg.f64 %r138;
	.reg.f64 %r139;
	.reg.f64 %r140;
	.reg.f64 %r141;
	.reg.f64 %r142;
	.reg.f64 %r143;
	.reg.f64 %r144;
	.reg.f64 %r145;
	.reg.f64 %r146;
	.reg.f64 %r148;
	.reg.f64 %r149;
	.reg.f64 %r150;
	.reg.f64 %r151;
	.reg.f64 %r152;
	.reg.f64 %r153;
	.reg.f64 %r154;
	.reg.f64 %r155;
	.reg.f64 %r156;
	.reg.f64 %r157;
	.reg.f64 %r159;
	.reg.f64 %r160;
	.reg.f64 %r161;
	.reg.f64 %r162;
	.reg.f64 %r163;
	.reg.f64 %r164;
	.reg.f64 %r165;
	.reg.f64 %r166;
	.reg.f64 %r167;
	.reg.f64 %r168;
	.reg.f64 %r170;
	.reg.f64 %r171;
	.reg.f64 %r172;
	.reg.f64 %r173;
	.reg.f64 %r174;
	.reg.f64 %r175;
	.reg.f64 %r176;
	.reg.f64 %r177;
	.reg.f64 %r178;
	.reg.f64 %r179;
	.reg.f64 %r181;
	.reg.f64 %r182;
	.reg.f64 %r183;
	.reg.f64 %r184;
	.reg.f64 %r185;
	.reg.f64 %r187;
	.reg.f64 %r188;
	.reg.f64 %r189;
	.reg.f64 %r190;
	.reg.f64 %r191;
	.reg.f64 %r193;
	.reg.f64 %r194;
	.reg.f64 %r195;
	.reg.f64 %r196;
	.reg.f64 %r197;
	.reg.f64 %r199;
	.reg.f64 %r200;
	.reg.f64 %r201;
	.reg.f64 %r202;
	.reg.f64 %r203;
	.reg.f64 %r205;
	.reg.f64 %r206;
	.reg.f64 %r207;
	.reg.f64 %r208;
	.reg.f64 %r209;
	.reg.f64 %r210;
	.reg.f64 %r211;
	.reg.f64 %r212;
	.reg.f64 %r213;
	.reg.f64 %r214;
	.reg.f64 %r216;
	.reg.f64 %r217;
	.reg.f64 %r218;
	.reg.f64 %r219;
	.reg.f64 %r220;
	.reg.f64 %r222;
	.reg.f64 %r223;
	.reg.f64 %r224;
	.reg.f64 %r225;
	.reg.f64 %r226;
	.reg.f64 %r228;
	.reg.f64 %r229;
	.reg.f64 %r230;
	.reg.f64 %r231;
	.reg.f64 %r232;
	.reg.f64 %r234;
	.reg.f64 %r235;
	.reg.f64 %r236;
	.reg.f64 %r237;
	.reg.f64 %r238;
	.reg.f64 %r240;
	.reg.f64 %r241;
	.reg.f64 %r242;
	.reg.f64 %r243;
	.reg.f64 %r244;
	.reg.f64 %r245;
	.reg.f64 %r246;
	.reg.f64 %r247;
	.reg.f64 %r248;
	.reg.f64 %r249;
	.reg.f64 %r251;
	.reg.f64 %r252;
	.reg.f64 %r253;
	.reg.f64 %r254;
	.reg.f64 %r255;
	.reg.f64 %r257;
	.reg.f64 %r258;
	.reg.f64 %r259;
	.reg.f64 %r260;
	.reg.f64 %r261;
	.reg.f64 %r263;
	.reg.f64 %r264;
	.reg.f64 %r265;
	.reg.f64 %r266;
	.reg.f64 %r267;
	.reg.f64 %r269;
	.reg.f64 %r270;
	.reg.f64 %r271;
	.reg.f64 %r272;
	.reg.f64 %r273;
	.reg.f64 %r275;
	.reg.f64 %r276;
	.reg.f64 %r277;
	.reg.f64 %r278;
	.reg.f64 %r279;
	.reg.f64 %r280;
	.reg.f64 %r281;
	.reg.f64 %r282;
	.reg.f64 %r283;
	.reg.f64 %r284;
	.reg.f64 %r286;
	.reg.f64 %r287;
	.reg.f64 %r288;
	.reg.f64 %r289;
	.reg.f64 %r290;
	.reg.f64 %r292;
	.reg.f64 %r293;
	.reg.f64 %r294;
	.reg.f64 %r295;
	.reg.f64 %r296;
	.reg.f64 %r298;
	.reg.f64 %r299;
	.reg.f64 %r300;
	.reg.f64 %r301;
	.reg.f64 %r302;
	.reg.f64 %r304;
	.reg.f64 %r305;
	.reg.f64 %r306;
	.reg.f64 %r307;
	.reg.f64 %r308;
	.reg.f64 %r309;
	.reg.f64 %r327;
	.reg.f64 %r330;
	.reg.f64 %r333;
	.reg.f64 %r336;
	.reg.f64 %r339;
	.reg.f64 %r342;
	.reg.f64 %r345;
	.reg.f64 %r348;
	.reg.f64 %r351;
	.reg.f64 %r354;
	.reg.f64 %r357;
	.reg.f64 %r358;
	.reg.f64 %r361;
	.reg.f64 %r364;
	.reg.f64 %r367;
	.reg.f64 %r370;
	.reg.f64 %r373;
	.reg.f64 %r376;
	.reg.f64 %r379;
	.reg.f64 %r382;
	.reg.f64 %r385;
	.reg.f64 %r388;
	.reg.f64 %r389;
	.reg.f64 %r392;
	.reg.f64 %r395;
	.reg.f64 %r398;
	.reg.f64 %r401;
	.reg.f64 %r404;
	.reg.f64 %r407;
	.reg.f64 %r410;
	.reg.f64 %r413;
	.reg.f64 %r416;
	.reg.f64 %r419;
	.reg.f64 %r420;
	.reg.f64 %r423;
	.reg.f64 %r426;
	.reg.f64 %r429;
	.reg.f64 %r432;
	.reg.f64 %r435;
	.reg.f64 %r438;
	.reg.f64 %r441;
	.reg.f64 %r444;
	.reg.f64 %r447;
	.reg.f64 %r450;
	.reg.f64 %r452;
	.reg.f64 %r471;
	.reg.f64 %r474;
	.reg.f64 %r477;
	.reg.f64 %r480;
	.reg.f64 %r483;
	.reg.f64 %r486;
	.reg.f64 %r489;
	.reg.f64 %r492;
	.reg.f64 %r495;
	.reg.f64 %r498;
	.reg.f64 %r499;
	.reg.f64 %r502;
	.reg.f64 %r505;
	.reg.f64 %r508;
	.reg.f64 %r511;
	.reg.f64 %r514;
	.reg.f64 %r517;
	.reg.f64 %r520;
	.reg.f64 %r523;
	.reg.f64 %r526;
	.reg.f64 %r527;
	.reg.f64 %r530;
	.reg.f64 %r533;
	.reg.f64 %r536;
	.reg.f64 %r539;
	.reg.f64 %r542;
	.reg.f64 %r545;
	.reg.f64 %r548;
	.reg.f64 %r551;
	.reg.f64 %r554;
	.reg.f64 %r555;
	.reg.f64 %r558;
	.reg.f64 %r561;
	.reg.f64 %r564;
	.reg.f64 %r567;
	.reg.f64 %r570;
	.reg.f64 %r573;
	.reg.f64 %r576;
	.reg.f64 %r579;
	.reg.f64 %r582;
	.reg.f64 %r584;
	.reg.f64 %r601;
	.reg.f64 %r604;
	.reg.f64 %r607;
	.reg.f64 %r610;
	.reg.f64 %r613;
	.reg.f64 %r616;
	.reg.f64 %r619;
	.reg.f64 %r622;
	.reg.f64 %r625;
	.reg.f64 %r626;
	.reg.f64 %r629;
	.reg.f64 %r632;
	.reg.f64 %r635;
	.reg.f64 %r638;
	.reg.f64 %r641;
	.reg.f64 %r644;
	.reg.f64 %r647;
	.reg.f64 %r650;
	.reg.f64 %r651;
	.reg.f64 %r654;
	.reg.f64 %r657;
	.reg.f64 %r660;
	.reg.f64 %r663;
	.reg.f64 %r666;
	.reg.f64 %r669;
	.reg.f64 %r672;
	.reg.f64 %r675;
	.reg.f64 %r676;
	.reg.f64 %r679;
	.reg.f64 %r682;
	.reg.f64 %r685;
	.reg.f64 %r688;
	.reg.f64 %r691;
	.reg.f64 %r694;
	.reg.f64 %r697;
	.reg.f64 %r700;
	.reg.f64 %r702;
	.reg.f64 %r717;
	.reg.f64 %r720;
	.reg.f64 %r723;
	.reg.f64 %r726;
	.reg.f64 %r729;
	.reg.f64 %r732;
	.reg.f64 %r735;
	.reg.f64 %r738;
	.reg.f64 %r739;
	.reg.f64 %r742;
	.reg.f64 %r745;
	.reg.f64 %r748;
	.reg.f64 %r751;
	.reg.f64 %r754;
	.reg.f64 %r757;
	.reg.f64 %r760;
	.reg.f64 %r761;
	.reg.f64 %r764;
	.reg.f64 %r767;
	.reg.f64 %r770;
	.reg.f64 %r773;
	.reg.f64 %r776;
	.reg.f64 %r779;
	.reg.f64 %r782;
	.reg.f64 %r783;
	.reg.f64 %r786;
	.reg.f64 %r789;
	.reg.f64 %r792;
	.reg.f64 %r795;
	.reg.f64 %r798;
	.reg.f64 %r801;
	.reg.f64 %r804;
	.reg.f64 %r806;
	.reg.f64 %r819;
	.reg.f64 %r822;
	.reg.f64 %r825;
	.reg.f64 %r828;
	.reg.f64 %r831;
	.reg.f64 %r834;
	.reg.f64 %r837;
	.reg.f64 %r838;
	.reg.f64 %r841;
	.reg.f64 %r844;
	.reg.f64 %r847;
	.reg.f64 %r850;
	.reg.f64 %r853;
	.reg.f64 %r856;
	.reg.f64 %r857;
	.reg.f64 %r860;
	.reg.f64 %r863;
	.reg.f64 %r866;
	.reg.f64 %r869;
	.reg.f64 %r872;
	.reg.f64 %r875;
	.reg.f64 %r876;
	.reg.f64 %r879;
	.reg.f64 %r882;
	.reg.f64 %r885;
	.reg.f64 %r888;
	.reg.f64 %r891;
	.reg.f64 %r894;
	.reg.u64 %r901;
	.reg.u32 %r907;
	.reg.u32 %r915;
	.reg.u32 %r916;
	.reg.u32 %r920;
	.reg.u32 %r921;
	.reg.u64 %r924;
	.reg.u32 %r1190;
	.reg.u64 %r1191;
	.reg.u64 %r1192;
	.reg.u64 %r1199;
	.reg.u64 %r1220;
	.reg.u64 %r1221;
	.reg.u32 %r1222;
	.reg.u32 %r1223;
	.reg.u32 %r1224;
	.reg.pred %r1225;
	.reg.u64 %r1226;
	.reg.u64 %r1227;
	.reg.u32 %r1228;
	.reg.pred %r1229;
	.reg.pred %r1230;
	.reg.u64 %r1231;
	.reg.u64 %r1233;
	.reg.u32 %r1234;
	.reg.u64 %r1235;
	.reg.u64 %r1236;
	.reg.u64 %r1238;
	.reg.u64 %r1239;
	.reg.u64 %r1240;
	.reg.u64 %r1241;
	.reg.u64 %r1242;
	.reg.u64 %r1243;
	.reg.u64 %r1244;
	.reg.pred %r1245;
	.reg.f64 %r1246;
	.reg.f64 %r1247;
	.reg.f64 %r1248;
	.reg.f64 %r1249;
	.reg.f64 %r1250;
	.reg.f64 %r1251;
	.reg.f64 %r1252;
	.reg.f64 %r1253;
	.reg.f64 %r1254;
	.reg.f64 %r1255;
	.reg.f64 %r1256;
	.reg.f64 %r1257;
	.reg.f64 %r1258;
	.reg.f64 %r1259;
	.reg.f64 %r1260;
	.reg.f64 %r1261;
	.reg.f64 %r1262;
	.reg.f64 %r1263;
	.reg.f64 %r1264;
	.reg.f64 %r1265;
	.reg.f64 %r1266;
	.reg.f64 %r1267;
	.reg.f64 %r1269;
	.reg.f64 %r1270;
	.reg.f64 %r1272;
	.reg.f64 %r1274;
	.reg.f64 %r1276;
	.reg.f64 %r1278;
	.reg.f64 %r1280;
	.reg.f64 %r1281;
	.reg.f64 %r1283;
	.reg.f64 %r1285;
	.reg.f64 %r1287;
	.reg.f64 %r1289;
	.reg.f64 %r1291;
	.reg.f64 %r1292;
	.reg.f64 %r1294;
	.reg.f64 %r1296;
	.reg.f64 %r1298;
	.reg.f64 %r1300;
	.reg.f64 %r1301;
	.reg.f64 %r1302;
	.reg.f64 %r1303;
	.reg.f64 %r1304;
	.reg.f64 %r1305;
	.reg.f64 %r1306;
	.reg.f64 %r1307;
	.reg.f64 %r1308;
	.reg.f64 %r1309;
	.reg.f64 %r1310;
	.reg.f64 %r1311;
	.reg.f64 %r1312;
	.reg.f64 %r1314;
	.reg.f64 %r1320;
	.reg.f64 %r1326;
	.reg.f64 %r1332;
	.reg.f64 %r1337;
	.reg.f64 %r1338;
	.reg.f64 %r1339;
	.reg.f64 %r1340;
	.reg.f64 %r1341;
	.reg.f64 %r1342;
	.reg.f64 %r1343;
	.reg.f64 %r1344;
	.reg.f64 %r1345;
	.reg.f64 %r1346;
	.reg.f64 %r1347;
	.reg.f64 %r1348;
	.reg.f64 %r1349;
	.reg.f64 %r1350;
	.reg.f64 %r1351;
	.reg.f64 %r1352;
	.reg.f64 %r1353;
	.reg.f64 %r1354;
	.reg.f64 %r1355;
	.reg.f64 %r1356;
	.reg.f64 %r1357;
	.reg.f64 %r1358;
	.reg.f64 %r1359;
	.reg.f64 %r1360;
	.reg.f64 %r1362;
	.reg.f64 %r1368;
	.reg.f64 %r1374;
	.reg.f64 %r1380;
	.reg.f64 %r1386;
	.reg.f64 %r1392;
	.reg.f64 %r1398;
	.reg.f64 %r1404;
	.reg.f64 %r1410;
	.reg.f64 %r1416;
	.reg.f64 %r1422;
	.reg.f64 %r1428;
	.reg.f64 %r1434;
	.reg.f64 %r1440;
	.reg.f64 %r1446;
	.reg.f64 %r1451;
	.reg.f64 %r1452;
	.reg.f64 %r1453;
	.reg.f64 %r1454;
	.reg.f64 %r1455;
	.reg.f64 %r1456;
	.reg.f64 %r1457;
	.reg.f64 %r1458;
	.reg.f64 %r1459;
	.reg.f64 %r1460;
	.reg.f64 %r1461;
	.reg.f64 %r1462;
	.reg.f64 %r1463;
	.reg.f64 %r1464;
	.reg.f64 %r1465;
	.reg.f64 %r1466;
	.reg.f64 %r1467;
	.reg.f64 %r1468;
	.reg.f64 %r1469;
	.reg.f64 %r1470;
	.reg.f64 %r1472;
	.reg.f64 %r1473;
	.reg.f64 %r1475;
	.reg.f64 %r1476;
	.reg.f64 %r1478;
	.reg.f64 %r1479;
	.reg.f64 %r1481;
	.reg.f64 %r1482;
	.reg.f64 %r1484;
	.reg.f64 %r1485;
	.reg.f64 %r1487;
	.reg.f64 %r1488;
	.reg.f64 %r1490;
	.reg.f64 %r1491;
	.reg.f64 %r1493;
	.reg.f64 %r1494;
	.reg.f64 %r1496;
	.reg.f64 %r1497;
	.reg.f64 %r1498;
	.reg.f64 %r1499;
	.reg.f64 %r1500;
	.reg.f64 %r1502;
	.reg.f64 %r1503;
	.reg.f64 %r1505;
	.reg.f64 %r1506;
	.reg.f64 %r1508;
	.reg.f64 %r1509;
	.reg.f64 %r1511;
	.reg.f64 %r1512;
	.reg.f64 %r1514;
	.reg.f64 %r1515;
	.reg.f64 %r1517;
	.reg.f64 %r1518;
	.reg.f64 %r1520;
	.reg.f64 %r1521;
	.reg.f64 %r1523;
	.reg.f64 %r1524;
	.reg.f64 %r1526;
	.reg.f64 %r1527;
	.reg.f64 %r1528;
	.reg.f64 %r1529;
	.reg.f64 %r1530;
	.reg.f64 %r1532;
	.reg.f64 %r1533;
	.reg.f64 %r1535;
	.reg.f64 %r1536;
	.reg.f64 %r1538;
	.reg.f64 %r1539;
	.reg.f64 %r1541;
	.reg.f64 %r1542;
	.reg.f64 %r1544;
	.reg.f64 %r1545;
	.reg.f64 %r1547;
	.reg.f64 %r1548;
	.reg.f64 %r1550;
	.reg.f64 %r1551;
	.reg.f64 %r1553;
	.reg.f64 %r1554;
	.reg.f64 %r1556;
	.reg.f64 %r1557;
	.reg.f64 %r1558;
	.reg.f64 %r1559;
	.reg.f64 %r1560;
	.reg.f64 %r1562;
	.reg.f64 %r1563;
	.reg.f64 %r1565;
	.reg.f64 %r1566;
	.reg.f64 %r1568;
	.reg.f64 %r1569;
	.reg.f64 %r1571;
	.reg.f64 %r1572;
	.reg.f64 %r1574;
	.reg.f64 %r1575;
	.reg.f64 %r1577;
	.reg.f64 %r1578;
	.reg.f64 %r1580;
	.reg.f64 %r1581;
	.reg.f64 %r1583;
	.reg.f64 %r1584;
	.reg.f64 %r1586;
	.reg.f64 %r1587;
	.reg.f64 %r1589;
	.reg.f64 %r1590;
	.reg.f64 %r1591;
	.reg.f64 %r1592;
	.reg.f64 %r1593;
	.reg.f64 %r1594;
	.reg.f64 %r1595;
	.reg.f64 %r1596;
	.reg.f64 %r1597;
	.reg.f64 %r1598;
	.reg.f64 %r1599;
	.reg.f64 %r1600;
	.reg.f64 %r1601;
	.reg.f64 %r1602;
	.reg.f64 %r1603;
	.reg.f64 %r1604;
	.reg.f64 %r1605;
	.reg.f64 %r1606;
	.reg.f64 %r1607;
	.reg.f64 %r1608;
	.reg.f64 %r1609;
	.reg.f64 %r1610;
	.reg.f64 %r1612;
	.reg.f64 %r1613;
	.reg.f64 %r1615;
	.reg.f64 %r1616;
	.reg.f64 %r1618;
	.reg.f64 %r1619;
	.reg.f64 %r1621;
	.reg.f64 %r1622;
	.reg.f64 %r1624;
	.reg.f64 %r1625;
	.reg.f64 %r1627;
	.reg.f64 %r1628;
	.reg.f64 %r1630;
	.reg.f64 %r1631;
	.reg.f64 %r1633;
	.reg.f64 %r1634;
	.reg.f64 %r1635;
	.reg.f64 %r1636;
	.reg.f64 %r1637;
	.reg.f64 %r1639;
	.reg.f64 %r1640;
	.reg.f64 %r1642;
	.reg.f64 %r1643;
	.reg.f64 %r1645;
	.reg.f64 %r1646;
	.reg.f64 %r1648;
	.reg.f64 %r1649;
	.reg.f64 %r1651;
	.reg.f64 %r1652;
	.reg.f64 %r1654;
	.reg.f64 %r1655;
	.reg.f64 %r1657;
	.reg.f64 %r1658;
	.reg.f64 %r1660;
	.reg.f64 %r1661;
	.reg.f64 %r1662;
	.reg.f64 %r1663;
	.reg.f64 %r1664;
	.reg.f64 %r1666;
	.reg.f64 %r1667;
	.reg.f64 %r1669;
	.reg.f64 %r1670;
	.reg.f64 %r1672;
	.reg.f64 %r1673;
	.reg.f64 %r1675;
	.reg.f64 %r1676;
	.reg.f64 %r1678;
	.reg.f64 %r1679;
	.reg.f64 %r1681;
	.reg.f64 %r1682;
	.reg.f64 %r1684;
	.reg.f64 %r1685;
	.reg.f64 %r1687;
	.reg.f64 %r1688;
	.reg.f64 %r1689;
	.reg.f64 %r1690;
	.reg.f64 %r1691;
	.reg.f64 %r1693;
	.reg.f64 %r1694;
	.reg.f64 %r1696;
	.reg.f64 %r1697;
	.reg.f64 %r1699;
	.reg.f64 %r1700;
	.reg.f64 %r1702;
	.reg.f64 %r1703;
	.reg.f64 %r1705;
	.reg.f64 %r1706;
	.reg.f64 %r1708;
	.reg.f64 %r1709;
	.reg.f64 %r1711;
	.reg.f64 %r1712;
	.reg.f64 %r1714;
	.reg.f64 %r1715;
	.reg.f64 %r1717;
	.reg.f64 %r1718;
	.reg.f64 %r1719;
	.reg.f64 %r1720;
	.reg.f64 %r1721;
	.reg.f64 %r1722;
	.reg.f64 %r1723;
	.reg.f64 %r1724;
	.reg.f64 %r1725;
	.reg.f64 %r1726;
	.reg.f64 %r1727;
	.reg.f64 %r1728;
	.reg.f64 %r1729;
	.reg.f64 %r1730;
	.reg.f64 %r1731;
	.reg.f64 %r1732;
	.reg.f64 %r1733;
	.reg.f64 %r1734;
	.reg.f64 %r1735;
	.reg.f64 %r1736;
	.reg.f64 %r1738;
	.reg.f64 %r1739;
	.reg.f64 %r1741;
	.reg.f64 %r1742;
	.reg.f64 %r1744;
	.reg.f64 %r1745;
	.reg.f64 %r1747;
	.reg.f64 %r1748;
	.reg.f64 %r1750;
	.reg.f64 %r1751;
	.reg.f64 %r1753;
	.reg.f64 %r1754;
	.reg.f64 %r1756;
	.reg.f64 %r1757;
	.reg.f64 %r1758;
	.reg.f64 %r1759;
	.reg.f64 %r1760;
	.reg.f64 %r1762;
	.reg.f64 %r1763;
	.reg.f64 %r1765;
	.reg.f64 %r1766;
	.reg.f64 %r1768;
	.reg.f64 %r1769;
	.reg.f64 %r1771;
	.reg.f64 %r1772;
	.reg.f64 %r1774;
	.reg.f64 %r1775;
	.reg.f64 %r1777;
	.reg.f64 %r1778;
	.reg.f64 %r1780;
	.reg.f64 %r1781;
	.reg.f64 %r1782;
	.reg.f64 %r1783;
	.reg.f64 %r1784;
	.reg.f64 %r1786;
	.reg.f64 %r1787;
	.reg.f64 %r1789;
	.reg.f64 %r1790;
	.reg.f64 %r1792;
	.reg.f64 %r1793;
	.reg.f64 %r1795;
	.reg.f64 %r1796;
	.reg.f64 %r1798;
	.reg.f64 %r1799;
	.reg.f64 %r1801;
	.reg.f64 %r1802;
	.reg.f64 %r1804;
	.reg.f64 %r1805;
	.reg.f64 %r1806;
	.reg.f64 %r1807;
	.reg.f64 %r1808;
	.reg.f64 %r1810;
	.reg.f64 %r1811;
	.reg.f64 %r1813;
	.reg.f64 %r1814;
	.reg.f64 %r1816;
	.reg.f64 %r1817;
	.reg.f64 %r1819;
	.reg.f64 %r1820;
	.reg.f64 %r1822;
	.reg.f64 %r1823;
	.reg.f64 %r1825;
	.reg.f64 %r1826;
	.reg.f64 %r1828;
	.reg.f64 %r1829;
	.reg.f64 %r1831;
	.reg.f64 %r1832;
	.reg.f64 %r1833;
	.reg.f64 %r1834;
	.reg.f64 %r1835;
	.reg.f64 %r1836;
	.reg.f64 %r1837;
	.reg.f64 %r1838;
	.reg.f64 %r1839;
	.reg.f64 %r1840;
	.reg.f64 %r1841;
	.reg.f64 %r1842;
	.reg.f64 %r1843;
	.reg.f64 %r1844;
	.reg.f64 %r1845;
	.reg.f64 %r1846;
	.reg.f64 %r1847;
	.reg.f64 %r1848;
	.reg.f64 %r1850;
	.reg.f64 %r1851;
	.reg.f64 %r1853;
	.reg.f64 %r1854;
	.reg.f64 %r1856;
	.reg.f64 %r1857;
	.reg.f64 %r1859;
	.reg.f64 %r1860;
	.reg.f64 %r1862;
	.reg.f64 %r1863;
	.reg.f64 %r1865;
	.reg.f64 %r1866;
	.reg.f64 %r1867;
	.reg.f64 %r1868;
	.reg.f64 %r1869;
	.reg.f64 %r1871;
	.reg.f64 %r1872;
	.reg.f64 %r1874;
	.reg.f64 %r1875;
	.reg.f64 %r1877;
	.reg.f64 %r1878;
	.reg.f64 %r1880;
	.reg.f64 %r1881;
	.reg.f64 %r1883;
	.reg.f64 %r1884;
	.reg.f64 %r1886;
	.reg.f64 %r1887;
	.reg.f64 %r1888;
	.reg.f64 %r1889;
	.reg.f64 %r1890;
	.reg.f64 %r1892;
	.reg.f64 %r1893;
	.reg.f64 %r1895;
	.reg.f64 %r1896;
	.reg.f64 %r1898;
	.reg.f64 %r1899;
	.reg.f64 %r1901;
	.reg.f64 %r1902;
	.reg.f64 %r1904;
	.reg.f64 %r1905;
	.reg.f64 %r1907;
	.reg.f64 %r1908;
	.reg.f64 %r1909;
	.reg.f64 %r1910;
	.reg.f64 %r1911;
	.reg.f64 %r1913;
	.reg.f64 %r1914;
	.reg.f64 %r1916;
	.reg.f64 %r1917;
	.reg.f64 %r1919;
	.reg.f64 %r1920;
	.reg.f64 %r1922;
	.reg.f64 %r1923;
	.reg.f64 %r1925;
	.reg.f64 %r1926;
	.reg.f64 %r1928;
	.reg.f64 %r1929;
	.reg.f64 %r1931;
	.reg.f64 %r1932;
	.reg.f64 %r1933;
	.reg.f64 %r1934;
	.reg.f64 %r1935;
	.reg.f64 %r1936;
	.reg.f64 %r1937;
	.reg.f64 %r1938;
	.reg.f64 %r1939;
	.reg.f64 %r1940;
	.reg.f64 %r1941;
	.reg.f64 %r1942;
	.reg.f64 %r1943;
	.reg.f64 %r1944;
	.reg.f64 %r1945;
	.reg.f64 %r1946;
	.reg.f64 %r1948;
	.reg.f64 %r1949;
	.reg.f64 %r1951;
	.reg.f64 %r1952;
	.reg.f64 %r1954;
	.reg.f64 %r1955;
	.reg.f64 %r1957;
	.reg.f64 %r1958;
	.reg.f64 %r1960;
	.reg.f64 %r1961;
	.reg.f64 %r1962;
	.reg.f64 %r1963;
	.reg.f64 %r1964;
	.reg.f64 %r1966;
	.reg.f64 %r1967;
	.reg.f64 %r1969;
	.reg.f64 %r1970;
	.reg.f64 %r1972;
	.reg.f64 %r1973;
	.reg.f64 %r1975;
	.reg.f64 %r1976;
	.reg.f64 %r1978;
	.reg.f64 %r1979;
	.reg.f64 %r1980;
	.reg.f64 %r1981;
	.reg.f64 %r1982;
	.reg.f64 %r1984;
	.reg.f64 %r1985;
	.reg.f64 %r1987;
	.reg.f64 %r1988;
	.reg.f64 %r1990;
	.reg.f64 %r1991;
	.reg.f64 %r1993;
	.reg.f64 %r1994;
	.reg.f64 %r1996;
	.reg.f64 %r1997;
	.reg.f64 %r1998;
	.reg.f64 %r1999;
	.reg.f64 %r2000;
	.reg.f64 %r2002;
	.reg.f64 %r2003;
	.reg.f64 %r2005;
	.reg.f64 %r2006;
	.reg.f64 %r2008;
	.reg.f64 %r2009;
	.reg.f64 %r2011;
	.reg.f64 %r2012;
	.reg.f64 %r2014;
	.reg.f64 %r2015;
	.reg.pred %r2016;
	.reg.pred %r2017;
	.reg.u64 %r2018;
	.reg.u64 %r2019;
	.reg.pred %r2020;
	.reg.pred %r2021;
	.reg.u32 %r2022;
	.reg.u32 %r2023;
	.reg.u32 %r2024;
	.reg.u32 %r2025;
	{
		.reg.u32	%y;
		mov.u32	%y, %tid.y;
		setp.ne.u32	%r2020, %y, 0;
	}
	{
		.reg.u32	%x;
		mov.u32	%x, %tid.x;
		setp.ne.u32	%r2021, %x, 0;
	}
	@%r2020	bra.uni	$L113;
	@%r2021	bra	$L114;
		mov.u64	%r1220, %ar0;
		ld.u64	%r1221, [%r1220+24];
		ld.u32	%r27, [%r1221];
		mov.u32	%r915, %nctaid.x;
		mov.u32	%r916, %ctaid.x;
		add.u32	%r1222, %r27, -1;
		add.u32	%r1223, %r1222, %r915;
		div.s32	%r907, %r1223, %r915;
		mul.lo.u32	%r24, %r907, %r916;
		add.u32	%r1224, %r24, %r907;
		min.s32	%r32, %r1224, %r27;
		setp.ge.s32	%r1225, %r24, %r32;
		selp.u32	%r2024, 1, 0, %r1225;
		st.shared.u32	[__oacc_bcast], %r2024;
$L114:
$L113:
		bar.sync	0;
		ld.shared.u32	%r2025, [__oacc_bcast];
		setp.ne.u32	%r1225, %r2025, 0;
		bar.sync	0;
	@%r1225	bra.uni	$L96;
	@%r2020	bra.uni	$L111;
	@%r2021	bra	$L112;
		ld.u64	%r1226, [%r1220+32];
		ld.u32	%r29, [%r1226];
		ld.u64	%r1227, [%r1220+40];
		ld.u32	%r31, [%r1227];
$L112:
$L111:
$L102:
	@%r2020	bra.uni	$L109;
	@%r2021	bra	$L110;
		add.u32	%r24, %r24, 1;
	// fork 2;
		cvta.shared.u64	%r2019, __oacc_bcast;
		st.u32	[%r2019], %r24;
		st.u32	[%r2019+4], %r29;
		st.u32	[%r2019+8], %r31;
		st.u32	[%r2019+12], %r32;
		st.u64	[%r2019+16], %r1220;
$L110:
$L109:
		bar.sync	0;
	// forked 2;
		cvta.shared.u64	%r2018, __oacc_bcast;
		ld.u32	%r24, [%r2018];
		ld.u32	%r29, [%r2018+4];
		ld.u32	%r31, [%r2018+8];
		ld.u32	%r32, [%r2018+12];
		ld.u64	%r1220, [%r2018+16];
	// fork 4;
	// forked 4;
		mov.u32	%r920, %tid.y;
		mov.u32	%r921, %tid.x;
		shl.b32	%r1228, %r920, 5;
		add.u32	%r35, %r1228, %r921;
		setp.le.s32	%r1229, %r29, %r35;
	@%r1229	bra	$L98;
		ld.u64	%r36, [%r1220+56];
		ld.u64	%r38, [%r1220+16];
		setp.le.s32	%r1230, %r31, 1;
	@%r1230	bra	$L98;
		mov.u32	%r1190, %r35;
		cvt.s64.s32	%r1192, %r1190;
		add.u64	%r1231, %r1192, 1;
		mov.u32	%r1234, 1304;
		mul.wide.s32	%r1233, %r24, %r1234;
		mad.lo.u64	%r1235, %r1231, 212552, %r1233;
		add.u64	%r1191, %r36, %r1235;
		cvt.s64.s32	%r1236, %r24;
		shl.b64	%r1238, %r1236, 2;
		add.u64	%r1239, %r1238, %r1236;
		shl.b64	%r1240, %r1239, 5;
		add.u64	%r1241, %r1240, %r1236;
		add.u64	%r1242, %r1241, 25922;
		add.u64	%r1243, %r1242, %r1192;
		shl.b64	%r1244, %r1243, 3;
		add.u64	%r1199, %r38, %r1244;
$L100:
		mov.u64	%r924, %r1199;
		mov.u64	%r901, %r1191;
		mov.u32	%r86, 1;
		bra	$L99;
$L106:
		add.u32	%r1190, %r1190, 128;
		add.u64	%r1191, %r1191, 27206656;
		add.u64	%r1199, %r1199, 1024;
		setp.gt.s32	%r1245, %r29, %r1190;
	@%r1245	bra	$L100;
		bra	$L98;
$L99:
		ld.f64	%r40, [%r901];
		ld.f64	%r1247, [%r924];
		neg.f64	%r1246, %r1247;
		ld.f64	%r1248, [%r901+8];
		fma.rn.f64	%r41, %r1246, %r40, %r1248;
		ld.f64	%r43, [%r901+34433424];
		ld.f64	%r1250, [%r924+100780848];
		neg.f64	%r1249, %r1250;
		fma.rn.f64	%r44, %r1249, %r43, %r41;
		ld.f64	%r46, [%r901+68866848];
		ld.f64	%r1252, [%r924+201561696];
		neg.f64	%r1251, %r1252;
		fma.rn.f64	%r47, %r1251, %r46, %r44;
		ld.f64	%r49, [%r901+103300272];
		ld.f64	%r1254, [%r924+302342544];
		neg.f64	%r1253, %r1254;
		fma.rn.f64	%r50, %r1253, %r49, %r47;
		ld.f64	%r52, [%r901+137733696];
		ld.f64	%r1256, [%r924+403123392];
		neg.f64	%r1255, %r1256;
		fma.rn.f64	%r53, %r1255, %r52, %r50;
		st.f64	[%r901+8], %r53;
		neg.f64	%r1257, %r40;
		ld.f64	%r1258, [%r924+503904240];
		ld.f64	%r1259, [%r901+34433432];
		fma.rn.f64	%r57, %r1257, %r1258, %r1259;
		neg.f64	%r1260, %r43;
		ld.f64	%r1261, [%r924+604685088];
		fma.rn.f64	%r60, %r1260, %r1261, %r57;
		neg.f64	%r1262, %r46;
		ld.f64	%r1263, [%r924+705465936];
		fma.rn.f64	%r63, %r1262, %r1263, %r60;
		neg.f64	%r1264, %r49;
		ld.f64	%r1265, [%r924+806246784];
		fma.rn.f64	%r66, %r1264, %r1265, %r63;
		neg.f64	%r1266, %r52;
		ld.f64	%r1267, [%r924+907027632];
		fma.rn.f64	%r69, %r1266, %r1267, %r66;
		st.f64	[%r901+34433432], %r69;
		ld.f64	%r1269, [%r924+1007808480];
		ld.f64	%r1270, [%r901+68866856];
		fma.rn.f64	%r73, %r1257, %r1269, %r1270;
		ld.f64	%r1272, [%r924+1108589328];
		fma.rn.f64	%r76, %r1260, %r1272, %r73;
		ld.f64	%r1274, [%r924+1209370176];
		fma.rn.f64	%r79, %r1262, %r1274, %r76;
		ld.f64	%r1276, [%r924+1310151024];
		fma.rn.f64	%r81, %r1264, %r1276, %r79;
		ld.f64	%r1278, [%r924+1410931872];
		fma.rn.f64	%r83, %r1266, %r1278, %r81;
		st.f64	[%r901+68866856], %r83;
		ld.f64	%r1280, [%r924+1511712720];
		ld.f64	%r1281, [%r901+103300280];
		fma.rn.f64	%r87, %r1257, %r1280, %r1281;
		ld.f64	%r1283, [%r924+1612493568];
		fma.rn.f64	%r89, %r1260, %r1283, %r87;
		ld.f64	%r1285, [%r924+1713274416];
		fma.rn.f64	%r92, %r1262, %r1285, %r89;
		ld.f64	%r1287, [%r924+1814055264];
		fma.rn.f64	%r94, %r1264, %r1287, %r92;
		ld.f64	%r1289, [%r924+1914836112];
		fma.rn.f64	%r96, %r1266, %r1289, %r94;
		st.f64	[%r901+103300280], %r96;
		ld.f64	%r1291, [%r924+2015616960];
		ld.f64	%r1292, [%r901+137733704];
		fma.rn.f64	%r99, %r1257, %r1291, %r1292;
		ld.f64	%r1294, [%r924+2116397808];
		fma.rn.f64	%r101, %r1260, %r1294, %r99;
		ld.f64	%r1296, [%r924+2217178656];
		fma.rn.f64	%r103, %r1262, %r1296, %r101;
		ld.f64	%r1298, [%r924+2317959504];
		fma.rn.f64	%r106, %r1264, %r1298, %r103;
		ld.f64	%r1300, [%r924+2418740352];
		fma.rn.f64	%r108, %r1266, %r1300, %r106;
		st.f64	[%r901+137733704], %r108;
		ld.f64	%r110, [%r924];
		ld.f64	%r111, [%r924+66979864];
		neg.f64	%r1301, %r110;
		ld.f64	%r1302, [%r924+33593616];
		fma.rn.f64	%r112, %r1301, %r111, %r1302;
		ld.f64	%r113, [%r924+100780848];
		ld.f64	%r114, [%r924+570884104];
		neg.f64	%r1303, %r113;
		fma.rn.f64	%r115, %r1303, %r114, %r112;
		ld.f64	%r116, [%r924+201561696];
		ld.f64	%r117, [%r924+1074788344];
		neg.f64	%r1304, %r116;
		fma.rn.f64	%r118, %r1304, %r117, %r115;
		ld.f64	%r119, [%r924+302342544];
		ld.f64	%r120, [%r924+1578692584];
		neg.f64	%r1305, %r119;
		fma.rn.f64	%r121, %r1305, %r120, %r118;
		ld.f64	%r122, [%r924+403123392];
		ld.f64	%r123, [%r924+2082596824];
		neg.f64	%r1306, %r122;
		fma.rn.f64	%r124, %r1306, %r123, %r121;
		st.f64	[%r924+33593616], %r124;
		ld.f64	%r126, [%r924+503904240];
		neg.f64	%r1307, %r111;
		ld.f64	%r1308, [%r924+537497856];
		fma.rn.f64	%r127, %r1307, %r126, %r1308;
		ld.f64	%r128, [%r924+604685088];
		neg.f64	%r1309, %r114;
		fma.rn.f64	%r129, %r1309, %r128, %r127;
		ld.f64	%r130, [%r924+705465936];
		neg.f64	%r1310, %r117;
		fma.rn.f64	%r131, %r1310, %r130, %r129;
		ld.f64	%r132, [%r924+806246784];
		neg.f64	%r1311, %r120;
		fma.rn.f64	%r133, %r1311, %r132, %r131;
		ld.f64	%r134, [%r924+907027632];
		neg.f64	%r1312, %r123;
		fma.rn.f64	%r135, %r1312, %r134, %r133;
		st.f64	[%r924+537497856], %r135;
		ld.f64	%r137, [%r924+1007808480];
		ld.f64	%r1314, [%r924+1041402096];
		fma.rn.f64	%r138, %r1307, %r137, %r1314;
		ld.f64	%r139, [%r924+1108589328];
		fma.rn.f64	%r140, %r1309, %r139, %r138;
		ld.f64	%r141, [%r924+1209370176];
		fma.rn.f64	%r142, %r1310, %r141, %r140;
		ld.f64	%r143, [%r924+1310151024];
		fma.rn.f64	%r144, %r1311, %r143, %r142;
		ld.f64	%r145, [%r924+1410931872];
		fma.rn.f64	%r146, %r1312, %r145, %r144;
		st.f64	[%r924+1041402096], %r146;
		ld.f64	%r148, [%r924+1511712720];
		ld.f64	%r1320, [%r924+1545306336];
		fma.rn.f64	%r149, %r1307, %r148, %r1320;
		ld.f64	%r150, [%r924+1612493568];
		fma.rn.f64	%r151, %r1309, %r150, %r149;
		ld.f64	%r152, [%r924+1713274416];
		fma.rn.f64	%r153, %r1310, %r152, %r151;
		ld.f64	%r154, [%r924+1814055264];
		fma.rn.f64	%r155, %r1311, %r154, %r153;
		ld.f64	%r156, [%r924+1914836112];
		fma.rn.f64	%r157, %r1312, %r156, %r155;
		st.f64	[%r924+1545306336], %r157;
		ld.f64	%r159, [%r924+2015616960];
		ld.f64	%r1326, [%r924+2049210576];
		fma.rn.f64	%r160, %r1307, %r159, %r1326;
		ld.f64	%r161, [%r924+2116397808];
		fma.rn.f64	%r162, %r1309, %r161, %r160;
		ld.f64	%r163, [%r924+2217178656];
		fma.rn.f64	%r164, %r1310, %r163, %r162;
		ld.f64	%r165, [%r924+2317959504];
		fma.rn.f64	%r166, %r1311, %r165, %r164;
		ld.f64	%r167, [%r924+2418740352];
		fma.rn.f64	%r168, %r1312, %r167, %r166;
		st.f64	[%r924+2049210576], %r168;
		ld.f64	%r170, [%r924+167760712];
		ld.f64	%r1332, [%r924+134374464];
		fma.rn.f64	%r171, %r1301, %r170, %r1332;
		ld.f64	%r172, [%r924+671664952];
		fma.rn.f64	%r173, %r1303, %r172, %r171;
		ld.f64	%r174, [%r924+1175569192];
		fma.rn.f64	%r175, %r1304, %r174, %r173;
		ld.f64	%r176, [%r924+1679473432];
		fma.rn.f64	%r177, %r1305, %r176, %r175;
		ld.f64	%r178, [%r924+2183377672];
		fma.rn.f64	%r179, %r1306, %r178, %r177;
		neg.f64	%r1337, %r126;
		ld.f64	%r1338, [%r924+638278704];
		fma.rn.f64	%r181, %r1337, %r170, %r1338;
		neg.f64	%r1339, %r128;
		fma.rn.f64	%r182, %r1339, %r172, %r181;
		neg.f64	%r1340, %r130;
		fma.rn.f64	%r183, %r1340, %r174, %r182;
		neg.f64	%r1341, %r132;
		fma.rn.f64	%r184, %r1341, %r176, %r183;
		neg.f64	%r1342, %r134;
		fma.rn.f64	%r185, %r1342, %r178, %r184;
		st.f64	[%r924+638278704], %r185;
		neg.f64	%r1343, %r137;
		ld.f64	%r1344, [%r924+1142182944];
		fma.rn.f64	%r187, %r1343, %r170, %r1344;
		neg.f64	%r1345, %r139;
		fma.rn.f64	%r188, %r1345, %r172, %r187;
		neg.f64	%r1346, %r141;
		fma.rn.f64	%r189, %r1346, %r174, %r188;
		neg.f64	%r1347, %r143;
		fma.rn.f64	%r190, %r1347, %r176, %r189;
		neg.f64	%r1348, %r145;
		fma.rn.f64	%r191, %r1348, %r178, %r190;
		st.f64	[%r924+1142182944], %r191;
		neg.f64	%r1349, %r148;
		ld.f64	%r1350, [%r924+1646087184];
		fma.rn.f64	%r193, %r1349, %r170, %r1350;
		neg.f64	%r1351, %r150;
		fma.rn.f64	%r194, %r1351, %r172, %r193;
		neg.f64	%r1352, %r152;
		fma.rn.f64	%r195, %r1352, %r174, %r194;
		neg.f64	%r1353, %r154;
		fma.rn.f64	%r196, %r1353, %r176, %r195;
		neg.f64	%r1354, %r156;
		fma.rn.f64	%r197, %r1354, %r178, %r196;
		st.f64	[%r924+1646087184], %r197;
		neg.f64	%r1355, %r159;
		ld.f64	%r1356, [%r924+2149991424];
		fma.rn.f64	%r199, %r1355, %r170, %r1356;
		neg.f64	%r1357, %r161;
		fma.rn.f64	%r200, %r1357, %r172, %r199;
		neg.f64	%r1358, %r163;
		fma.rn.f64	%r201, %r1358, %r174, %r200;
		neg.f64	%r1359, %r165;
		fma.rn.f64	%r202, %r1359, %r176, %r201;
		neg.f64	%r1360, %r167;
		fma.rn.f64	%r203, %r1360, %r178, %r202;
		st.f64	[%r924+2149991424], %r203;
		ld.f64	%r205, [%r924+268541560];
		ld.f64	%r1362, [%r924+235155312];
		fma.rn.f64	%r206, %r1301, %r205, %r1362;
		ld.f64	%r207, [%r924+772445800];
		fma.rn.f64	%r208, %r1303, %r207, %r206;
		ld.f64	%r209, [%r924+1276350040];
		fma.rn.f64	%r210, %r1304, %r209, %r208;
		ld.f64	%r211, [%r924+1780254280];
		fma.rn.f64	%r212, %r1305, %r211, %r210;
		ld.f64	%r213, [%r924+2284158520];
		fma.rn.f64	%r214, %r1306, %r213, %r212;
		ld.f64	%r1368, [%r924+739059552];
		fma.rn.f64	%r216, %r1337, %r205, %r1368;
		fma.rn.f64	%r217, %r1339, %r207, %r216;
		fma.rn.f64	%r218, %r1340, %r209, %r217;
		fma.rn.f64	%r219, %r1341, %r211, %r218;
		fma.rn.f64	%r220, %r1342, %r213, %r219;
		st.f64	[%r924+739059552], %r220;
		ld.f64	%r1374, [%r924+1242963792];
		fma.rn.f64	%r222, %r1343, %r205, %r1374;
		fma.rn.f64	%r223, %r1345, %r207, %r222;
		fma.rn.f64	%r224, %r1346, %r209, %r223;
		fma.rn.f64	%r225, %r1347, %r211, %r224;
		fma.rn.f64	%r226, %r1348, %r213, %r225;
		st.f64	[%r924+1242963792], %r226;
		ld.f64	%r1380, [%r924+1746868032];
		fma.rn.f64	%r228, %r1349, %r205, %r1380;
		fma.rn.f64	%r229, %r1351, %r207, %r228;
		fma.rn.f64	%r230, %r1352, %r209, %r229;
		fma.rn.f64	%r231, %r1353, %r211, %r230;
		fma.rn.f64	%r232, %r1354, %r213, %r231;
		st.f64	[%r924+1746868032], %r232;
		ld.f64	%r1386, [%r924+2250772272];
		fma.rn.f64	%r234, %r1355, %r205, %r1386;
		fma.rn.f64	%r235, %r1357, %r207, %r234;
		fma.rn.f64	%r236, %r1358, %r209, %r235;
		fma.rn.f64	%r237, %r1359, %r211, %r236;
		fma.rn.f64	%r238, %r1360, %r213, %r237;
		st.f64	[%r924+2250772272], %r238;
		ld.f64	%r240, [%r924+369322408];
		ld.f64	%r1392, [%r924+335936160];
		fma.rn.f64	%r241, %r1301, %r240, %r1392;
		ld.f64	%r242, [%r924+873226648];
		fma.rn.f64	%r243, %r1303, %r242, %r241;
		ld.f64	%r244, [%r924+1377130888];
		fma.rn.f64	%r245, %r1304, %r244, %r243;
		ld.f64	%r246, [%r924+1881035128];
		fma.rn.f64	%r247, %r1305, %r246, %r245;
		ld.f64	%r248, [%r924+2384939368];
		fma.rn.f64	%r249, %r1306, %r248, %r247;
		ld.f64	%r1398, [%r924+839840400];
		fma.rn.f64	%r251, %r1337, %r240, %r1398;
		fma.rn.f64	%r252, %r1339, %r242, %r251;
		fma.rn.f64	%r253, %r1340, %r244, %r252;
		fma.rn.f64	%r254, %r1341, %r246, %r253;
		fma.rn.f64	%r255, %r1342, %r248, %r254;
		st.f64	[%r924+839840400], %r255;
		ld.f64	%r1404, [%r924+1343744640];
		fma.rn.f64	%r257, %r1343, %r240, %r1404;
		fma.rn.f64	%r258, %r1345, %r242, %r257;
		fma.rn.f64	%r259, %r1346, %r244, %r258;
		fma.rn.f64	%r260, %r1347, %r246, %r259;
		fma.rn.f64	%r261, %r1348, %r248, %r260;
		st.f64	[%r924+1343744640], %r261;
		ld.f64	%r1410, [%r924+1847648880];
		fma.rn.f64	%r263, %r1349, %r240, %r1410;
		fma.rn.f64	%r264, %r1351, %r242, %r263;
		fma.rn.f64	%r265, %r1352, %r244, %r264;
		fma.rn.f64	%r266, %r1353, %r246, %r265;
		fma.rn.f64	%r267, %r1354, %r248, %r266;
		st.f64	[%r924+1847648880], %r267;
		ld.f64	%r1416, [%r924+2351553120];
		fma.rn.f64	%r269, %r1355, %r240, %r1416;
		fma.rn.f64	%r270, %r1357, %r242, %r269;
		fma.rn.f64	%r271, %r1358, %r244, %r270;
		fma.rn.f64	%r272, %r1359, %r246, %r271;
		fma.rn.f64	%r273, %r1360, %r248, %r272;
		st.f64	[%r924+2351553120], %r273;
		ld.f64	%r275, [%r924+470103256];
		ld.f64	%r1422, [%r924+436717008];
		fma.rn.f64	%r276, %r1301, %r275, %r1422;
		ld.f64	%r277, [%r924+974007496];
		fma.rn.f64	%r278, %r1303, %r277, %r276;
		ld.f64	%r279, [%r924+1477911736];
		fma.rn.f64	%r280, %r1304, %r279, %r278;
		ld.f64	%r281, [%r924+1981815976];
		fma.rn.f64	%r282, %r1305, %r281, %r280;
		ld.f64	%r283, [%r924+2485720216];
		fma.rn.f64	%r284, %r1306, %r283, %r282;
		ld.f64	%r1428, [%r924+940621248];
		fma.rn.f64	%r286, %r1337, %r275, %r1428;
		fma.rn.f64	%r287, %r1339, %r277, %r286;
		fma.rn.f64	%r288, %r1340, %r279, %r287;
		fma.rn.f64	%r289, %r1341, %r281, %r288;
		fma.rn.f64	%r290, %r1342, %r283, %r289;
		st.f64	[%r924+940621248], %r290;
		ld.f64	%r1434, [%r924+1444525488];
		fma.rn.f64	%r292, %r1343, %r275, %r1434;
		fma.rn.f64	%r293, %r1345, %r277, %r292;
		fma.rn.f64	%r294, %r1346, %r279, %r293;
		fma.rn.f64	%r295, %r1347, %r281, %r294;
		fma.rn.f64	%r296, %r1348, %r283, %r295;
		st.f64	[%r924+1444525488], %r296;
		ld.f64	%r1440, [%r924+1948429728];
		fma.rn.f64	%r298, %r1349, %r275, %r1440;
		fma.rn.f64	%r299, %r1351, %r277, %r298;
		fma.rn.f64	%r300, %r1352, %r279, %r299;
		fma.rn.f64	%r301, %r1353, %r281, %r300;
		fma.rn.f64	%r302, %r1354, %r283, %r301;
		st.f64	[%r924+1948429728], %r302;
		ld.f64	%r1446, [%r924+2452333968];
		fma.rn.f64	%r304, %r1355, %r275, %r1446;
		fma.rn.f64	%r305, %r1357, %r277, %r304;
		fma.rn.f64	%r306, %r1358, %r279, %r305;
		fma.rn.f64	%r307, %r1359, %r281, %r306;
		fma.rn.f64	%r308, %r1360, %r283, %r307;
		st.f64	[%r924+2452333968], %r308;
		mov.f64	%r1451, 0d3ff0000000000000;
		div.rn.f64	%r309, %r1451, %r124;
		mul.f64	%r1452, %r179, %r309;
		st.f64	[%r924+134374464], %r1452;
		mul.f64	%r1453, %r214, %r309;
		st.f64	[%r924+235155312], %r1453;
		mul.f64	%r1454, %r249, %r309;
		st.f64	[%r924+335936160], %r1454;
		mul.f64	%r1455, %r284, %r309;
		st.f64	[%r924+436717008], %r1455;
		ld.f64	%r1457, [%r924+67187232];
		mul.f64	%r1456, %r1457, %r309;
		st.f64	[%r924+67187232], %r1456;
		ld.f64	%r1459, [%r924+167968080];
		mul.f64	%r1458, %r1459, %r309;
		st.f64	[%r924+167968080], %r1458;
		ld.f64	%r1461, [%r924+268748928];
		mul.f64	%r1460, %r1461, %r309;
		st.f64	[%r924+268748928], %r1460;
		ld.f64	%r1463, [%r924+369529776];
		mul.f64	%r1462, %r1463, %r309;
		st.f64	[%r924+369529776], %r1462;
		ld.f64	%r1465, [%r924+470310624];
		mul.f64	%r1464, %r1465, %r309;
		st.f64	[%r924+470310624], %r1464;
		ld.f64	%r1467, [%r901+8];
		mul.f64	%r1466, %r1467, %r309;
		st.f64	[%r901+8], %r1466;
		ld.f64	%r327, [%r924+537497856];
		neg.f64	%r1468, %r327;
		ld.f64	%r1469, [%r924+134374464];
		ld.f64	%r1470, [%r924+638278704];
		fma.rn.f64	%r330, %r1468, %r1469, %r1470;
		st.f64	[%r924+638278704], %r330;
		ld.f64	%r1472, [%r924+235155312];
		ld.f64	%r1473, [%r924+739059552];
		fma.rn.f64	%r333, %r1468, %r1472, %r1473;
		st.f64	[%r924+739059552], %r333;
		ld.f64	%r1475, [%r924+335936160];
		ld.f64	%r1476, [%r924+839840400];
		fma.rn.f64	%r336, %r1468, %r1475, %r1476;
		st.f64	[%r924+839840400], %r336;
		ld.f64	%r1478, [%r924+436717008];
		ld.f64	%r1479, [%r924+940621248];
		fma.rn.f64	%r339, %r1468, %r1478, %r1479;
		st.f64	[%r924+940621248], %r339;
		ld.f64	%r1481, [%r924+67187232];
		ld.f64	%r1482, [%r924+571091472];
		fma.rn.f64	%r342, %r1468, %r1481, %r1482;
		st.f64	[%r924+571091472], %r342;
		ld.f64	%r1484, [%r924+167968080];
		ld.f64	%r1485, [%r924+671872320];
		fma.rn.f64	%r345, %r1468, %r1484, %r1485;
		st.f64	[%r924+671872320], %r345;
		ld.f64	%r1487, [%r924+268748928];
		ld.f64	%r1488, [%r924+772653168];
		fma.rn.f64	%r348, %r1468, %r1487, %r1488;
		st.f64	[%r924+772653168], %r348;
		ld.f64	%r1490, [%r924+369529776];
		ld.f64	%r1491, [%r924+873434016];
		fma.rn.f64	%r351, %r1468, %r1490, %r1491;
		st.f64	[%r924+873434016], %r351;
		ld.f64	%r1493, [%r924+470310624];
		ld.f64	%r1494, [%r924+974214864];
		fma.rn.f64	%r354, %r1468, %r1493, %r1494;
		st.f64	[%r924+974214864], %r354;
		ld.f64	%r1496, [%r901+8];
		ld.f64	%r1497, [%r901+34433432];
		fma.rn.f64	%r357, %r1468, %r1496, %r1497;
		st.f64	[%r901+34433432], %r357;
		ld.f64	%r358, [%r924+1041402096];
		neg.f64	%r1498, %r358;
		ld.f64	%r1499, [%r924+134374464];
		ld.f64	%r1500, [%r924+1142182944];
		fma.rn.f64	%r361, %r1498, %r1499, %r1500;
		st.f64	[%r924+1142182944], %r361;
		ld.f64	%r1502, [%r924+235155312];
		ld.f64	%r1503, [%r924+1242963792];
		fma.rn.f64	%r364, %r1498, %r1502, %r1503;
		st.f64	[%r924+1242963792], %r364;
		ld.f64	%r1505, [%r924+335936160];
		ld.f64	%r1506, [%r924+1343744640];
		fma.rn.f64	%r367, %r1498, %r1505, %r1506;
		st.f64	[%r924+1343744640], %r367;
		ld.f64	%r1508, [%r924+436717008];
		ld.f64	%r1509, [%r924+1444525488];
		fma.rn.f64	%r370, %r1498, %r1508, %r1509;
		st.f64	[%r924+1444525488], %r370;
		ld.f64	%r1511, [%r924+67187232];
		ld.f64	%r1512, [%r924+1074995712];
		fma.rn.f64	%r373, %r1498, %r1511, %r1512;
		st.f64	[%r924+1074995712], %r373;
		ld.f64	%r1514, [%r924+167968080];
		ld.f64	%r1515, [%r924+1175776560];
		fma.rn.f64	%r376, %r1498, %r1514, %r1515;
		st.f64	[%r924+1175776560], %r376;
		ld.f64	%r1517, [%r924+268748928];
		ld.f64	%r1518, [%r924+1276557408];
		fma.rn.f64	%r379, %r1498, %r1517, %r1518;
		st.f64	[%r924+1276557408], %r379;
		ld.f64	%r1520, [%r924+369529776];
		ld.f64	%r1521, [%r924+1377338256];
		fma.rn.f64	%r382, %r1498, %r1520, %r1521;
		st.f64	[%r924+1377338256], %r382;
		ld.f64	%r1523, [%r924+470310624];
		ld.f64	%r1524, [%r924+1478119104];
		fma.rn.f64	%r385, %r1498, %r1523, %r1524;
		st.f64	[%r924+1478119104], %r385;
		ld.f64	%r1526, [%r901+8];
		ld.f64	%r1527, [%r901+68866856];
		fma.rn.f64	%r388, %r1498, %r1526, %r1527;
		st.f64	[%r901+68866856], %r388;
		ld.f64	%r389, [%r924+1545306336];
		neg.f64	%r1528, %r389;
		ld.f64	%r1529, [%r924+134374464];
		ld.f64	%r1530, [%r924+1646087184];
		fma.rn.f64	%r392, %r1528, %r1529, %r1530;
		st.f64	[%r924+1646087184], %r392;
		ld.f64	%r1532, [%r924+235155312];
		ld.f64	%r1533, [%r924+1746868032];
		fma.rn.f64	%r395, %r1528, %r1532, %r1533;
		st.f64	[%r924+1746868032], %r395;
		ld.f64	%r1535, [%r924+335936160];
		ld.f64	%r1536, [%r924+1847648880];
		fma.rn.f64	%r398, %r1528, %r1535, %r1536;
		st.f64	[%r924+1847648880], %r398;
		ld.f64	%r1538, [%r924+436717008];
		ld.f64	%r1539, [%r924+1948429728];
		fma.rn.f64	%r401, %r1528, %r1538, %r1539;
		st.f64	[%r924+1948429728], %r401;
		ld.f64	%r1541, [%r924+67187232];
		ld.f64	%r1542, [%r924+1578899952];
		fma.rn.f64	%r404, %r1528, %r1541, %r1542;
		st.f64	[%r924+1578899952], %r404;
		ld.f64	%r1544, [%r924+167968080];
		ld.f64	%r1545, [%r924+1679680800];
		fma.rn.f64	%r407, %r1528, %r1544, %r1545;
		st.f64	[%r924+1679680800], %r407;
		ld.f64	%r1547, [%r924+268748928];
		ld.f64	%r1548, [%r924+1780461648];
		fma.rn.f64	%r410, %r1528, %r1547, %r1548;
		st.f64	[%r924+1780461648], %r410;
		ld.f64	%r1550, [%r924+369529776];
		ld.f64	%r1551, [%r924+1881242496];
		fma.rn.f64	%r413, %r1528, %r1550, %r1551;
		st.f64	[%r924+1881242496], %r413;
		ld.f64	%r1553, [%r924+470310624];
		ld.f64	%r1554, [%r924+1982023344];
		fma.rn.f64	%r416, %r1528, %r1553, %r1554;
		st.f64	[%r924+1982023344], %r416;
		ld.f64	%r1556, [%r901+8];
		ld.f64	%r1557, [%r901+103300280];
		fma.rn.f64	%r419, %r1528, %r1556, %r1557;
		st.f64	[%r901+103300280], %r419;
		ld.f64	%r420, [%r924+2049210576];
		neg.f64	%r1558, %r420;
		ld.f64	%r1559, [%r924+134374464];
		ld.f64	%r1560, [%r924+2149991424];
		fma.rn.f64	%r423, %r1558, %r1559, %r1560;
		st.f64	[%r924+2149991424], %r423;
		ld.f64	%r1562, [%r924+235155312];
		ld.f64	%r1563, [%r924+2250772272];
		fma.rn.f64	%r426, %r1558, %r1562, %r1563;
		st.f64	[%r924+2250772272], %r426;
		ld.f64	%r1565, [%r924+335936160];
		ld.f64	%r1566, [%r924+2351553120];
		fma.rn.f64	%r429, %r1558, %r1565, %r1566;
		st.f64	[%r924+2351553120], %r429;
		ld.f64	%r1568, [%r924+436717008];
		ld.f64	%r1569, [%r924+2452333968];
		fma.rn.f64	%r432, %r1558, %r1568, %r1569;
		st.f64	[%r924+2452333968], %r432;
		ld.f64	%r1571, [%r924+67187232];
		ld.f64	%r1572, [%r924+2082804192];
		fma.rn.f64	%r435, %r1558, %r1571, %r1572;
		st.f64	[%r924+2082804192], %r435;
		ld.f64	%r1574, [%r924+167968080];
		ld.f64	%r1575, [%r924+2183585040];
		fma.rn.f64	%r438, %r1558, %r1574, %r1575;
		st.f64	[%r924+2183585040], %r438;
		ld.f64	%r1577, [%r924+268748928];
		ld.f64	%r1578, [%r924+2284365888];
		fma.rn.f64	%r441, %r1558, %r1577, %r1578;
		st.f64	[%r924+2284365888], %r441;
		ld.f64	%r1580, [%r924+369529776];
		ld.f64	%r1581, [%r924+2385146736];
		fma.rn.f64	%r444, %r1558, %r1580, %r1581;
		st.f64	[%r924+2385146736], %r444;
		ld.f64	%r1583, [%r924+470310624];
		ld.f64	%r1584, [%r924+2485927584];
		fma.rn.f64	%r447, %r1558, %r1583, %r1584;
		st.f64	[%r924+2485927584], %r447;
		ld.f64	%r1586, [%r901+8];
		ld.f64	%r1587, [%r901+137733704];
		fma.rn.f64	%r450, %r1558, %r1586, %r1587;
		st.f64	[%r901+137733704], %r450;
		ld.f64	%r1589, [%r924+638278704];
		div.rn.f64	%r452, %r1451, %r1589;
		ld.f64	%r1591, [%r924+739059552];
		mul.f64	%r1590, %r1591, %r452;
		st.f64	[%r924+739059552], %r1590;
		ld.f64	%r1593, [%r924+839840400];
		mul.f64	%r1592, %r1593, %r452;
		st.f64	[%r924+839840400], %r1592;
		ld.f64	%r1595, [%r924+940621248];
		mul.f64	%r1594, %r1595, %r452;
		st.f64	[%r924+940621248], %r1594;
		ld.f64	%r1597, [%r924+571091472];
		mul.f64	%r1596, %r1597, %r452;
		st.f64	[%r924+571091472], %r1596;
		ld.f64	%r1599, [%r924+671872320];
		mul.f64	%r1598, %r1599, %r452;
		st.f64	[%r924+671872320], %r1598;
		ld.f64	%r1601, [%r924+772653168];
		mul.f64	%r1600, %r1601, %r452;
		st.f64	[%r924+772653168], %r1600;
		ld.f64	%r1603, [%r924+873434016];
		mul.f64	%r1602, %r1603, %r452;
		st.f64	[%r924+873434016], %r1602;
		ld.f64	%r1605, [%r924+974214864];
		mul.f64	%r1604, %r1605, %r452;
		st.f64	[%r924+974214864], %r1604;
		ld.f64	%r1607, [%r901+34433432];
		mul.f64	%r1606, %r1607, %r452;
		st.f64	[%r901+34433432], %r1606;
		ld.f64	%r471, [%r924+134374464];
		neg.f64	%r1608, %r471;
		ld.f64	%r1609, [%r924+739059552];
		ld.f64	%r1610, [%r924+235155312];
		fma.rn.f64	%r474, %r1608, %r1609, %r1610;
		st.f64	[%r924+235155312], %r474;
		ld.f64	%r1612, [%r924+839840400];
		ld.f64	%r1613, [%r924+335936160];
		fma.rn.f64	%r477, %r1608, %r1612, %r1613;
		st.f64	[%r924+335936160], %r477;
		ld.f64	%r1615, [%r924+940621248];
		ld.f64	%r1616, [%r924+436717008];
		fma.rn.f64	%r480, %r1608, %r1615, %r1616;
		st.f64	[%r924+436717008], %r480;
		ld.f64	%r1618, [%r924+571091472];
		ld.f64	%r1619, [%r924+67187232];
		fma.rn.f64	%r483, %r1608, %r1618, %r1619;
		st.f64	[%r924+67187232], %r483;
		ld.f64	%r1621, [%r924+671872320];
		ld.f64	%r1622, [%r924+167968080];
		fma.rn.f64	%r486, %r1608, %r1621, %r1622;
		st.f64	[%r924+167968080], %r486;
		ld.f64	%r1624, [%r924+772653168];
		ld.f64	%r1625, [%r924+268748928];
		fma.rn.f64	%r489, %r1608, %r1624, %r1625;
		st.f64	[%r924+268748928], %r489;
		ld.f64	%r1627, [%r924+873434016];
		ld.f64	%r1628, [%r924+369529776];
		fma.rn.f64	%r492, %r1608, %r1627, %r1628;
		st.f64	[%r924+369529776], %r492;
		ld.f64	%r1630, [%r924+974214864];
		ld.f64	%r1631, [%r924+470310624];
		fma.rn.f64	%r495, %r1608, %r1630, %r1631;
		st.f64	[%r924+470310624], %r495;
		ld.f64	%r1633, [%r901+34433432];
		ld.f64	%r1634, [%r901+8];
		fma.rn.f64	%r498, %r1608, %r1633, %r1634;
		st.f64	[%r901+8], %r498;
		ld.f64	%r499, [%r924+1142182944];
		neg.f64	%r1635, %r499;
		ld.f64	%r1636, [%r924+739059552];
		ld.f64	%r1637, [%r924+1242963792];
		fma.rn.f64	%r502, %r1635, %r1636, %r1637;
		st.f64	[%r924+1242963792], %r502;
		ld.f64	%r1639, [%r924+839840400];
		ld.f64	%r1640, [%r924+1343744640];
		fma.rn.f64	%r505, %r1635, %r1639, %r1640;
		st.f64	[%r924+1343744640], %r505;
		ld.f64	%r1642, [%r924+940621248];
		ld.f64	%r1643, [%r924+1444525488];
		fma.rn.f64	%r508, %r1635, %r1642, %r1643;
		st.f64	[%r924+1444525488], %r508;
		ld.f64	%r1645, [%r924+571091472];
		ld.f64	%r1646, [%r924+1074995712];
		fma.rn.f64	%r511, %r1635, %r1645, %r1646;
		st.f64	[%r924+1074995712], %r511;
		ld.f64	%r1648, [%r924+671872320];
		ld.f64	%r1649, [%r924+1175776560];
		fma.rn.f64	%r514, %r1635, %r1648, %r1649;
		st.f64	[%r924+1175776560], %r514;
		ld.f64	%r1651, [%r924+772653168];
		ld.f64	%r1652, [%r924+1276557408];
		fma.rn.f64	%r517, %r1635, %r1651, %r1652;
		st.f64	[%r924+1276557408], %r517;
		ld.f64	%r1654, [%r924+873434016];
		ld.f64	%r1655, [%r924+1377338256];
		fma.rn.f64	%r520, %r1635, %r1654, %r1655;
		st.f64	[%r924+1377338256], %r520;
		ld.f64	%r1657, [%r924+974214864];
		ld.f64	%r1658, [%r924+1478119104];
		fma.rn.f64	%r523, %r1635, %r1657, %r1658;
		st.f64	[%r924+1478119104], %r523;
		ld.f64	%r1660, [%r901+34433432];
		ld.f64	%r1661, [%r901+68866856];
		fma.rn.f64	%r526, %r1635, %r1660, %r1661;
		st.f64	[%r901+68866856], %r526;
		ld.f64	%r527, [%r924+1646087184];
		neg.f64	%r1662, %r527;
		ld.f64	%r1663, [%r924+739059552];
		ld.f64	%r1664, [%r924+1746868032];
		fma.rn.f64	%r530, %r1662, %r1663, %r1664;
		st.f64	[%r924+1746868032], %r530;
		ld.f64	%r1666, [%r924+839840400];
		ld.f64	%r1667, [%r924+1847648880];
		fma.rn.f64	%r533, %r1662, %r1666, %r1667;
		st.f64	[%r924+1847648880], %r533;
		ld.f64	%r1669, [%r924+940621248];
		ld.f64	%r1670, [%r924+1948429728];
		fma.rn.f64	%r536, %r1662, %r1669, %r1670;
		st.f64	[%r924+1948429728], %r536;
		ld.f64	%r1672, [%r924+571091472];
		ld.f64	%r1673, [%r924+1578899952];
		fma.rn.f64	%r539, %r1662, %r1672, %r1673;
		st.f64	[%r924+1578899952], %r539;
		ld.f64	%r1675, [%r924+671872320];
		ld.f64	%r1676, [%r924+1679680800];
		fma.rn.f64	%r542, %r1662, %r1675, %r1676;
		st.f64	[%r924+1679680800], %r542;
		ld.f64	%r1678, [%r924+772653168];
		ld.f64	%r1679, [%r924+1780461648];
		fma.rn.f64	%r545, %r1662, %r1678, %r1679;
		st.f64	[%r924+1780461648], %r545;
		ld.f64	%r1681, [%r924+873434016];
		ld.f64	%r1682, [%r924+1881242496];
		fma.rn.f64	%r548, %r1662, %r1681, %r1682;
		st.f64	[%r924+1881242496], %r548;
		ld.f64	%r1684, [%r924+974214864];
		ld.f64	%r1685, [%r924+1982023344];
		fma.rn.f64	%r551, %r1662, %r1684, %r1685;
		st.f64	[%r924+1982023344], %r551;
		ld.f64	%r1687, [%r901+34433432];
		ld.f64	%r1688, [%r901+103300280];
		fma.rn.f64	%r554, %r1662, %r1687, %r1688;
		st.f64	[%r901+103300280], %r554;
		ld.f64	%r555, [%r924+2149991424];
		neg.f64	%r1689, %r555;
		ld.f64	%r1690, [%r924+739059552];
		ld.f64	%r1691, [%r924+2250772272];
		fma.rn.f64	%r558, %r1689, %r1690, %r1691;
		st.f64	[%r924+2250772272], %r558;
		ld.f64	%r1693, [%r924+839840400];
		ld.f64	%r1694, [%r924+2351553120];
		fma.rn.f64	%r561, %r1689, %r1693, %r1694;
		st.f64	[%r924+2351553120], %r561;
		ld.f64	%r1696, [%r924+940621248];
		ld.f64	%r1697, [%r924+2452333968];
		fma.rn.f64	%r564, %r1689, %r1696, %r1697;
		st.f64	[%r924+2452333968], %r564;
		ld.f64	%r1699, [%r924+571091472];
		ld.f64	%r1700, [%r924+2082804192];
		fma.rn.f64	%r567, %r1689, %r1699, %r1700;
		st.f64	[%r924+2082804192], %r567;
		ld.f64	%r1702, [%r924+671872320];
		ld.f64	%r1703, [%r924+2183585040];
		fma.rn.f64	%r570, %r1689, %r1702, %r1703;
		st.f64	[%r924+2183585040], %r570;
		ld.f64	%r1705, [%r924+772653168];
		ld.f64	%r1706, [%r924+2284365888];
		fma.rn.f64	%r573, %r1689, %r1705, %r1706;
		st.f64	[%r924+2284365888], %r573;
		ld.f64	%r1708, [%r924+873434016];
		ld.f64	%r1709, [%r924+2385146736];
		fma.rn.f64	%r576, %r1689, %r1708, %r1709;
		st.f64	[%r924+2385146736], %r576;
		ld.f64	%r1711, [%r924+974214864];
		ld.f64	%r1712, [%r924+2485927584];
		fma.rn.f64	%r579, %r1689, %r1711, %r1712;
		st.f64	[%r924+2485927584], %r579;
		ld.f64	%r1714, [%r901+34433432];
		ld.f64	%r1715, [%r901+137733704];
		fma.rn.f64	%r582, %r1689, %r1714, %r1715;
		st.f64	[%r901+137733704], %r582;
		ld.f64	%r1717, [%r924+1242963792];
		div.rn.f64	%r584, %r1451, %r1717;
		ld.f64	%r1719, [%r924+1343744640];
		mul.f64	%r1718, %r1719, %r584;
		st.f64	[%r924+1343744640], %r1718;
		ld.f64	%r1721, [%r924+1444525488];
		mul.f64	%r1720, %r1721, %r584;
		st.f64	[%r924+1444525488], %r1720;
		ld.f64	%r1723, [%r924+1074995712];
		mul.f64	%r1722, %r1723, %r584;
		st.f64	[%r924+1074995712], %r1722;
		ld.f64	%r1725, [%r924+1175776560];
		mul.f64	%r1724, %r1725, %r584;
		st.f64	[%r924+1175776560], %r1724;
		ld.f64	%r1727, [%r924+1276557408];
		mul.f64	%r1726, %r1727, %r584;
		st.f64	[%r924+1276557408], %r1726;
		ld.f64	%r1729, [%r924+1377338256];
		mul.f64	%r1728, %r1729, %r584;
		st.f64	[%r924+1377338256], %r1728;
		ld.f64	%r1731, [%r924+1478119104];
		mul.f64	%r1730, %r1731, %r584;
		st.f64	[%r924+1478119104], %r1730;
		ld.f64	%r1733, [%r901+68866856];
		mul.f64	%r1732, %r1733, %r584;
		st.f64	[%r901+68866856], %r1732;
		ld.f64	%r601, [%r924+235155312];
		neg.f64	%r1734, %r601;
		ld.f64	%r1735, [%r924+1343744640];
		ld.f64	%r1736, [%r924+335936160];
		fma.rn.f64	%r604, %r1734, %r1735, %r1736;
		st.f64	[%r924+335936160], %r604;
		ld.f64	%r1738, [%r924+1444525488];
		ld.f64	%r1739, [%r924+436717008];
		fma.rn.f64	%r607, %r1734, %r1738, %r1739;
		st.f64	[%r924+436717008], %r607;
		ld.f64	%r1741, [%r924+1074995712];
		ld.f64	%r1742, [%r924+67187232];
		fma.rn.f64	%r610, %r1734, %r1741, %r1742;
		st.f64	[%r924+67187232], %r610;
		ld.f64	%r1744, [%r924+1175776560];
		ld.f64	%r1745, [%r924+167968080];
		fma.rn.f64	%r613, %r1734, %r1744, %r1745;
		st.f64	[%r924+167968080], %r613;
		ld.f64	%r1747, [%r924+1276557408];
		ld.f64	%r1748, [%r924+268748928];
		fma.rn.f64	%r616, %r1734, %r1747, %r1748;
		st.f64	[%r924+268748928], %r616;
		ld.f64	%r1750, [%r924+1377338256];
		ld.f64	%r1751, [%r924+369529776];
		fma.rn.f64	%r619, %r1734, %r1750, %r1751;
		st.f64	[%r924+369529776], %r619;
		ld.f64	%r1753, [%r924+1478119104];
		ld.f64	%r1754, [%r924+470310624];
		fma.rn.f64	%r622, %r1734, %r1753, %r1754;
		st.f64	[%r924+470310624], %r622;
		ld.f64	%r1756, [%r901+68866856];
		ld.f64	%r1757, [%r901+8];
		fma.rn.f64	%r625, %r1734, %r1756, %r1757;
		st.f64	[%r901+8], %r625;
		ld.f64	%r626, [%r924+739059552];
		neg.f64	%r1758, %r626;
		ld.f64	%r1759, [%r924+1343744640];
		ld.f64	%r1760, [%r924+839840400];
		fma.rn.f64	%r629, %r1758, %r1759, %r1760;
		st.f64	[%r924+839840400], %r629;
		ld.f64	%r1762, [%r924+1444525488];
		ld.f64	%r1763, [%r924+940621248];
		fma.rn.f64	%r632, %r1758, %r1762, %r1763;
		st.f64	[%r924+940621248], %r632;
		ld.f64	%r1765, [%r924+1074995712];
		ld.f64	%r1766, [%r924+571091472];
		fma.rn.f64	%r635, %r1758, %r1765, %r1766;
		st.f64	[%r924+571091472], %r635;
		ld.f64	%r1768, [%r924+1175776560];
		ld.f64	%r1769, [%r924+671872320];
		fma.rn.f64	%r638, %r1758, %r1768, %r1769;
		st.f64	[%r924+671872320], %r638;
		ld.f64	%r1771, [%r924+1276557408];
		ld.f64	%r1772, [%r924+772653168];
		fma.rn.f64	%r641, %r1758, %r1771, %r1772;
		st.f64	[%r924+772653168], %r641;
		ld.f64	%r1774, [%r924+1377338256];
		ld.f64	%r1775, [%r924+873434016];
		fma.rn.f64	%r644, %r1758, %r1774, %r1775;
		st.f64	[%r924+873434016], %r644;
		ld.f64	%r1777, [%r924+1478119104];
		ld.f64	%r1778, [%r924+974214864];
		fma.rn.f64	%r647, %r1758, %r1777, %r1778;
		st.f64	[%r924+974214864], %r647;
		ld.f64	%r1780, [%r901+68866856];
		ld.f64	%r1781, [%r901+34433432];
		fma.rn.f64	%r650, %r1758, %r1780, %r1781;
		st.f64	[%r901+34433432], %r650;
		ld.f64	%r651, [%r924+1746868032];
		neg.f64	%r1782, %r651;
		ld.f64	%r1783, [%r924+1343744640];
		ld.f64	%r1784, [%r924+1847648880];
		fma.rn.f64	%r654, %r1782, %r1783, %r1784;
		st.f64	[%r924+1847648880], %r654;
		ld.f64	%r1786, [%r924+1444525488];
		ld.f64	%r1787, [%r924+1948429728];
		fma.rn.f64	%r657, %r1782, %r1786, %r1787;
		st.f64	[%r924+1948429728], %r657;
		ld.f64	%r1789, [%r924+1074995712];
		ld.f64	%r1790, [%r924+1578899952];
		fma.rn.f64	%r660, %r1782, %r1789, %r1790;
		st.f64	[%r924+1578899952], %r660;
		ld.f64	%r1792, [%r924+1175776560];
		ld.f64	%r1793, [%r924+1679680800];
		fma.rn.f64	%r663, %r1782, %r1792, %r1793;
		st.f64	[%r924+1679680800], %r663;
		ld.f64	%r1795, [%r924+1276557408];
		ld.f64	%r1796, [%r924+1780461648];
		fma.rn.f64	%r666, %r1782, %r1795, %r1796;
		st.f64	[%r924+1780461648], %r666;
		ld.f64	%r1798, [%r924+1377338256];
		ld.f64	%r1799, [%r924+1881242496];
		fma.rn.f64	%r669, %r1782, %r1798, %r1799;
		st.f64	[%r924+1881242496], %r669;
		ld.f64	%r1801, [%r924+1478119104];
		ld.f64	%r1802, [%r924+1982023344];
		fma.rn.f64	%r672, %r1782, %r1801, %r1802;
		st.f64	[%r924+1982023344], %r672;
		ld.f64	%r1804, [%r901+68866856];
		ld.f64	%r1805, [%r901+103300280];
		fma.rn.f64	%r675, %r1782, %r1804, %r1805;
		st.f64	[%r901+103300280], %r675;
		ld.f64	%r676, [%r924+2250772272];
		neg.f64	%r1806, %r676;
		ld.f64	%r1807, [%r924+1343744640];
		ld.f64	%r1808, [%r924+2351553120];
		fma.rn.f64	%r679, %r1806, %r1807, %r1808;
		st.f64	[%r924+2351553120], %r679;
		ld.f64	%r1810, [%r924+1444525488];
		ld.f64	%r1811, [%r924+2452333968];
		fma.rn.f64	%r682, %r1806, %r1810, %r1811;
		st.f64	[%r924+2452333968], %r682;
		ld.f64	%r1813, [%r924+1074995712];
		ld.f64	%r1814, [%r924+2082804192];
		fma.rn.f64	%r685, %r1806, %r1813, %r1814;
		st.f64	[%r924+2082804192], %r685;
		ld.f64	%r1816, [%r924+1175776560];
		ld.f64	%r1817, [%r924+2183585040];
		fma.rn.f64	%r688, %r1806, %r1816, %r1817;
		st.f64	[%r924+2183585040], %r688;
		ld.f64	%r1819, [%r924+1276557408];
		ld.f64	%r1820, [%r924+2284365888];
		fma.rn.f64	%r691, %r1806, %r1819, %r1820;
		st.f64	[%r924+2284365888], %r691;
		ld.f64	%r1822, [%r924+1377338256];
		ld.f64	%r1823, [%r924+2385146736];
		fma.rn.f64	%r694, %r1806, %r1822, %r1823;
		st.f64	[%r924+2385146736], %r694;
		ld.f64	%r1825, [%r924+1478119104];
		ld.f64	%r1826, [%r924+2485927584];
		fma.rn.f64	%r697, %r1806, %r1825, %r1826;
		st.f64	[%r924+2485927584], %r697;
		ld.f64	%r1828, [%r901+68866856];
		ld.f64	%r1829, [%r901+137733704];
		fma.rn.f64	%r700, %r1806, %r1828, %r1829;
		st.f64	[%r901+137733704], %r700;
		ld.f64	%r1831, [%r924+1847648880];
		div.rn.f64	%r702, %r1451, %r1831;
		ld.f64	%r1833, [%r924+1948429728];
		mul.f64	%r1832, %r1833, %r702;
		st.f64	[%r924+1948429728], %r1832;
		ld.f64	%r1835, [%r924+1578899952];
		mul.f64	%r1834, %r1835, %r702;
		st.f64	[%r924+1578899952], %r1834;
		ld.f64	%r1837, [%r924+1679680800];
		mul.f64	%r1836, %r1837, %r702;
		st.f64	[%r924+1679680800], %r1836;
		ld.f64	%r1839, [%r924+1780461648];
		mul.f64	%r1838, %r1839, %r702;
		st.f64	[%r924+1780461648], %r1838;
		ld.f64	%r1841, [%r924+1881242496];
		mul.f64	%r1840, %r1841, %r702;
		st.f64	[%r924+1881242496], %r1840;
		ld.f64	%r1843, [%r924+1982023344];
		mul.f64	%r1842, %r1843, %r702;
		st.f64	[%r924+1982023344], %r1842;
		ld.f64	%r1845, [%r901+103300280];
		mul.f64	%r1844, %r1845, %r702;
		st.f64	[%r901+103300280], %r1844;
		ld.f64	%r717, [%r924+335936160];
		neg.f64	%r1846, %r717;
		ld.f64	%r1847, [%r924+1948429728];
		ld.f64	%r1848, [%r924+436717008];
		fma.rn.f64	%r720, %r1846, %r1847, %r1848;
		st.f64	[%r924+436717008], %r720;
		ld.f64	%r1850, [%r924+1578899952];
		ld.f64	%r1851, [%r924+67187232];
		fma.rn.f64	%r723, %r1846, %r1850, %r1851;
		st.f64	[%r924+67187232], %r723;
		ld.f64	%r1853, [%r924+1679680800];
		ld.f64	%r1854, [%r924+167968080];
		fma.rn.f64	%r726, %r1846, %r1853, %r1854;
		st.f64	[%r924+167968080], %r726;
		ld.f64	%r1856, [%r924+1780461648];
		ld.f64	%r1857, [%r924+268748928];
		fma.rn.f64	%r729, %r1846, %r1856, %r1857;
		st.f64	[%r924+268748928], %r729;
		ld.f64	%r1859, [%r924+1881242496];
		ld.f64	%r1860, [%r924+369529776];
		fma.rn.f64	%r732, %r1846, %r1859, %r1860;
		st.f64	[%r924+369529776], %r732;
		ld.f64	%r1862, [%r924+1982023344];
		ld.f64	%r1863, [%r924+470310624];
		fma.rn.f64	%r735, %r1846, %r1862, %r1863;
		st.f64	[%r924+470310624], %r735;
		ld.f64	%r1865, [%r901+103300280];
		ld.f64	%r1866, [%r901+8];
		fma.rn.f64	%r738, %r1846, %r1865, %r1866;
		st.f64	[%r901+8], %r738;
		ld.f64	%r739, [%r924+839840400];
		neg.f64	%r1867, %r739;
		ld.f64	%r1868, [%r924+1948429728];
		ld.f64	%r1869, [%r924+940621248];
		fma.rn.f64	%r742, %r1867, %r1868, %r1869;
		st.f64	[%r924+940621248], %r742;
		ld.f64	%r1871, [%r924+1578899952];
		ld.f64	%r1872, [%r924+571091472];
		fma.rn.f64	%r745, %r1867, %r1871, %r1872;
		st.f64	[%r924+571091472], %r745;
		ld.f64	%r1874, [%r924+1679680800];
		ld.f64	%r1875, [%r924+671872320];
		fma.rn.f64	%r748, %r1867, %r1874, %r1875;
		st.f64	[%r924+671872320], %r748;
		ld.f64	%r1877, [%r924+1780461648];
		ld.f64	%r1878, [%r924+772653168];
		fma.rn.f64	%r751, %r1867, %r1877, %r1878;
		st.f64	[%r924+772653168], %r751;
		ld.f64	%r1880, [%r924+1881242496];
		ld.f64	%r1881, [%r924+873434016];
		fma.rn.f64	%r754, %r1867, %r1880, %r1881;
		st.f64	[%r924+873434016], %r754;
		ld.f64	%r1883, [%r924+1982023344];
		ld.f64	%r1884, [%r924+974214864];
		fma.rn.f64	%r757, %r1867, %r1883, %r1884;
		st.f64	[%r924+974214864], %r757;
		ld.f64	%r1886, [%r901+103300280];
		ld.f64	%r1887, [%r901+34433432];
		fma.rn.f64	%r760, %r1867, %r1886, %r1887;
		st.f64	[%r901+34433432], %r760;
		ld.f64	%r761, [%r924+1343744640];
		neg.f64	%r1888, %r761;
		ld.f64	%r1889, [%r924+1948429728];
		ld.f64	%r1890, [%r924+1444525488];
		fma.rn.f64	%r764, %r1888, %r1889, %r1890;
		st.f64	[%r924+1444525488], %r764;
		ld.f64	%r1892, [%r924+1578899952];
		ld.f64	%r1893, [%r924+1074995712];
		fma.rn.f64	%r767, %r1888, %r1892, %r1893;
		st.f64	[%r924+1074995712], %r767;
		ld.f64	%r1895, [%r924+1679680800];
		ld.f64	%r1896, [%r924+1175776560];
		fma.rn.f64	%r770, %r1888, %r1895, %r1896;
		st.f64	[%r924+1175776560], %r770;
		ld.f64	%r1898, [%r924+1780461648];
		ld.f64	%r1899, [%r924+1276557408];
		fma.rn.f64	%r773, %r1888, %r1898, %r1899;
		st.f64	[%r924+1276557408], %r773;
		ld.f64	%r1901, [%r924+1881242496];
		ld.f64	%r1902, [%r924+1377338256];
		fma.rn.f64	%r776, %r1888, %r1901, %r1902;
		st.f64	[%r924+1377338256], %r776;
		ld.f64	%r1904, [%r924+1982023344];
		ld.f64	%r1905, [%r924+1478119104];
		fma.rn.f64	%r779, %r1888, %r1904, %r1905;
		st.f64	[%r924+1478119104], %r779;
		ld.f64	%r1907, [%r901+103300280];
		ld.f64	%r1908, [%r901+68866856];
		fma.rn.f64	%r782, %r1888, %r1907, %r1908;
		st.f64	[%r901+68866856], %r782;
		ld.f64	%r783, [%r924+2351553120];
		neg.f64	%r1909, %r783;
		ld.f64	%r1910, [%r924+1948429728];
		ld.f64	%r1911, [%r924+2452333968];
		fma.rn.f64	%r786, %r1909, %r1910, %r1911;
		st.f64	[%r924+2452333968], %r786;
		ld.f64	%r1913, [%r924+1578899952];
		ld.f64	%r1914, [%r924+2082804192];
		fma.rn.f64	%r789, %r1909, %r1913, %r1914;
		st.f64	[%r924+2082804192], %r789;
		ld.f64	%r1916, [%r924+1679680800];
		ld.f64	%r1917, [%r924+2183585040];
		fma.rn.f64	%r792, %r1909, %r1916, %r1917;
		st.f64	[%r924+2183585040], %r792;
		ld.f64	%r1919, [%r924+1780461648];
		ld.f64	%r1920, [%r924+2284365888];
		fma.rn.f64	%r795, %r1909, %r1919, %r1920;
		st.f64	[%r924+2284365888], %r795;
		ld.f64	%r1922, [%r924+1881242496];
		ld.f64	%r1923, [%r924+2385146736];
		fma.rn.f64	%r798, %r1909, %r1922, %r1923;
		st.f64	[%r924+2385146736], %r798;
		ld.f64	%r1925, [%r924+1982023344];
		ld.f64	%r1926, [%r924+2485927584];
		fma.rn.f64	%r801, %r1909, %r1925, %r1926;
		st.f64	[%r924+2485927584], %r801;
		ld.f64	%r1928, [%r901+103300280];
		ld.f64	%r1929, [%r901+137733704];
		fma.rn.f64	%r804, %r1909, %r1928, %r1929;
		st.f64	[%r901+137733704], %r804;
		ld.f64	%r1931, [%r924+2452333968];
		div.rn.f64	%r806, %r1451, %r1931;
		ld.f64	%r1933, [%r924+2082804192];
		mul.f64	%r1932, %r1933, %r806;
		st.f64	[%r924+2082804192], %r1932;
		ld.f64	%r1935, [%r924+2183585040];
		mul.f64	%r1934, %r1935, %r806;
		st.f64	[%r924+2183585040], %r1934;
		ld.f64	%r1937, [%r924+2284365888];
		mul.f64	%r1936, %r1937, %r806;
		st.f64	[%r924+2284365888], %r1936;
		ld.f64	%r1939, [%r924+2385146736];
		mul.f64	%r1938, %r1939, %r806;
		st.f64	[%r924+2385146736], %r1938;
		ld.f64	%r1941, [%r924+2485927584];
		mul.f64	%r1940, %r1941, %r806;
		st.f64	[%r924+2485927584], %r1940;
		ld.f64	%r1943, [%r901+137733704];
		mul.f64	%r1942, %r1943, %r806;
		st.f64	[%r901+137733704], %r1942;
		ld.f64	%r819, [%r924+436717008];
		neg.f64	%r1944, %r819;
		ld.f64	%r1945, [%r924+2082804192];
		ld.f64	%r1946, [%r924+67187232];
		fma.rn.f64	%r822, %r1944, %r1945, %r1946;
		st.f64	[%r924+67187232], %r822;
		ld.f64	%r1948, [%r924+2183585040];
		ld.f64	%r1949, [%r924+167968080];
		fma.rn.f64	%r825, %r1944, %r1948, %r1949;
		st.f64	[%r924+167968080], %r825;
		ld.f64	%r1951, [%r924+2284365888];
		ld.f64	%r1952, [%r924+268748928];
		fma.rn.f64	%r828, %r1944, %r1951, %r1952;
		st.f64	[%r924+268748928], %r828;
		ld.f64	%r1954, [%r924+2385146736];
		ld.f64	%r1955, [%r924+369529776];
		fma.rn.f64	%r831, %r1944, %r1954, %r1955;
		st.f64	[%r924+369529776], %r831;
		ld.f64	%r1957, [%r924+2485927584];
		ld.f64	%r1958, [%r924+470310624];
		fma.rn.f64	%r834, %r1944, %r1957, %r1958;
		st.f64	[%r924+470310624], %r834;
		ld.f64	%r1960, [%r901+137733704];
		ld.f64	%r1961, [%r901+8];
		fma.rn.f64	%r837, %r1944, %r1960, %r1961;
		st.f64	[%r901+8], %r837;
		ld.f64	%r838, [%r924+940621248];
		neg.f64	%r1962, %r838;
		ld.f64	%r1963, [%r924+2082804192];
		ld.f64	%r1964, [%r924+571091472];
		fma.rn.f64	%r841, %r1962, %r1963, %r1964;
		st.f64	[%r924+571091472], %r841;
		ld.f64	%r1966, [%r924+2183585040];
		ld.f64	%r1967, [%r924+671872320];
		fma.rn.f64	%r844, %r1962, %r1966, %r1967;
		st.f64	[%r924+671872320], %r844;
		ld.f64	%r1969, [%r924+2284365888];
		ld.f64	%r1970, [%r924+772653168];
		fma.rn.f64	%r847, %r1962, %r1969, %r1970;
		st.f64	[%r924+772653168], %r847;
		ld.f64	%r1972, [%r924+2385146736];
		ld.f64	%r1973, [%r924+873434016];
		fma.rn.f64	%r850, %r1962, %r1972, %r1973;
		st.f64	[%r924+873434016], %r850;
		ld.f64	%r1975, [%r924+2485927584];
		ld.f64	%r1976, [%r924+974214864];
		fma.rn.f64	%r853, %r1962, %r1975, %r1976;
		st.f64	[%r924+974214864], %r853;
		ld.f64	%r1978, [%r901+137733704];
		ld.f64	%r1979, [%r901+34433432];
		fma.rn.f64	%r856, %r1962, %r1978, %r1979;
		st.f64	[%r901+34433432], %r856;
		ld.f64	%r857, [%r924+1444525488];
		neg.f64	%r1980, %r857;
		ld.f64	%r1981, [%r924+2082804192];
		ld.f64	%r1982, [%r924+1074995712];
		fma.rn.f64	%r860, %r1980, %r1981, %r1982;
		st.f64	[%r924+1074995712], %r860;
		ld.f64	%r1984, [%r924+2183585040];
		ld.f64	%r1985, [%r924+1175776560];
		fma.rn.f64	%r863, %r1980, %r1984, %r1985;
		st.f64	[%r924+1175776560], %r863;
		ld.f64	%r1987, [%r924+2284365888];
		ld.f64	%r1988, [%r924+1276557408];
		fma.rn.f64	%r866, %r1980, %r1987, %r1988;
		st.f64	[%r924+1276557408], %r866;
		ld.f64	%r1990, [%r924+2385146736];
		ld.f64	%r1991, [%r924+1377338256];
		fma.rn.f64	%r869, %r1980, %r1990, %r1991;
		st.f64	[%r924+1377338256], %r869;
		ld.f64	%r1993, [%r924+2485927584];
		ld.f64	%r1994, [%r924+1478119104];
		fma.rn.f64	%r872, %r1980, %r1993, %r1994;
		st.f64	[%r924+1478119104], %r872;
		ld.f64	%r1996, [%r901+137733704];
		ld.f64	%r1997, [%r901+68866856];
		fma.rn.f64	%r875, %r1980, %r1996, %r1997;
		st.f64	[%r901+68866856], %r875;
		ld.f64	%r876, [%r924+1948429728];
		neg.f64	%r1998, %r876;
		ld.f64	%r1999, [%r924+2082804192];
		ld.f64	%r2000, [%r924+1578899952];
		fma.rn.f64	%r879, %r1998, %r1999, %r2000;
		st.f64	[%r924+1578899952], %r879;
		ld.f64	%r2002, [%r924+2183585040];
		ld.f64	%r2003, [%r924+1679680800];
		fma.rn.f64	%r882, %r1998, %r2002, %r2003;
		st.f64	[%r924+1679680800], %r882;
		ld.f64	%r2005, [%r924+2284365888];
		ld.f64	%r2006, [%r924+1780461648];
		fma.rn.f64	%r885, %r1998, %r2005, %r2006;
		st.f64	[%r924+1780461648], %r885;
		ld.f64	%r2008, [%r924+2385146736];
		ld.f64	%r2009, [%r924+1881242496];
		fma.rn.f64	%r888, %r1998, %r2008, %r2009;
		st.f64	[%r924+1881242496], %r888;
		ld.f64	%r2011, [%r924+2485927584];
		ld.f64	%r2012, [%r924+1982023344];
		fma.rn.f64	%r891, %r1998, %r2011, %r2012;
		st.f64	[%r924+1982023344], %r891;
		ld.f64	%r2014, [%r901+137733704];
		ld.f64	%r2015, [%r901+103300280];
		fma.rn.f64	%r894, %r1998, %r2014, %r2015;
		st.f64	[%r901+103300280], %r894;
		add.u32	%r86, %r86, 1;
		add.u64	%r901, %r901, 8;
		add.u64	%r924, %r924, 207368;
		setp.ne.u32	%r2016, %r31, %r86;
	@%r2016	bra	$L99;
		bra	$L106;
$L98:
	// joining 4;
	// join 4;
	// joining 2;
		bar.sync	0;
	// join 2;
	@%r2020	bra.uni	$L107;
	@%r2021	bra	$L108;
		setp.ne.u32	%r2017, %r32, %r24;
		selp.u32	%r2022, 1, 0, %r2017;
		st.shared.u32	[__oacc_bcast], %r2022;
$L108:
$L107:
		bar.sync	0;
		ld.shared.u32	%r2023, [__oacc_bcast];
		setp.ne.u32	%r2017, %r2023, 0;
		bar.sync	0;
	@%r2017	bra.uni	$L102;
$L96:
	ret;
}

// BEGIN FUNCTION DECL: x_solve$_omp_fn$6
.entry x_solve$_omp_fn$6 (.param.u64 %in_ar0);

// BEGIN FUNCTION DEF: x_solve$_omp_fn$6
.entry x_solve$_omp_fn$6 (.param.u64 %in_ar0)
{
	.reg.u64 %ar0;
	ld.param.u64 %ar0, [%in_ar0];
	.reg.u32 %r22;
	.reg.u32 %r26;
	.reg.u32 %r28;
	.reg.u32 %r30;
	.reg.f64 %r31;
	.reg.f64 %r32;
	.reg.f64 %r34;
	.reg.u32 %r35;
	.reg.f64 %r40;
	.reg.u32 %r41;
	.reg.u32 %r42;
	.reg.u64 %r43;
	.reg.u64 %r45;
	.reg.f64 %r47;
	.reg.f64 %r49;
	.reg.f64 %r51;
	.reg.f64 %r52;
	.reg.f64 %r54;
	.reg.f64 %r55;
	.reg.f64 %r57;
	.reg.f64 %r58;
	.reg.f64 %r60;
	.reg.f64 %r61;
	.reg.f64 %r64;
	.reg.f64 %r65;
	.reg.f64 %r68;
	.reg.f64 %r70;
	.reg.f64 %r71;
	.reg.f64 %r73;
	.reg.f64 %r76;
	.reg.f64 %r79;
	.reg.f64 %r80;
	.reg.f64 %r82;
	.reg.f64 %r83;
	.reg.f64 %r85;
	.reg.f64 %r88;
	.reg.f64 %r90;
	.reg.f64 %r91;
	.reg.f64 %r94;
	.reg.f64 %r97;
	.reg.f64 %r99;
	.reg.f64 %r100;
	.reg.f64 %r102;
	.reg.f64 %r103;
	.reg.f64 %r105;
	.reg.f64 %r108;
	.reg.f64 %r109;
	.reg.f64 %r112;
	.reg.f64 %r115;
	.reg.f64 %r118;
	.reg.f64 %r120;
	.reg.f64 %r122;
	.reg.f64 %r124;
	.reg.f64 %r126;
	.reg.f64 %r127;
	.reg.f64 %r129;
	.reg.u32 %r135;
	.reg.f64 %r136;
	.reg.f64 %r138;
	.reg.f64 %r139;
	.reg.u32 %r143;
	.reg.u32 %r144;
	.reg.f64 %r145;
	.reg.u32 %r147;
	.reg.u32 %r149;
	.reg.u32 %r151;
	.reg.u32 %r152;
	.reg.f64 %r154;
	.reg.f64 %r156;
	.reg.f64 %r159;
	.reg.f64 %r161;
	.reg.f64 %r163;
	.reg.f64 %r164;
	.reg.f64 %r166;
	.reg.f64 %r168;
	.reg.f64 %r171;
	.reg.f64 %r173;
	.reg.f64 %r175;
	.reg.f64 %r178;
	.reg.f64 %r180;
	.reg.u64 %r183;
	.reg.u64 %r186;
	.reg.u64 %r218;
	.reg.u64 %r219;
	.reg.u64 %r222;
	.reg.u64 %r244;
	.reg.u64 %r248;
	.reg.u64 %r250;
	.reg.u64 %r253;
	.reg.u64 %r256;
	.reg.u64 %r257;
	.reg.u64 %r258;
	.reg.u32 %r259;
	.reg.u32 %r260;
	.reg.u32 %r261;
	.reg.pred %r262;
	.reg.u64 %r263;
	.reg.u64 %r264;
	.reg.u32 %r265;
	.reg.pred %r266;
	.reg.u64 %r267;
	.reg.u64 %r268;
	.reg.u64 %r269;
	.reg.u64 %r271;
	.reg.u64 %r272;
	.reg.u64 %r273;
	.reg.u64 %r274;
	.reg.u64 %r275;
	.reg.f64 %r276;
	.reg.f64 %r277;
	.reg.u64 %r279;
	.reg.u64 %r282;
	.reg.u64 %r283;
	.reg.u64 %r284;
	.reg.u64 %r285;
	.reg.u64 %r286;
	.reg.u64 %r293;
	.reg.u64 %r294;
	.reg.u64 %r295;
	.reg.f64 %r296;
	.reg.f64 %r297;
	.reg.u64 %r298;
	.reg.u64 %r307;
	.reg.u64 %r308;
	.reg.u32 %r309;
	.reg.u64 %r310;
	.reg.u32 %r311;
	.reg.u64 %r312;
	.reg.u64 %r313;
	.reg.f64 %r314;
	.reg.f64 %r315;
	.reg.f64 %r316;
	.reg.f64 %r317;
	.reg.f64 %r318;
	.reg.f64 %r319;
	.reg.f64 %r320;
	.reg.f64 %r321;
	.reg.u64 %r331;
	.reg.u64 %r332;
	.reg.f64 %r342;
	.reg.f64 %r343;
	.reg.f64 %r344;
	.reg.f64 %r345;
	.reg.f64 %r346;
	.reg.f64 %r347;
	.reg.f64 %r348;
	.reg.f64 %r349;
	.reg.f64 %r350;
	.reg.f64 %r351;
	.reg.f64 %r352;
	.reg.f64 %r353;
	.reg.f64 %r354;
	.reg.f64 %r355;
	.reg.f64 %r356;
	.reg.f64 %r357;
	.reg.f64 %r358;
	.reg.f64 %r359;
	.reg.f64 %r361;
	.reg.f64 %r363;
	.reg.f64 %r365;
	.reg.f64 %r366;
	.reg.f64 %r368;
	.reg.f64 %r369;
	.reg.f64 %r370;
	.reg.f64 %r372;
	.reg.f64 %r374;
	.reg.f64 %r376;
	.reg.f64 %r377;
	.reg.f64 %r379;
	.reg.f64 %r380;
	.reg.f64 %r381;
	.reg.f64 %r382;
	.reg.f64 %r383;
	.reg.f64 %r384;
	.reg.f64 %r386;
	.reg.u32 %r387;
	.reg.pred %r388;
	.reg.u64 %r389;
	.reg.u64 %r395;
	.reg.u64 %r396;
	.reg.u64 %r397;
	.reg.f64 %r398;
	.reg.f64 %r399;
	.reg.u64 %r405;
	.reg.u64 %r406;
	.reg.u64 %r407;
	.reg.u64 %r408;
	.reg.u64 %r415;
	.reg.u64 %r416;
	.reg.u64 %r417;
	.reg.f64 %r418;
	.reg.f64 %r419;
	.reg.u64 %r421;
	.reg.u64 %r422;
	.reg.u64 %r423;
	.reg.u64 %r425;
	.reg.u64 %r426;
	.reg.f64 %r427;
	.reg.f64 %r428;
	.reg.f64 %r429;
	.reg.f64 %r430;
	.reg.f64 %r431;
	.reg.f64 %r432;
	.reg.f64 %r433;
	.reg.f64 %r434;
	.reg.u64 %r444;
	.reg.u64 %r445;
	.reg.f64 %r455;
	.reg.f64 %r456;
	.reg.f64 %r457;
	.reg.f64 %r458;
	.reg.f64 %r459;
	.reg.f64 %r460;
	.reg.f64 %r461;
	.reg.f64 %r462;
	.reg.f64 %r463;
	.reg.f64 %r464;
	.reg.f64 %r465;
	.reg.f64 %r466;
	.reg.f64 %r467;
	.reg.f64 %r468;
	.reg.f64 %r469;
	.reg.f64 %r470;
	.reg.f64 %r472;
	.reg.f64 %r474;
	.reg.f64 %r476;
	.reg.f64 %r478;
	.reg.f64 %r479;
	.reg.f64 %r480;
	.reg.f64 %r481;
	.reg.f64 %r482;
	.reg.f64 %r483;
	.reg.f64 %r485;
	.reg.f64 %r487;
	.reg.f64 %r489;
	.reg.f64 %r490;
	.reg.f64 %r492;
	.reg.f64 %r493;
	.reg.f64 %r494;
	.reg.f64 %r495;
	.reg.f64 %r496;
	.reg.f64 %r497;
	.reg.f64 %r499;
	.reg.pred %r500;
	.reg.u64 %r501;
	.reg.u64 %r502;
	.reg.pred %r503;
	.reg.pred %r504;
	.reg.u32 %r505;
	.reg.u32 %r506;
	.reg.u32 %r507;
	.reg.u32 %r508;
	{
		.reg.u32	%y;
		mov.u32	%y, %tid.y;
		setp.ne.u32	%r503, %y, 0;
	}
	{
		.reg.u32	%x;
		mov.u32	%x, %tid.x;
		setp.ne.u32	%r504, %x, 0;
	}
	@%r503	bra.uni	$L129;
	@%r504	bra	$L130;
		mov.u64	%r257, %ar0;
		ld.u64	%r258, [%r257+8];
		ld.u32	%r26, [%r258];
		mov.u32	%r143, %nctaid.x;
		mov.u32	%r144, %ctaid.x;
		add.u32	%r259, %r26, -1;
		add.u32	%r260, %r259, %r143;
		div.s32	%r135, %r260, %r143;
		mul.lo.u32	%r22, %r135, %r144;
		add.u32	%r261, %r22, %r135;
		min.s32	%r35, %r261, %r26;
		setp.lt.s32	%r262, %r22, %r35;
		selp.u32	%r507, 1, 0, %r262;
		st.shared.u32	[__oacc_bcast], %r507;
$L130:
$L129:
		bar.sync	0;
		ld.shared.u32	%r508, [__oacc_bcast];
		setp.ne.u32	%r262, %r508, 0;
		bar.sync	0;
	@!%r262	bra.uni	$L115;
	@%r503	bra.uni	$L127;
	@%r504	bra	$L128;
		ld.u64	%r263, [%r257+16];
		ld.u32	%r28, [%r263];
		ld.u64	%r264, [%r257+24];
		ld.u32	%r30, [%r264];
$L128:
$L127:
$L120:
	@%r503	bra.uni	$L125;
	@%r504	bra	$L126;
		add.u32	%r22, %r22, 1;
	// fork 2;
		cvta.shared.u64	%r502, __oacc_bcast;
		st.u32	[%r502], %r22;
		st.u32	[%r502+4], %r28;
		st.u32	[%r502+8], %r30;
		st.u32	[%r502+12], %r35;
		st.u64	[%r502+16], %r257;
$L126:
$L125:
		bar.sync	0;
	// forked 2;
		cvta.shared.u64	%r501, __oacc_bcast;
		ld.u32	%r22, [%r501];
		ld.u32	%r28, [%r501+4];
		ld.u32	%r30, [%r501+8];
		ld.u32	%r35, [%r501+12];
		ld.u64	%r257, [%r501+16];
	// fork 4;
	// forked 4;
		mov.u32	%r147, %tid.y;
		mov.u32	%r149, %tid.x;
		shl.b32	%r265, %r147, 5;
		add.u32	%r41, %r265, %r149;
		setp.gt.s32	%r266, %r28, %r41;
	@%r266	bra	$L117;
$L119:
	// joining 4;
	// join 4;
	// joining 2;
		bar.sync	0;
	// join 2;
	@%r503	bra.uni	$L123;
	@%r504	bra	$L124;
		setp.ne.u32	%r500, %r35, %r22;
		selp.u32	%r505, 1, 0, %r500;
		st.shared.u32	[__oacc_bcast], %r505;
$L124:
$L123:
		bar.sync	0;
		ld.shared.u32	%r506, [__oacc_bcast];
		setp.ne.u32	%r500, %r506, 0;
		bar.sync	0;
	@%r500	bra.uni	$L120;
		bra	$L115;
$L117:
		ld.u64	%r43, [%r257+32];
		ld.u64	%r45, [%r257];
		add.u32	%r151, %r30, -1;
		add.u32	%r152, %r41, 1;
		cvt.s64.s32	%r267, %r151;
		cvt.s64.s32	%r268, %r152;
		cvt.s64.s32	%r269, %r22;
		mul.lo.u64	%r271, %r269, 163;
		mad.lo.u64	%r272, %r268, 26569, %r271;
		add.u64	%r273, %r272, %r267;
		shl.b64	%r274, %r273, 3;
		add.u64	%r275, %r43, %r274;
		ld.f64	%r277, [%r275];
		neg.f64	%r276, %r277;
		cvt.s64.s32	%r279, %r30;
		mul.lo.u64	%r282, %r269, 161;
		mad.lo.u64	%r283, %r279, 25921, %r282;
		add.u64	%r284, %r283, %r268;
		shl.b64	%r285, %r284, 3;
		add.u64	%r286, %r45, %r285;
		add.u64	%r293, %r272, %r279;
		shl.b64	%r294, %r293, 3;
		add.u64	%r295, %r43, %r294;
		ld.f64	%r296, [%r286];
		ld.f64	%r297, [%r295];
		fma.rn.f64	%r145, %r276, %r296, %r297;
		cvt.s64.s32	%r298, %r30;
		mad.lo.u64	%r183, %r298, 25921, %r282;
		add.u64	%r307, %r268, %r183;
		shl.b64	%r308, %r307, 3;
		add.u64	%r186, %r45, %r308;
		mov.u32	%r309, 163;
		mul.wide.s32	%r218, %r22, %r309;
		mov.u32	%r311, 26569;
		mul.wide.s32	%r310, %r152, %r311;
		add.u64	%r219, %r310, %r218;
		add.u64	%r312, %r267, %r219;
		shl.b64	%r313, %r312, 3;
		add.u64	%r222, %r43, %r313;
		ld.f64	%r139, [%r222+34433424];
		neg.f64	%r314, %r139;
		ld.f64	%r315, [%r186+100780848];
		fma.rn.f64	%r138, %r314, %r315, %r145;
		ld.f64	%r136, [%r222+68866848];
		neg.f64	%r316, %r136;
		ld.f64	%r317, [%r186+201561696];
		fma.rn.f64	%r129, %r316, %r317, %r138;
		ld.f64	%r127, [%r222+103300272];
		neg.f64	%r318, %r127;
		ld.f64	%r319, [%r186+302342544];
		fma.rn.f64	%r126, %r318, %r319, %r129;
		ld.f64	%r124, [%r222+137733696];
		neg.f64	%r320, %r124;
		ld.f64	%r321, [%r186+403123392];
		fma.rn.f64	%r122, %r320, %r321, %r126;
		st.f64	[%r295], %r122;
		add.u64	%r331, %r279, %r219;
		shl.b64	%r332, %r331, 3;
		add.u64	%r244, %r43, %r332;
		ld.f64	%r108, [%r275];
		neg.f64	%r342, %r108;
		ld.f64	%r343, [%r186+503904240];
		ld.f64	%r344, [%r244+34433424];
		fma.rn.f64	%r102, %r342, %r343, %r344;
		ld.f64	%r346, [%r186+604685088];
		neg.f64	%r345, %r346;
		fma.rn.f64	%r90, %r345, %r139, %r102;
		ld.f64	%r348, [%r186+705465936];
		neg.f64	%r347, %r348;
		fma.rn.f64	%r79, %r347, %r136, %r90;
		ld.f64	%r350, [%r186+806246784];
		neg.f64	%r349, %r350;
		fma.rn.f64	%r70, %r349, %r127, %r79;
		ld.f64	%r352, [%r186+907027632];
		neg.f64	%r351, %r352;
		fma.rn.f64	%r40, %r351, %r124, %r70;
		st.f64	[%r244+34433424], %r40;
		ld.f64	%r354, [%r186+1007808480];
		neg.f64	%r353, %r354;
		ld.f64	%r355, [%r244+68866848];
		fma.rn.f64	%r34, %r353, %r108, %r355;
		ld.f64	%r32, [%r222+34433424];
		neg.f64	%r356, %r32;
		ld.f64	%r357, [%r186+1108589328];
		fma.rn.f64	%r31, %r356, %r357, %r34;
		ld.f64	%r359, [%r186+1209370176];
		neg.f64	%r358, %r359;
		fma.rn.f64	%r47, %r358, %r136, %r31;
		ld.f64	%r361, [%r186+1310151024];
		fma.rn.f64	%r154, %r318, %r361, %r47;
		ld.f64	%r363, [%r186+1410931872];
		fma.rn.f64	%r156, %r320, %r363, %r154;
		st.f64	[%r244+68866848], %r156;
		ld.f64	%r365, [%r186+1511712720];
		ld.f64	%r366, [%r244+103300272];
		fma.rn.f64	%r159, %r342, %r365, %r366;
		ld.f64	%r368, [%r186+1612493568];
		fma.rn.f64	%r161, %r356, %r368, %r159;
		ld.f64	%r163, [%r222+68866848];
		ld.f64	%r370, [%r186+1713274416];
		neg.f64	%r369, %r370;
		fma.rn.f64	%r164, %r369, %r163, %r161;
		ld.f64	%r372, [%r186+1814055264];
		fma.rn.f64	%r166, %r318, %r372, %r164;
		ld.f64	%r374, [%r186+1914836112];
		fma.rn.f64	%r168, %r320, %r374, %r166;
		st.f64	[%r244+103300272], %r168;
		ld.f64	%r376, [%r186+2015616960];
		ld.f64	%r377, [%r244+137733696];
		fma.rn.f64	%r171, %r342, %r376, %r377;
		ld.f64	%r379, [%r186+2116397808];
		fma.rn.f64	%r173, %r356, %r379, %r171;
		neg.f64	%r380, %r163;
		ld.f64	%r381, [%r186+2217178656];
		fma.rn.f64	%r175, %r380, %r381, %r173;
		ld.f64	%r383, [%r186+2317959504];
		neg.f64	%r382, %r383;
		ld.f64	%r384, [%r222+103300272];
		fma.rn.f64	%r178, %r382, %r384, %r175;
		ld.f64	%r386, [%r186+2418740352];
		fma.rn.f64	%r180, %r320, %r386, %r178;
		st.f64	[%r244+137733696], %r180;
		add.u32	%r387, %r41, 128;
		setp.le.s32	%r388, %r28, %r387;
	@%r388	bra	$L119;
		add.u32	%r42, %r41, 129;
		cvt.s64.s32	%r389, %r42;
		add.u64	%r395, %r283, %r389;
		shl.b64	%r396, %r395, 3;
		add.u64	%r397, %r45, %r396;
		ld.f64	%r399, [%r397];
		neg.f64	%r398, %r399;
		mad.lo.u64	%r405, %r389, 26569, %r271;
		add.u64	%r406, %r405, %r267;
		shl.b64	%r407, %r406, 3;
		add.u64	%r408, %r43, %r407;
		add.u64	%r415, %r405, %r279;
		shl.b64	%r416, %r415, 3;
		add.u64	%r417, %r43, %r416;
		ld.f64	%r418, [%r408];
		ld.f64	%r419, [%r417];
		fma.rn.f64	%r49, %r398, %r418, %r419;
		add.u64	%r421, %r389, %r183;
		shl.b64	%r422, %r421, 3;
		add.u64	%r248, %r45, %r422;
		mul.wide.s32	%r423, %r42, %r311;
		add.u64	%r250, %r423, %r218;
		add.u64	%r425, %r267, %r250;
		shl.b64	%r426, %r425, 3;
		add.u64	%r253, %r43, %r426;
		ld.f64	%r51, [%r253+34433424];
		ld.f64	%r428, [%r248+100780848];
		neg.f64	%r427, %r428;
		fma.rn.f64	%r52, %r427, %r51, %r49;
		ld.f64	%r54, [%r253+68866848];
		ld.f64	%r430, [%r248+201561696];
		neg.f64	%r429, %r430;
		fma.rn.f64	%r55, %r429, %r54, %r52;
		ld.f64	%r57, [%r253+103300272];
		ld.f64	%r432, [%r248+302342544];
		neg.f64	%r431, %r432;
		fma.rn.f64	%r58, %r431, %r57, %r55;
		ld.f64	%r60, [%r253+137733696];
		ld.f64	%r434, [%r248+403123392];
		neg.f64	%r433, %r434;
		fma.rn.f64	%r61, %r433, %r60, %r58;
		st.f64	[%r417], %r61;
		add.u64	%r444, %r279, %r250;
		shl.b64	%r445, %r444, 3;
		add.u64	%r256, %r43, %r445;
		ld.f64	%r64, [%r408];
		ld.f64	%r456, [%r248+503904240];
		neg.f64	%r455, %r456;
		ld.f64	%r457, [%r256+34433424];
		fma.rn.f64	%r65, %r455, %r64, %r457;
		neg.f64	%r458, %r51;
		ld.f64	%r459, [%r248+604685088];
		fma.rn.f64	%r68, %r458, %r459, %r65;
		neg.f64	%r460, %r54;
		ld.f64	%r461, [%r248+705465936];
		fma.rn.f64	%r71, %r460, %r461, %r68;
		neg.f64	%r462, %r57;
		ld.f64	%r463, [%r248+806246784];
		fma.rn.f64	%r73, %r462, %r463, %r71;
		neg.f64	%r464, %r60;
		ld.f64	%r465, [%r248+907027632];
		fma.rn.f64	%r76, %r464, %r465, %r73;
		st.f64	[%r256+34433424], %r76;
		neg.f64	%r466, %r64;
		ld.f64	%r467, [%r248+1007808480];
		ld.f64	%r468, [%r256+68866848];
		fma.rn.f64	%r80, %r466, %r467, %r468;
		ld.f64	%r82, [%r253+34433424];
		ld.f64	%r470, [%r248+1108589328];
		neg.f64	%r469, %r470;
		fma.rn.f64	%r83, %r469, %r82, %r80;
		ld.f64	%r472, [%r248+1209370176];
		fma.rn.f64	%r85, %r460, %r472, %r83;
		ld.f64	%r474, [%r248+1310151024];
		fma.rn.f64	%r88, %r462, %r474, %r85;
		ld.f64	%r476, [%r248+1410931872];
		fma.rn.f64	%r91, %r464, %r476, %r88;
		st.f64	[%r256+68866848], %r91;
		ld.f64	%r478, [%r248+1511712720];
		ld.f64	%r479, [%r256+103300272];
		fma.rn.f64	%r94, %r466, %r478, %r479;
		neg.f64	%r480, %r82;
		ld.f64	%r481, [%r248+1612493568];
		fma.rn.f64	%r97, %r480, %r481, %r94;
		ld.f64	%r99, [%r253+68866848];
		ld.f64	%r483, [%r248+1713274416];
		neg.f64	%r482, %r483;
		fma.rn.f64	%r100, %r482, %r99, %r97;
		ld.f64	%r485, [%r248+1814055264];
		fma.rn.f64	%r103, %r462, %r485, %r100;
		ld.f64	%r487, [%r248+1914836112];
		fma.rn.f64	%r105, %r464, %r487, %r103;
		st.f64	[%r256+103300272], %r105;
		ld.f64	%r489, [%r248+2015616960];
		ld.f64	%r490, [%r256+137733696];
		fma.rn.f64	%r109, %r466, %r489, %r490;
		ld.f64	%r492, [%r248+2116397808];
		fma.rn.f64	%r112, %r480, %r492, %r109;
		neg.f64	%r493, %r99;
		ld.f64	%r494, [%r248+2217178656];
		fma.rn.f64	%r115, %r493, %r494, %r112;
		ld.f64	%r496, [%r248+2317959504];
		neg.f64	%r495, %r496;
		ld.f64	%r497, [%r253+103300272];
		fma.rn.f64	%r118, %r495, %r497, %r115;
		ld.f64	%r499, [%r248+2418740352];
		fma.rn.f64	%r120, %r464, %r499, %r118;
		st.f64	[%r256+137733696], %r120;
		bra	$L119;
$L115:
	ret;
}

// BEGIN FUNCTION DECL: x_solve$_omp_fn$7
.entry x_solve$_omp_fn$7 (.param.u64 %in_ar0);

// BEGIN FUNCTION DEF: x_solve$_omp_fn$7
.entry x_solve$_omp_fn$7 (.param.u64 %in_ar0)
{
	.reg.u64 %ar0;
	ld.param.u64 %ar0, [%in_ar0];
	.reg.u32 %r25;
	.reg.u32 %r27;
	.reg.u32 %r29;
	.reg.u32 %r31;
	.reg.u32 %r37;
	.reg.u32 %r38;
	.reg.u64 %r47;
	.reg.f64 %r49;
	.reg.f64 %r51;
	.reg.f64 %r52;
	.reg.f64 %r53;
	.reg.f64 %r54;
	.reg.f64 %r55;
	.reg.f64 %r56;
	.reg.f64 %r57;
	.reg.f64 %r58;
	.reg.f64 %r59;
	.reg.f64 %r60;
	.reg.f64 %r61;
	.reg.f64 %r62;
	.reg.f64 %r63;
	.reg.f64 %r64;
	.reg.f64 %r66;
	.reg.f64 %r67;
	.reg.f64 %r68;
	.reg.f64 %r69;
	.reg.f64 %r70;
	.reg.f64 %r71;
	.reg.f64 %r72;
	.reg.f64 %r73;
	.reg.f64 %r74;
	.reg.f64 %r75;
	.reg.f64 %r77;
	.reg.f64 %r78;
	.reg.f64 %r79;
	.reg.f64 %r80;
	.reg.f64 %r81;
	.reg.f64 %r82;
	.reg.f64 %r83;
	.reg.f64 %r84;
	.reg.f64 %r85;
	.reg.f64 %r86;
	.reg.f64 %r88;
	.reg.f64 %r89;
	.reg.f64 %r90;
	.reg.f64 %r91;
	.reg.f64 %r92;
	.reg.f64 %r93;
	.reg.f64 %r94;
	.reg.f64 %r95;
	.reg.f64 %r96;
	.reg.f64 %r97;
	.reg.f64 %r99;
	.reg.f64 %r100;
	.reg.f64 %r101;
	.reg.f64 %r102;
	.reg.f64 %r103;
	.reg.f64 %r104;
	.reg.f64 %r105;
	.reg.f64 %r106;
	.reg.f64 %r107;
	.reg.f64 %r108;
	.reg.f64 %r110;
	.reg.f64 %r111;
	.reg.f64 %r112;
	.reg.f64 %r113;
	.reg.f64 %r114;
	.reg.f64 %r115;
	.reg.f64 %r116;
	.reg.f64 %r117;
	.reg.f64 %r118;
	.reg.f64 %r119;
	.reg.f64 %r121;
	.reg.f64 %r122;
	.reg.f64 %r123;
	.reg.f64 %r124;
	.reg.f64 %r125;
	.reg.f64 %r127;
	.reg.f64 %r128;
	.reg.f64 %r129;
	.reg.f64 %r130;
	.reg.f64 %r131;
	.reg.f64 %r133;
	.reg.f64 %r134;
	.reg.f64 %r135;
	.reg.f64 %r136;
	.reg.f64 %r137;
	.reg.f64 %r139;
	.reg.f64 %r140;
	.reg.f64 %r141;
	.reg.f64 %r142;
	.reg.f64 %r143;
	.reg.f64 %r145;
	.reg.f64 %r146;
	.reg.f64 %r147;
	.reg.f64 %r148;
	.reg.f64 %r149;
	.reg.f64 %r150;
	.reg.f64 %r151;
	.reg.f64 %r152;
	.reg.f64 %r153;
	.reg.f64 %r154;
	.reg.f64 %r156;
	.reg.f64 %r157;
	.reg.f64 %r158;
	.reg.f64 %r159;
	.reg.f64 %r160;
	.reg.f64 %r162;
	.reg.f64 %r163;
	.reg.f64 %r164;
	.reg.f64 %r165;
	.reg.f64 %r166;
	.reg.f64 %r168;
	.reg.f64 %r169;
	.reg.f64 %r170;
	.reg.f64 %r171;
	.reg.f64 %r172;
	.reg.f64 %r174;
	.reg.f64 %r175;
	.reg.f64 %r176;
	.reg.f64 %r177;
	.reg.f64 %r178;
	.reg.f64 %r180;
	.reg.f64 %r181;
	.reg.f64 %r182;
	.reg.f64 %r183;
	.reg.f64 %r184;
	.reg.f64 %r185;
	.reg.f64 %r186;
	.reg.f64 %r187;
	.reg.f64 %r188;
	.reg.f64 %r189;
	.reg.f64 %r191;
	.reg.f64 %r192;
	.reg.f64 %r193;
	.reg.f64 %r194;
	.reg.f64 %r195;
	.reg.f64 %r197;
	.reg.f64 %r198;
	.reg.f64 %r199;
	.reg.f64 %r200;
	.reg.f64 %r201;
	.reg.f64 %r203;
	.reg.f64 %r204;
	.reg.f64 %r205;
	.reg.f64 %r206;
	.reg.f64 %r207;
	.reg.f64 %r209;
	.reg.f64 %r210;
	.reg.f64 %r211;
	.reg.f64 %r212;
	.reg.f64 %r213;
	.reg.f64 %r215;
	.reg.f64 %r216;
	.reg.f64 %r217;
	.reg.f64 %r218;
	.reg.f64 %r219;
	.reg.f64 %r220;
	.reg.f64 %r221;
	.reg.f64 %r222;
	.reg.f64 %r223;
	.reg.f64 %r224;
	.reg.f64 %r226;
	.reg.f64 %r227;
	.reg.f64 %r228;
	.reg.f64 %r229;
	.reg.f64 %r230;
	.reg.f64 %r232;
	.reg.f64 %r233;
	.reg.f64 %r234;
	.reg.f64 %r235;
	.reg.f64 %r236;
	.reg.f64 %r238;
	.reg.f64 %r239;
	.reg.f64 %r240;
	.reg.f64 %r241;
	.reg.f64 %r242;
	.reg.f64 %r244;
	.reg.f64 %r245;
	.reg.f64 %r246;
	.reg.f64 %r247;
	.reg.f64 %r248;
	.reg.u64 %r253;
	.reg.u64 %r258;
	.reg.u32 %r261;
	.reg.u32 %r270;
	.reg.u32 %r271;
	.reg.u64 %r274;
	.reg.u32 %r275;
	.reg.u32 %r276;
	.reg.u64 %r370;
	.reg.u64 %r372;
	.reg.u64 %r373;
	.reg.u64 %r388;
	.reg.u64 %r395;
	.reg.u64 %r404;
	.reg.u64 %r405;
	.reg.u32 %r406;
	.reg.u32 %r407;
	.reg.u32 %r408;
	.reg.pred %r409;
	.reg.u64 %r410;
	.reg.u64 %r411;
	.reg.u32 %r412;
	.reg.u64 %r413;
	.reg.u32 %r415;
	.reg.u32 %r416;
	.reg.u64 %r417;
	.reg.u64 %r418;
	.reg.u64 %r420;
	.reg.u32 %r421;
	.reg.u64 %r422;
	.reg.u64 %r423;
	.reg.u64 %r424;
	.reg.u32 %r425;
	.reg.pred %r426;
	.reg.u64 %r427;
	.reg.u64 %r428;
	.reg.u64 %r429;
	.reg.u64 %r430;
	.reg.u64 %r431;
	.reg.u64 %r432;
	.reg.u64 %r433;
	.reg.f64 %r434;
	.reg.f64 %r435;
	.reg.f64 %r436;
	.reg.f64 %r437;
	.reg.f64 %r438;
	.reg.f64 %r439;
	.reg.f64 %r440;
	.reg.f64 %r441;
	.reg.f64 %r442;
	.reg.f64 %r443;
	.reg.f64 %r444;
	.reg.f64 %r445;
	.reg.f64 %r447;
	.reg.f64 %r453;
	.reg.f64 %r459;
	.reg.f64 %r465;
	.reg.f64 %r470;
	.reg.f64 %r471;
	.reg.f64 %r472;
	.reg.f64 %r473;
	.reg.f64 %r474;
	.reg.f64 %r475;
	.reg.f64 %r476;
	.reg.f64 %r477;
	.reg.f64 %r478;
	.reg.f64 %r479;
	.reg.f64 %r480;
	.reg.f64 %r481;
	.reg.f64 %r482;
	.reg.f64 %r483;
	.reg.f64 %r484;
	.reg.f64 %r485;
	.reg.f64 %r486;
	.reg.f64 %r487;
	.reg.f64 %r488;
	.reg.f64 %r489;
	.reg.f64 %r490;
	.reg.f64 %r491;
	.reg.f64 %r492;
	.reg.f64 %r493;
	.reg.f64 %r495;
	.reg.f64 %r501;
	.reg.f64 %r507;
	.reg.f64 %r513;
	.reg.f64 %r519;
	.reg.f64 %r525;
	.reg.f64 %r531;
	.reg.f64 %r537;
	.reg.f64 %r543;
	.reg.f64 %r549;
	.reg.f64 %r555;
	.reg.f64 %r561;
	.reg.f64 %r567;
	.reg.f64 %r573;
	.reg.f64 %r579;
	.reg.pred %r584;
	.reg.pred %r585;
	.reg.u64 %r586;
	.reg.u64 %r587;
	.reg.pred %r588;
	.reg.pred %r589;
	.reg.u32 %r590;
	.reg.u32 %r591;
	.reg.u32 %r592;
	.reg.u32 %r593;
	{
		.reg.u32	%y;
		mov.u32	%y, %tid.y;
		setp.ne.u32	%r588, %y, 0;
	}
	{
		.reg.u32	%x;
		mov.u32	%x, %tid.x;
		setp.ne.u32	%r589, %x, 0;
	}
	@%r588	bra.uni	$L147;
	@%r589	bra	$L148;
		mov.u64	%r404, %ar0;
		ld.u64	%r405, [%r404+8];
		ld.u32	%r27, [%r405];
		mov.u32	%r270, %nctaid.x;
		mov.u32	%r271, %ctaid.x;
		add.u32	%r406, %r27, -1;
		add.u32	%r407, %r406, %r270;
		div.s32	%r261, %r407, %r270;
		mul.lo.u32	%r37, %r261, %r271;
		add.u32	%r408, %r37, %r261;
		min.s32	%r38, %r408, %r27;
		setp.lt.s32	%r409, %r37, %r38;
		selp.u32	%r592, 1, 0, %r409;
		st.shared.u32	[__oacc_bcast], %r592;
$L148:
$L147:
		bar.sync	0;
		ld.shared.u32	%r593, [__oacc_bcast];
		setp.ne.u32	%r409, %r593, 0;
		bar.sync	0;
	@!%r409	bra.uni	$L131;
	@%r588	bra.uni	$L145;
	@%r589	bra	$L146;
		ld.u64	%r410, [%r404+16];
		ld.u32	%r29, [%r410];
		ld.u64	%r411, [%r404+24];
		ld.u32	%r31, [%r411];
		mov.u32	%r412, 25921;
		mul.wide.s32	%r372, %r31, %r412;
		cvt.s64.s32	%r373, %r37;
		add.u64	%r413, %r373, 1;
		mad.lo.u64	%r370, %r413, 161, %r372;
		sub.u32	%r415, %r38, %r37;
		add.u32	%r416, %r415, -1;
		cvt.u64.u32	%r417, %r416;
		add.u64	%r418, %r417, %r373;
		add.u64	%r420, %r372, 322;
		mad.lo.u64	%r388, %r418, 161, %r420;
		add.u32	%r421, %r31, -1;
		cvt.s64.s32	%r422, %r421;
		cvt.s64.s32	%r423, %r31;
		sub.u64	%r424, %r422, %r423;
		mul.lo.u64	%r395, %r424, 25921;
$L146:
$L145:
$L137:
	// fork 2;
	@%r588	bra.uni	$L143;
	@%r589	bra	$L144;
		cvta.shared.u64	%r587, __oacc_bcast;
		st.u32	[%r587], %r29;
		st.u64	[%r587+8], %r370;
		st.u64	[%r587+16], %r388;
		st.u64	[%r587+24], %r395;
		st.u64	[%r587+32], %r404;
$L144:
$L143:
		bar.sync	0;
	// forked 2;
		cvta.shared.u64	%r586, __oacc_bcast;
		ld.u32	%r29, [%r586];
		ld.u64	%r370, [%r586+8];
		ld.u64	%r388, [%r586+16];
		ld.u64	%r395, [%r586+24];
		ld.u64	%r404, [%r586+32];
	// fork 4;
	// forked 4;
		mov.u32	%r275, %tid.y;
		mov.u32	%r276, %tid.x;
		shl.b32	%r425, %r275, 5;
		add.u32	%r25, %r425, %r276;
		setp.gt.s32	%r426, %r29, %r25;
	@%r426	bra	$L133;
$L136:
	// joining 4;
	// join 4;
	// joining 2;
		bar.sync	0;
	// join 2;
	@%r588	bra.uni	$L141;
	@%r589	bra	$L142;
		add.u64	%r370, %r370, 161;
		setp.ne.u64	%r585, %r370, %r388;
		selp.u32	%r590, 1, 0, %r585;
		st.shared.u32	[__oacc_bcast], %r590;
$L142:
$L141:
		bar.sync	0;
		ld.shared.u32	%r591, [__oacc_bcast];
		setp.ne.u32	%r585, %r591, 0;
		bar.sync	0;
	@%r585	bra.uni	$L137;
		bra	$L131;
$L133:
		ld.u64	%r47, [%r404];
		cvt.s64.s32	%r274, %r25;
		add.u64	%r427, %r370, 1;
		add.u64	%r428, %r427, %r274;
		shl.b64	%r429, %r428, 3;
		add.u64	%r258, %r47, %r429;
		add.u64	%r430, %r395, 8398405;
		add.u64	%r431, %r430, %r370;
		add.u64	%r432, %r431, %r274;
		shl.b64	%r433, %r432, 3;
		add.u64	%r253, %r47, %r433;
$L135:
		ld.f64	%r49, [%r258];
		ld.f64	%r51, [%r253];
		neg.f64	%r434, %r49;
		ld.f64	%r435, [%r258+33593616];
		fma.rn.f64	%r52, %r434, %r51, %r435;
		ld.f64	%r53, [%r258+100780848];
		ld.f64	%r54, [%r253+503904240];
		neg.f64	%r436, %r53;
		fma.rn.f64	%r55, %r436, %r54, %r52;
		ld.f64	%r56, [%r258+201561696];
		ld.f64	%r57, [%r253+1007808480];
		neg.f64	%r437, %r56;
		fma.rn.f64	%r58, %r437, %r57, %r55;
		ld.f64	%r59, [%r258+302342544];
		ld.f64	%r60, [%r253+1511712720];
		neg.f64	%r438, %r59;
		fma.rn.f64	%r61, %r438, %r60, %r58;
		ld.f64	%r62, [%r258+403123392];
		ld.f64	%r63, [%r253+2015616960];
		neg.f64	%r439, %r62;
		fma.rn.f64	%r64, %r439, %r63, %r61;
		st.f64	[%r258+33593616], %r64;
		ld.f64	%r66, [%r258+503904240];
		neg.f64	%r440, %r51;
		ld.f64	%r441, [%r258+537497856];
		fma.rn.f64	%r67, %r440, %r66, %r441;
		ld.f64	%r68, [%r258+604685088];
		neg.f64	%r442, %r54;
		fma.rn.f64	%r69, %r442, %r68, %r67;
		ld.f64	%r70, [%r258+705465936];
		neg.f64	%r443, %r57;
		fma.rn.f64	%r71, %r443, %r70, %r69;
		ld.f64	%r72, [%r258+806246784];
		neg.f64	%r444, %r60;
		fma.rn.f64	%r73, %r444, %r72, %r71;
		ld.f64	%r74, [%r258+907027632];
		neg.f64	%r445, %r63;
		fma.rn.f64	%r75, %r445, %r74, %r73;
		st.f64	[%r258+537497856], %r75;
		ld.f64	%r77, [%r258+1007808480];
		ld.f64	%r447, [%r258+1041402096];
		fma.rn.f64	%r78, %r440, %r77, %r447;
		ld.f64	%r79, [%r258+1108589328];
		fma.rn.f64	%r80, %r442, %r79, %r78;
		ld.f64	%r81, [%r258+1209370176];
		fma.rn.f64	%r82, %r443, %r81, %r80;
		ld.f64	%r83, [%r258+1310151024];
		fma.rn.f64	%r84, %r444, %r83, %r82;
		ld.f64	%r85, [%r258+1410931872];
		fma.rn.f64	%r86, %r445, %r85, %r84;
		st.f64	[%r258+1041402096], %r86;
		ld.f64	%r88, [%r258+1511712720];
		ld.f64	%r453, [%r258+1545306336];
		fma.rn.f64	%r89, %r440, %r88, %r453;
		ld.f64	%r90, [%r258+1612493568];
		fma.rn.f64	%r91, %r442, %r90, %r89;
		ld.f64	%r92, [%r258+1713274416];
		fma.rn.f64	%r93, %r443, %r92, %r91;
		ld.f64	%r94, [%r258+1814055264];
		fma.rn.f64	%r95, %r444, %r94, %r93;
		ld.f64	%r96, [%r258+1914836112];
		fma.rn.f64	%r97, %r445, %r96, %r95;
		st.f64	[%r258+1545306336], %r97;
		ld.f64	%r99, [%r258+2015616960];
		ld.f64	%r459, [%r258+2049210576];
		fma.rn.f64	%r100, %r440, %r99, %r459;
		ld.f64	%r101, [%r258+2116397808];
		fma.rn.f64	%r102, %r442, %r101, %r100;
		ld.f64	%r103, [%r258+2217178656];
		fma.rn.f64	%r104, %r443, %r103, %r102;
		ld.f64	%r105, [%r258+2317959504];
		fma.rn.f64	%r106, %r444, %r105, %r104;
		ld.f64	%r107, [%r258+2418740352];
		fma.rn.f64	%r108, %r445, %r107, %r106;
		st.f64	[%r258+2049210576], %r108;
		ld.f64	%r110, [%r253+100780848];
		ld.f64	%r465, [%r258+134374464];
		fma.rn.f64	%r111, %r434, %r110, %r465;
		ld.f64	%r112, [%r253+604685088];
		fma.rn.f64	%r113, %r436, %r112, %r111;
		ld.f64	%r114, [%r253+1108589328];
		fma.rn.f64	%r115, %r437, %r114, %r113;
		ld.f64	%r116, [%r253+1612493568];
		fma.rn.f64	%r117, %r438, %r116, %r115;
		ld.f64	%r118, [%r253+2116397808];
		fma.rn.f64	%r119, %r439, %r118, %r117;
		st.f64	[%r258+134374464], %r119;
		neg.f64	%r470, %r66;
		ld.f64	%r471, [%r258+638278704];
		fma.rn.f64	%r121, %r470, %r110, %r471;
		neg.f64	%r472, %r68;
		fma.rn.f64	%r122, %r472, %r112, %r121;
		neg.f64	%r473, %r70;
		fma.rn.f64	%r123, %r473, %r114, %r122;
		neg.f64	%r474, %r72;
		fma.rn.f64	%r124, %r474, %r116, %r123;
		neg.f64	%r475, %r74;
		fma.rn.f64	%r125, %r475, %r118, %r124;
		st.f64	[%r258+638278704], %r125;
		neg.f64	%r476, %r77;
		ld.f64	%r477, [%r258+1142182944];
		fma.rn.f64	%r127, %r476, %r110, %r477;
		neg.f64	%r478, %r79;
		fma.rn.f64	%r128, %r478, %r112, %r127;
		neg.f64	%r479, %r81;
		fma.rn.f64	%r129, %r479, %r114, %r128;
		neg.f64	%r480, %r83;
		fma.rn.f64	%r130, %r480, %r116, %r129;
		neg.f64	%r481, %r85;
		fma.rn.f64	%r131, %r481, %r118, %r130;
		st.f64	[%r258+1142182944], %r131;
		neg.f64	%r482, %r88;
		ld.f64	%r483, [%r258+1646087184];
		fma.rn.f64	%r133, %r482, %r110, %r483;
		neg.f64	%r484, %r90;
		fma.rn.f64	%r134, %r484, %r112, %r133;
		neg.f64	%r485, %r92;
		fma.rn.f64	%r135, %r485, %r114, %r134;
		neg.f64	%r486, %r94;
		fma.rn.f64	%r136, %r486, %r116, %r135;
		neg.f64	%r487, %r96;
		fma.rn.f64	%r137, %r487, %r118, %r136;
		st.f64	[%r258+1646087184], %r137;
		neg.f64	%r488, %r99;
		ld.f64	%r489, [%r258+2149991424];
		fma.rn.f64	%r139, %r488, %r110, %r489;
		neg.f64	%r490, %r101;
		fma.rn.f64	%r140, %r490, %r112, %r139;
		neg.f64	%r491, %r103;
		fma.rn.f64	%r141, %r491, %r114, %r140;
		neg.f64	%r492, %r105;
		fma.rn.f64	%r142, %r492, %r116, %r141;
		neg.f64	%r493, %r107;
		fma.rn.f64	%r143, %r493, %r118, %r142;
		st.f64	[%r258+2149991424], %r143;
		ld.f64	%r145, [%r253+201561696];
		ld.f64	%r495, [%r258+235155312];
		fma.rn.f64	%r146, %r434, %r145, %r495;
		ld.f64	%r147, [%r253+705465936];
		fma.rn.f64	%r148, %r436, %r147, %r146;
		ld.f64	%r149, [%r253+1209370176];
		fma.rn.f64	%r150, %r437, %r149, %r148;
		ld.f64	%r151, [%r253+1713274416];
		fma.rn.f64	%r152, %r438, %r151, %r150;
		ld.f64	%r153, [%r253+2217178656];
		fma.rn.f64	%r154, %r439, %r153, %r152;
		st.f64	[%r258+235155312], %r154;
		ld.f64	%r501, [%r258+739059552];
		fma.rn.f64	%r156, %r470, %r145, %r501;
		fma.rn.f64	%r157, %r472, %r147, %r156;
		fma.rn.f64	%r158, %r473, %r149, %r157;
		fma.rn.f64	%r159, %r474, %r151, %r158;
		fma.rn.f64	%r160, %r475, %r153, %r159;
		st.f64	[%r258+739059552], %r160;
		ld.f64	%r507, [%r258+1242963792];
		fma.rn.f64	%r162, %r476, %r145, %r507;
		fma.rn.f64	%r163, %r478, %r147, %r162;
		fma.rn.f64	%r164, %r479, %r149, %r163;
		fma.rn.f64	%r165, %r480, %r151, %r164;
		fma.rn.f64	%r166, %r481, %r153, %r165;
		st.f64	[%r258+1242963792], %r166;
		ld.f64	%r513, [%r258+1746868032];
		fma.rn.f64	%r168, %r482, %r145, %r513;
		fma.rn.f64	%r169, %r484, %r147, %r168;
		fma.rn.f64	%r170, %r485, %r149, %r169;
		fma.rn.f64	%r171, %r486, %r151, %r170;
		fma.rn.f64	%r172, %r487, %r153, %r171;
		st.f64	[%r258+1746868032], %r172;
		ld.f64	%r519, [%r258+2250772272];
		fma.rn.f64	%r174, %r488, %r145, %r519;
		fma.rn.f64	%r175, %r490, %r147, %r174;
		fma.rn.f64	%r176, %r491, %r149, %r175;
		fma.rn.f64	%r177, %r492, %r151, %r176;
		fma.rn.f64	%r178, %r493, %r153, %r177;
		st.f64	[%r258+2250772272], %r178;
		ld.f64	%r180, [%r253+302342544];
		ld.f64	%r525, [%r258+335936160];
		fma.rn.f64	%r181, %r434, %r180, %r525;
		ld.f64	%r182, [%r253+806246784];
		fma.rn.f64	%r183, %r436, %r182, %r181;
		ld.f64	%r184, [%r253+1310151024];
		fma.rn.f64	%r185, %r437, %r184, %r183;
		ld.f64	%r186, [%r253+1814055264];
		fma.rn.f64	%r187, %r438, %r186, %r185;
		ld.f64	%r188, [%r253+2317959504];
		fma.rn.f64	%r189, %r439, %r188, %r187;
		st.f64	[%r258+335936160], %r189;
		ld.f64	%r531, [%r258+839840400];
		fma.rn.f64	%r191, %r470, %r180, %r531;
		fma.rn.f64	%r192, %r472, %r182, %r191;
		fma.rn.f64	%r193, %r473, %r184, %r192;
		fma.rn.f64	%r194, %r474, %r186, %r193;
		fma.rn.f64	%r195, %r475, %r188, %r194;
		st.f64	[%r258+839840400], %r195;
		ld.f64	%r537, [%r258+1343744640];
		fma.rn.f64	%r197, %r476, %r180, %r537;
		fma.rn.f64	%r198, %r478, %r182, %r197;
		fma.rn.f64	%r199, %r479, %r184, %r198;
		fma.rn.f64	%r200, %r480, %r186, %r199;
		fma.rn.f64	%r201, %r481, %r188, %r200;
		st.f64	[%r258+1343744640], %r201;
		ld.f64	%r543, [%r258+1847648880];
		fma.rn.f64	%r203, %r482, %r180, %r543;
		fma.rn.f64	%r204, %r484, %r182, %r203;
		fma.rn.f64	%r205, %r485, %r184, %r204;
		fma.rn.f64	%r206, %r486, %r186, %r205;
		fma.rn.f64	%r207, %r487, %r188, %r206;
		st.f64	[%r258+1847648880], %r207;
		ld.f64	%r549, [%r258+2351553120];
		fma.rn.f64	%r209, %r488, %r180, %r549;
		fma.rn.f64	%r210, %r490, %r182, %r209;
		fma.rn.f64	%r211, %r491, %r184, %r210;
		fma.rn.f64	%r212, %r492, %r186, %r211;
		fma.rn.f64	%r213, %r493, %r188, %r212;
		st.f64	[%r258+2351553120], %r213;
		ld.f64	%r215, [%r253+403123392];
		ld.f64	%r555, [%r258+436717008];
		fma.rn.f64	%r216, %r434, %r215, %r555;
		ld.f64	%r217, [%r253+907027632];
		fma.rn.f64	%r218, %r436, %r217, %r216;
		ld.f64	%r219, [%r253+1410931872];
		fma.rn.f64	%r220, %r437, %r219, %r218;
		ld.f64	%r221, [%r253+1914836112];
		fma.rn.f64	%r222, %r438, %r221, %r220;
		ld.f64	%r223, [%r253+2418740352];
		fma.rn.f64	%r224, %r439, %r223, %r222;
		st.f64	[%r258+436717008], %r224;
		ld.f64	%r561, [%r258+940621248];
		fma.rn.f64	%r226, %r470, %r215, %r561;
		fma.rn.f64	%r227, %r472, %r217, %r226;
		fma.rn.f64	%r228, %r473, %r219, %r227;
		fma.rn.f64	%r229, %r474, %r221, %r228;
		fma.rn.f64	%r230, %r475, %r223, %r229;
		st.f64	[%r258+940621248], %r230;
		ld.f64	%r567, [%r258+1444525488];
		fma.rn.f64	%r232, %r476, %r215, %r567;
		fma.rn.f64	%r233, %r478, %r217, %r232;
		fma.rn.f64	%r234, %r479, %r219, %r233;
		fma.rn.f64	%r235, %r480, %r221, %r234;
		fma.rn.f64	%r236, %r481, %r223, %r235;
		st.f64	[%r258+1444525488], %r236;
		ld.f64	%r573, [%r258+1948429728];
		fma.rn.f64	%r238, %r482, %r215, %r573;
		fma.rn.f64	%r239, %r484, %r217, %r238;
		fma.rn.f64	%r240, %r485, %r219, %r239;
		fma.rn.f64	%r241, %r486, %r221, %r240;
		fma.rn.f64	%r242, %r487, %r223, %r241;
		st.f64	[%r258+1948429728], %r242;
		ld.f64	%r579, [%r258+2452333968];
		fma.rn.f64	%r244, %r488, %r215, %r579;
		fma.rn.f64	%r245, %r490, %r217, %r244;
		fma.rn.f64	%r246, %r491, %r219, %r245;
		fma.rn.f64	%r247, %r492, %r221, %r246;
		fma.rn.f64	%r248, %r493, %r223, %r247;
		st.f64	[%r258+2452333968], %r248;
		add.u32	%r25, %r25, 128;
		add.u64	%r258, %r258, 1024;
		add.u64	%r253, %r253, 1024;
		setp.gt.s32	%r584, %r29, %r25;
	@%r584	bra	$L135;
		bra	$L136;
$L131:
	ret;
}

// BEGIN FUNCTION DECL: x_solve$_omp_fn$8
.entry x_solve$_omp_fn$8 (.param.u64 %in_ar0);

// BEGIN FUNCTION DEF: x_solve$_omp_fn$8
.entry x_solve$_omp_fn$8 (.param.u64 %in_ar0)
{
	.reg.u64 %ar0;
	ld.param.u64 %ar0, [%in_ar0];
	.reg.u32 %r24;
	.reg.u32 %r26;
	.reg.u32 %r28;
	.reg.u32 %r30;
	.reg.u32 %r35;
	.reg.u32 %r36;
	.reg.f64 %r49;
	.reg.f64 %r61;
	.reg.f64 %r64;
	.reg.f64 %r67;
	.reg.f64 %r70;
	.reg.f64 %r73;
	.reg.f64 %r76;
	.reg.f64 %r77;
	.reg.f64 %r80;
	.reg.f64 %r83;
	.reg.f64 %r86;
	.reg.f64 %r89;
	.reg.f64 %r92;
	.reg.f64 %r93;
	.reg.f64 %r96;
	.reg.f64 %r99;
	.reg.f64 %r102;
	.reg.f64 %r105;
	.reg.f64 %r108;
	.reg.f64 %r109;
	.reg.f64 %r112;
	.reg.f64 %r115;
	.reg.f64 %r118;
	.reg.f64 %r121;
	.reg.f64 %r124;
	.reg.f64 %r126;
	.reg.f64 %r135;
	.reg.f64 %r138;
	.reg.f64 %r141;
	.reg.f64 %r144;
	.reg.f64 %r147;
	.reg.f64 %r148;
	.reg.f64 %r151;
	.reg.f64 %r154;
	.reg.f64 %r157;
	.reg.f64 %r160;
	.reg.f64 %r161;
	.reg.f64 %r164;
	.reg.f64 %r167;
	.reg.f64 %r170;
	.reg.f64 %r173;
	.reg.f64 %r174;
	.reg.f64 %r177;
	.reg.f64 %r180;
	.reg.f64 %r183;
	.reg.f64 %r186;
	.reg.f64 %r188;
	.reg.f64 %r195;
	.reg.f64 %r198;
	.reg.f64 %r201;
	.reg.f64 %r204;
	.reg.f64 %r205;
	.reg.f64 %r208;
	.reg.f64 %r211;
	.reg.f64 %r214;
	.reg.f64 %r215;
	.reg.f64 %r218;
	.reg.f64 %r221;
	.reg.f64 %r224;
	.reg.f64 %r225;
	.reg.f64 %r228;
	.reg.f64 %r231;
	.reg.f64 %r234;
	.reg.f64 %r236;
	.reg.f64 %r241;
	.reg.f64 %r244;
	.reg.f64 %r247;
	.reg.f64 %r248;
	.reg.f64 %r251;
	.reg.f64 %r254;
	.reg.f64 %r255;
	.reg.f64 %r258;
	.reg.f64 %r261;
	.reg.f64 %r262;
	.reg.f64 %r265;
	.reg.f64 %r267;
	.reg.f64 %r268;
	.reg.f64 %r271;
	.reg.f64 %r274;
	.reg.f64 %r278;
	.reg.f64 %r281;
	.reg.u64 %r283;
	.reg.f64 %r284;
	.reg.u64 %r293;
	.reg.u32 %r296;
	.reg.u32 %r303;
	.reg.u32 %r304;
	.reg.u32 %r307;
	.reg.u32 %r308;
	.reg.u64 %r352;
	.reg.u64 %r353;
	.reg.u64 %r355;
	.reg.u64 %r356;
	.reg.u64 %r358;
	.reg.u64 %r368;
	.reg.u64 %r369;
	.reg.u64 %r370;
	.reg.u32 %r371;
	.reg.u32 %r372;
	.reg.u32 %r373;
	.reg.pred %r374;
	.reg.u64 %r375;
	.reg.u64 %r376;
	.reg.u64 %r377;
	.reg.u32 %r378;
	.reg.u32 %r380;
	.reg.u32 %r381;
	.reg.u64 %r382;
	.reg.u64 %r383;
	.reg.u32 %r385;
	.reg.pred %r386;
	.reg.u64 %r387;
	.reg.u64 %r388;
	.reg.u64 %r389;
	.reg.u64 %r390;
	.reg.u64 %r391;
	.reg.u64 %r392;
	.reg.u64 %r393;
	.reg.u64 %r394;
	.reg.u64 %r396;
	.reg.u64 %r397;
	.reg.u64 %r398;
	.reg.f64 %r399;
	.reg.f64 %r400;
	.reg.f64 %r401;
	.reg.f64 %r402;
	.reg.f64 %r403;
	.reg.f64 %r404;
	.reg.f64 %r405;
	.reg.f64 %r406;
	.reg.f64 %r407;
	.reg.f64 %r408;
	.reg.f64 %r409;
	.reg.f64 %r410;
	.reg.f64 %r411;
	.reg.f64 %r412;
	.reg.f64 %r413;
	.reg.f64 %r415;
	.reg.f64 %r416;
	.reg.f64 %r418;
	.reg.f64 %r419;
	.reg.f64 %r421;
	.reg.f64 %r422;
	.reg.f64 %r424;
	.reg.f64 %r425;
	.reg.f64 %r426;
	.reg.f64 %r427;
	.reg.f64 %r428;
	.reg.f64 %r430;
	.reg.f64 %r431;
	.reg.f64 %r433;
	.reg.f64 %r434;
	.reg.f64 %r436;
	.reg.f64 %r437;
	.reg.f64 %r439;
	.reg.f64 %r440;
	.reg.f64 %r441;
	.reg.f64 %r442;
	.reg.f64 %r443;
	.reg.f64 %r445;
	.reg.f64 %r446;
	.reg.f64 %r448;
	.reg.f64 %r449;
	.reg.f64 %r451;
	.reg.f64 %r452;
	.reg.f64 %r454;
	.reg.f64 %r455;
	.reg.f64 %r456;
	.reg.f64 %r457;
	.reg.f64 %r458;
	.reg.f64 %r460;
	.reg.f64 %r461;
	.reg.f64 %r463;
	.reg.f64 %r464;
	.reg.f64 %r466;
	.reg.f64 %r467;
	.reg.f64 %r469;
	.reg.f64 %r470;
	.reg.f64 %r472;
	.reg.f64 %r473;
	.reg.f64 %r474;
	.reg.f64 %r475;
	.reg.f64 %r476;
	.reg.f64 %r477;
	.reg.f64 %r478;
	.reg.f64 %r479;
	.reg.f64 %r480;
	.reg.f64 %r481;
	.reg.f64 %r482;
	.reg.f64 %r483;
	.reg.f64 %r485;
	.reg.f64 %r486;
	.reg.f64 %r488;
	.reg.f64 %r489;
	.reg.f64 %r491;
	.reg.f64 %r492;
	.reg.f64 %r493;
	.reg.f64 %r494;
	.reg.f64 %r495;
	.reg.f64 %r497;
	.reg.f64 %r498;
	.reg.f64 %r500;
	.reg.f64 %r501;
	.reg.f64 %r503;
	.reg.f64 %r504;
	.reg.f64 %r505;
	.reg.f64 %r506;
	.reg.f64 %r507;
	.reg.f64 %r509;
	.reg.f64 %r510;
	.reg.f64 %r512;
	.reg.f64 %r513;
	.reg.f64 %r515;
	.reg.f64 %r516;
	.reg.f64 %r517;
	.reg.f64 %r518;
	.reg.f64 %r519;
	.reg.f64 %r521;
	.reg.f64 %r522;
	.reg.f64 %r524;
	.reg.f64 %r525;
	.reg.f64 %r527;
	.reg.f64 %r528;
	.reg.f64 %r530;
	.reg.f64 %r531;
	.reg.f64 %r532;
	.reg.f64 %r533;
	.reg.f64 %r534;
	.reg.f64 %r535;
	.reg.f64 %r536;
	.reg.f64 %r537;
	.reg.f64 %r538;
	.reg.f64 %r539;
	.reg.f64 %r541;
	.reg.f64 %r542;
	.reg.f64 %r544;
	.reg.f64 %r545;
	.reg.f64 %r546;
	.reg.f64 %r547;
	.reg.f64 %r548;
	.reg.f64 %r550;
	.reg.f64 %r551;
	.reg.f64 %r553;
	.reg.f64 %r554;
	.reg.f64 %r555;
	.reg.f64 %r556;
	.reg.f64 %r557;
	.reg.f64 %r559;
	.reg.f64 %r560;
	.reg.f64 %r562;
	.reg.f64 %r563;
	.reg.f64 %r564;
	.reg.f64 %r565;
	.reg.f64 %r566;
	.reg.f64 %r568;
	.reg.f64 %r569;
	.reg.f64 %r571;
	.reg.f64 %r572;
	.reg.f64 %r574;
	.reg.f64 %r575;
	.reg.f64 %r576;
	.reg.f64 %r577;
	.reg.f64 %r578;
	.reg.f64 %r579;
	.reg.f64 %r580;
	.reg.f64 %r581;
	.reg.f64 %r583;
	.reg.f64 %r584;
	.reg.f64 %r585;
	.reg.f64 %r586;
	.reg.f64 %r587;
	.reg.f64 %r589;
	.reg.f64 %r590;
	.reg.f64 %r591;
	.reg.f64 %r592;
	.reg.f64 %r593;
	.reg.f64 %r595;
	.reg.f64 %r596;
	.reg.f64 %r597;
	.reg.f64 %r598;
	.reg.f64 %r599;
	.reg.f64 %r601;
	.reg.f64 %r602;
	.reg.f64 %r604;
	.reg.f64 %r605;
	.reg.f64 %r606;
	.reg.f64 %r607;
	.reg.f64 %r609;
	.reg.f64 %r610;
	.reg.f64 %r612;
	.reg.f64 %r613;
	.reg.f64 %r615;
	.reg.pred %r616;
	.reg.pred %r617;
	.reg.u64 %r618;
	.reg.u64 %r619;
	.reg.pred %r620;
	.reg.pred %r621;
	.reg.u32 %r622;
	.reg.u32 %r623;
	.reg.u32 %r624;
	.reg.u32 %r625;
	{
		.reg.u32	%y;
		mov.u32	%y, %tid.y;
		setp.ne.u32	%r620, %y, 0;
	}
	{
		.reg.u32	%x;
		mov.u32	%x, %tid.x;
		setp.ne.u32	%r621, %x, 0;
	}
	@%r620	bra.uni	$L162;
	@%r621	bra	$L163;
		mov.u64	%r369, %ar0;
		ld.u64	%r370, [%r369+24];
		ld.u32	%r26, [%r370];
		mov.u32	%r303, %nctaid.x;
		mov.u32	%r304, %ctaid.x;
		add.u32	%r371, %r26, -1;
		add.u32	%r372, %r371, %r303;
		div.s32	%r296, %r372, %r303;
		mul.lo.u32	%r35, %r296, %r304;
		add.u32	%r373, %r35, %r296;
		min.s32	%r36, %r373, %r26;
		setp.ge.s32	%r374, %r35, %r36;
		selp.u32	%r624, 1, 0, %r374;
		st.shared.u32	[__oacc_bcast], %r624;
$L163:
$L162:
		bar.sync	0;
		ld.shared.u32	%r625, [__oacc_bcast];
		setp.ne.u32	%r374, %r625, 0;
		bar.sync	0;
	@%r374	bra.uni	$L149;
	@%r620	bra.uni	$L160;
	@%r621	bra	$L161;
		ld.u64	%r375, [%r369+32];
		ld.u32	%r28, [%r375];
		ld.u64	%r376, [%r369+40];
		ld.u32	%r30, [%r376];
		cvt.s64.s32	%r353, %r30;
		cvt.s64.s32	%r355, %r35;
		add.u64	%r356, %r355, 1;
		mov.u32	%r378, 25921;
		mul.wide.s32	%r377, %r30, %r378;
		mad.lo.u64	%r352, %r356, 161, %r377;
		mul.lo.u64	%r358, %r356, 163;
		sub.u32	%r380, %r36, %r35;
		add.u32	%r381, %r380, -1;
		cvt.u64.u32	%r382, %r381;
		add.u64	%r383, %r382, %r355;
		mad.lo.u64	%r368, %r383, 163, 326;
$L161:
$L160:
$L153:
	// fork 2;
	@%r620	bra.uni	$L158;
	@%r621	bra	$L159;
		cvta.shared.u64	%r619, __oacc_bcast;
		st.u32	[%r619], %r28;
		st.u64	[%r619+8], %r352;
		st.u64	[%r619+16], %r353;
		st.u64	[%r619+24], %r358;
		st.u64	[%r619+32], %r368;
		st.u64	[%r619+40], %r369;
$L159:
$L158:
		bar.sync	0;
	// forked 2;
		cvta.shared.u64	%r618, __oacc_bcast;
		ld.u32	%r28, [%r618];
		ld.u64	%r352, [%r618+8];
		ld.u64	%r353, [%r618+16];
		ld.u64	%r358, [%r618+24];
		ld.u64	%r368, [%r618+32];
		ld.u64	%r369, [%r618+40];
	// fork 4;
	// forked 4;
		mov.u32	%r307, %tid.y;
		mov.u32	%r308, %tid.x;
		shl.b32	%r385, %r307, 5;
		add.u32	%r24, %r385, %r308;
		setp.le.s32	%r386, %r28, %r24;
	@%r386	bra	$L151;
		add.u64	%r387, %r352, 4199203;
		cvt.s64.s32	%r388, %r24;
		add.u64	%r389, %r387, %r388;
		shl.b64	%r390, %r389, 3;
		ld.u64	%r391, [%r369+16];
		add.u64	%r293, %r391, %r390;
		add.u64	%r392, %r353, 26569;
		add.u64	%r393, %r392, %r358;
		cvt.s64.s32	%r394, %r24;
		mad.lo.u64	%r396, %r394, 26569, %r393;
		shl.b64	%r397, %r396, 3;
		ld.u64	%r398, [%r369+48];
		add.u64	%r283, %r398, %r397;
$L152:
		mov.f64	%r399, 0d3ff0000000000000;
		ld.f64	%r400, [%r293];
		div.rn.f64	%r49, %r399, %r400;
		ld.f64	%r402, [%r293+100780848];
		mul.f64	%r401, %r402, %r49;
		st.f64	[%r293+100780848], %r401;
		ld.f64	%r404, [%r293+201561696];
		mul.f64	%r403, %r404, %r49;
		st.f64	[%r293+201561696], %r403;
		ld.f64	%r406, [%r293+302342544];
		mul.f64	%r405, %r406, %r49;
		st.f64	[%r293+302342544], %r405;
		ld.f64	%r408, [%r293+403123392];
		mul.f64	%r407, %r408, %r49;
		st.f64	[%r293+403123392], %r407;
		ld.f64	%r410, [%r283];
		mul.f64	%r409, %r410, %r49;
		st.f64	[%r283], %r409;
		ld.f64	%r61, [%r293+503904240];
		neg.f64	%r411, %r61;
		ld.f64	%r412, [%r293+100780848];
		ld.f64	%r413, [%r293+604685088];
		fma.rn.f64	%r64, %r411, %r412, %r413;
		st.f64	[%r293+604685088], %r64;
		ld.f64	%r415, [%r293+201561696];
		ld.f64	%r416, [%r293+705465936];
		fma.rn.f64	%r67, %r411, %r415, %r416;
		st.f64	[%r293+705465936], %r67;
		ld.f64	%r418, [%r293+302342544];
		ld.f64	%r419, [%r293+806246784];
		fma.rn.f64	%r70, %r411, %r418, %r419;
		st.f64	[%r293+806246784], %r70;
		ld.f64	%r421, [%r293+403123392];
		ld.f64	%r422, [%r293+907027632];
		fma.rn.f64	%r73, %r411, %r421, %r422;
		st.f64	[%r293+907027632], %r73;
		ld.f64	%r424, [%r283];
		ld.f64	%r425, [%r283+34433424];
		fma.rn.f64	%r76, %r411, %r424, %r425;
		st.f64	[%r283+34433424], %r76;
		ld.f64	%r77, [%r293+1007808480];
		neg.f64	%r426, %r77;
		ld.f64	%r427, [%r293+100780848];
		ld.f64	%r428, [%r293+1108589328];
		fma.rn.f64	%r80, %r426, %r427, %r428;
		st.f64	[%r293+1108589328], %r80;
		ld.f64	%r430, [%r293+201561696];
		ld.f64	%r431, [%r293+1209370176];
		fma.rn.f64	%r83, %r426, %r430, %r431;
		st.f64	[%r293+1209370176], %r83;
		ld.f64	%r433, [%r293+302342544];
		ld.f64	%r434, [%r293+1310151024];
		fma.rn.f64	%r86, %r426, %r433, %r434;
		st.f64	[%r293+1310151024], %r86;
		ld.f64	%r436, [%r293+403123392];
		ld.f64	%r437, [%r293+1410931872];
		fma.rn.f64	%r89, %r426, %r436, %r437;
		st.f64	[%r293+1410931872], %r89;
		ld.f64	%r439, [%r283];
		ld.f64	%r440, [%r283+68866848];
		fma.rn.f64	%r92, %r426, %r439, %r440;
		st.f64	[%r283+68866848], %r92;
		ld.f64	%r93, [%r293+1511712720];
		neg.f64	%r441, %r93;
		ld.f64	%r442, [%r293+100780848];
		ld.f64	%r443, [%r293+1612493568];
		fma.rn.f64	%r96, %r441, %r442, %r443;
		st.f64	[%r293+1612493568], %r96;
		ld.f64	%r445, [%r293+201561696];
		ld.f64	%r446, [%r293+1713274416];
		fma.rn.f64	%r99, %r441, %r445, %r446;
		st.f64	[%r293+1713274416], %r99;
		ld.f64	%r448, [%r293+302342544];
		ld.f64	%r449, [%r293+1814055264];
		fma.rn.f64	%r102, %r441, %r448, %r449;
		st.f64	[%r293+1814055264], %r102;
		ld.f64	%r451, [%r293+403123392];
		ld.f64	%r452, [%r293+1914836112];
		fma.rn.f64	%r105, %r441, %r451, %r452;
		st.f64	[%r293+1914836112], %r105;
		ld.f64	%r454, [%r283];
		ld.f64	%r455, [%r283+103300272];
		fma.rn.f64	%r108, %r441, %r454, %r455;
		st.f64	[%r283+103300272], %r108;
		ld.f64	%r109, [%r293+2015616960];
		neg.f64	%r456, %r109;
		ld.f64	%r457, [%r293+100780848];
		ld.f64	%r458, [%r293+2116397808];
		fma.rn.f64	%r112, %r456, %r457, %r458;
		st.f64	[%r293+2116397808], %r112;
		ld.f64	%r460, [%r293+201561696];
		ld.f64	%r461, [%r293+2217178656];
		fma.rn.f64	%r115, %r456, %r460, %r461;
		st.f64	[%r293+2217178656], %r115;
		ld.f64	%r463, [%r293+302342544];
		ld.f64	%r464, [%r293+2317959504];
		fma.rn.f64	%r118, %r456, %r463, %r464;
		st.f64	[%r293+2317959504], %r118;
		ld.f64	%r466, [%r293+403123392];
		ld.f64	%r467, [%r293+2418740352];
		fma.rn.f64	%r121, %r456, %r466, %r467;
		st.f64	[%r293+2418740352], %r121;
		ld.f64	%r469, [%r283];
		ld.f64	%r470, [%r283+137733696];
		fma.rn.f64	%r124, %r456, %r469, %r470;
		st.f64	[%r283+137733696], %r124;
		ld.f64	%r472, [%r293+604685088];
		div.rn.f64	%r126, %r399, %r472;
		ld.f64	%r474, [%r293+705465936];
		mul.f64	%r473, %r474, %r126;
		st.f64	[%r293+705465936], %r473;
		ld.f64	%r476, [%r293+806246784];
		mul.f64	%r475, %r476, %r126;
		st.f64	[%r293+806246784], %r475;
		ld.f64	%r478, [%r293+907027632];
		mul.f64	%r477, %r478, %r126;
		st.f64	[%r293+907027632], %r477;
		ld.f64	%r480, [%r283+34433424];
		mul.f64	%r479, %r480, %r126;
		st.f64	[%r283+34433424], %r479;
		ld.f64	%r135, [%r293+100780848];
		neg.f64	%r481, %r135;
		ld.f64	%r482, [%r293+705465936];
		ld.f64	%r483, [%r293+201561696];
		fma.rn.f64	%r138, %r481, %r482, %r483;
		st.f64	[%r293+201561696], %r138;
		ld.f64	%r485, [%r293+806246784];
		ld.f64	%r486, [%r293+302342544];
		fma.rn.f64	%r141, %r481, %r485, %r486;
		st.f64	[%r293+302342544], %r141;
		ld.f64	%r488, [%r293+907027632];
		ld.f64	%r489, [%r293+403123392];
		fma.rn.f64	%r144, %r481, %r488, %r489;
		st.f64	[%r293+403123392], %r144;
		ld.f64	%r491, [%r283+34433424];
		ld.f64	%r492, [%r283];
		fma.rn.f64	%r147, %r481, %r491, %r492;
		st.f64	[%r283], %r147;
		ld.f64	%r148, [%r293+1108589328];
		neg.f64	%r493, %r148;
		ld.f64	%r494, [%r293+705465936];
		ld.f64	%r495, [%r293+1209370176];
		fma.rn.f64	%r151, %r493, %r494, %r495;
		st.f64	[%r293+1209370176], %r151;
		ld.f64	%r497, [%r293+806246784];
		ld.f64	%r498, [%r293+1310151024];
		fma.rn.f64	%r154, %r493, %r497, %r498;
		st.f64	[%r293+1310151024], %r154;
		ld.f64	%r500, [%r293+907027632];
		ld.f64	%r501, [%r293+1410931872];
		fma.rn.f64	%r157, %r493, %r500, %r501;
		st.f64	[%r293+1410931872], %r157;
		ld.f64	%r503, [%r283+34433424];
		ld.f64	%r504, [%r283+68866848];
		fma.rn.f64	%r160, %r493, %r503, %r504;
		st.f64	[%r283+68866848], %r160;
		ld.f64	%r161, [%r293+1612493568];
		neg.f64	%r505, %r161;
		ld.f64	%r506, [%r293+705465936];
		ld.f64	%r507, [%r293+1713274416];
		fma.rn.f64	%r164, %r505, %r506, %r507;
		st.f64	[%r293+1713274416], %r164;
		ld.f64	%r509, [%r293+806246784];
		ld.f64	%r510, [%r293+1814055264];
		fma.rn.f64	%r167, %r505, %r509, %r510;
		st.f64	[%r293+1814055264], %r167;
		ld.f64	%r512, [%r293+907027632];
		ld.f64	%r513, [%r293+1914836112];
		fma.rn.f64	%r170, %r505, %r512, %r513;
		st.f64	[%r293+1914836112], %r170;
		ld.f64	%r515, [%r283+34433424];
		ld.f64	%r516, [%r283+103300272];
		fma.rn.f64	%r173, %r505, %r515, %r516;
		st.f64	[%r283+103300272], %r173;
		ld.f64	%r174, [%r293+2116397808];
		neg.f64	%r517, %r174;
		ld.f64	%r518, [%r293+705465936];
		ld.f64	%r519, [%r293+2217178656];
		fma.rn.f64	%r177, %r517, %r518, %r519;
		st.f64	[%r293+2217178656], %r177;
		ld.f64	%r521, [%r293+806246784];
		ld.f64	%r522, [%r293+2317959504];
		fma.rn.f64	%r180, %r517, %r521, %r522;
		st.f64	[%r293+2317959504], %r180;
		ld.f64	%r524, [%r293+907027632];
		ld.f64	%r525, [%r293+2418740352];
		fma.rn.f64	%r183, %r517, %r524, %r525;
		st.f64	[%r293+2418740352], %r183;
		ld.f64	%r527, [%r283+34433424];
		ld.f64	%r528, [%r283+137733696];
		fma.rn.f64	%r186, %r517, %r527, %r528;
		st.f64	[%r283+137733696], %r186;
		ld.f64	%r530, [%r293+1209370176];
		div.rn.f64	%r188, %r399, %r530;
		ld.f64	%r532, [%r293+1310151024];
		mul.f64	%r531, %r532, %r188;
		st.f64	[%r293+1310151024], %r531;
		ld.f64	%r534, [%r293+1410931872];
		mul.f64	%r533, %r534, %r188;
		st.f64	[%r293+1410931872], %r533;
		ld.f64	%r536, [%r283+68866848];
		mul.f64	%r535, %r536, %r188;
		st.f64	[%r283+68866848], %r535;
		ld.f64	%r195, [%r293+201561696];
		neg.f64	%r537, %r195;
		ld.f64	%r538, [%r293+1310151024];
		ld.f64	%r539, [%r293+302342544];
		fma.rn.f64	%r198, %r537, %r538, %r539;
		st.f64	[%r293+302342544], %r198;
		ld.f64	%r541, [%r293+1410931872];
		ld.f64	%r542, [%r293+403123392];
		fma.rn.f64	%r201, %r537, %r541, %r542;
		st.f64	[%r293+403123392], %r201;
		ld.f64	%r544, [%r283+68866848];
		ld.f64	%r545, [%r283];
		fma.rn.f64	%r204, %r537, %r544, %r545;
		st.f64	[%r283], %r204;
		ld.f64	%r205, [%r293+705465936];
		neg.f64	%r546, %r205;
		ld.f64	%r547, [%r293+1310151024];
		ld.f64	%r548, [%r293+806246784];
		fma.rn.f64	%r208, %r546, %r547, %r548;
		st.f64	[%r293+806246784], %r208;
		ld.f64	%r550, [%r293+1410931872];
		ld.f64	%r551, [%r293+907027632];
		fma.rn.f64	%r211, %r546, %r550, %r551;
		st.f64	[%r293+907027632], %r211;
		ld.f64	%r553, [%r283+68866848];
		ld.f64	%r554, [%r283+34433424];
		fma.rn.f64	%r214, %r546, %r553, %r554;
		st.f64	[%r283+34433424], %r214;
		ld.f64	%r215, [%r293+1713274416];
		neg.f64	%r555, %r215;
		ld.f64	%r556, [%r293+1310151024];
		ld.f64	%r557, [%r293+1814055264];
		fma.rn.f64	%r218, %r555, %r556, %r557;
		st.f64	[%r293+1814055264], %r218;
		ld.f64	%r559, [%r293+1410931872];
		ld.f64	%r560, [%r293+1914836112];
		fma.rn.f64	%r221, %r555, %r559, %r560;
		st.f64	[%r293+1914836112], %r221;
		ld.f64	%r562, [%r283+68866848];
		ld.f64	%r563, [%r283+103300272];
		fma.rn.f64	%r224, %r555, %r562, %r563;
		st.f64	[%r283+103300272], %r224;
		ld.f64	%r225, [%r293+2217178656];
		neg.f64	%r564, %r225;
		ld.f64	%r565, [%r293+1310151024];
		ld.f64	%r566, [%r293+2317959504];
		fma.rn.f64	%r228, %r564, %r565, %r566;
		st.f64	[%r293+2317959504], %r228;
		ld.f64	%r568, [%r293+1410931872];
		ld.f64	%r569, [%r293+2418740352];
		fma.rn.f64	%r231, %r564, %r568, %r569;
		st.f64	[%r293+2418740352], %r231;
		ld.f64	%r571, [%r283+68866848];
		ld.f64	%r572, [%r283+137733696];
		fma.rn.f64	%r234, %r564, %r571, %r572;
		st.f64	[%r283+137733696], %r234;
		ld.f64	%r574, [%r293+1814055264];
		div.rn.f64	%r236, %r399, %r574;
		ld.f64	%r576, [%r293+1914836112];
		mul.f64	%r575, %r576, %r236;
		st.f64	[%r293+1914836112], %r575;
		ld.f64	%r578, [%r283+103300272];
		mul.f64	%r577, %r578, %r236;
		st.f64	[%r283+103300272], %r577;
		ld.f64	%r241, [%r293+302342544];
		neg.f64	%r579, %r241;
		ld.f64	%r580, [%r293+1914836112];
		ld.f64	%r581, [%r293+403123392];
		fma.rn.f64	%r244, %r579, %r580, %r581;
		st.f64	[%r293+403123392], %r244;
		ld.f64	%r583, [%r283+103300272];
		ld.f64	%r584, [%r283];
		fma.rn.f64	%r247, %r579, %r583, %r584;
		st.f64	[%r283], %r247;
		ld.f64	%r248, [%r293+806246784];
		neg.f64	%r585, %r248;
		ld.f64	%r586, [%r293+1914836112];
		ld.f64	%r587, [%r293+907027632];
		fma.rn.f64	%r251, %r585, %r586, %r587;
		st.f64	[%r293+907027632], %r251;
		ld.f64	%r589, [%r283+103300272];
		ld.f64	%r590, [%r283+34433424];
		fma.rn.f64	%r254, %r585, %r589, %r590;
		st.f64	[%r283+34433424], %r254;
		ld.f64	%r255, [%r293+1310151024];
		neg.f64	%r591, %r255;
		ld.f64	%r592, [%r293+1914836112];
		ld.f64	%r593, [%r293+1410931872];
		fma.rn.f64	%r258, %r591, %r592, %r593;
		st.f64	[%r293+1410931872], %r258;
		ld.f64	%r595, [%r283+103300272];
		ld.f64	%r596, [%r283+68866848];
		fma.rn.f64	%r261, %r591, %r595, %r596;
		st.f64	[%r283+68866848], %r261;
		ld.f64	%r262, [%r293+2317959504];
		neg.f64	%r597, %r262;
		ld.f64	%r598, [%r293+1914836112];
		ld.f64	%r599, [%r293+2418740352];
		fma.rn.f64	%r265, %r597, %r598, %r599;
		st.f64	[%r293+2418740352], %r265;
		ld.f64	%r267, [%r283+103300272];
		ld.f64	%r601, [%r283+137733696];
		fma.rn.f64	%r268, %r597, %r267, %r601;
		st.f64	[%r283+137733696], %r268;
		ld.f64	%r604, [%r293+2418740352];
		div.rn.f64	%r602, %r399, %r604;
		mul.f64	%r271, %r602, %r268;
		st.f64	[%r283+137733696], %r271;
		neg.f64	%r605, %r271;
		ld.f64	%r606, [%r293+403123392];
		ld.f64	%r607, [%r283];
		fma.rn.f64	%r274, %r605, %r606, %r607;
		st.f64	[%r283], %r274;
		ld.f64	%r609, [%r293+907027632];
		ld.f64	%r610, [%r283+34433424];
		fma.rn.f64	%r278, %r605, %r609, %r610;
		st.f64	[%r283+34433424], %r278;
		ld.f64	%r612, [%r293+1410931872];
		ld.f64	%r613, [%r283+68866848];
		fma.rn.f64	%r281, %r605, %r612, %r613;
		st.f64	[%r283+68866848], %r281;
		ld.f64	%r615, [%r293+1914836112];
		fma.rn.f64	%r284, %r605, %r615, %r267;
		st.f64	[%r283+103300272], %r284;
		add.u32	%r24, %r24, 128;
		add.u64	%r293, %r293, 1024;
		add.u64	%r283, %r283, 27206656;
		setp.gt.s32	%r616, %r28, %r24;
	@%r616	bra	$L152;
$L151:
	// joining 4;
	// join 4;
	// joining 2;
		bar.sync	0;
	// join 2;
	@%r620	bra.uni	$L156;
	@%r621	bra	$L157;
		add.u64	%r352, %r352, 161;
		add.u64	%r358, %r358, 163;
		setp.ne.u64	%r617, %r358, %r368;
		selp.u32	%r622, 1, 0, %r617;
		st.shared.u32	[__oacc_bcast], %r622;
$L157:
$L156:
		bar.sync	0;
		ld.shared.u32	%r623, [__oacc_bcast];
		setp.ne.u32	%r617, %r623, 0;
		bar.sync	0;
	@%r617	bra.uni	$L153;
$L149:
	ret;
}

// BEGIN FUNCTION DECL: x_solve$_omp_fn$9
.entry x_solve$_omp_fn$9 (.param.u64 %in_ar0);

// BEGIN FUNCTION DEF: x_solve$_omp_fn$9
.entry x_solve$_omp_fn$9 (.param.u64 %in_ar0)
{
	.reg.u64 %ar0;
	ld.param.u64 %ar0, [%in_ar0];
	.reg.u32 %r22;
	.reg.u32 %r25;
	.reg.u32 %r27;
	.reg.u32 %r29;
	.reg.f64 %r30;
	.reg.u32 %r31;
	.reg.u32 %r32;
	.reg.f64 %r34;
	.reg.u32 %r38;
	.reg.f64 %r39;
	.reg.u32 %r40;
	.reg.u64 %r41;
	.reg.u64 %r43;
	.reg.f64 %r47;
	.reg.f64 %r50;
	.reg.f64 %r52;
	.reg.f64 %r53;
	.reg.f64 %r55;
	.reg.f64 %r56;
	.reg.f64 %r58;
	.reg.f64 %r59;
	.reg.f64 %r62;
	.reg.f64 %r63;
	.reg.f64 %r66;
	.reg.f64 %r68;
	.reg.f64 %r69;
	.reg.f64 %r72;
	.reg.f64 %r74;
	.reg.f64 %r77;
	.reg.f64 %r78;
	.reg.f64 %r80;
	.reg.f64 %r81;
	.reg.f64 %r84;
	.reg.f64 %r86;
	.reg.f64 %r88;
	.reg.f64 %r89;
	.reg.f64 %r93;
	.reg.f64 %r95;
	.reg.f64 %r97;
	.reg.f64 %r98;
	.reg.f64 %r101;
	.reg.f64 %r103;
	.reg.f64 %r104;
	.reg.f64 %r107;
	.reg.f64 %r109;
	.reg.f64 %r110;
	.reg.f64 %r113;
	.reg.f64 %r116;
	.reg.f64 %r119;
	.reg.f64 %r123;
	.reg.f64 %r124;
	.reg.u64 %r128;
	.reg.u32 %r132;
	.reg.f64 %r135;
	.reg.f64 %r136;
	.reg.u32 %r139;
	.reg.u32 %r140;
	.reg.u32 %r144;
	.reg.u32 %r145;
	.reg.u32 %r146;
	.reg.f64 %r147;
	.reg.f64 %r149;
	.reg.f64 %r152;
	.reg.f64 %r154;
	.reg.f64 %r155;
	.reg.f64 %r158;
	.reg.f64 %r160;
	.reg.f64 %r162;
	.reg.f64 %r165;
	.reg.f64 %r167;
	.reg.f64 %r169;
	.reg.f64 %r170;
	.reg.f64 %r173;
	.reg.f64 %r175;
	.reg.f64 %r178;
	.reg.f64 %r180;
	.reg.f64 %r182;
	.reg.f64 %r185;
	.reg.f64 %r188;
	.reg.u64 %r191;
	.reg.u64 %r194;
	.reg.u64 %r227;
	.reg.u64 %r228;
	.reg.u64 %r231;
	.reg.u64 %r252;
	.reg.u64 %r256;
	.reg.u64 %r258;
	.reg.u64 %r261;
	.reg.u64 %r264;
	.reg.u64 %r265;
	.reg.u64 %r266;
	.reg.u32 %r267;
	.reg.u32 %r268;
	.reg.u32 %r269;
	.reg.pred %r270;
	.reg.u64 %r271;
	.reg.u64 %r272;
	.reg.u32 %r273;
	.reg.pred %r274;
	.reg.u64 %r275;
	.reg.u64 %r277;
	.reg.u64 %r279;
	.reg.u64 %r280;
	.reg.u64 %r281;
	.reg.u64 %r282;
	.reg.u64 %r283;
	.reg.u64 %r284;
	.reg.u64 %r285;
	.reg.u64 %r286;
	.reg.u64 %r290;
	.reg.u64 %r291;
	.reg.u64 %r292;
	.reg.u64 %r293;
	.reg.u64 %r294;
	.reg.f64 %r295;
	.reg.f64 %r296;
	.reg.u64 %r303;
	.reg.u64 %r304;
	.reg.u64 %r305;
	.reg.f64 %r306;
	.reg.f64 %r307;
	.reg.u32 %r317;
	.reg.u64 %r318;
	.reg.u32 %r319;
	.reg.u64 %r320;
	.reg.u64 %r321;
	.reg.f64 %r322;
	.reg.f64 %r323;
	.reg.f64 %r324;
	.reg.f64 %r334;
	.reg.f64 %r335;
	.reg.f64 %r345;
	.reg.f64 %r346;
	.reg.f64 %r356;
	.reg.f64 %r357;
	.reg.u64 %r367;
	.reg.u64 %r368;
	.reg.f64 %r378;
	.reg.f64 %r379;
	.reg.f64 %r380;
	.reg.f64 %r381;
	.reg.f64 %r382;
	.reg.f64 %r383;
	.reg.f64 %r385;
	.reg.f64 %r387;
	.reg.f64 %r389;
	.reg.f64 %r390;
	.reg.f64 %r391;
	.reg.f64 %r392;
	.reg.f64 %r393;
	.reg.f64 %r394;
	.reg.f64 %r395;
	.reg.f64 %r396;
	.reg.f64 %r397;
	.reg.f64 %r399;
	.reg.f64 %r401;
	.reg.f64 %r403;
	.reg.f64 %r404;
	.reg.f64 %r405;
	.reg.f64 %r406;
	.reg.f64 %r407;
	.reg.f64 %r408;
	.reg.f64 %r409;
	.reg.f64 %r410;
	.reg.f64 %r411;
	.reg.f64 %r413;
	.reg.f64 %r415;
	.reg.f64 %r416;
	.reg.f64 %r418;
	.reg.f64 %r419;
	.reg.f64 %r420;
	.reg.f64 %r421;
	.reg.f64 %r422;
	.reg.f64 %r423;
	.reg.f64 %r424;
	.reg.f64 %r425;
	.reg.f64 %r426;
	.reg.u32 %r427;
	.reg.pred %r428;
	.reg.u64 %r429;
	.reg.u64 %r430;
	.reg.u64 %r431;
	.reg.f64 %r432;
	.reg.f64 %r433;
	.reg.u64 %r439;
	.reg.u64 %r440;
	.reg.u64 %r441;
	.reg.u64 %r442;
	.reg.u64 %r449;
	.reg.u64 %r450;
	.reg.u64 %r451;
	.reg.f64 %r452;
	.reg.f64 %r453;
	.reg.u64 %r463;
	.reg.u64 %r465;
	.reg.u64 %r466;
	.reg.f64 %r467;
	.reg.f64 %r468;
	.reg.f64 %r469;
	.reg.f64 %r479;
	.reg.f64 %r480;
	.reg.f64 %r490;
	.reg.f64 %r491;
	.reg.f64 %r501;
	.reg.f64 %r502;
	.reg.u64 %r512;
	.reg.u64 %r513;
	.reg.f64 %r523;
	.reg.f64 %r524;
	.reg.f64 %r525;
	.reg.f64 %r526;
	.reg.f64 %r527;
	.reg.f64 %r528;
	.reg.f64 %r529;
	.reg.f64 %r530;
	.reg.f64 %r531;
	.reg.f64 %r532;
	.reg.f64 %r533;
	.reg.f64 %r534;
	.reg.f64 %r535;
	.reg.f64 %r536;
	.reg.f64 %r537;
	.reg.f64 %r538;
	.reg.f64 %r539;
	.reg.f64 %r540;
	.reg.f64 %r541;
	.reg.f64 %r542;
	.reg.f64 %r544;
	.reg.f64 %r546;
	.reg.f64 %r548;
	.reg.f64 %r549;
	.reg.f64 %r550;
	.reg.f64 %r551;
	.reg.f64 %r552;
	.reg.f64 %r553;
	.reg.f64 %r554;
	.reg.f64 %r555;
	.reg.f64 %r556;
	.reg.f64 %r558;
	.reg.f64 %r560;
	.reg.f64 %r561;
	.reg.f64 %r563;
	.reg.f64 %r564;
	.reg.f64 %r565;
	.reg.f64 %r566;
	.reg.f64 %r567;
	.reg.f64 %r568;
	.reg.f64 %r569;
	.reg.f64 %r570;
	.reg.f64 %r571;
	.reg.pred %r572;
	.reg.u64 %r573;
	.reg.u64 %r574;
	.reg.pred %r575;
	.reg.pred %r576;
	.reg.u32 %r577;
	.reg.u32 %r578;
	.reg.u32 %r579;
	.reg.u32 %r580;
	{
		.reg.u32	%y;
		mov.u32	%y, %tid.y;
		setp.ne.u32	%r575, %y, 0;
	}
	{
		.reg.u32	%x;
		mov.u32	%x, %tid.x;
		setp.ne.u32	%r576, %x, 0;
	}
	@%r575	bra.uni	$L178;
	@%r576	bra	$L179;
		mov.u64	%r265, %ar0;
		ld.u64	%r266, [%r265+8];
		ld.u32	%r25, [%r266];
		mov.u32	%r139, %nctaid.x;
		mov.u32	%r140, %ctaid.x;
		add.u32	%r267, %r25, -1;
		add.u32	%r268, %r267, %r139;
		div.s32	%r132, %r268, %r139;
		mul.lo.u32	%r22, %r132, %r140;
		add.u32	%r269, %r22, %r132;
		min.s32	%r32, %r269, %r25;
		setp.lt.s32	%r270, %r22, %r32;
		selp.u32	%r579, 1, 0, %r270;
		st.shared.u32	[__oacc_bcast], %r579;
$L179:
$L178:
		bar.sync	0;
		ld.shared.u32	%r580, [__oacc_bcast];
		setp.ne.u32	%r270, %r580, 0;
		bar.sync	0;
	@!%r270	bra.uni	$L164;
	@%r575	bra.uni	$L176;
	@%r576	bra	$L177;
		ld.u64	%r271, [%r265+16];
		ld.u32	%r27, [%r271];
		ld.u64	%r272, [%r265+24];
		ld.u32	%r29, [%r272];
$L177:
$L176:
$L169:
	@%r575	bra.uni	$L174;
	@%r576	bra	$L175;
		add.u32	%r22, %r22, 1;
	// fork 2;
		cvta.shared.u64	%r574, __oacc_bcast;
		st.u32	[%r574], %r22;
		st.u32	[%r574+4], %r27;
		st.u32	[%r574+8], %r29;
		st.u32	[%r574+12], %r32;
		st.u64	[%r574+16], %r265;
$L175:
$L174:
		bar.sync	0;
	// forked 2;
		cvta.shared.u64	%r573, __oacc_bcast;
		ld.u32	%r22, [%r573];
		ld.u32	%r27, [%r573+4];
		ld.u32	%r29, [%r573+8];
		ld.u32	%r32, [%r573+12];
		ld.u64	%r265, [%r573+16];
	// fork 4;
	// forked 4;
		mov.u32	%r144, %tid.y;
		mov.u32	%r146, %tid.x;
		shl.b32	%r273, %r144, 5;
		add.u32	%r38, %r273, %r146;
		setp.gt.s32	%r274, %r27, %r38;
	@%r274	bra	$L166;
$L168:
	// joining 4;
	// join 4;
	// joining 2;
		bar.sync	0;
	// join 2;
	@%r575	bra.uni	$L172;
	@%r576	bra	$L173;
		setp.ne.u32	%r572, %r32, %r22;
		selp.u32	%r577, 1, 0, %r572;
		st.shared.u32	[__oacc_bcast], %r577;
$L173:
$L172:
		bar.sync	0;
		ld.shared.u32	%r578, [__oacc_bcast];
		setp.ne.u32	%r572, %r578, 0;
		bar.sync	0;
	@%r572	bra.uni	$L169;
		bra	$L164;
$L166:
		ld.u64	%r41, [%r265+32];
		ld.u64	%r43, [%r265];
		add.u32	%r31, %r29, 1;
		add.u32	%r145, %r38, 1;
		cvt.s64.s32	%r128, %r29;
		cvt.s64.s32	%r275, %r29;
		cvt.s64.s32	%r277, %r22;
		shl.b64	%r279, %r277, 2;
		add.u64	%r280, %r279, %r277;
		shl.b64	%r281, %r280, 5;
		add.u64	%r282, %r281, %r277;
		mad.lo.u64	%r191, %r275, 25921, %r282;
		cvt.s64.s32	%r283, %r145;
		add.u64	%r284, %r283, %r191;
		shl.b64	%r285, %r284, 3;
		add.u64	%r194, %r43, %r285;
		cvt.s64.s32	%r286, %r31;
		mul.lo.u64	%r290, %r277, 163;
		mad.lo.u64	%r291, %r283, 26569, %r290;
		add.u64	%r292, %r291, %r286;
		shl.b64	%r293, %r292, 3;
		add.u64	%r294, %r41, %r293;
		ld.f64	%r296, [%r294];
		neg.f64	%r295, %r296;
		add.u64	%r303, %r291, %r128;
		shl.b64	%r304, %r303, 3;
		add.u64	%r305, %r41, %r304;
		ld.f64	%r306, [%r194+67187232];
		ld.f64	%r307, [%r305];
		fma.rn.f64	%r135, %r295, %r306, %r307;
		st.f64	[%r305], %r135;
		mov.u32	%r317, 163;
		mul.wide.s32	%r227, %r22, %r317;
		mov.u32	%r319, 26569;
		mul.wide.s32	%r318, %r145, %r319;
		add.u64	%r228, %r318, %r227;
		add.u64	%r320, %r286, %r228;
		shl.b64	%r321, %r320, 3;
		add.u64	%r231, %r41, %r321;
		ld.f64	%r323, [%r231+34433424];
		neg.f64	%r322, %r323;
		ld.f64	%r324, [%r194+167968080];
		fma.rn.f64	%r123, %r322, %r324, %r135;
		st.f64	[%r305], %r123;
		ld.f64	%r109, [%r231+68866848];
		neg.f64	%r334, %r109;
		ld.f64	%r335, [%r194+268748928];
		fma.rn.f64	%r103, %r334, %r335, %r123;
		st.f64	[%r305], %r103;
		ld.f64	%r88, [%r231+103300272];
		neg.f64	%r345, %r88;
		ld.f64	%r346, [%r194+369529776];
		fma.rn.f64	%r77, %r345, %r346, %r103;
		st.f64	[%r305], %r77;
		ld.f64	%r68, [%r231+137733696];
		neg.f64	%r356, %r68;
		ld.f64	%r357, [%r194+470310624];
		fma.rn.f64	%r30, %r356, %r357, %r77;
		st.f64	[%r305], %r30;
		add.u64	%r367, %r128, %r228;
		shl.b64	%r368, %r367, 3;
		add.u64	%r252, %r41, %r368;
		ld.f64	%r136, [%r294];
		ld.f64	%r379, [%r194+571091472];
		neg.f64	%r378, %r379;
		ld.f64	%r380, [%r252+34433424];
		fma.rn.f64	%r34, %r378, %r136, %r380;
		st.f64	[%r252+34433424], %r34;
		ld.f64	%r382, [%r194+671872320];
		neg.f64	%r381, %r382;
		ld.f64	%r383, [%r231+34433424];
		fma.rn.f64	%r39, %r381, %r383, %r34;
		st.f64	[%r252+34433424], %r39;
		ld.f64	%r385, [%r194+772653168];
		fma.rn.f64	%r124, %r334, %r385, %r39;
		st.f64	[%r252+34433424], %r124;
		ld.f64	%r387, [%r194+873434016];
		fma.rn.f64	%r147, %r345, %r387, %r124;
		st.f64	[%r252+34433424], %r147;
		ld.f64	%r389, [%r194+974214864];
		fma.rn.f64	%r149, %r356, %r389, %r147;
		st.f64	[%r252+34433424], %r149;
		neg.f64	%r390, %r136;
		ld.f64	%r391, [%r194+1074995712];
		ld.f64	%r392, [%r252+68866848];
		fma.rn.f64	%r152, %r390, %r391, %r392;
		st.f64	[%r252+68866848], %r152;
		ld.f64	%r154, [%r231+34433424];
		ld.f64	%r394, [%r194+1175776560];
		neg.f64	%r393, %r394;
		fma.rn.f64	%r155, %r393, %r154, %r152;
		st.f64	[%r252+68866848], %r155;
		ld.f64	%r396, [%r194+1276557408];
		neg.f64	%r395, %r396;
		ld.f64	%r397, [%r231+68866848];
		fma.rn.f64	%r158, %r395, %r397, %r155;
		st.f64	[%r252+68866848], %r158;
		ld.f64	%r399, [%r194+1377338256];
		fma.rn.f64	%r160, %r345, %r399, %r158;
		st.f64	[%r252+68866848], %r160;
		ld.f64	%r401, [%r194+1478119104];
		fma.rn.f64	%r162, %r356, %r401, %r160;
		st.f64	[%r252+68866848], %r162;
		ld.f64	%r403, [%r194+1578899952];
		ld.f64	%r404, [%r252+103300272];
		fma.rn.f64	%r165, %r390, %r403, %r404;
		st.f64	[%r252+103300272], %r165;
		neg.f64	%r405, %r154;
		ld.f64	%r406, [%r194+1679680800];
		fma.rn.f64	%r167, %r405, %r406, %r165;
		st.f64	[%r252+103300272], %r167;
		ld.f64	%r169, [%r231+68866848];
		ld.f64	%r408, [%r194+1780461648];
		neg.f64	%r407, %r408;
		fma.rn.f64	%r170, %r407, %r169, %r167;
		st.f64	[%r252+103300272], %r170;
		ld.f64	%r410, [%r194+1881242496];
		neg.f64	%r409, %r410;
		ld.f64	%r411, [%r231+103300272];
		fma.rn.f64	%r173, %r409, %r411, %r170;
		st.f64	[%r252+103300272], %r173;
		ld.f64	%r413, [%r194+1982023344];
		fma.rn.f64	%r175, %r356, %r413, %r173;
		st.f64	[%r252+103300272], %r175;
		ld.f64	%r415, [%r194+2082804192];
		ld.f64	%r416, [%r252+137733696];
		fma.rn.f64	%r178, %r390, %r415, %r416;
		st.f64	[%r252+137733696], %r178;
		ld.f64	%r418, [%r194+2183585040];
		fma.rn.f64	%r180, %r405, %r418, %r178;
		st.f64	[%r252+137733696], %r180;
		neg.f64	%r419, %r169;
		ld.f64	%r420, [%r194+2284365888];
		fma.rn.f64	%r182, %r419, %r420, %r180;
		st.f64	[%r252+137733696], %r182;
		ld.f64	%r422, [%r194+2385146736];
		neg.f64	%r421, %r422;
		ld.f64	%r423, [%r231+103300272];
		fma.rn.f64	%r185, %r421, %r423, %r182;
		st.f64	[%r252+137733696], %r185;
		ld.f64	%r425, [%r194+2485927584];
		neg.f64	%r424, %r425;
		ld.f64	%r426, [%r231+137733696];
		fma.rn.f64	%r188, %r424, %r426, %r185;
		st.f64	[%r252+137733696], %r188;
		add.u32	%r427, %r38, 128;
		setp.le.s32	%r428, %r27, %r427;
	@%r428	bra	$L168;
		add.u32	%r40, %r38, 129;
		cvt.s64.s32	%r429, %r40;
		add.u64	%r430, %r429, %r191;
		shl.b64	%r431, %r430, 3;
		add.u64	%r256, %r43, %r431;
		ld.f64	%r433, [%r256+67187232];
		neg.f64	%r432, %r433;
		mad.lo.u64	%r439, %r429, 26569, %r290;
		add.u64	%r440, %r439, %r286;
		shl.b64	%r441, %r440, 3;
		add.u64	%r442, %r41, %r441;
		add.u64	%r449, %r439, %r128;
		shl.b64	%r450, %r449, 3;
		add.u64	%r451, %r41, %r450;
		ld.f64	%r452, [%r442];
		ld.f64	%r453, [%r451];
		fma.rn.f64	%r47, %r432, %r452, %r453;
		st.f64	[%r451], %r47;
		mul.wide.s32	%r463, %r40, %r319;
		add.u64	%r258, %r463, %r227;
		add.u64	%r465, %r286, %r258;
		shl.b64	%r466, %r465, 3;
		add.u64	%r261, %r41, %r466;
		ld.f64	%r468, [%r256+167968080];
		neg.f64	%r467, %r468;
		ld.f64	%r469, [%r261+34433424];
		fma.rn.f64	%r50, %r467, %r469, %r47;
		st.f64	[%r451], %r50;
		ld.f64	%r52, [%r261+68866848];
		ld.f64	%r480, [%r256+268748928];
		neg.f64	%r479, %r480;
		fma.rn.f64	%r53, %r479, %r52, %r50;
		st.f64	[%r451], %r53;
		ld.f64	%r55, [%r261+103300272];
		ld.f64	%r491, [%r256+369529776];
		neg.f64	%r490, %r491;
		fma.rn.f64	%r56, %r490, %r55, %r53;
		st.f64	[%r451], %r56;
		ld.f64	%r58, [%r261+137733696];
		ld.f64	%r502, [%r256+470310624];
		neg.f64	%r501, %r502;
		fma.rn.f64	%r59, %r501, %r58, %r56;
		st.f64	[%r451], %r59;
		add.u64	%r512, %r128, %r258;
		shl.b64	%r513, %r512, 3;
		add.u64	%r264, %r41, %r513;
		ld.f64	%r62, [%r442];
		ld.f64	%r524, [%r256+571091472];
		neg.f64	%r523, %r524;
		ld.f64	%r525, [%r264+34433424];
		fma.rn.f64	%r63, %r523, %r62, %r525;
		st.f64	[%r264+34433424], %r63;
		ld.f64	%r527, [%r256+671872320];
		neg.f64	%r526, %r527;
		ld.f64	%r528, [%r261+34433424];
		fma.rn.f64	%r66, %r526, %r528, %r63;
		st.f64	[%r264+34433424], %r66;
		neg.f64	%r529, %r52;
		ld.f64	%r530, [%r256+772653168];
		fma.rn.f64	%r69, %r529, %r530, %r66;
		st.f64	[%r264+34433424], %r69;
		neg.f64	%r531, %r55;
		ld.f64	%r532, [%r256+873434016];
		fma.rn.f64	%r72, %r531, %r532, %r69;
		st.f64	[%r264+34433424], %r72;
		neg.f64	%r533, %r58;
		ld.f64	%r534, [%r256+974214864];
		fma.rn.f64	%r74, %r533, %r534, %r72;
		st.f64	[%r264+34433424], %r74;
		neg.f64	%r535, %r62;
		ld.f64	%r536, [%r256+1074995712];
		ld.f64	%r537, [%r264+68866848];
		fma.rn.f64	%r78, %r535, %r536, %r537;
		st.f64	[%r264+68866848], %r78;
		ld.f64	%r80, [%r261+34433424];
		ld.f64	%r539, [%r256+1175776560];
		neg.f64	%r538, %r539;
		fma.rn.f64	%r81, %r538, %r80, %r78;
		st.f64	[%r264+68866848], %r81;
		ld.f64	%r541, [%r256+1276557408];
		neg.f64	%r540, %r541;
		ld.f64	%r542, [%r261+68866848];
		fma.rn.f64	%r84, %r540, %r542, %r81;
		st.f64	[%r264+68866848], %r84;
		ld.f64	%r544, [%r256+1377338256];
		fma.rn.f64	%r86, %r531, %r544, %r84;
		st.f64	[%r264+68866848], %r86;
		ld.f64	%r546, [%r256+1478119104];
		fma.rn.f64	%r89, %r533, %r546, %r86;
		st.f64	[%r264+68866848], %r89;
		ld.f64	%r548, [%r256+1578899952];
		ld.f64	%r549, [%r264+103300272];
		fma.rn.f64	%r93, %r535, %r548, %r549;
		st.f64	[%r264+103300272], %r93;
		neg.f64	%r550, %r80;
		ld.f64	%r551, [%r256+1679680800];
		fma.rn.f64	%r95, %r550, %r551, %r93;
		st.f64	[%r264+103300272], %r95;
		ld.f64	%r97, [%r261+68866848];
		ld.f64	%r553, [%r256+1780461648];
		neg.f64	%r552, %r553;
		fma.rn.f64	%r98, %r552, %r97, %r95;
		st.f64	[%r264+103300272], %r98;
		ld.f64	%r555, [%r256+1881242496];
		neg.f64	%r554, %r555;
		ld.f64	%r556, [%r261+103300272];
		fma.rn.f64	%r101, %r554, %r556, %r98;
		st.f64	[%r264+103300272], %r101;
		ld.f64	%r558, [%r256+1982023344];
		fma.rn.f64	%r104, %r533, %r558, %r101;
		st.f64	[%r264+103300272], %r104;
		ld.f64	%r560, [%r256+2082804192];
		ld.f64	%r561, [%r264+137733696];
		fma.rn.f64	%r107, %r535, %r560, %r561;
		st.f64	[%r264+137733696], %r107;
		ld.f64	%r563, [%r256+2183585040];
		fma.rn.f64	%r110, %r550, %r563, %r107;
		st.f64	[%r264+137733696], %r110;
		neg.f64	%r564, %r97;
		ld.f64	%r565, [%r256+2284365888];
		fma.rn.f64	%r113, %r564, %r565, %r110;
		st.f64	[%r264+137733696], %r113;
		ld.f64	%r567, [%r256+2385146736];
		neg.f64	%r566, %r567;
		ld.f64	%r568, [%r261+103300272];
		fma.rn.f64	%r116, %r566, %r568, %r113;
		st.f64	[%r264+137733696], %r116;
		ld.f64	%r570, [%r256+2485927584];
		neg.f64	%r569, %r570;
		ld.f64	%r571, [%r261+137733696];
		fma.rn.f64	%r119, %r569, %r571, %r116;
		st.f64	[%r264+137733696], %r119;
		bra	$L168;
$L164:
	ret;
}
//:FUNC_MAP "x_solve$_omp_fn$9", 0, 0x4, 0x20
//:FUNC_MAP "x_solve$_omp_fn$8", 0, 0x4, 0x20
//:FUNC_MAP "x_solve$_omp_fn$7", 0, 0x4, 0x20
//:FUNC_MAP "x_solve$_omp_fn$6", 0, 0x4, 0x20
//:FUNC_MAP "x_solve$_omp_fn$5", 0, 0x4, 0x20
//:FUNC_MAP "x_solve$_omp_fn$4", 0, 0x4, 0x20
//:FUNC_MAP "x_solve$_omp_fn$3", 0, 0x8, 0x20
//:FUNC_MAP "x_solve$_omp_fn$2", 0, 0x8, 0x20
//:FUNC_MAP "x_solve$_omp_fn$1", 0, 0x8, 0x20
//:FUNC_MAP "x_solve$_omp_fn$0", 0, 0x8, 0x20

// BEGIN VAR DEF: __oacc_bcast
.shared .align 8 .u8 __oacc_bcast[112];
string-delimiter
  )

(define ptx-sample19
  #<<string-delimiter
// BEGIN PREAMBLE
        .version        3.1
        .target sm_35
        .address_size 64
// END PREAMBLE


// BEGIN FUNCTION DECL: cpu_stencil$_omp_fn$1
.func cpu_stencil$_omp_fn$1 (.param.u64 %in_ar0);

// BEGIN FUNCTION DEF: cpu_stencil$_omp_fn$1
.func cpu_stencil$_omp_fn$1 (.param.u64 %in_ar0)
{
        .reg.u64 %ar0;
        ld.param.u64 %ar0, [%in_ar0];
        .reg.u32 %r22;
        .reg.u32 %r23;
        .reg.u32 %r24;
        .reg.u32 %r25;
        .reg.u32 %r26;
        .reg.u32 %r27;
        .reg.u32 %r28;
        .reg.u32 %r29;
        .reg.u32 %r30;
        .reg.u32 %r31;
        .reg.u32 %r32;
        .reg.u32 %r33;
        .reg.u32 %r34;
        .reg.u32 %r36;
        .reg.u32 %r37;
        .reg.u32 %r38;
        .reg.u32 %r40;
        .reg.u32 %r41;
        .reg.u32 %r42;
        .reg.u32 %r43;
        .reg.u64 %r44;
        .reg.u64 %r45;
        .reg.f32 %r46;
        .reg.f32 %r47;
        .reg.u32 %r52;
        .reg.u32 %r54;
        .reg.u32 %r55;
        .reg.u32 %r58;
        .reg.u32 %r64;
        .reg.u32 %r65;
        .reg.u32 %r71;
        .reg.u32 %r74;
        .reg.u32 %r76;
        .reg.u32 %r79;
        .reg.u32 %r80;
        .reg.u32 %r83;
        .reg.u32 %r86;
        .reg.u32 %r87;
        .reg.u32 %r93;
        .reg.f32 %r104;
        .reg.u32 %r106;
        .reg.u64 %r111;
        .reg.u64 %r113;
        .reg.u64 %r115;
        .reg.u64 %r117;
        .reg.u64 %r118;
        .reg.u64 %r122;
        .reg.u64 %r124;
        .reg.u64 %r126;
        .reg.u64 %r128;
        .reg.u32 %r129;
        .reg.u32 %r131;
        .reg.u64 %r135;
        .reg.u32 %r136;
        .reg.u32 %r137;
        .reg.u32 %r138;
        .reg.pred %r139;
        .reg.pred %r141;
        .reg.u32 %r143;
        .reg.u32 %r145;
        .reg.u32 %r147;
        .reg.u32 %r148;
        .reg.pred %r149;
        .reg.pred %r150;
        .reg.pred %r152;
        .reg.pred %r153;
        .reg.pred %r154;
        .reg.pred %r155;
        .reg.u32 %r156;
        .reg.u32 %r157;
        .reg.u32 %r158;
        .reg.u64 %r159;
        .reg.u64 %r160;
        .reg.u64 %r162;
        .reg.u64 %r163;
        .reg.u32 %r164;
        .reg.u32 %r165;
        .reg.u64 %r166;
        .reg.u32 %r167;
        .reg.u32 %r168;
        .reg.u64 %r169;
        .reg.u32 %r170;
        .reg.u32 %r171;
        .reg.u64 %r172;
        .reg.u32 %r173;
        .reg.u32 %r174;
        .reg.u32 %r175;
        .reg.u64 %r176;
        .reg.u64 %r177;
        .reg.u64 %r178;
        .reg.f32 %r179;
        .reg.f32 %r180;
        .reg.f32 %r181;
        .reg.u64 %r182;
        .reg.f32 %r183;
        .reg.f32 %r184;
        .reg.u64 %r185;
        .reg.f32 %r186;
        .reg.f32 %r187;
        .reg.f32 %r188;
        .reg.f32 %r189;
        .reg.f32 %r190;
        .reg.f32 %r191;
        .reg.f32 %r192;
        .reg.f32 %r193;
        .reg.f32 %r194;
        .reg.v2.u32 %r196;
        .reg.pred %r197;
        .reg.u32 %r198;
        .reg.u32 %r199;
        .reg.u32 %r200;
        .reg.u32 %r201;
        .reg.pred %r202;
        .reg.pred %r203;
        .reg.pred %r204;
        .reg.pred %r205;
        .reg.pred %r206;
        .reg.pred %r207;
        .reg.pred %r208;
        .reg.u32 %r213;
        .reg.pred %r214;
        .reg.u64 %r216;
        .reg.u32 %r218;
        .reg.pred %r219;
        .reg.u32 %r222;
        .reg.u32 %r223;
        .reg.u32 %r224;
        .reg.u64 %r229;
        .reg.u64 %r230;
        .reg.u64 %r231;
        .reg.f32 %r232;
        .reg.f32 %r233;
        .reg.f32 %r234;
        .reg.u64 %r235;
        .reg.f32 %r236;
        .reg.f32 %r237;
        .reg.u64 %r238;
        .reg.f32 %r239;
        .reg.f32 %r240;
        .reg.f32 %r241;
        .reg.f32 %r242;
        .reg.f32 %r243;
        .reg.f32 %r244;
        .reg.f32 %r245;
        .reg.f32 %r246;
        .reg.f32 %r247;
        .reg.f32 %r248;
        .reg.pred %r249;
        .reg.pred %r250;
        .reg.pred %r251;
        .reg.pred %r253;
        .reg.pred %r255;
        .reg.pred %r257;
        .reg.pred %r259;
        .reg.pred %r261;
        .reg.pred %r263;
        .reg.pred %r264;
        .reg.pred %r283;
        .reg.u64 %r284;
        .reg.u64 %r285;
        .reg.u64 %r286;
        .reg.f32 %r287;
        .reg.f32 %r288;
        .reg.f32 %r289;
        .reg.u64 %r290;
        .reg.f32 %r291;
        .reg.f32 %r292;
        .reg.u64 %r293;
        .reg.f32 %r294;
        .reg.f32 %r295;
        .reg.f32 %r296;
        .reg.f32 %r297;
        .reg.f32 %r298;
        .reg.f32 %r299;
        .reg.f32 %r300;
        .reg.f32 %r301;
        .reg.f32 %r302;
        .reg.f32 %r303;
        .reg.pred %r304;
                mov.u64 %r135, %ar0;
                ld.u32  %r34, [%r135+72];
                ld.u32  %r38, [%r135+56];
        {
                .param.u32 %value_in;
                call (%value_in), omp_get_num_threads;
                ld.param.u32    %r136, [%value_in];
        }
        {
                .param.u32 %value_in;
                call (%value_in), omp_get_thread_num;
                ld.param.u32    %r137, [%value_in];
        }
                ld.u32  %r138, [%r135+68];
                sub.u32 %r52, %r138, %r34;
                div.u32 %r23, %r52, %r136;
                rem.u32 %r24, %r52, %r136;
                setp.lt.u32     %r139, %r137, %r24;
        @%r139  bra     $L2;
$L15:
                mad.lo.u32      %r54, %r23, %r137, %r24;
                add.u32 %r55, %r23, %r54;
                setp.ge.u32     %r141, %r54, %r55;
        @%r141  bra     $L16;
                ld.u32  %r36, [%r135+64];
                ld.u32  %r37, [%r135+60];
                ld.u32  %r40, [%r135+48];
                ld.u32  %r41, [%r135+44];
                ld.u32  %r42, [%r135+28];
                ld.u32  %r43, [%r135+24];
                ld.u64  %r44, [%r135+8];
                ld.u64  %r45, [%r135];
                ld.f32  %r46, [%r135+20];
                ld.f32  %r47, [%r135+16];
                add.u32 %r25, %r34, %r54;
                add.u32 %r22, %r34, %r55;
                rem.u32 %r143, %r25, %r37;
                add.u32 %r26, %r143, 1;
                div.u32 %r58, %r25, %r37;
                rem.u32 %r145, %r58, %r36;
                add.u32 %r28, %r145, 1;
                div.u32 %r147, %r58, %r36;
                add.u32 %r29, %r147, 1;
                ld.u32  %r148, [%r135+52];
                sub.u32 %r30, %r148, %r26;
                mov.u32 %r93, 0;
                mov.u32 %r86, %r93;
                mov.u32 %r79, %r93;
$L10:
                min.u32 %r64, %r23, %r30;
                add.u32 %r65, %r25, %r64;
                add.u32 %r131, %r29, 1;
                add.u32 %r27, %r28, 1;
                setp.lt.u32     %r149, %r25, %r65;
        @%r149  bra     $L4;
                mov.u32 %r28, %r80;
                mov.u32 %r65, %r25;
$L12:
                mov.u32 %r198, 1;
                not.b32 %r200, %r29;
                add.u32 %r199, %r200, %r41;
                and.b32 %r201, %r199, 7;
                setp.lt.s32     %r150, %r27, %r40;
        @%r150  bra     $L5;
                bra     $L65;
$L6:
                mov.u32 %r29, %r218;
                setp.lt.s32     %r219, %r198, %r40;
        @%r219  bra     $L5;
                mov.u32 %r27, %r198;
                add.u32 %r218, %r218, 8;
                setp.gt.s32     %r283, %r41, %r218;
        @%r283  bra     $L6;
$L67:
                setp.eq.u32     %r152, %r93, 0;
                selp.u32        %r222, 0, %r87, %r152;
                setp.eq.u32     %r153, %r86, 0;
                selp.u32        %r223, 0, %r28, %r153;
                setp.eq.u32     %r154, %r79, 0;
                selp.u32        %r224, 0, %r74, %r154;
                setp.ne.u32     %r155, %r38, %r65;
        @%r155  bra     $L3;
                add.u32 %r31, %r222, 1;
                add.u32 %r32, %r223, 1;
                add.u32 %r33, %r224, 1;
                bra     $L3;
$L5:
                sub.u32 %r23, %r22, %r65;
                mov.u32 %r80, %r28;
                mov.u32 %r30, %r37;
                mov.u32 %r28, %r27;
                mov.u32 %r25, %r65;
                mov.u32 %r26, 1;
                bra     $L10;
$L4:
                mul.lo.u32      %r71, %r42, %r131;
                add.u32 %r156, %r42, %r42;
                sub.u32 %r76, %r71, %r156;
                add.u32 %r83, %r42, %r76;
                mov.u32 %r129, %r26;
                add.u32 %r157, %r28, %r83;
                mul.lo.u32      %r158, %r157, %r43;
                cvt.s64.s32     %r126, %r158;
                cvt.s64.s32     %r159, %r129;
                add.u64 %r160, %r159, %r126;
                shl.b64 %r124, %r160, 2;
                add.u64 %r128, %r45, %r124;
                add.u64 %r122, %r44, %r124;
                add.u32 %r106, %r64, %r129;
                neg.s64 %r162, %r126;
                shl.b64 %r163, %r162, 2;
                add.u32 %r164, %r28, %r71;
                mul.lo.u32      %r165, %r164, %r43;
                cvt.s64.s32     %r166, %r165;
                shl.b64 %r117, %r166, 2;
                add.u32 %r167, %r28, %r76;
                mul.lo.u32      %r168, %r167, %r43;
                cvt.s64.s32     %r169, %r168;
                shl.b64 %r115, %r169, 2;
                add.u32 %r170, %r83, %r27;
                mul.lo.u32      %r171, %r170, %r43;
                cvt.s64.s32     %r172, %r171;
                shl.b64 %r113, %r172, 2;
                add.u32 %r173, %r28, -1;
                add.u32 %r174, %r173, %r83;
                mul.lo.u32      %r175, %r174, %r43;
                cvt.s64.s32     %r176, %r175;
                shl.b64 %r111, %r176, 2;
                and.b32 %r213, %r64, 1;
                setp.eq.u32     %r214, %r213, 0;
        @!%r214 bra     $L66;
$L11:
                add.u64 %r118, %r163, %r128;
                add.u64 %r177, %r118, %r117;
                add.u64 %r178, %r118, %r115;
                ld.f32  %r180, [%r177];
                ld.f32  %r181, [%r178];
                add.f32 %r179, %r180, %r181;
                add.u64 %r182, %r118, %r113;
                ld.f32  %r184, [%r182];
                add.f32 %r183, %r179, %r184;
                add.u64 %r185, %r118, %r111;
                ld.f32  %r187, [%r185];
                add.f32 %r186, %r183, %r187;
                ld.f32  %r189, [%r128+4];
                add.f32 %r188, %r186, %r189;
                ld.f32  %r191, [%r128+-4];
                add.f32 %r190, %r188, %r191;
                ld.f32  %r193, [%r128];
                mul.f32 %r192, %r47, %r193;
                neg.f32 %r194, %r192;
                fma.rn.f32      %r104, %r46, %r190, %r194;
                st.f32  [%r122], %r104;
                add.u64 %r216, %r128, 4;
                add.u32 %r87, %r129, 1;
                add.u64 %r229, %r163, %r216;
                add.u64 %r230, %r229, %r117;
                add.u64 %r231, %r229, %r115;
                ld.f32  %r232, [%r230];
                ld.f32  %r233, [%r231];
                add.f32 %r234, %r232, %r233;
                add.u64 %r235, %r229, %r113;
                ld.f32  %r236, [%r235];
                add.f32 %r237, %r234, %r236;
                add.u64 %r238, %r229, %r111;
                ld.f32  %r239, [%r238];
                add.f32 %r240, %r237, %r239;
                ld.f32  %r241, [%r216+4];
                add.f32 %r242, %r240, %r241;
                ld.f32  %r243, [%r128];
                add.f32 %r244, %r242, %r243;
                ld.f32  %r245, [%r216];
                mul.f32 %r246, %r47, %r245;
                neg.f32 %r247, %r246;
                fma.rn.f32      %r248, %r46, %r244, %r247;
                st.f32  [%r122+4], %r248;
                add.u32 %r129, %r129, 2;
                add.u64 %r128, %r128, 8;
                add.u64 %r122, %r122, 8;
                setp.ne.u32     %r249, %r106, %r129;
        @%r249  bra     $L11;
$L68:
                mov.u32 %r74, %r29;
                mov.u32 %r93, 1;
                mov.u32 %r86, %r93;
                mov.u32 %r79, %r93;
                bra     $L12;
$L16:
                mov.u32 %r22, 0;
$L3:
                mov.v2.u32      %r196, { 0, 0 };
                mov.u32 %r196.x, %r31;
                mov.u32 %r196.y, %r32;
                setp.eq.u32     %r197, %r22, %r38;
        @!%r197 bra     $L1;
                st.u32  [%r135+40], %r33;
                st.v2.u32       [%r135+32], %r196;
                bra     $L1;
$L2:
                add.u32 %r23, %r23, 1;
                mov.u32 %r24, 0;
                bra     $L15;
$L1:
        ret;
$L65:
                add.u32 %r218, %r29, 1;
                mov.u32 %r27, %r198;
                setp.gt.s32     %r250, %r41, %r218;
        @!%r250 bra     $L67;
                setp.eq.u32     %r208, %r201, 0;
        @%r208  bra     $L6;
                setp.eq.u32     %r207, %r201, 1;
        @%r207  bra     $L51;
                setp.eq.u32     %r206, %r201, 2;
        @%r206  bra     $L52;
                setp.eq.u32     %r205, %r201, 3;
        @%r205  bra     $L53;
                setp.eq.u32     %r204, %r201, 4;
        @%r204  bra     $L54;
                setp.eq.u32     %r203, %r201, 5;
        @%r203  bra     $L55;
                setp.eq.u32     %r202, %r201, 6;
        @%r202  bra     $L56;
                mov.u32 %r29, %r218;
                setp.lt.s32     %r251, %r27, %r40;
        @%r251  bra     $L5;
                add.u32 %r218, %r218, 1;
                mov.u32 %r27, %r198;
$L56:
                mov.u32 %r29, %r218;
                setp.lt.s32     %r253, %r198, %r40;
        @%r253  bra     $L5;
                add.u32 %r218, %r218, 1;
                mov.u32 %r27, %r198;
$L55:
                mov.u32 %r29, %r218;
                setp.lt.s32     %r255, %r198, %r40;
        @%r255  bra     $L5;
                add.u32 %r218, %r218, 1;
                mov.u32 %r27, %r198;
$L54:
                mov.u32 %r29, %r218;
                setp.lt.s32     %r257, %r198, %r40;
        @%r257  bra     $L5;
                add.u32 %r218, %r218, 1;
                mov.u32 %r27, %r198;
$L53:
                mov.u32 %r29, %r218;
                setp.lt.s32     %r259, %r198, %r40;
        @%r259  bra     $L5;
                add.u32 %r218, %r218, 1;
                mov.u32 %r27, %r198;
$L52:
                mov.u32 %r29, %r218;
                setp.lt.s32     %r261, %r198, %r40;
        @%r261  bra     $L5;
                add.u32 %r218, %r218, 1;
                mov.u32 %r27, %r198;
$L51:
                mov.u32 %r29, %r218;
                setp.lt.s32     %r263, %r198, %r40;
        @%r263  bra     $L5;
                add.u32 %r218, %r218, 1;
                mov.u32 %r27, %r198;
                setp.gt.s32     %r264, %r41, %r218;
        @%r264  bra     $L6;
                bra     $L67;
$L66:
                mov.u32 %r87, %r129;
                add.u64 %r284, %r163, %r128;
                add.u64 %r285, %r284, %r117;
                add.u64 %r286, %r284, %r115;
                ld.f32  %r287, [%r285];
                ld.f32  %r288, [%r286];
                add.f32 %r289, %r287, %r288;
                add.u64 %r290, %r284, %r113;
                ld.f32  %r291, [%r290];
                add.f32 %r292, %r289, %r291;
                add.u64 %r293, %r284, %r111;
                ld.f32  %r294, [%r293];
                add.f32 %r295, %r292, %r294;
                ld.f32  %r296, [%r128+4];
                add.f32 %r297, %r295, %r296;
                ld.f32  %r298, [%r128+-4];
                add.f32 %r299, %r297, %r298;
                ld.f32  %r300, [%r128];
                mul.f32 %r301, %r47, %r300;
                neg.f32 %r302, %r301;
                fma.rn.f32      %r303, %r46, %r299, %r302;
                st.f32  [%r122], %r303;
                add.u32 %r129, %r87, 1;
                add.u64 %r128, %r128, 4;
                add.u64 %r122, %r122, 4;
                setp.ne.u32     %r304, %r106, %r129;
        @%r304  bra     $L11;
                bra     $L68;
}
string-delimiter
  )

(define ptx-sample20
  #<<string-delimiter
.version 6.5
.target sm_70
.address_size 64

        // .globl       wave13pt_63_gpu

.visible .entry wave13pt_63_gpu(
        .param .u32 wave13pt_63_gpu_param_0,
        .param .u32 wave13pt_63_gpu_param_1,
        .param .u32 wave13pt_63_gpu_param_2,
        .param .u64 wave13pt_63_gpu_param_3,
        .param .u64 wave13pt_63_gpu_param_4,
        .param .u64 wave13pt_63_gpu_param_5,
        .param .u32 wave13pt_63_gpu_param_6,
        .param .u32 wave13pt_63_gpu_param_7,
        .param .f32 wave13pt_63_gpu_param_8,
        .param .f32 wave13pt_63_gpu_param_9,
        .param .f32 wave13pt_63_gpu_param_10
)
.maxntid 512, 1, 1
{
        .reg .pred      %p<9>;
        .reg .f32       %f<32>;
        .reg .b32       %r<155>;
        .reg .b64       %rd<42>;


        ld.param.u32    %r78, [wave13pt_63_gpu_param_0];
        ld.param.u32    %r79, [wave13pt_63_gpu_param_1];
        ld.param.u32    %r124, [wave13pt_63_gpu_param_2];
        ld.param.u64    %rd9, [wave13pt_63_gpu_param_3];
        ld.param.u64    %rd10, [wave13pt_63_gpu_param_4];
        ld.param.u64    %rd11, [wave13pt_63_gpu_param_5];
        ld.param.u32    %r81, [wave13pt_63_gpu_param_6];
        ld.param.u32    %r82, [wave13pt_63_gpu_param_7];
        ld.param.f32    %f1, [wave13pt_63_gpu_param_8];
        ld.param.f32    %f2, [wave13pt_63_gpu_param_9];
        ld.param.f32    %f3, [wave13pt_63_gpu_param_10];
        mov.u32         %r83, %ctaid.x;
        add.s32         %r84, %r83, 3;
        add.s32         %r85, %r83, 1;
        mov.u32         %r86, 1;
        add.s32         %r87, %r83, 4;
        mov.u32         %r88, %ctaid.y;
        add.s32         %r89, %r88, 3;
        add.s32         %r90, %r88, 1;
        add.s32         %r91, %r88, 2;
        add.s32         %r92, %r88, 4;
        add.s32         %r93, %r83, 2;
        mov.u32         %r94, %nctaid.z;
        shl.b32         %r1, %r94, 9;
        mov.u32         %r95, %ctaid.z;
        shl.b32         %r96, %r95, 9;
        mul.lo.s32      %r97, %r82, %r81;
        mad.lo.s32      %r98, %r91, %r97, %r96;
        mov.u32         %r99, %tid.x;
        mad.lo.s32      %r100, %r93, %r81, %r99;
        add.s32         %r127, %r100, %r98;
        mad.lo.s32      %r101, %r88, %r97, %r100;
        add.s32         %r130, %r101, %r96;
        mad.lo.s32      %r102, %r92, %r97, %r100;
        add.s32         %r103, %r102, %r96;
        mad.lo.s32      %r104, %r90, %r97, %r100;
        add.s32         %r131, %r104, %r96;
        mad.lo.s32      %r105, %r89, %r97, %r100;
        add.s32         %r132, %r105, %r96;
        mad.lo.s32      %r106, %r83, %r81, %r99;
        add.s32         %r125, %r106, %r98;
        mad.lo.s32      %r107, %r87, %r81, %r99;
        add.s32         %r126, %r107, %r98;
        mad.lo.s32      %r108, %r85, %r81, %r99;
        add.s32         %r128, %r108, %r98;
        mad.lo.s32      %r109, %r84, %r81, %r99;
        add.s32         %r129, %r109, %r98;
        cvt.s64.s32     %rd39, %r103;
        sub.s32         %r110, %r86, %r124;
        add.s32         %r133, %r110, %r88;
        cvta.to.global.u64      %rd14, %rd9;
        cvta.to.global.u64      %rd33, %rd10;
        cvta.to.global.u64      %rd35, %rd11;

BB0_1:
        cvt.s64.s32     %rd3, %r126;
        sub.s32         %r113, %r86, %r79;
        add.s32         %r142, %r113, %r83;
        mov.u32         %r134, %r79;
        mov.u32         %r135, %r130;
        mov.u64         %rd40, %rd39;
        mov.u32         %r136, %r127;
        mov.u32         %r137, %r131;
        mov.u32         %r138, %r132;
        mov.u32         %r139, %r125;
        mov.u64         %rd41, %rd3;
        mov.u32         %r140, %r128;
        mov.u32         %r141, %r129;

BB0_2:
        setp.gt.s32     %p1, %r142, 0;
        setp.gt.s32     %p2, %r133, 0;
        or.pred         %p3, %p1, %p2;
        mov.u32         %r154, %r78;
        @%p3 bra        BB0_7;
        bra.uni         BB0_3;

BB0_7:
        sub.s32         %r154, %r154, %r1;
        setp.gt.s32     %p6, %r154, 0;
        @%p6 bra        BB0_7;
        bra.uni         BB0_8;

BB0_3:
        add.s64         %rd12, %rd41, 2;
        add.s32         %r151, %r141, 2;
        cvt.u32.u64     %r152, %rd12;
        add.s64         %rd13, %rd40, 2;
        cvt.u32.u64     %r153, %rd13;
        mad.lo.s32      %r116, %r95, 512, %r99;
        sub.s32         %r143, %r116, %r78;
        mov.u32         %r144, %r135;
        mov.u32         %r145, %r139;
        mov.u32         %r146, %r137;
        mov.u32         %r147, %r138;
        mov.u32         %r148, %r140;
        mov.u32         %r149, %r136;
        mov.u32         %r150, %r78;

BB0_4:
        add.s32         %r117, %r143, 1;
        setp.gt.s32     %p4, %r117, 0;
        @%p4 bra        BB0_6;

        mul.wide.s32    %rd15, %r144, 4;
        add.s64         %rd16, %rd14, %rd15;
        mul.wide.s32    %rd17, %r153, 4;
        add.s64         %rd18, %rd14, %rd17;
        mul.wide.s32    %rd19, %r145, 4;
        add.s64         %rd20, %rd14, %rd19;
        mul.wide.s32    %rd21, %r152, 4;
        add.s64         %rd22, %rd14, %rd21;
        mul.wide.s32    %rd23, %r149, 4;
        add.s64         %rd24, %rd14, %rd23;
        ld.global.f32   %f4, [%rd24+16];
        ld.global.f32   %f5, [%rd24];
        add.f32         %f6, %f5, %f4;
        ld.global.f32   %f7, [%rd22];
        add.f32         %f8, %f7, %f6;
        ld.global.f32   %f9, [%rd20+8];
        add.f32         %f10, %f9, %f8;
        ld.global.f32   %f11, [%rd18];
        add.f32         %f12, %f11, %f10;
        ld.global.f32   %f13, [%rd16+8];
        add.f32         %f14, %f13, %f12;
        mul.wide.s32    %rd25, %r146, 4;
        add.s64         %rd26, %rd14, %rd25;
        mul.wide.s32    %rd27, %r147, 4;
        add.s64         %rd28, %rd14, %rd27;
        mul.wide.s32    %rd29, %r148, 4;
        add.s64         %rd30, %rd14, %rd29;
        mul.wide.s32    %rd31, %r151, 4;
        add.s64         %rd32, %rd14, %rd31;
        ld.global.f32   %f15, [%rd24+12];
        ld.global.f32   %f16, [%rd24+4];
        add.f32         %f17, %f16, %f15;
        ld.global.f32   %f18, [%rd32];
        add.f32         %f19, %f18, %f17;
        ld.global.f32   %f20, [%rd30+8];
        add.f32         %f21, %f20, %f19;
        ld.global.f32   %f22, [%rd28+8];
        add.f32         %f23, %f22, %f21;
        ld.global.f32   %f24, [%rd26+8];
        add.f32         %f25, %f24, %f23;
        add.s64         %rd34, %rd33, %rd23;
        ld.global.f32   %f26, [%rd34+8];
        neg.f32         %f27, %f26;
        ld.global.f32   %f28, [%rd24+8];
        fma.rn.f32      %f29, %f28, %f3, %f27;
        fma.rn.f32      %f30, %f25, %f2, %f29;
        fma.rn.f32      %f31, %f14, %f1, %f30;
        add.s64         %rd36, %rd35, %rd23;
        st.global.f32   [%rd36+8], %f31;

BB0_6:
        add.s32         %r153, %r153, %r1;
        add.s32         %r152, %r152, %r1;
        add.s32         %r151, %r151, %r1;
        add.s32         %r149, %r149, %r1;
        add.s32         %r148, %r148, %r1;
        add.s32         %r147, %r147, %r1;
        add.s32         %r146, %r146, %r1;
        add.s32         %r145, %r145, %r1;
        add.s32         %r144, %r144, %r1;
        add.s32         %r143, %r143, %r1;
        sub.s32         %r150, %r150, %r1;
        setp.gt.s32     %p5, %r150, 0;
        @%p5 bra        BB0_4;

BB0_8:
        mov.u32         %r118, %nctaid.x;
        mul.lo.s32      %r119, %r118, %r81;
        cvt.s64.s32     %rd37, %r119;
        add.s32         %r142, %r142, %r118;
        add.s32         %r141, %r141, %r119;
        add.s32         %r140, %r140, %r119;
        add.s64         %rd41, %rd41, %rd37;
        add.s32         %r139, %r139, %r119;
        add.s32         %r138, %r138, %r119;
        add.s32         %r137, %r137, %r119;
        add.s32         %r136, %r136, %r119;
        add.s64         %rd40, %rd40, %rd37;
        add.s32         %r135, %r135, %r119;
        sub.s32         %r134, %r134, %r118;
        setp.gt.s32     %p7, %r134, 0;
        @%p7 bra        BB0_2;

        mov.u32         %r120, %nctaid.y;
        mul.lo.s32      %r122, %r120, %r97;
        cvt.s64.s32     %rd38, %r122;
        cvt.u32.u64     %r123, %rd3;
        add.s32         %r133, %r133, %r120;
        add.s32         %r132, %r132, %r122;
        add.s32         %r131, %r131, %r122;
        add.s64         %rd39, %rd39, %rd38;
        add.s32         %r130, %r130, %r122;
        add.s32         %r129, %r129, %r122;
        add.s32         %r128, %r128, %r122;
        add.s32         %r127, %r127, %r122;
        add.s32         %r126, %r123, %r122;
        add.s32         %r125, %r125, %r122;
        sub.s32         %r124, %r124, %r120;
        setp.gt.s32     %p8, %r124, 0;
        @%p8 bra        BB0_1;

        ret;
}
string-delimiter
  )

(define ptx-sample21
  #<<string-delimiter
// BEGIN PREAMBLE
        .version        3.1
        .target sm_35
        .address_size 64
// END PREAMBLE


// BEGIN FUNCTION DECL: gameoflife$_omp_fn$0
.entry gameoflife$_omp_fn$0 (.param.u64 %in_ar0);

// BEGIN FUNCTION DEF: gameoflife$_omp_fn$0
.entry gameoflife$_omp_fn$0 (.param.u64 %in_ar0)
{
        .reg.u64 %ar0;
        ld.param.u64 %ar0, [%in_ar0];
        .reg.u64 %r23;
        .reg.u64 %r24;
        .reg.u32 %r26;
        .reg.f32 %r47;
        .reg.u32 %r59;
        .reg.u64 %r61;
        .reg.u32 %r62;
        .reg.u32 %r64;
        .reg.u32 %r65;
        .reg.u32 %r66;
        .reg.u32 %r67;
        .reg.u64 %r68;
        .reg.u64 %r81;
        .reg.u64 %r84;
        .reg.u64 %r88;
        .reg.u64 %r92;
        .reg.u64 %r93;
        .reg.pred %r94;
        .reg.u64 %r95;
        .reg.u32 %r96;
        .reg.pred %r97;
        .reg.u64 %r99;
        .reg.u64 %r100;
        .reg.u64 %r101;
        .reg.u64 %r102;
        .reg.u64 %r103;
        .reg.u64 %r104;
        .reg.u64 %r106;
        .reg.u64 %r107;
        .reg.u64 %r109;
        .reg.u64 %r111;
        .reg.u64 %r112;
        .reg.f32 %r114;
        .reg.f32 %r115;
        .reg.f32 %r116;
        .reg.f32 %r117;
        .reg.f32 %r118;
        .reg.f32 %r119;
        .reg.f32 %r120;
        .reg.f32 %r121;
        .reg.f32 %r122;
        .reg.f32 %r123;
        .reg.f32 %r124;
        .reg.f32 %r125;
        .reg.f32 %r126;
        .reg.f32 %r127;
        .reg.f32 %r128;
        .reg.f32 %r129;
        .reg.f64 %r130;
        .reg.f64 %r131;
        .reg.f64 %r132;
        .reg.f64 %r133;
        .reg.f64 %r134;
        .reg.f64 %r136;
        .reg.f64 %r137;
        .reg.f64 %r138;
        .reg.f64 %r139;
        .reg.f64 %r140;
        .reg.f32 %r141;
        .reg.pred %r143;
        .reg.u64 %r144;
        .reg.u32 %r145;
        .reg.u64 %r146;
        .reg.u64 %r147;
        .reg.u64 %r148;
        .reg.u64 %r150;
        .reg.pred %r151;
        .reg.u64 %r152;
        .reg.u64 %r153;
        .reg.u64 %r154;
        .reg.f32 %r160;
        .reg.f32 %r161;
        .reg.f32 %r162;
        .reg.f32 %r163;
        .reg.f32 %r164;
        .reg.f32 %r165;
        .reg.f32 %r166;
        .reg.f32 %r167;
        .reg.f32 %r168;
        .reg.f32 %r169;
        .reg.f32 %r170;
        .reg.f32 %r171;
        .reg.f32 %r172;
        .reg.f32 %r173;
        .reg.f32 %r174;
        .reg.f32 %r175;
        .reg.f32 %r176;
        .reg.f64 %r177;
        .reg.f64 %r179;
        .reg.f64 %r180;
        .reg.f64 %r181;
        .reg.f64 %r182;
        .reg.f64 %r183;
        .reg.f64 %r184;
        .reg.f64 %r186;
        .reg.f32 %r187;
        .reg.pred %r188;
        .reg.f32 %r189;
        .reg.f32 %r190;
        .reg.f32 %r191;
        .reg.f32 %r192;
        .reg.f32 %r193;
        .reg.f32 %r194;
        .reg.f32 %r195;
        .reg.f32 %r196;
        .reg.f32 %r197;
        .reg.f32 %r198;
        .reg.f32 %r199;
        .reg.f32 %r200;
        .reg.f32 %r201;
        .reg.f32 %r202;
        .reg.f32 %r203;
        .reg.f32 %r204;
        .reg.f32 %r205;
        .reg.f64 %r206;
        .reg.f64 %r207;
        .reg.f64 %r208;
        .reg.f64 %r209;
        .reg.f64 %r210;
        .reg.f64 %r211;
        .reg.f64 %r212;
        .reg.f64 %r213;
        .reg.f64 %r215;
        .reg.f32 %r216;
        .reg.pred %r217;
        .reg.pred %r218;
        .reg.pred %r219;
        .reg.u32 %r220;
        .reg.pred %r221;
        .reg.u32 %r222;
        .reg.pred %r223;
        .reg.u32 %r224;
        {
                .reg.u32        %x;
                mov.u32 %x, %tid.x;
                setp.ne.u32     %r218, %x, 0;
        }
                setp.eq.u32     %r223, 1, 0;
        @%r218  bra     $L16;
                mov.u64 %r92, %ar0;
                ld.u64  %r93, [%r92+16];
                ld.u32  %r26, [%r93];
                setp.le.s32     %r94, %r26, 2;
                mov.pred        %r223, %r94;
$L16:
                mov.pred        %r94, %r223;
                selp.u32        %r224, 1, 0, %r94;
                shfl.idx.b32    %r224, %r224, 0, 31;
                setp.ne.u32     %r94, %r224, 0;
        @%r94   bra.uni $L1;
                setp.eq.u32     %r221, 1, 0;
        @%r218  bra     $L15;
                ld.u64  %r23, [%r92];
                ld.u64  %r24, [%r92+8];
                ld.u64  %r95, [%r92+24];
                ld.u32  %r59, [%r95];
                add.u32 %r96, %r59, -2;
                setp.le.s32     %r97, %r96, 0;
                mov.pred        %r221, %r97;
$L15:
                mov.pred        %r97, %r221;
                selp.u32        %r222, 1, 0, %r97;
                shfl.idx.b32    %r222, %r222, 0, 31;
                setp.ne.u32     %r97, %r222, 0;
        @%r97   bra.uni $L1;
        @%r218  bra     $L14;
                add.u32 %r64, %r59, %r59;
                add.u32 %r62, %r26, -2;
                mov.u32 %r65, %r59;
                mov.u32 %r66, 0;
                mov.u32 %r67, %r66;
                add.u32 %r145, %r59, -3;
                add.u64 %r144, %r23, 4;
$L14:
$L4:
                setp.eq.u32     %r219, 1, 0;
        @%r218  bra     $L13;
                cvt.s64.s32     %r99, %r66;
                shl.b64 %r100, %r99, 2;
                add.u64 %r61, %r23, %r100;
                cvt.s64.s32     %r101, %r65;
                shl.b64 %r102, %r101, 2;
                add.u64 %r88, %r23, %r102;
                cvt.s64.s32     %r103, %r64;
                shl.b64 %r104, %r103, 2;
                add.u64 %r84, %r23, %r104;
                add.u64 %r106, %r101, 1;
                shl.b64 %r107, %r106, 2;
                add.u64 %r81, %r24, %r107;
                cvt.u64.u32     %r109, %r145;
                add.u64 %r111, %r109, %r99;
                shl.b64 %r112, %r111, 2;
                add.u64 %r68, %r144, %r112;
                sub.u64 %r147, %r68, %r61;
                add.u64 %r148, %r147, -4;
                shr.u64 %r146, %r148, 2;
                and.b64 %r150, %r146, 1;
                setp.ne.u64     %r151, %r150, 0;
        @!%r151 bra     $L11;
$L3:
                ld.f32  %r115, [%r61];
                ld.f32  %r116, [%r61+4];
                add.f32 %r114, %r115, %r116;
                ld.f32  %r118, [%r61+8];
                add.f32 %r117, %r114, %r118;
                ld.f32  %r120, [%r88];
                add.f32 %r119, %r117, %r120;
                ld.f32  %r122, [%r88+8];
                add.f32 %r121, %r119, %r122;
                ld.f32  %r124, [%r84];
                add.f32 %r123, %r121, %r124;
                ld.f32  %r126, [%r84+4];
                add.f32 %r125, %r123, %r126;
                ld.f32  %r127, [%r84+8];
                add.f32 %r47, %r125, %r127;
                ld.f32  %r129, [%r88+4];
                add.f32 %r128, %r47, %r129;
                cvt.f64.f32     %r130, %r128;
                mov.f64 %r132, 0d4008000000000000;
                sub.f64 %r131, %r130, %r132;
                cvt.f64.f32     %r133, %r47;
                sub.f64 %r134, %r133, %r132;
                mul.f64 %r136, %r131, %r134;
                mul.f64 %r137, %r136, 0d4415af1d80000000;
                add.f64 %r138, %r137, 0d3ff0000000000000;
                mov.f64 %r140, 0d3ff0000000000000;
                div.rn.f64      %r139, %r140, %r138;
                cvt.rn.f32.f64  %r141, %r139;
                st.f32  [%r81], %r141;
                add.u64 %r152, %r61, 4;
                add.u64 %r153, %r88, 4;
                add.u64 %r154, %r84, 4;
                ld.f32  %r160, [%r152];
                ld.f32  %r161, [%r152+4];
                add.f32 %r162, %r160, %r161;
                ld.f32  %r163, [%r152+8];
                add.f32 %r164, %r162, %r163;
                ld.f32  %r165, [%r153];
                add.f32 %r166, %r164, %r165;
                ld.f32  %r167, [%r153+8];
                add.f32 %r168, %r166, %r167;
                ld.f32  %r169, [%r154];
                add.f32 %r170, %r168, %r169;
                ld.f32  %r171, [%r154+4];
                add.f32 %r172, %r170, %r171;
                ld.f32  %r173, [%r154+8];
                add.f32 %r174, %r172, %r173;
                ld.f32  %r175, [%r153+4];
                add.f32 %r176, %r174, %r175;
                cvt.f64.f32     %r177, %r176;
                sub.f64 %r179, %r177, %r132;
                cvt.f64.f32     %r180, %r174;
                sub.f64 %r181, %r180, %r132;
                mul.f64 %r182, %r179, %r181;
                mul.f64 %r183, %r182, 0d4415af1d80000000;
                add.f64 %r184, %r183, 0d3ff0000000000000;
                div.rn.f64      %r186, %r140, %r184;
                cvt.rn.f32.f64  %r187, %r186;
                st.f32  [%r81+4], %r187;
                add.u64 %r61, %r61, 8;
                add.u64 %r88, %r88, 8;
                add.u64 %r84, %r84, 8;
                add.u64 %r81, %r81, 8;
                setp.ne.u64     %r188, %r61, %r68;
        @%r188  bra     $L3;
$L12:
                add.u32 %r67, %r67, 1;
                add.u32 %r66, %r66, %r59;
                add.u32 %r65, %r65, %r59;
                add.u32 %r64, %r64, %r59;
                setp.ne.u32     %r143, %r62, %r67;
                mov.pred        %r219, %r143;
$L13:
                mov.pred        %r143, %r219;
                selp.u32        %r220, 1, 0, %r143;
                shfl.idx.b32    %r220, %r220, 0, 31;
                setp.ne.u32     %r143, %r220, 0;
        @%r143  bra.uni $L4;
$L1:
        ret;
$L11:
                ld.f32  %r189, [%r61];
                ld.f32  %r190, [%r61+4];
                add.f32 %r191, %r189, %r190;
                ld.f32  %r192, [%r61+8];
                add.f32 %r193, %r191, %r192;
                ld.f32  %r194, [%r88];
                add.f32 %r195, %r193, %r194;
                ld.f32  %r196, [%r88+8];
                add.f32 %r197, %r195, %r196;
                ld.f32  %r198, [%r84];
                add.f32 %r199, %r197, %r198;
                ld.f32  %r200, [%r84+4];
                add.f32 %r201, %r199, %r200;
                ld.f32  %r202, [%r84+8];
                add.f32 %r203, %r201, %r202;
                ld.f32  %r204, [%r88+4];
                add.f32 %r205, %r203, %r204;
                cvt.f64.f32     %r206, %r205;
                mov.f64 %r207, 0d4008000000000000;
                sub.f64 %r208, %r206, %r207;
                cvt.f64.f32     %r209, %r203;
                sub.f64 %r210, %r209, %r207;
                mul.f64 %r211, %r208, %r210;
                mul.f64 %r212, %r211, 0d4415af1d80000000;
                add.f64 %r213, %r212, 0d3ff0000000000000;
                rcp.rn.f64      %r215, %r213;
                cvt.rn.f32.f64  %r216, %r215;
                st.f32  [%r81], %r216;
                add.u64 %r61, %r61, 4;
                add.u64 %r88, %r88, 4;
                add.u64 %r84, %r84, 4;
                add.u64 %r81, %r81, 4;
                setp.ne.u64     %r217, %r61, %r68;
        @%r217  bra     $L3;
                bra     $L12;
}
//:FUNC_MAP "gameoflife$_omp_fn$0", 0x1, 0x1, 0x20
string-delimiter
  )

(define ptx-sample22
  #<<string-delimiter
//
// Generated by LLVM NVPTX Back-End
//

.version 6.0
.target sm_70
.address_size 64

	// .globl	_kernel_output_s0_y_y___block_id_y // -- Begin function _kernel_output_s0_y_y___block_id_y
                                        // @_kernel_output_s0_y_y___block_id_y
.visible .entry _kernel_output_s0_y_y___block_id_y(
	.param .u64 _kernel_output_s0_y_y___block_id_y_param_0,
	.param .u64 _kernel_output_s0_y_y___block_id_y_param_1,
	.param .u32 _kernel_output_s0_y_y___block_id_y_param_2,
	.param .u32 _kernel_output_s0_y_y___block_id_y_param_3,
	.param .u32 _kernel_output_s0_y_y___block_id_y_param_4,
	.param .u32 _kernel_output_s0_y_y___block_id_y_param_5,
	.param .u32 _kernel_output_s0_y_y___block_id_y_param_6,
	.param .u32 _kernel_output_s0_y_y___block_id_y_param_7,
	.param .u32 _kernel_output_s0_y_y___block_id_y_param_8,
	.param .u32 _kernel_output_s0_y_y___block_id_y_param_9,
	.param .u32 _kernel_output_s0_y_y___block_id_y_param_10,
	.param .u32 _kernel_output_s0_y_y___block_id_y_param_11,
	.param .u32 _kernel_output_s0_y_y___block_id_y_param_12
)
{
	.reg .pred 	%p<7>;
	.reg .f32 	%f<163>;
	.reg .b32 	%r<54>;
	.reg .b64 	%rd<22>;

// %bb.0:                               // %entry
	mov.u32 	%r14, %ctaid.y;
	ld.param.u32 	%r15, [_kernel_output_s0_y_y___block_id_y_param_4];
	mov.u32 	%r16, %ctaid.x;
	mov.u32 	%r1, %tid.y;
	ld.param.u32 	%r17, [_kernel_output_s0_y_y___block_id_y_param_5];
	mov.u32 	%r2, %tid.x;
	mul.lo.s32 	%r18, %r14, 14;
	add.s32 	%r19, %r17, -14;
	min.s32 	%r3, %r18, %r19;
	mul.lo.s32 	%r20, %r16, 62;
	add.s32 	%r21, %r15, -62;
	min.s32 	%r4, %r20, %r21;
	setp.lt.u32 	%p1, %r1, 9;
	setp.lt.u32 	%p2, %r2, 22;
	and.pred  	%p3, %p1, %p2;
	@%p3 bra 	LBB0_4;
	bra.uni 	LBB0_1;
LBB0_4:                                 // %"produce gray"
	ld.param.u32 	%r13, [_kernel_output_s0_y_y___block_id_y_param_12];
	ld.param.u32 	%r12, [_kernel_output_s0_y_y___block_id_y_param_11];
	ld.param.u32 	%r11, [_kernel_output_s0_y_y___block_id_y_param_10];
	ld.param.u32 	%r10, [_kernel_output_s0_y_y___block_id_y_param_9];
	ld.param.u32 	%r8, [_kernel_output_s0_y_y___block_id_y_param_7];
	ld.param.u32 	%r7, [_kernel_output_s0_y_y___block_id_y_param_6];
	ld.param.u32 	%r6, [_kernel_output_s0_y_y___block_id_y_param_3];
	ld.param.u32 	%r5, [_kernel_output_s0_y_y___block_id_y_param_2];
	ld.param.u64 	%rd4, [_kernel_output_s0_y_y___block_id_y_param_0];
	cvta.to.global.u64 	%rd2, %rd4;
	shl.b32 	%r22, %r1, 1;
	add.s32 	%r23, %r3, %r8;
	add.s32 	%r24, %r23, %r22;
	add.s32 	%r25, %r4, %r7;
	mad.lo.s32 	%r26, %r2, 3, %r25;
	add.s32 	%r27, %r24, -2;
	mul.lo.s32 	%r28, %r27, %r6;
	add.s32 	%r29, %r10, %r5;
	sub.s32 	%r30, %r11, %r29;
	add.s32 	%r31, %r26, %r30;
	add.s32 	%r32, %r31, %r28;
	mul.wide.s32 	%rd6, %r32, 4;
	add.s64 	%rd7, %rd2, %rd6;
	ld.global.nc.f32 	%f1, [%rd7+-8];
	add.s32 	%r33, %r29, %r12;
	add.s32 	%r34, %r28, %r26;
	sub.s32 	%r35, %r34, %r33;
	mul.wide.s32 	%rd8, %r35, 4;
	add.s64 	%rd9, %rd2, %rd8;
	ld.global.nc.f32 	%f2, [%rd9+-8];
	sub.s32 	%r36, %r13, %r29;
	add.s32 	%r37, %r26, %r36;
	add.s32 	%r38, %r37, %r28;
	mul.wide.s32 	%rd10, %r38, 4;
	add.s64 	%rd11, %rd2, %rd10;
	ld.global.nc.f32 	%f3, [%rd11+-8];
	mul.f32 	%f4, %f3, 0f3F1645A2;
	fma.rn.f32 	%f5, %f2, 0f3E991687, %f4;
	fma.rn.f32 	%f6, %f1, 0f3DE978D5, %f5;
	mad.lo.s32 	%r39, %r1, 44, %r2;
	mul.lo.s32 	%r40, %r39, 3;
	mul.wide.u32 	%rd12, %r40, 4;
	st.shared.f32 	[%rd12], %f6;
	ld.global.nc.f32 	%f7, [%rd7+-4];
	ld.global.nc.f32 	%f8, [%rd9+-4];
	ld.global.nc.f32 	%f9, [%rd11+-4];
	mul.f32 	%f10, %f9, 0f3F1645A2;
	fma.rn.f32 	%f11, %f8, 0f3E991687, %f10;
	fma.rn.f32 	%f12, %f7, 0f3DE978D5, %f11;
	st.shared.f32 	[%rd12+4], %f12;
	ld.global.nc.f32 	%f13, [%rd7];
	ld.global.nc.f32 	%f14, [%rd9];
	ld.global.nc.f32 	%f15, [%rd11];
	mul.f32 	%f16, %f15, 0f3F1645A2;
	fma.rn.f32 	%f17, %f14, 0f3E991687, %f16;
	fma.rn.f32 	%f18, %f13, 0f3DE978D5, %f17;
	st.shared.f32 	[%rd12+8], %f18;
	add.s32 	%r41, %r28, %r6;
	add.s32 	%r42, %r31, %r41;
	mul.wide.s32 	%rd13, %r42, 4;
	add.s64 	%rd14, %rd2, %rd13;
	ld.global.nc.f32 	%f19, [%rd14+-8];
	add.s32 	%r43, %r41, %r26;
	sub.s32 	%r44, %r43, %r33;
	mul.wide.s32 	%rd15, %r44, 4;
	add.s64 	%rd16, %rd2, %rd15;
	ld.global.nc.f32 	%f20, [%rd16+-8];
	add.s32 	%r45, %r37, %r41;
	mul.wide.s32 	%rd17, %r45, 4;
	add.s64 	%rd18, %rd2, %rd17;
	ld.global.nc.f32 	%f21, [%rd18+-8];
	mul.f32 	%f22, %f21, 0f3F1645A2;
	fma.rn.f32 	%f23, %f20, 0f3E991687, %f22;
	fma.rn.f32 	%f24, %f19, 0f3DE978D5, %f23;
	st.shared.f32 	[%rd12+264], %f24;
	ld.global.nc.f32 	%f25, [%rd14+-4];
	ld.global.nc.f32 	%f26, [%rd16+-4];
	ld.global.nc.f32 	%f27, [%rd18+-4];
	mul.f32 	%f28, %f27, 0f3F1645A2;
	fma.rn.f32 	%f29, %f26, 0f3E991687, %f28;
	fma.rn.f32 	%f30, %f25, 0f3DE978D5, %f29;
	st.shared.f32 	[%rd12+268], %f30;
	ld.global.nc.f32 	%f31, [%rd14];
	ld.global.nc.f32 	%f32, [%rd16];
	ld.global.nc.f32 	%f33, [%rd18];
	mul.f32 	%f34, %f33, 0f3F1645A2;
	fma.rn.f32 	%f35, %f32, 0f3E991687, %f34;
	fma.rn.f32 	%f36, %f31, 0f3DE978D5, %f35;
	st.shared.f32 	[%rd12+272], %f36;
LBB0_1:                                 // %after_bb
	bar.sync 	0;
	mad.lo.s32 	%r46, %r1, 33, %r2;
	shl.b32 	%r47, %r46, 1;
	mul.wide.u32 	%rd19, %r47, 4;
	ld.shared.v2.f32 	{%f37, %f38}, [%rd19+8];
	ld.shared.v2.f32 	{%f39, %f40}, [%rd19+264];
	ld.shared.v2.f32 	{%f41, %f42}, [%rd19+272];
	ld.shared.v2.f32 	{%f43, %f44}, [%rd19+536];
	ld.shared.v2.f32 	{%f45, %f46}, [%rd19+528];
	ld.shared.v2.f32 	{%f47, %f48}, [%rd19];
	fma.rn.f32 	%f49, %f48, 0f40000000, %f47;
	fma.rn.f32 	%f50, %f46, 0f40000000, %f45;
	add.f32 	%f51, %f49, %f37;
	sub.f32 	%f52, %f50, %f51;
	add.f32 	%f53, %f43, %f52;
	mul.f32 	%f54, %f53, 0f3DAAAAAB;
	sub.s32 	%r48, %r46, %r1;
	shl.b32 	%r49, %r48, 1;
	mul.wide.u32 	%rd3, %r49, 4;
	fma.rn.f32 	%f55, %f37, 0f40000000, %f48;
	fma.rn.f32 	%f56, %f43, 0f40000000, %f46;
	add.f32 	%f57, %f55, %f38;
	sub.f32 	%f58, %f56, %f57;
	add.f32 	%f59, %f44, %f58;
	mul.f32 	%f60, %f59, 0f3DAAAAAB;
	st.shared.v2.f32 	[%rd3+8848], {%f54, %f60};
	fma.rn.f32 	%f61, %f39, 0f40000000, %f47;
	fma.rn.f32 	%f62, %f41, 0f40000000, %f37;
	add.f32 	%f63, %f61, %f45;
	sub.f32 	%f64, %f62, %f63;
	add.f32 	%f65, %f43, %f64;
	mul.f32 	%f66, %f65, 0f3DAAAAAB;
	fma.rn.f32 	%f67, %f40, 0f40000000, %f48;
	fma.rn.f32 	%f68, %f42, 0f40000000, %f38;
	add.f32 	%f69, %f67, %f46;
	sub.f32 	%f70, %f68, %f69;
	add.f32 	%f71, %f44, %f70;
	mul.f32 	%f72, %f71, 0f3DAAAAAB;
	st.shared.v2.f32 	[%rd3+4752], {%f66, %f72};
	bar.sync 	0;
	setp.lt.u32 	%p4, %r1, 14;
	setp.lt.u32 	%p5, %r2, 31;
	and.pred  	%p6, %p4, %p5;
	@%p6 bra 	LBB0_3;
	bra.uni 	LBB0_2;
LBB0_3:                                 // %"produce Ix_global_wrapper$0"
	ld.param.u64 	%rd5, [_kernel_output_s0_y_y___block_id_y_param_1];
	ld.param.u32 	%r9, [_kernel_output_s0_y_y___block_id_y_param_8];
	cvta.to.global.u64 	%rd1, %rd5;
	ld.shared.v2.f32 	{%f73, %f74}, [%rd3+4752];
	ld.shared.v2.f32 	{%f75, %f76}, [%rd3+4760];
	ld.shared.v2.f32 	{%f77, %f78}, [%rd3+5008];
	ld.shared.v2.f32 	{%f79, %f80}, [%rd3+5016];
	ld.shared.v2.f32 	{%f81, %f82}, [%rd3+5264];
	ld.shared.v2.f32 	{%f83, %f84}, [%rd3+5272];
	ld.shared.v2.f32 	{%f85, %f86}, [%rd3+8848];
	ld.shared.v2.f32 	{%f87, %f88}, [%rd3+8856];
	ld.shared.v2.f32 	{%f89, %f90}, [%rd3+9104];
	ld.shared.v2.f32 	{%f91, %f92}, [%rd3+9112];
	ld.shared.v2.f32 	{%f93, %f94}, [%rd3+9360];
	ld.shared.v2.f32 	{%f95, %f96}, [%rd3+9368];
	mul.f32 	%f97, %f78, %f78;
	mul.f32 	%f98, %f77, %f77;
	fma.rn.f32 	%f99, %f73, %f73, %f98;
	fma.rn.f32 	%f100, %f81, %f81, %f99;
	fma.rn.f32 	%f101, %f74, %f74, %f100;
	fma.rn.f32 	%f102, %f78, %f78, %f101;
	fma.rn.f32 	%f103, %f82, %f82, %f102;
	fma.rn.f32 	%f104, %f75, %f75, %f103;
	fma.rn.f32 	%f105, %f79, %f79, %f104;
	fma.rn.f32 	%f106, %f83, %f83, %f105;
	mul.f32 	%f107, %f90, %f90;
	mul.f32 	%f108, %f89, %f89;
	fma.rn.f32 	%f109, %f85, %f85, %f108;
	fma.rn.f32 	%f110, %f93, %f93, %f109;
	fma.rn.f32 	%f111, %f86, %f86, %f110;
	fma.rn.f32 	%f112, %f90, %f90, %f111;
	fma.rn.f32 	%f113, %f94, %f94, %f112;
	fma.rn.f32 	%f114, %f87, %f87, %f113;
	fma.rn.f32 	%f115, %f91, %f91, %f114;
	fma.rn.f32 	%f116, %f95, %f95, %f115;
	mul.f32 	%f117, %f78, %f90;
	mul.f32 	%f118, %f77, %f89;
	fma.rn.f32 	%f119, %f73, %f85, %f118;
	fma.rn.f32 	%f120, %f81, %f93, %f119;
	fma.rn.f32 	%f121, %f74, %f86, %f120;
	fma.rn.f32 	%f122, %f78, %f90, %f121;
	fma.rn.f32 	%f123, %f82, %f94, %f122;
	fma.rn.f32 	%f124, %f75, %f87, %f123;
	fma.rn.f32 	%f125, %f79, %f91, %f124;
	fma.rn.f32 	%f126, %f83, %f95, %f125;
	add.f32 	%f127, %f106, %f116;
	mul.f32 	%f128, %f127, %f127;
	mul.f32 	%f129, %f128, 0f3D23D70A;
	fma.rn.f32 	%f130, %f126, %f126, %f129;
	neg.f32 	%f131, %f130;
	fma.rn.f32 	%f132, %f106, %f116, %f131;
	shl.b32 	%r50, %r2, 1;
	add.s32 	%r51, %r3, %r1;
	add.s32 	%r52, %r50, %r4;
	mad.lo.s32 	%r53, %r51, %r9, %r52;
	mul.wide.s32 	%rd20, %r53, 4;
	add.s64 	%rd21, %rd1, %rd20;
	st.global.f32 	[%rd21], %f132;
	fma.rn.f32 	%f133, %f74, %f74, %f97;
	fma.rn.f32 	%f134, %f82, %f82, %f133;
	fma.rn.f32 	%f135, %f75, %f75, %f134;
	fma.rn.f32 	%f136, %f79, %f79, %f135;
	fma.rn.f32 	%f137, %f83, %f83, %f136;
	fma.rn.f32 	%f138, %f76, %f76, %f137;
	fma.rn.f32 	%f139, %f80, %f80, %f138;
	fma.rn.f32 	%f140, %f84, %f84, %f139;
	fma.rn.f32 	%f141, %f86, %f86, %f107;
	fma.rn.f32 	%f142, %f94, %f94, %f141;
	fma.rn.f32 	%f143, %f87, %f87, %f142;
	fma.rn.f32 	%f144, %f91, %f91, %f143;
	fma.rn.f32 	%f145, %f95, %f95, %f144;
	fma.rn.f32 	%f146, %f88, %f88, %f145;
	fma.rn.f32 	%f147, %f92, %f92, %f146;
	fma.rn.f32 	%f148, %f96, %f96, %f147;
	fma.rn.f32 	%f149, %f74, %f86, %f117;
	fma.rn.f32 	%f150, %f82, %f94, %f149;
	fma.rn.f32 	%f151, %f75, %f87, %f150;
	fma.rn.f32 	%f152, %f79, %f91, %f151;
	fma.rn.f32 	%f153, %f83, %f95, %f152;
	fma.rn.f32 	%f154, %f76, %f88, %f153;
	fma.rn.f32 	%f155, %f80, %f92, %f154;
	fma.rn.f32 	%f156, %f84, %f96, %f155;
	add.f32 	%f157, %f140, %f148;
	mul.f32 	%f158, %f157, %f157;
	mul.f32 	%f159, %f158, 0f3D23D70A;
	fma.rn.f32 	%f160, %f156, %f156, %f159;
	neg.f32 	%f161, %f160;
	fma.rn.f32 	%f162, %f140, %f148, %f161;
	st.global.f32 	[%rd21+4], %f162;
LBB0_2:                                 // %after_bb2
	ret;
                                        // -- End function
}
string-delimiter
  )
