
bin/app.elf:     file format elf32-littlearm


Disassembly of section .text:

c0d00000 <main>:
#include "view.h"

#include <os_io_seproxyhal.h>

__attribute__((section(".boot"))) int
main(void) {
c0d00000:	b510      	push	{r4, lr}
c0d00002:	b08c      	sub	sp, #48	; 0x30
    // exit critical section
    __asm volatile("cpsie i");
c0d00004:	b662      	cpsie	i

    view_init();
c0d00006:	f005 fac9 	bl	c0d0559c <view_init>
    os_boot();
c0d0000a:	f001 fbe9 	bl	c0d017e0 <os_boot>
c0d0000e:	ac01      	add	r4, sp, #4

    BEGIN_TRY
    {
        TRY
c0d00010:	4620      	mov	r0, r4
c0d00012:	f006 f9d7 	bl	c0d063c4 <setjmp>
c0d00016:	8520      	strh	r0, [r4, #40]	; 0x28
c0d00018:	490f      	ldr	r1, [pc, #60]	; (c0d00058 <main+0x58>)
c0d0001a:	4208      	tst	r0, r1
c0d0001c:	d003      	beq.n	c0d00026 <main+0x26>
c0d0001e:	a801      	add	r0, sp, #4
        {
            app_init();
            app_main();
        }
        CATCH_OTHER(e)
c0d00020:	2100      	movs	r1, #0
c0d00022:	8501      	strh	r1, [r0, #40]	; 0x28
c0d00024:	e006      	b.n	c0d00034 <main+0x34>
c0d00026:	a801      	add	r0, sp, #4
    view_init();
    os_boot();

    BEGIN_TRY
    {
        TRY
c0d00028:	f001 fbdd 	bl	c0d017e6 <try_context_set>
        {
            app_init();
c0d0002c:	f000 fe62 	bl	c0d00cf4 <app_init>
            app_main();
c0d00030:	f000 fe6e 	bl	c0d00d10 <app_main>
        }
        CATCH_OTHER(e)
        {}
        FINALLY
c0d00034:	f001 fd44 	bl	c0d01ac0 <try_context_get>
c0d00038:	a901      	add	r1, sp, #4
c0d0003a:	4288      	cmp	r0, r1
c0d0003c:	d103      	bne.n	c0d00046 <main+0x46>
c0d0003e:	f001 fd41 	bl	c0d01ac4 <try_context_get_previous>
c0d00042:	f001 fbd0 	bl	c0d017e6 <try_context_set>
c0d00046:	a801      	add	r0, sp, #4
        {}
    }
    END_TRY;
c0d00048:	8d00      	ldrh	r0, [r0, #40]	; 0x28
c0d0004a:	2800      	cmp	r0, #0
c0d0004c:	d102      	bne.n	c0d00054 <main+0x54>
}
c0d0004e:	2000      	movs	r0, #0
c0d00050:	b00c      	add	sp, #48	; 0x30
c0d00052:	bd10      	pop	{r4, pc}
        CATCH_OTHER(e)
        {}
        FINALLY
        {}
    }
    END_TRY;
c0d00054:	f001 fd2f 	bl	c0d01ab6 <os_longjmp>
c0d00058:	0000ffff 	.word	0x0000ffff

c0d0005c <io_event>:
};
#endif

unsigned char G_io_seproxyhal_spi_buffer[IO_SEPROXYHAL_BUFFER_SIZE_B];

unsigned char io_event(unsigned char channel) {
c0d0005c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0005e:	b085      	sub	sp, #20
    switch (G_io_seproxyhal_spi_buffer[0]) {
c0d00060:	4de6      	ldr	r5, [pc, #920]	; (c0d003fc <io_event+0x3a0>)
c0d00062:	7828      	ldrb	r0, [r5, #0]
c0d00064:	4fe6      	ldr	r7, [pc, #920]	; (c0d00400 <io_event+0x3a4>)
c0d00066:	280c      	cmp	r0, #12
c0d00068:	dc2b      	bgt.n	c0d000c2 <io_event+0x66>
c0d0006a:	2805      	cmp	r0, #5
c0d0006c:	d070      	beq.n	c0d00150 <io_event+0xf4>
c0d0006e:	280c      	cmp	r0, #12
c0d00070:	d000      	beq.n	c0d00074 <io_event+0x18>
c0d00072:	e0d8      	b.n	c0d00226 <io_event+0x1ca>
        case SEPROXYHAL_TAG_FINGER_EVENT: //
            UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00074:	4ce3      	ldr	r4, [pc, #908]	; (c0d00404 <io_event+0x3a8>)
c0d00076:	2001      	movs	r0, #1
c0d00078:	7620      	strb	r0, [r4, #24]
c0d0007a:	2600      	movs	r6, #0
c0d0007c:	61e6      	str	r6, [r4, #28]
c0d0007e:	4620      	mov	r0, r4
c0d00080:	3018      	adds	r0, #24
c0d00082:	f003 f84d 	bl	c0d03120 <os_ux>
c0d00086:	61e0      	str	r0, [r4, #28]
c0d00088:	f002 fbb4 	bl	c0d027f4 <ux_check_status_default>
c0d0008c:	69e0      	ldr	r0, [r4, #28]
c0d0008e:	49fd      	ldr	r1, [pc, #1012]	; (c0d00484 <io_event+0x428>)
c0d00090:	4288      	cmp	r0, r1
c0d00092:	d100      	bne.n	c0d00096 <io_event+0x3a>
c0d00094:	e229      	b.n	c0d004ea <io_event+0x48e>
c0d00096:	2800      	cmp	r0, #0
c0d00098:	d100      	bne.n	c0d0009c <io_event+0x40>
c0d0009a:	e226      	b.n	c0d004ea <io_event+0x48e>
c0d0009c:	49f7      	ldr	r1, [pc, #988]	; (c0d0047c <io_event+0x420>)
c0d0009e:	4288      	cmp	r0, r1
c0d000a0:	d000      	beq.n	c0d000a4 <io_event+0x48>
c0d000a2:	e1b1      	b.n	c0d00408 <io_event+0x3ac>
c0d000a4:	f001 fe64 	bl	c0d01d70 <io_seproxyhal_init_ux>
c0d000a8:	f001 fe68 	bl	c0d01d7c <io_seproxyhal_init_button>
c0d000ac:	60a6      	str	r6, [r4, #8]
c0d000ae:	6820      	ldr	r0, [r4, #0]
c0d000b0:	2800      	cmp	r0, #0
c0d000b2:	d100      	bne.n	c0d000b6 <io_event+0x5a>
c0d000b4:	e219      	b.n	c0d004ea <io_event+0x48e>
c0d000b6:	69e0      	ldr	r0, [r4, #28]
c0d000b8:	49f2      	ldr	r1, [pc, #968]	; (c0d00484 <io_event+0x428>)
c0d000ba:	4288      	cmp	r0, r1
c0d000bc:	d000      	beq.n	c0d000c0 <io_event+0x64>
c0d000be:	e113      	b.n	c0d002e8 <io_event+0x28c>
c0d000c0:	e213      	b.n	c0d004ea <io_event+0x48e>
c0d000c2:	280d      	cmp	r0, #13
c0d000c4:	d06b      	beq.n	c0d0019e <io_event+0x142>
c0d000c6:	280e      	cmp	r0, #14
c0d000c8:	d000      	beq.n	c0d000cc <io_event+0x70>
c0d000ca:	e0ac      	b.n	c0d00226 <io_event+0x1ca>
            if (!UX_DISPLAYED())
                UX_DISPLAYED_EVENT();
            break;

        case SEPROXYHAL_TAG_TICKER_EVENT: { //
            UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer, {
c0d000cc:	4cec      	ldr	r4, [pc, #944]	; (c0d00480 <io_event+0x424>)
c0d000ce:	2001      	movs	r0, #1
c0d000d0:	7620      	strb	r0, [r4, #24]
c0d000d2:	2600      	movs	r6, #0
c0d000d4:	61e6      	str	r6, [r4, #28]
c0d000d6:	4620      	mov	r0, r4
c0d000d8:	3018      	adds	r0, #24
c0d000da:	f003 f821 	bl	c0d03120 <os_ux>
c0d000de:	61e0      	str	r0, [r4, #28]
c0d000e0:	f002 fb88 	bl	c0d027f4 <ux_check_status_default>
c0d000e4:	69e5      	ldr	r5, [r4, #28]
c0d000e6:	42bd      	cmp	r5, r7
c0d000e8:	d000      	beq.n	c0d000ec <io_event+0x90>
c0d000ea:	e123      	b.n	c0d00334 <io_event+0x2d8>
c0d000ec:	f001 fe40 	bl	c0d01d70 <io_seproxyhal_init_ux>
c0d000f0:	f001 fe44 	bl	c0d01d7c <io_seproxyhal_init_button>
c0d000f4:	2000      	movs	r0, #0
c0d000f6:	60a0      	str	r0, [r4, #8]
c0d000f8:	6821      	ldr	r1, [r4, #0]
c0d000fa:	2900      	cmp	r1, #0
c0d000fc:	d100      	bne.n	c0d00100 <io_event+0xa4>
c0d000fe:	e1f4      	b.n	c0d004ea <io_event+0x48e>
c0d00100:	69e1      	ldr	r1, [r4, #28]
c0d00102:	4ae0      	ldr	r2, [pc, #896]	; (c0d00484 <io_event+0x428>)
c0d00104:	4291      	cmp	r1, r2
c0d00106:	d120      	bne.n	c0d0014a <io_event+0xee>
c0d00108:	e1ef      	b.n	c0d004ea <io_event+0x48e>
c0d0010a:	6861      	ldr	r1, [r4, #4]
c0d0010c:	4288      	cmp	r0, r1
c0d0010e:	d300      	bcc.n	c0d00112 <io_event+0xb6>
c0d00110:	e1eb      	b.n	c0d004ea <io_event+0x48e>
c0d00112:	f003 f88f 	bl	c0d03234 <io_seproxyhal_spi_is_status_sent>
c0d00116:	2800      	cmp	r0, #0
c0d00118:	d000      	beq.n	c0d0011c <io_event+0xc0>
c0d0011a:	e1e6      	b.n	c0d004ea <io_event+0x48e>
c0d0011c:	68a0      	ldr	r0, [r4, #8]
c0d0011e:	68e1      	ldr	r1, [r4, #12]
c0d00120:	2538      	movs	r5, #56	; 0x38
c0d00122:	4368      	muls	r0, r5
c0d00124:	6822      	ldr	r2, [r4, #0]
c0d00126:	1810      	adds	r0, r2, r0
c0d00128:	2900      	cmp	r1, #0
c0d0012a:	d002      	beq.n	c0d00132 <io_event+0xd6>
c0d0012c:	4788      	blx	r1
c0d0012e:	2800      	cmp	r0, #0
c0d00130:	d007      	beq.n	c0d00142 <io_event+0xe6>
c0d00132:	2801      	cmp	r0, #1
c0d00134:	d103      	bne.n	c0d0013e <io_event+0xe2>
c0d00136:	68a0      	ldr	r0, [r4, #8]
c0d00138:	4345      	muls	r5, r0
c0d0013a:	6820      	ldr	r0, [r4, #0]
c0d0013c:	1940      	adds	r0, r0, r5
c0d0013e:	f005 fa29 	bl	c0d05594 <io_seproxyhal_display>
c0d00142:	68a0      	ldr	r0, [r4, #8]
c0d00144:	1c40      	adds	r0, r0, #1
c0d00146:	60a0      	str	r0, [r4, #8]
c0d00148:	6821      	ldr	r1, [r4, #0]
c0d0014a:	2900      	cmp	r1, #0
c0d0014c:	d1dd      	bne.n	c0d0010a <io_event+0xae>
c0d0014e:	e1cc      	b.n	c0d004ea <io_event+0x48e>
        case SEPROXYHAL_TAG_FINGER_EVENT: //
            UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
            break;

        case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
            UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00150:	4ccb      	ldr	r4, [pc, #812]	; (c0d00480 <io_event+0x424>)
c0d00152:	2001      	movs	r0, #1
c0d00154:	7620      	strb	r0, [r4, #24]
c0d00156:	2600      	movs	r6, #0
c0d00158:	61e6      	str	r6, [r4, #28]
c0d0015a:	4620      	mov	r0, r4
c0d0015c:	3018      	adds	r0, #24
c0d0015e:	f002 ffdf 	bl	c0d03120 <os_ux>
c0d00162:	61e0      	str	r0, [r4, #28]
c0d00164:	f002 fb46 	bl	c0d027f4 <ux_check_status_default>
c0d00168:	69e0      	ldr	r0, [r4, #28]
c0d0016a:	49c6      	ldr	r1, [pc, #792]	; (c0d00484 <io_event+0x428>)
c0d0016c:	4288      	cmp	r0, r1
c0d0016e:	d100      	bne.n	c0d00172 <io_event+0x116>
c0d00170:	e1bb      	b.n	c0d004ea <io_event+0x48e>
c0d00172:	2800      	cmp	r0, #0
c0d00174:	d100      	bne.n	c0d00178 <io_event+0x11c>
c0d00176:	e1b8      	b.n	c0d004ea <io_event+0x48e>
c0d00178:	49c0      	ldr	r1, [pc, #768]	; (c0d0047c <io_event+0x420>)
c0d0017a:	4288      	cmp	r0, r1
c0d0017c:	d000      	beq.n	c0d00180 <io_event+0x124>
c0d0017e:	e183      	b.n	c0d00488 <io_event+0x42c>
c0d00180:	f001 fdf6 	bl	c0d01d70 <io_seproxyhal_init_ux>
c0d00184:	f001 fdfa 	bl	c0d01d7c <io_seproxyhal_init_button>
c0d00188:	60a6      	str	r6, [r4, #8]
c0d0018a:	6820      	ldr	r0, [r4, #0]
c0d0018c:	2800      	cmp	r0, #0
c0d0018e:	d100      	bne.n	c0d00192 <io_event+0x136>
c0d00190:	e1ab      	b.n	c0d004ea <io_event+0x48e>
c0d00192:	69e0      	ldr	r0, [r4, #28]
c0d00194:	49bb      	ldr	r1, [pc, #748]	; (c0d00484 <io_event+0x428>)
c0d00196:	4288      	cmp	r0, r1
c0d00198:	d000      	beq.n	c0d0019c <io_event+0x140>
c0d0019a:	e0c8      	b.n	c0d0032e <io_event+0x2d2>
c0d0019c:	e1a5      	b.n	c0d004ea <io_event+0x48e>
            break;

        case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
            if (!UX_DISPLAYED())
c0d0019e:	4cb8      	ldr	r4, [pc, #736]	; (c0d00480 <io_event+0x424>)
c0d001a0:	6860      	ldr	r0, [r4, #4]
c0d001a2:	68a1      	ldr	r1, [r4, #8]
c0d001a4:	4281      	cmp	r1, r0
c0d001a6:	d201      	bcs.n	c0d001ac <io_event+0x150>
                UX_DISPLAYED_EVENT();
c0d001a8:	2001      	movs	r0, #1
c0d001aa:	7620      	strb	r0, [r4, #24]
c0d001ac:	2500      	movs	r5, #0
c0d001ae:	61e5      	str	r5, [r4, #28]
c0d001b0:	4620      	mov	r0, r4
c0d001b2:	3018      	adds	r0, #24
c0d001b4:	f002 ffb4 	bl	c0d03120 <os_ux>
c0d001b8:	61e0      	str	r0, [r4, #28]
c0d001ba:	f002 fb1b 	bl	c0d027f4 <ux_check_status_default>
c0d001be:	69e0      	ldr	r0, [r4, #28]
c0d001c0:	49b0      	ldr	r1, [pc, #704]	; (c0d00484 <io_event+0x428>)
c0d001c2:	4288      	cmp	r0, r1
c0d001c4:	d100      	bne.n	c0d001c8 <io_event+0x16c>
c0d001c6:	e190      	b.n	c0d004ea <io_event+0x48e>
c0d001c8:	49ac      	ldr	r1, [pc, #688]	; (c0d0047c <io_event+0x420>)
c0d001ca:	4288      	cmp	r0, r1
c0d001cc:	d100      	bne.n	c0d001d0 <io_event+0x174>
c0d001ce:	e195      	b.n	c0d004fc <io_event+0x4a0>
c0d001d0:	2800      	cmp	r0, #0
c0d001d2:	d100      	bne.n	c0d001d6 <io_event+0x17a>
c0d001d4:	e189      	b.n	c0d004ea <io_event+0x48e>
c0d001d6:	6820      	ldr	r0, [r4, #0]
c0d001d8:	2800      	cmp	r0, #0
c0d001da:	d100      	bne.n	c0d001de <io_event+0x182>
c0d001dc:	e17f      	b.n	c0d004de <io_event+0x482>
c0d001de:	68a0      	ldr	r0, [r4, #8]
c0d001e0:	6861      	ldr	r1, [r4, #4]
c0d001e2:	4288      	cmp	r0, r1
c0d001e4:	d300      	bcc.n	c0d001e8 <io_event+0x18c>
c0d001e6:	e17a      	b.n	c0d004de <io_event+0x482>
c0d001e8:	f003 f824 	bl	c0d03234 <io_seproxyhal_spi_is_status_sent>
c0d001ec:	2800      	cmp	r0, #0
c0d001ee:	d000      	beq.n	c0d001f2 <io_event+0x196>
c0d001f0:	e175      	b.n	c0d004de <io_event+0x482>
c0d001f2:	68a0      	ldr	r0, [r4, #8]
c0d001f4:	68e1      	ldr	r1, [r4, #12]
c0d001f6:	2538      	movs	r5, #56	; 0x38
c0d001f8:	4368      	muls	r0, r5
c0d001fa:	6822      	ldr	r2, [r4, #0]
c0d001fc:	1810      	adds	r0, r2, r0
c0d001fe:	2900      	cmp	r1, #0
c0d00200:	d002      	beq.n	c0d00208 <io_event+0x1ac>
c0d00202:	4788      	blx	r1
c0d00204:	2800      	cmp	r0, #0
c0d00206:	d007      	beq.n	c0d00218 <io_event+0x1bc>
c0d00208:	2801      	cmp	r0, #1
c0d0020a:	d103      	bne.n	c0d00214 <io_event+0x1b8>
c0d0020c:	68a0      	ldr	r0, [r4, #8]
c0d0020e:	4345      	muls	r5, r0
c0d00210:	6820      	ldr	r0, [r4, #0]
c0d00212:	1940      	adds	r0, r0, r5
c0d00214:	f005 f9be 	bl	c0d05594 <io_seproxyhal_display>
c0d00218:	68a0      	ldr	r0, [r4, #8]
c0d0021a:	1c40      	adds	r0, r0, #1
c0d0021c:	60a0      	str	r0, [r4, #8]
c0d0021e:	6821      	ldr	r1, [r4, #0]
c0d00220:	2900      	cmp	r1, #0
c0d00222:	d1dd      	bne.n	c0d001e0 <io_event+0x184>
c0d00224:	e15b      	b.n	c0d004de <io_event+0x482>
            break;
        }

            // unknown events are acknowledged
        default:
            UX_DEFAULT_EVENT();
c0d00226:	4ce7      	ldr	r4, [pc, #924]	; (c0d005c4 <io_event+0x568>)
c0d00228:	2001      	movs	r0, #1
c0d0022a:	7620      	strb	r0, [r4, #24]
c0d0022c:	2500      	movs	r5, #0
c0d0022e:	61e5      	str	r5, [r4, #28]
c0d00230:	4620      	mov	r0, r4
c0d00232:	3018      	adds	r0, #24
c0d00234:	f002 ff74 	bl	c0d03120 <os_ux>
c0d00238:	61e0      	str	r0, [r4, #28]
c0d0023a:	f002 fadb 	bl	c0d027f4 <ux_check_status_default>
c0d0023e:	69e0      	ldr	r0, [r4, #28]
c0d00240:	42b8      	cmp	r0, r7
c0d00242:	d000      	beq.n	c0d00246 <io_event+0x1ea>
c0d00244:	e0b1      	b.n	c0d003aa <io_event+0x34e>
c0d00246:	f001 fd93 	bl	c0d01d70 <io_seproxyhal_init_ux>
c0d0024a:	f001 fd97 	bl	c0d01d7c <io_seproxyhal_init_button>
c0d0024e:	60a5      	str	r5, [r4, #8]
c0d00250:	6820      	ldr	r0, [r4, #0]
c0d00252:	2800      	cmp	r0, #0
c0d00254:	d100      	bne.n	c0d00258 <io_event+0x1fc>
c0d00256:	e148      	b.n	c0d004ea <io_event+0x48e>
c0d00258:	69e0      	ldr	r0, [r4, #28]
c0d0025a:	49db      	ldr	r1, [pc, #876]	; (c0d005c8 <io_event+0x56c>)
c0d0025c:	4288      	cmp	r0, r1
c0d0025e:	d120      	bne.n	c0d002a2 <io_event+0x246>
c0d00260:	e143      	b.n	c0d004ea <io_event+0x48e>
c0d00262:	6860      	ldr	r0, [r4, #4]
c0d00264:	4285      	cmp	r5, r0
c0d00266:	d300      	bcc.n	c0d0026a <io_event+0x20e>
c0d00268:	e13f      	b.n	c0d004ea <io_event+0x48e>
c0d0026a:	f002 ffe3 	bl	c0d03234 <io_seproxyhal_spi_is_status_sent>
c0d0026e:	2800      	cmp	r0, #0
c0d00270:	d000      	beq.n	c0d00274 <io_event+0x218>
c0d00272:	e13a      	b.n	c0d004ea <io_event+0x48e>
c0d00274:	68a0      	ldr	r0, [r4, #8]
c0d00276:	68e1      	ldr	r1, [r4, #12]
c0d00278:	2538      	movs	r5, #56	; 0x38
c0d0027a:	4368      	muls	r0, r5
c0d0027c:	6822      	ldr	r2, [r4, #0]
c0d0027e:	1810      	adds	r0, r2, r0
c0d00280:	2900      	cmp	r1, #0
c0d00282:	d002      	beq.n	c0d0028a <io_event+0x22e>
c0d00284:	4788      	blx	r1
c0d00286:	2800      	cmp	r0, #0
c0d00288:	d007      	beq.n	c0d0029a <io_event+0x23e>
c0d0028a:	2801      	cmp	r0, #1
c0d0028c:	d103      	bne.n	c0d00296 <io_event+0x23a>
c0d0028e:	68a0      	ldr	r0, [r4, #8]
c0d00290:	4345      	muls	r5, r0
c0d00292:	6820      	ldr	r0, [r4, #0]
c0d00294:	1940      	adds	r0, r0, r5
c0d00296:	f005 f97d 	bl	c0d05594 <io_seproxyhal_display>
c0d0029a:	68a0      	ldr	r0, [r4, #8]
c0d0029c:	1c45      	adds	r5, r0, #1
c0d0029e:	60a5      	str	r5, [r4, #8]
c0d002a0:	6820      	ldr	r0, [r4, #0]
c0d002a2:	2800      	cmp	r0, #0
c0d002a4:	d1dd      	bne.n	c0d00262 <io_event+0x206>
c0d002a6:	e120      	b.n	c0d004ea <io_event+0x48e>
unsigned char G_io_seproxyhal_spi_buffer[IO_SEPROXYHAL_BUFFER_SIZE_B];

unsigned char io_event(unsigned char channel) {
    switch (G_io_seproxyhal_spi_buffer[0]) {
        case SEPROXYHAL_TAG_FINGER_EVENT: //
            UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d002a8:	6860      	ldr	r0, [r4, #4]
c0d002aa:	4286      	cmp	r6, r0
c0d002ac:	d300      	bcc.n	c0d002b0 <io_event+0x254>
c0d002ae:	e11c      	b.n	c0d004ea <io_event+0x48e>
c0d002b0:	f002 ffc0 	bl	c0d03234 <io_seproxyhal_spi_is_status_sent>
c0d002b4:	2800      	cmp	r0, #0
c0d002b6:	d000      	beq.n	c0d002ba <io_event+0x25e>
c0d002b8:	e117      	b.n	c0d004ea <io_event+0x48e>
c0d002ba:	68a0      	ldr	r0, [r4, #8]
c0d002bc:	68e1      	ldr	r1, [r4, #12]
c0d002be:	2538      	movs	r5, #56	; 0x38
c0d002c0:	4368      	muls	r0, r5
c0d002c2:	6822      	ldr	r2, [r4, #0]
c0d002c4:	1810      	adds	r0, r2, r0
c0d002c6:	2900      	cmp	r1, #0
c0d002c8:	d002      	beq.n	c0d002d0 <io_event+0x274>
c0d002ca:	4788      	blx	r1
c0d002cc:	2800      	cmp	r0, #0
c0d002ce:	d007      	beq.n	c0d002e0 <io_event+0x284>
c0d002d0:	2801      	cmp	r0, #1
c0d002d2:	d103      	bne.n	c0d002dc <io_event+0x280>
c0d002d4:	68a0      	ldr	r0, [r4, #8]
c0d002d6:	4345      	muls	r5, r0
c0d002d8:	6820      	ldr	r0, [r4, #0]
c0d002da:	1940      	adds	r0, r0, r5
c0d002dc:	f005 f95a 	bl	c0d05594 <io_seproxyhal_display>
c0d002e0:	68a0      	ldr	r0, [r4, #8]
c0d002e2:	1c46      	adds	r6, r0, #1
c0d002e4:	60a6      	str	r6, [r4, #8]
c0d002e6:	6820      	ldr	r0, [r4, #0]
c0d002e8:	2800      	cmp	r0, #0
c0d002ea:	d1dd      	bne.n	c0d002a8 <io_event+0x24c>
c0d002ec:	e0fd      	b.n	c0d004ea <io_event+0x48e>
            break;

        case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
            UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d002ee:	6860      	ldr	r0, [r4, #4]
c0d002f0:	4286      	cmp	r6, r0
c0d002f2:	d300      	bcc.n	c0d002f6 <io_event+0x29a>
c0d002f4:	e0f9      	b.n	c0d004ea <io_event+0x48e>
c0d002f6:	f002 ff9d 	bl	c0d03234 <io_seproxyhal_spi_is_status_sent>
c0d002fa:	2800      	cmp	r0, #0
c0d002fc:	d000      	beq.n	c0d00300 <io_event+0x2a4>
c0d002fe:	e0f4      	b.n	c0d004ea <io_event+0x48e>
c0d00300:	68a0      	ldr	r0, [r4, #8]
c0d00302:	68e1      	ldr	r1, [r4, #12]
c0d00304:	2538      	movs	r5, #56	; 0x38
c0d00306:	4368      	muls	r0, r5
c0d00308:	6822      	ldr	r2, [r4, #0]
c0d0030a:	1810      	adds	r0, r2, r0
c0d0030c:	2900      	cmp	r1, #0
c0d0030e:	d002      	beq.n	c0d00316 <io_event+0x2ba>
c0d00310:	4788      	blx	r1
c0d00312:	2800      	cmp	r0, #0
c0d00314:	d007      	beq.n	c0d00326 <io_event+0x2ca>
c0d00316:	2801      	cmp	r0, #1
c0d00318:	d103      	bne.n	c0d00322 <io_event+0x2c6>
c0d0031a:	68a0      	ldr	r0, [r4, #8]
c0d0031c:	4345      	muls	r5, r0
c0d0031e:	6820      	ldr	r0, [r4, #0]
c0d00320:	1940      	adds	r0, r0, r5
c0d00322:	f005 f937 	bl	c0d05594 <io_seproxyhal_display>
c0d00326:	68a0      	ldr	r0, [r4, #8]
c0d00328:	1c46      	adds	r6, r0, #1
c0d0032a:	60a6      	str	r6, [r4, #8]
c0d0032c:	6820      	ldr	r0, [r4, #0]
c0d0032e:	2800      	cmp	r0, #0
c0d00330:	d1dd      	bne.n	c0d002ee <io_event+0x292>
c0d00332:	e0da      	b.n	c0d004ea <io_event+0x48e>
            if (!UX_DISPLAYED())
                UX_DISPLAYED_EVENT();
            break;

        case SEPROXYHAL_TAG_TICKER_EVENT: { //
            UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer, {
c0d00334:	6960      	ldr	r0, [r4, #20]
c0d00336:	2800      	cmp	r0, #0
c0d00338:	d008      	beq.n	c0d0034c <io_event+0x2f0>
c0d0033a:	2164      	movs	r1, #100	; 0x64
c0d0033c:	2864      	cmp	r0, #100	; 0x64
c0d0033e:	4602      	mov	r2, r0
c0d00340:	d300      	bcc.n	c0d00344 <io_event+0x2e8>
c0d00342:	460a      	mov	r2, r1
c0d00344:	1a80      	subs	r0, r0, r2
c0d00346:	6160      	str	r0, [r4, #20]
c0d00348:	d100      	bne.n	c0d0034c <io_event+0x2f0>
c0d0034a:	e105      	b.n	c0d00558 <io_event+0x4fc>
c0d0034c:	489e      	ldr	r0, [pc, #632]	; (c0d005c8 <io_event+0x56c>)
c0d0034e:	4285      	cmp	r5, r0
c0d00350:	d100      	bne.n	c0d00354 <io_event+0x2f8>
c0d00352:	e0ca      	b.n	c0d004ea <io_event+0x48e>
c0d00354:	2d00      	cmp	r5, #0
c0d00356:	d100      	bne.n	c0d0035a <io_event+0x2fe>
c0d00358:	e0c7      	b.n	c0d004ea <io_event+0x48e>
c0d0035a:	6820      	ldr	r0, [r4, #0]
c0d0035c:	2800      	cmp	r0, #0
c0d0035e:	d100      	bne.n	c0d00362 <io_event+0x306>
c0d00360:	e0bd      	b.n	c0d004de <io_event+0x482>
c0d00362:	68a0      	ldr	r0, [r4, #8]
c0d00364:	6861      	ldr	r1, [r4, #4]
c0d00366:	4288      	cmp	r0, r1
c0d00368:	d300      	bcc.n	c0d0036c <io_event+0x310>
c0d0036a:	e0b8      	b.n	c0d004de <io_event+0x482>
c0d0036c:	f002 ff62 	bl	c0d03234 <io_seproxyhal_spi_is_status_sent>
c0d00370:	2800      	cmp	r0, #0
c0d00372:	d000      	beq.n	c0d00376 <io_event+0x31a>
c0d00374:	e0b3      	b.n	c0d004de <io_event+0x482>
c0d00376:	68a0      	ldr	r0, [r4, #8]
c0d00378:	68e1      	ldr	r1, [r4, #12]
c0d0037a:	2538      	movs	r5, #56	; 0x38
c0d0037c:	4368      	muls	r0, r5
c0d0037e:	6822      	ldr	r2, [r4, #0]
c0d00380:	1810      	adds	r0, r2, r0
c0d00382:	2900      	cmp	r1, #0
c0d00384:	d002      	beq.n	c0d0038c <io_event+0x330>
c0d00386:	4788      	blx	r1
c0d00388:	2800      	cmp	r0, #0
c0d0038a:	d007      	beq.n	c0d0039c <io_event+0x340>
c0d0038c:	2801      	cmp	r0, #1
c0d0038e:	d103      	bne.n	c0d00398 <io_event+0x33c>
c0d00390:	68a0      	ldr	r0, [r4, #8]
c0d00392:	4345      	muls	r5, r0
c0d00394:	6820      	ldr	r0, [r4, #0]
c0d00396:	1940      	adds	r0, r0, r5
c0d00398:	f005 f8fc 	bl	c0d05594 <io_seproxyhal_display>
c0d0039c:	68a0      	ldr	r0, [r4, #8]
c0d0039e:	1c40      	adds	r0, r0, #1
c0d003a0:	60a0      	str	r0, [r4, #8]
c0d003a2:	6821      	ldr	r1, [r4, #0]
c0d003a4:	2900      	cmp	r1, #0
c0d003a6:	d1dd      	bne.n	c0d00364 <io_event+0x308>
c0d003a8:	e099      	b.n	c0d004de <io_event+0x482>
            break;
        }

            // unknown events are acknowledged
        default:
            UX_DEFAULT_EVENT();
c0d003aa:	6820      	ldr	r0, [r4, #0]
c0d003ac:	2800      	cmp	r0, #0
c0d003ae:	d100      	bne.n	c0d003b2 <io_event+0x356>
c0d003b0:	e095      	b.n	c0d004de <io_event+0x482>
c0d003b2:	68a0      	ldr	r0, [r4, #8]
c0d003b4:	6861      	ldr	r1, [r4, #4]
c0d003b6:	4288      	cmp	r0, r1
c0d003b8:	d300      	bcc.n	c0d003bc <io_event+0x360>
c0d003ba:	e090      	b.n	c0d004de <io_event+0x482>
c0d003bc:	f002 ff3a 	bl	c0d03234 <io_seproxyhal_spi_is_status_sent>
c0d003c0:	2800      	cmp	r0, #0
c0d003c2:	d000      	beq.n	c0d003c6 <io_event+0x36a>
c0d003c4:	e08b      	b.n	c0d004de <io_event+0x482>
c0d003c6:	68a0      	ldr	r0, [r4, #8]
c0d003c8:	68e1      	ldr	r1, [r4, #12]
c0d003ca:	2538      	movs	r5, #56	; 0x38
c0d003cc:	4368      	muls	r0, r5
c0d003ce:	6822      	ldr	r2, [r4, #0]
c0d003d0:	1810      	adds	r0, r2, r0
c0d003d2:	2900      	cmp	r1, #0
c0d003d4:	d002      	beq.n	c0d003dc <io_event+0x380>
c0d003d6:	4788      	blx	r1
c0d003d8:	2800      	cmp	r0, #0
c0d003da:	d007      	beq.n	c0d003ec <io_event+0x390>
c0d003dc:	2801      	cmp	r0, #1
c0d003de:	d103      	bne.n	c0d003e8 <io_event+0x38c>
c0d003e0:	68a0      	ldr	r0, [r4, #8]
c0d003e2:	4345      	muls	r5, r0
c0d003e4:	6820      	ldr	r0, [r4, #0]
c0d003e6:	1940      	adds	r0, r0, r5
c0d003e8:	f005 f8d4 	bl	c0d05594 <io_seproxyhal_display>
c0d003ec:	68a0      	ldr	r0, [r4, #8]
c0d003ee:	1c40      	adds	r0, r0, #1
c0d003f0:	60a0      	str	r0, [r4, #8]
c0d003f2:	6821      	ldr	r1, [r4, #0]
c0d003f4:	2900      	cmp	r1, #0
c0d003f6:	d1dd      	bne.n	c0d003b4 <io_event+0x358>
c0d003f8:	e071      	b.n	c0d004de <io_event+0x482>
c0d003fa:	46c0      	nop			; (mov r8, r8)
c0d003fc:	20001800 	.word	0x20001800
c0d00400:	b0105055 	.word	0xb0105055
c0d00404:	200022ac 	.word	0x200022ac
unsigned char G_io_seproxyhal_spi_buffer[IO_SEPROXYHAL_BUFFER_SIZE_B];

unsigned char io_event(unsigned char channel) {
    switch (G_io_seproxyhal_spi_buffer[0]) {
        case SEPROXYHAL_TAG_FINGER_EVENT: //
            UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00408:	88a0      	ldrh	r0, [r4, #4]
c0d0040a:	9004      	str	r0, [sp, #16]
c0d0040c:	6820      	ldr	r0, [r4, #0]
c0d0040e:	9003      	str	r0, [sp, #12]
c0d00410:	79ee      	ldrb	r6, [r5, #7]
c0d00412:	79ab      	ldrb	r3, [r5, #6]
c0d00414:	796f      	ldrb	r7, [r5, #5]
c0d00416:	792a      	ldrb	r2, [r5, #4]
c0d00418:	78ed      	ldrb	r5, [r5, #3]
c0d0041a:	68e1      	ldr	r1, [r4, #12]
c0d0041c:	4668      	mov	r0, sp
c0d0041e:	6005      	str	r5, [r0, #0]
c0d00420:	6041      	str	r1, [r0, #4]
c0d00422:	0212      	lsls	r2, r2, #8
c0d00424:	433a      	orrs	r2, r7
c0d00426:	021b      	lsls	r3, r3, #8
c0d00428:	4333      	orrs	r3, r6
c0d0042a:	9803      	ldr	r0, [sp, #12]
c0d0042c:	9904      	ldr	r1, [sp, #16]
c0d0042e:	f001 fd25 	bl	c0d01e7c <io_seproxyhal_touch_element_callback>
c0d00432:	6820      	ldr	r0, [r4, #0]
c0d00434:	2800      	cmp	r0, #0
c0d00436:	d052      	beq.n	c0d004de <io_event+0x482>
c0d00438:	68a0      	ldr	r0, [r4, #8]
c0d0043a:	6861      	ldr	r1, [r4, #4]
c0d0043c:	4288      	cmp	r0, r1
c0d0043e:	d24e      	bcs.n	c0d004de <io_event+0x482>
c0d00440:	f002 fef8 	bl	c0d03234 <io_seproxyhal_spi_is_status_sent>
c0d00444:	2800      	cmp	r0, #0
c0d00446:	d14a      	bne.n	c0d004de <io_event+0x482>
c0d00448:	68a0      	ldr	r0, [r4, #8]
c0d0044a:	68e1      	ldr	r1, [r4, #12]
c0d0044c:	2538      	movs	r5, #56	; 0x38
c0d0044e:	4368      	muls	r0, r5
c0d00450:	6822      	ldr	r2, [r4, #0]
c0d00452:	1810      	adds	r0, r2, r0
c0d00454:	2900      	cmp	r1, #0
c0d00456:	d002      	beq.n	c0d0045e <io_event+0x402>
c0d00458:	4788      	blx	r1
c0d0045a:	2800      	cmp	r0, #0
c0d0045c:	d007      	beq.n	c0d0046e <io_event+0x412>
c0d0045e:	2801      	cmp	r0, #1
c0d00460:	d103      	bne.n	c0d0046a <io_event+0x40e>
c0d00462:	68a0      	ldr	r0, [r4, #8]
c0d00464:	4345      	muls	r5, r0
c0d00466:	6820      	ldr	r0, [r4, #0]
c0d00468:	1940      	adds	r0, r0, r5
c0d0046a:	f005 f893 	bl	c0d05594 <io_seproxyhal_display>
c0d0046e:	68a0      	ldr	r0, [r4, #8]
c0d00470:	1c40      	adds	r0, r0, #1
c0d00472:	60a0      	str	r0, [r4, #8]
c0d00474:	6821      	ldr	r1, [r4, #0]
c0d00476:	2900      	cmp	r1, #0
c0d00478:	d1df      	bne.n	c0d0043a <io_event+0x3de>
c0d0047a:	e030      	b.n	c0d004de <io_event+0x482>
c0d0047c:	b0105055 	.word	0xb0105055
c0d00480:	200022ac 	.word	0x200022ac
c0d00484:	b0105044 	.word	0xb0105044
            break;

        case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
            UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00488:	6920      	ldr	r0, [r4, #16]
c0d0048a:	2800      	cmp	r0, #0
c0d0048c:	d003      	beq.n	c0d00496 <io_event+0x43a>
c0d0048e:	78e9      	ldrb	r1, [r5, #3]
c0d00490:	0849      	lsrs	r1, r1, #1
c0d00492:	f001 fe3d 	bl	c0d02110 <io_seproxyhal_button_push>
c0d00496:	6820      	ldr	r0, [r4, #0]
c0d00498:	2800      	cmp	r0, #0
c0d0049a:	d020      	beq.n	c0d004de <io_event+0x482>
c0d0049c:	68a0      	ldr	r0, [r4, #8]
c0d0049e:	6861      	ldr	r1, [r4, #4]
c0d004a0:	4288      	cmp	r0, r1
c0d004a2:	d21c      	bcs.n	c0d004de <io_event+0x482>
c0d004a4:	f002 fec6 	bl	c0d03234 <io_seproxyhal_spi_is_status_sent>
c0d004a8:	2800      	cmp	r0, #0
c0d004aa:	d118      	bne.n	c0d004de <io_event+0x482>
c0d004ac:	68a0      	ldr	r0, [r4, #8]
c0d004ae:	68e1      	ldr	r1, [r4, #12]
c0d004b0:	2538      	movs	r5, #56	; 0x38
c0d004b2:	4368      	muls	r0, r5
c0d004b4:	6822      	ldr	r2, [r4, #0]
c0d004b6:	1810      	adds	r0, r2, r0
c0d004b8:	2900      	cmp	r1, #0
c0d004ba:	d002      	beq.n	c0d004c2 <io_event+0x466>
c0d004bc:	4788      	blx	r1
c0d004be:	2800      	cmp	r0, #0
c0d004c0:	d007      	beq.n	c0d004d2 <io_event+0x476>
c0d004c2:	2801      	cmp	r0, #1
c0d004c4:	d103      	bne.n	c0d004ce <io_event+0x472>
c0d004c6:	68a0      	ldr	r0, [r4, #8]
c0d004c8:	4345      	muls	r5, r0
c0d004ca:	6820      	ldr	r0, [r4, #0]
c0d004cc:	1940      	adds	r0, r0, r5
c0d004ce:	f005 f861 	bl	c0d05594 <io_seproxyhal_display>
c0d004d2:	68a0      	ldr	r0, [r4, #8]
c0d004d4:	1c40      	adds	r0, r0, #1
c0d004d6:	60a0      	str	r0, [r4, #8]
c0d004d8:	6821      	ldr	r1, [r4, #0]
c0d004da:	2900      	cmp	r1, #0
c0d004dc:	d1df      	bne.n	c0d0049e <io_event+0x442>
c0d004de:	6860      	ldr	r0, [r4, #4]
c0d004e0:	68a1      	ldr	r1, [r4, #8]
c0d004e2:	4281      	cmp	r1, r0
c0d004e4:	d301      	bcc.n	c0d004ea <io_event+0x48e>
c0d004e6:	f002 fea5 	bl	c0d03234 <io_seproxyhal_spi_is_status_sent>
            // unknown events are acknowledged
        default:
            UX_DEFAULT_EVENT();
            break;
    }
    if (!io_seproxyhal_spi_is_status_sent()) {
c0d004ea:	f002 fea3 	bl	c0d03234 <io_seproxyhal_spi_is_status_sent>
c0d004ee:	2800      	cmp	r0, #0
c0d004f0:	d101      	bne.n	c0d004f6 <io_event+0x49a>
        io_seproxyhal_general_status();
c0d004f2:	f001 faed 	bl	c0d01ad0 <io_seproxyhal_general_status>
    }
    return 1; // DO NOT reset the current APDU transport
c0d004f6:	2001      	movs	r0, #1
c0d004f8:	b005      	add	sp, #20
c0d004fa:	bdf0      	pop	{r4, r5, r6, r7, pc}
            UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
            break;

        case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
            if (!UX_DISPLAYED())
                UX_DISPLAYED_EVENT();
c0d004fc:	f001 fc38 	bl	c0d01d70 <io_seproxyhal_init_ux>
c0d00500:	f001 fc3c 	bl	c0d01d7c <io_seproxyhal_init_button>
c0d00504:	60a5      	str	r5, [r4, #8]
c0d00506:	6820      	ldr	r0, [r4, #0]
c0d00508:	2800      	cmp	r0, #0
c0d0050a:	d0ee      	beq.n	c0d004ea <io_event+0x48e>
c0d0050c:	69e0      	ldr	r0, [r4, #28]
c0d0050e:	492e      	ldr	r1, [pc, #184]	; (c0d005c8 <io_event+0x56c>)
c0d00510:	4288      	cmp	r0, r1
c0d00512:	d11e      	bne.n	c0d00552 <io_event+0x4f6>
c0d00514:	e7e9      	b.n	c0d004ea <io_event+0x48e>
c0d00516:	6860      	ldr	r0, [r4, #4]
c0d00518:	4285      	cmp	r5, r0
c0d0051a:	d2e6      	bcs.n	c0d004ea <io_event+0x48e>
c0d0051c:	f002 fe8a 	bl	c0d03234 <io_seproxyhal_spi_is_status_sent>
c0d00520:	2800      	cmp	r0, #0
c0d00522:	d1e2      	bne.n	c0d004ea <io_event+0x48e>
c0d00524:	68a0      	ldr	r0, [r4, #8]
c0d00526:	68e1      	ldr	r1, [r4, #12]
c0d00528:	2538      	movs	r5, #56	; 0x38
c0d0052a:	4368      	muls	r0, r5
c0d0052c:	6822      	ldr	r2, [r4, #0]
c0d0052e:	1810      	adds	r0, r2, r0
c0d00530:	2900      	cmp	r1, #0
c0d00532:	d002      	beq.n	c0d0053a <io_event+0x4de>
c0d00534:	4788      	blx	r1
c0d00536:	2800      	cmp	r0, #0
c0d00538:	d007      	beq.n	c0d0054a <io_event+0x4ee>
c0d0053a:	2801      	cmp	r0, #1
c0d0053c:	d103      	bne.n	c0d00546 <io_event+0x4ea>
c0d0053e:	68a0      	ldr	r0, [r4, #8]
c0d00540:	4345      	muls	r5, r0
c0d00542:	6820      	ldr	r0, [r4, #0]
c0d00544:	1940      	adds	r0, r0, r5
c0d00546:	f005 f825 	bl	c0d05594 <io_seproxyhal_display>
c0d0054a:	68a0      	ldr	r0, [r4, #8]
c0d0054c:	1c45      	adds	r5, r0, #1
c0d0054e:	60a5      	str	r5, [r4, #8]
c0d00550:	6820      	ldr	r0, [r4, #0]
c0d00552:	2800      	cmp	r0, #0
c0d00554:	d1df      	bne.n	c0d00516 <io_event+0x4ba>
c0d00556:	e7c8      	b.n	c0d004ea <io_event+0x48e>
            break;

        case SEPROXYHAL_TAG_TICKER_EVENT: { //
            UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer, {
c0d00558:	481b      	ldr	r0, [pc, #108]	; (c0d005c8 <io_event+0x56c>)
c0d0055a:	4285      	cmp	r5, r0
c0d0055c:	d0c5      	beq.n	c0d004ea <io_event+0x48e>
c0d0055e:	2d00      	cmp	r5, #0
c0d00560:	d0c3      	beq.n	c0d004ea <io_event+0x48e>
c0d00562:	f001 fc05 	bl	c0d01d70 <io_seproxyhal_init_ux>
c0d00566:	f001 fc09 	bl	c0d01d7c <io_seproxyhal_init_button>
c0d0056a:	60a6      	str	r6, [r4, #8]
c0d0056c:	6820      	ldr	r0, [r4, #0]
c0d0056e:	2800      	cmp	r0, #0
c0d00570:	d100      	bne.n	c0d00574 <io_event+0x518>
c0d00572:	e6eb      	b.n	c0d0034c <io_event+0x2f0>
c0d00574:	69e0      	ldr	r0, [r4, #28]
c0d00576:	4914      	ldr	r1, [pc, #80]	; (c0d005c8 <io_event+0x56c>)
c0d00578:	4288      	cmp	r0, r1
c0d0057a:	d120      	bne.n	c0d005be <io_event+0x562>
c0d0057c:	e6e6      	b.n	c0d0034c <io_event+0x2f0>
c0d0057e:	6860      	ldr	r0, [r4, #4]
c0d00580:	4286      	cmp	r6, r0
c0d00582:	d300      	bcc.n	c0d00586 <io_event+0x52a>
c0d00584:	e6e2      	b.n	c0d0034c <io_event+0x2f0>
c0d00586:	f002 fe55 	bl	c0d03234 <io_seproxyhal_spi_is_status_sent>
c0d0058a:	2800      	cmp	r0, #0
c0d0058c:	d000      	beq.n	c0d00590 <io_event+0x534>
c0d0058e:	e6dd      	b.n	c0d0034c <io_event+0x2f0>
c0d00590:	68a0      	ldr	r0, [r4, #8]
c0d00592:	68e1      	ldr	r1, [r4, #12]
c0d00594:	2638      	movs	r6, #56	; 0x38
c0d00596:	4370      	muls	r0, r6
c0d00598:	6822      	ldr	r2, [r4, #0]
c0d0059a:	1810      	adds	r0, r2, r0
c0d0059c:	2900      	cmp	r1, #0
c0d0059e:	d002      	beq.n	c0d005a6 <io_event+0x54a>
c0d005a0:	4788      	blx	r1
c0d005a2:	2800      	cmp	r0, #0
c0d005a4:	d007      	beq.n	c0d005b6 <io_event+0x55a>
c0d005a6:	2801      	cmp	r0, #1
c0d005a8:	d103      	bne.n	c0d005b2 <io_event+0x556>
c0d005aa:	68a0      	ldr	r0, [r4, #8]
c0d005ac:	4346      	muls	r6, r0
c0d005ae:	6820      	ldr	r0, [r4, #0]
c0d005b0:	1980      	adds	r0, r0, r6
c0d005b2:	f004 ffef 	bl	c0d05594 <io_seproxyhal_display>
c0d005b6:	68a0      	ldr	r0, [r4, #8]
c0d005b8:	1c46      	adds	r6, r0, #1
c0d005ba:	60a6      	str	r6, [r4, #8]
c0d005bc:	6820      	ldr	r0, [r4, #0]
c0d005be:	2800      	cmp	r0, #0
c0d005c0:	d1dd      	bne.n	c0d0057e <io_event+0x522>
c0d005c2:	e6c3      	b.n	c0d0034c <io_event+0x2f0>
c0d005c4:	200022ac 	.word	0x200022ac
c0d005c8:	b0105044 	.word	0xb0105044

c0d005cc <io_exchange_al>:
        io_seproxyhal_general_status();
    }
    return 1; // DO NOT reset the current APDU transport
}

unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len) {
c0d005cc:	b5b0      	push	{r4, r5, r7, lr}
c0d005ce:	4605      	mov	r5, r0
c0d005d0:	2007      	movs	r0, #7
    switch (channel & ~(IO_FLAGS)) {
c0d005d2:	4028      	ands	r0, r5
c0d005d4:	2400      	movs	r4, #0
c0d005d6:	2801      	cmp	r0, #1
c0d005d8:	d013      	beq.n	c0d00602 <io_exchange_al+0x36>
c0d005da:	2802      	cmp	r0, #2
c0d005dc:	d113      	bne.n	c0d00606 <io_exchange_al+0x3a>
        case CHANNEL_KEYBOARD:
            break;

            // multiplexed io exchange over a SPI channel and TLV encapsulated protocol
        case CHANNEL_SPI:
            if (tx_len) {
c0d005de:	2900      	cmp	r1, #0
c0d005e0:	d008      	beq.n	c0d005f4 <io_exchange_al+0x28>
                io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);
c0d005e2:	480a      	ldr	r0, [pc, #40]	; (c0d0060c <io_exchange_al+0x40>)
c0d005e4:	f002 fe10 	bl	c0d03208 <io_seproxyhal_spi_send>

                if (channel & IO_RESET_AFTER_REPLIED) {
c0d005e8:	b268      	sxtb	r0, r5
c0d005ea:	2800      	cmp	r0, #0
c0d005ec:	da09      	bge.n	c0d00602 <io_exchange_al+0x36>
                    reset();
c0d005ee:	f002 fc5d 	bl	c0d02eac <reset>
c0d005f2:	e006      	b.n	c0d00602 <io_exchange_al+0x36>
                }
                return 0; // nothing received from the master so far (it's a tx
                // transaction)
            } else {
                return io_seproxyhal_spi_recv(G_io_apdu_buffer, sizeof(G_io_apdu_buffer), 0);
c0d005f4:	21ff      	movs	r1, #255	; 0xff
c0d005f6:	3152      	adds	r1, #82	; 0x52
c0d005f8:	4804      	ldr	r0, [pc, #16]	; (c0d0060c <io_exchange_al+0x40>)
c0d005fa:	2200      	movs	r2, #0
c0d005fc:	f002 fe30 	bl	c0d03260 <io_seproxyhal_spi_recv>
c0d00600:	4604      	mov	r4, r0

        default:
            THROW(INVALID_PARAMETER);
    }
    return 0;
}
c0d00602:	4620      	mov	r0, r4
c0d00604:	bdb0      	pop	{r4, r5, r7, pc}
            } else {
                return io_seproxyhal_spi_recv(G_io_apdu_buffer, sizeof(G_io_apdu_buffer), 0);
            }

        default:
            THROW(INVALID_PARAMETER);
c0d00606:	2002      	movs	r0, #2
c0d00608:	f001 fa55 	bl	c0d01ab6 <os_longjmp>
c0d0060c:	20001924 	.word	0x20001924

c0d00610 <extractHRP>:
        return 0;
    }
    return 1;
}

bool extractHRP(uint8_t *len, char *hrp, uint32_t rx, uint32_t offset) {
c0d00610:	b5b0      	push	{r4, r5, r7, lr}
c0d00612:	460c      	mov	r4, r1
c0d00614:	4605      	mov	r5, r0
    if (rx < offset + 1) {
c0d00616:	1c59      	adds	r1, r3, #1
c0d00618:	480a      	ldr	r0, [pc, #40]	; (c0d00644 <extractHRP+0x34>)
c0d0061a:	4291      	cmp	r1, r2
c0d0061c:	d810      	bhi.n	c0d00640 <extractHRP+0x30>
        THROW(APDU_CODE_DATA_INVALID);
    }

    *len = G_io_apdu_buffer[offset];
c0d0061e:	490a      	ldr	r1, [pc, #40]	; (c0d00648 <extractHRP+0x38>)
c0d00620:	5cca      	ldrb	r2, [r1, r3]
c0d00622:	702a      	strb	r2, [r5, #0]
c0d00624:	18c9      	adds	r1, r1, r3

    if (*len == 0 || *len > MAX_BECH32_HRP_LEN) {
c0d00626:	1e53      	subs	r3, r2, #1
c0d00628:	b2db      	uxtb	r3, r3
c0d0062a:	2b53      	cmp	r3, #83	; 0x53
c0d0062c:	d208      	bcs.n	c0d00640 <extractHRP+0x30>
        THROW(APDU_CODE_DATA_INVALID);
    }

    memcpy(hrp, G_io_apdu_buffer + offset + 1, *len);
c0d0062e:	1c49      	adds	r1, r1, #1
c0d00630:	4620      	mov	r0, r4
c0d00632:	f005 fe37 	bl	c0d062a4 <__aeabi_memcpy>
    hrp[*len] = 0; // zero terminate
c0d00636:	7828      	ldrb	r0, [r5, #0]
c0d00638:	2100      	movs	r1, #0
c0d0063a:	5421      	strb	r1, [r4, r0]
c0d0063c:	2001      	movs	r0, #1
    return 1;
c0d0063e:	bdb0      	pop	{r4, r5, r7, pc}
c0d00640:	f001 fa39 	bl	c0d01ab6 <os_longjmp>
c0d00644:	00006984 	.word	0x00006984
c0d00648:	20001924 	.word	0x20001924

c0d0064c <process_chunk>:
}

bool process_chunk(volatile uint32_t *tx, uint32_t rx, bool getBip32) {
c0d0064c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0064e:	b083      	sub	sp, #12
c0d00650:	4616      	mov	r6, r2
c0d00652:	460d      	mov	r5, r1
    int packageIndex = G_io_apdu_buffer[OFFSET_PCK_INDEX];
c0d00654:	4f1b      	ldr	r7, [pc, #108]	; (c0d006c4 <process_chunk+0x78>)
    int packageCount = G_io_apdu_buffer[OFFSET_PCK_COUNT];
c0d00656:	78f8      	ldrb	r0, [r7, #3]
    hrp[*len] = 0; // zero terminate
    return 1;
}

bool process_chunk(volatile uint32_t *tx, uint32_t rx, bool getBip32) {
    int packageIndex = G_io_apdu_buffer[OFFSET_PCK_INDEX];
c0d00658:	9002      	str	r0, [sp, #8]
c0d0065a:	78bc      	ldrb	r4, [r7, #2]
c0d0065c:	481a      	ldr	r0, [pc, #104]	; (c0d006c8 <process_chunk+0x7c>)
    int packageCount = G_io_apdu_buffer[OFFSET_PCK_COUNT];

    uint16_t offset = OFFSET_DATA;
    if (rx < offset) {
c0d0065e:	9001      	str	r0, [sp, #4]
c0d00660:	2d04      	cmp	r5, #4
c0d00662:	d928      	bls.n	c0d006b6 <process_chunk+0x6a>
        THROW(APDU_CODE_DATA_INVALID);
    }

    if (packageIndex == 1) {
c0d00664:	2c01      	cmp	r4, #1
c0d00666:	d117      	bne.n	c0d00698 <process_chunk+0x4c>
        transaction_initialize();
c0d00668:	f002 fe12 	bl	c0d03290 <transaction_initialize>
        transaction_reset();
c0d0066c:	f002 fe22 	bl	c0d032b4 <transaction_reset>
        if (getBip32) {
c0d00670:	2e01      	cmp	r6, #1
c0d00672:	d111      	bne.n	c0d00698 <process_chunk+0x4c>
    }
    return 0;
}

bool extractBip32(uint8_t *depth, uint32_t path[10], uint32_t rx, uint32_t offset) {
    if (rx < offset + 1) {
c0d00674:	2d06      	cmp	r5, #6
c0d00676:	d31e      	bcc.n	c0d006b6 <process_chunk+0x6a>
        return 0;
    }

    *depth = G_io_apdu_buffer[offset];
c0d00678:	7979      	ldrb	r1, [r7, #5]
c0d0067a:	4814      	ldr	r0, [pc, #80]	; (c0d006cc <process_chunk+0x80>)
c0d0067c:	7001      	strb	r1, [r0, #0]
    const uint16_t req_offset = 4 * *depth + 1 + offset;
c0d0067e:	008a      	lsls	r2, r1, #2
c0d00680:	2001      	movs	r0, #1
c0d00682:	4310      	orrs	r0, r2
c0d00684:	1d40      	adds	r0, r0, #5

    if (rx < req_offset || *depth > 10) {
c0d00686:	290a      	cmp	r1, #10
c0d00688:	d815      	bhi.n	c0d006b6 <process_chunk+0x6a>
c0d0068a:	42a8      	cmp	r0, r5
c0d0068c:	d813      	bhi.n	c0d006b6 <process_chunk+0x6a>
        return 0;
    }

    memcpy(path, G_io_apdu_buffer + offset + 1, *depth * 4);
c0d0068e:	1db9      	adds	r1, r7, #6
c0d00690:	480f      	ldr	r0, [pc, #60]	; (c0d006d0 <process_chunk+0x84>)
c0d00692:	f005 fe07 	bl	c0d062a4 <__aeabi_memcpy>
c0d00696:	e006      	b.n	c0d006a6 <process_chunk+0x5a>
            }
            return packageIndex == packageCount;
        }
    }

    if (transaction_append(&(G_io_apdu_buffer[offset]), rx - offset) != rx - offset) {
c0d00698:	1d78      	adds	r0, r7, #5
c0d0069a:	1f6d      	subs	r5, r5, #5
c0d0069c:	4629      	mov	r1, r5
c0d0069e:	f002 fe0d 	bl	c0d032bc <transaction_append>
c0d006a2:	42a8      	cmp	r0, r5
c0d006a4:	d10b      	bne.n	c0d006be <process_chunk+0x72>
c0d006a6:	2001      	movs	r0, #1
c0d006a8:	2100      	movs	r1, #0
c0d006aa:	9a02      	ldr	r2, [sp, #8]
c0d006ac:	4294      	cmp	r4, r2
c0d006ae:	d000      	beq.n	c0d006b2 <process_chunk+0x66>
c0d006b0:	4608      	mov	r0, r1
        THROW(APDU_CODE_OUTPUT_BUFFER_TOO_SMALL);
    }

    return packageIndex == packageCount;
}
c0d006b2:	b003      	add	sp, #12
c0d006b4:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d006b6:	9801      	ldr	r0, [sp, #4]
c0d006b8:	1c40      	adds	r0, r0, #1
c0d006ba:	f001 f9fc 	bl	c0d01ab6 <os_longjmp>
            return packageIndex == packageCount;
        }
    }

    if (transaction_append(&(G_io_apdu_buffer[offset]), rx - offset) != rx - offset) {
        THROW(APDU_CODE_OUTPUT_BUFFER_TOO_SMALL);
c0d006be:	9801      	ldr	r0, [sp, #4]
c0d006c0:	f001 f9f9 	bl	c0d01ab6 <os_longjmp>
c0d006c4:	20001924 	.word	0x20001924
c0d006c8:	00006983 	.word	0x00006983
c0d006cc:	200018c0 	.word	0x200018c0
c0d006d0:	20001898 	.word	0x20001898

c0d006d4 <tx_getData>:
                   char *key, int16_t max_key_length,
                   char *value, int16_t max_value_length,
                   int16_t page_index,
                   int16_t chunk_index,
                   int16_t *page_count_out,
                   int16_t *chunk_count_out) {
c0d006d4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d006d6:	b087      	sub	sp, #28
c0d006d8:	9306      	str	r3, [sp, #24]
c0d006da:	4615      	mov	r5, r2
c0d006dc:	9105      	str	r1, [sp, #20]
c0d006de:	4607      	mov	r7, r0
c0d006e0:	9e10      	ldr	r6, [sp, #64]	; 0x40
    *page_count_out = tx_display_num_pages();
c0d006e2:	f002 feef 	bl	c0d034c4 <tx_display_num_pages>
c0d006e6:	8030      	strh	r0, [r6, #0]
c0d006e8:	9c11      	ldr	r4, [sp, #68]	; 0x44
c0d006ea:	2100      	movs	r1, #0
    *chunk_count_out = 0;
c0d006ec:	8021      	strh	r1, [r4, #0]

    if (*page_count_out > 0) {
c0d006ee:	8830      	ldrh	r0, [r6, #0]
c0d006f0:	b200      	sxth	r0, r0
c0d006f2:	2801      	cmp	r0, #1
c0d006f4:	db2d      	blt.n	c0d00752 <tx_getData+0x7e>
c0d006f6:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d006f8:	9104      	str	r1, [sp, #16]
c0d006fa:	9a0e      	ldr	r2, [sp, #56]	; 0x38
c0d006fc:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d006fe:	9103      	str	r1, [sp, #12]
c0d00700:	9e0c      	ldr	r6, [sp, #48]	; 0x30
        switch (current_sigtype) {
c0d00702:	4915      	ldr	r1, [pc, #84]	; (c0d00758 <tx_getData+0x84>)
c0d00704:	7809      	ldrb	r1, [r1, #0]
c0d00706:	2900      	cmp	r1, #0
c0d00708:	9202      	str	r2, [sp, #8]
c0d0070a:	d005      	beq.n	c0d00718 <tx_getData+0x44>
                         "SECP256K1 %02d/%02d",
                         page_index + 1,
                         *page_count_out);
                break;
            default:
                snprintf(title, max_title_length, "INVALID!");
c0d0070c:	a213      	add	r2, pc, #76	; (adr r2, c0d0075c <tx_getData+0x88>)
c0d0070e:	4638      	mov	r0, r7
c0d00710:	9905      	ldr	r1, [sp, #20]
c0d00712:	f002 f871 	bl	c0d027f8 <snprintf>
c0d00716:	e007      	b.n	c0d00728 <tx_getData+0x54>
    *chunk_count_out = 0;

    if (*page_count_out > 0) {
        switch (current_sigtype) {
            case SECP256K1:
                snprintf(title,
c0d00718:	4669      	mov	r1, sp
c0d0071a:	6008      	str	r0, [r1, #0]
                         max_title_length,
                         "SECP256K1 %02d/%02d",
                         page_index + 1,
c0d0071c:	1c53      	adds	r3, r2, #1
    *chunk_count_out = 0;

    if (*page_count_out > 0) {
        switch (current_sigtype) {
            case SECP256K1:
                snprintf(title,
c0d0071e:	a212      	add	r2, pc, #72	; (adr r2, c0d00768 <tx_getData+0x94>)
c0d00720:	4638      	mov	r0, r7
c0d00722:	9905      	ldr	r1, [sp, #20]
c0d00724:	f002 f868 	bl	c0d027f8 <snprintf>
            default:
                snprintf(title, max_title_length, "INVALID!");
                break;
        }

        INIT_QUERY(key, max_key_length, value, max_value_length, chunk_index)
c0d00728:	2000      	movs	r0, #0
c0d0072a:	7028      	strb	r0, [r5, #0]
c0d0072c:	7030      	strb	r0, [r6, #0]
c0d0072e:	4913      	ldr	r1, [pc, #76]	; (c0d0077c <tx_getData+0xa8>)
c0d00730:	604d      	str	r5, [r1, #4]
c0d00732:	60ce      	str	r6, [r1, #12]
c0d00734:	9a06      	ldr	r2, [sp, #24]
c0d00736:	810a      	strh	r2, [r1, #8]
c0d00738:	9a03      	ldr	r2, [sp, #12]
c0d0073a:	820a      	strh	r2, [r1, #16]
c0d0073c:	8008      	strh	r0, [r1, #0]
c0d0073e:	9804      	ldr	r0, [sp, #16]
c0d00740:	8048      	strh	r0, [r1, #2]
        *chunk_count_out = tx_display_get_item(page_index);
c0d00742:	9802      	ldr	r0, [sp, #8]
c0d00744:	b280      	uxth	r0, r0
c0d00746:	f002 fec7 	bl	c0d034d8 <tx_display_get_item>
c0d0074a:	8020      	strh	r0, [r4, #0]

        tx_display_make_friendly();
c0d0074c:	f002 ff4a 	bl	c0d035e4 <tx_display_make_friendly>
c0d00750:	8821      	ldrh	r1, [r4, #0]
    }

    return *chunk_count_out;
c0d00752:	b208      	sxth	r0, r1
c0d00754:	b007      	add	sp, #28
c0d00756:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00758:	20001915 	.word	0x20001915
c0d0075c:	41564e49 	.word	0x41564e49
c0d00760:	2144494c 	.word	0x2144494c
c0d00764:	00000000 	.word	0x00000000
c0d00768:	50434553 	.word	0x50434553
c0d0076c:	4b363532 	.word	0x4b363532
c0d00770:	30252031 	.word	0x30252031
c0d00774:	252f6432 	.word	0x252f6432
c0d00778:	00643230 	.word	0x00643230
c0d0077c:	20002140 	.word	0x20002140

c0d00780 <tx_accept_sign>:
}

void tx_accept_sign() {
c0d00780:	b570      	push	{r4, r5, r6, lr}
c0d00782:	b0a8      	sub	sp, #160	; 0xa0
c0d00784:	2400      	movs	r4, #0
    // Generate keys
    cx_ecfp_public_key_t publicKey;
    cx_ecfp_private_key_t privateKey;
    uint8_t privateKeyData[32];

    unsigned int length = 0;
c0d00786:	9402      	str	r4, [sp, #8]
    int result = 0;
    switch (current_sigtype) {
c0d00788:	4824      	ldr	r0, [pc, #144]	; (c0d0081c <tx_accept_sign+0x9c>)
c0d0078a:	7800      	ldrb	r0, [r0, #0]
c0d0078c:	2800      	cmp	r0, #0
c0d0078e:	d141      	bne.n	c0d00814 <tx_accept_sign+0x94>
        case SECP256K1:
            os_perso_derive_node_bip32(CX_CURVE_256K1,
                                       bip32_path, bip32_depth,
c0d00790:	4823      	ldr	r0, [pc, #140]	; (c0d00820 <tx_accept_sign+0xa0>)
c0d00792:	7802      	ldrb	r2, [r0, #0]

    unsigned int length = 0;
    int result = 0;
    switch (current_sigtype) {
        case SECP256K1:
            os_perso_derive_node_bip32(CX_CURVE_256K1,
c0d00794:	4668      	mov	r0, sp
c0d00796:	6004      	str	r4, [r0, #0]
c0d00798:	2021      	movs	r0, #33	; 0x21
c0d0079a:	4922      	ldr	r1, [pc, #136]	; (c0d00824 <tx_accept_sign+0xa4>)
c0d0079c:	ae03      	add	r6, sp, #12
c0d0079e:	4633      	mov	r3, r6
c0d007a0:	f002 fc90 	bl	c0d030c4 <os_perso_derive_node_bip32>
c0d007a4:	a815      	add	r0, sp, #84	; 0x54
c0d007a6:	ad0b      	add	r5, sp, #44	; 0x2c
                                       bip32_path, bip32_depth,
                                       privateKeyData, NULL);
            keys_secp256k1(&publicKey, &privateKey, privateKeyData);
c0d007a8:	4629      	mov	r1, r5
c0d007aa:	4632      	mov	r2, r6
c0d007ac:	f000 fbaa 	bl	c0d00f04 <keys_secp256k1>
            memset(privateKeyData, 0, 32);
c0d007b0:	2120      	movs	r1, #32
c0d007b2:	4630      	mov	r0, r6
c0d007b4:	f005 fd70 	bl	c0d06298 <__aeabi_memclr>
            result = sign_secp256k1(transaction_get_buffer(),
c0d007b8:	f002 fd89 	bl	c0d032ce <transaction_get_buffer>
c0d007bc:	4606      	mov	r6, r0
                                    transaction_get_buffer_length(),
c0d007be:	f002 fd81 	bl	c0d032c4 <transaction_get_buffer_length>
c0d007c2:	4601      	mov	r1, r0
            os_perso_derive_node_bip32(CX_CURVE_256K1,
                                       bip32_path, bip32_depth,
                                       privateKeyData, NULL);
            keys_secp256k1(&publicKey, &privateKey, privateKeyData);
            memset(privateKeyData, 0, 32);
            result = sign_secp256k1(transaction_get_buffer(),
c0d007c4:	4668      	mov	r0, sp
c0d007c6:	6045      	str	r5, [r0, #4]
c0d007c8:	aa02      	add	r2, sp, #8
c0d007ca:	6002      	str	r2, [r0, #0]
c0d007cc:	23ff      	movs	r3, #255	; 0xff
c0d007ce:	3352      	adds	r3, #82	; 0x52
c0d007d0:	4d15      	ldr	r5, [pc, #84]	; (c0d00828 <tx_accept_sign+0xa8>)
c0d007d2:	4630      	mov	r0, r6
c0d007d4:	462a      	mov	r2, r5
c0d007d6:	f000 fbad 	bl	c0d00f34 <sign_secp256k1>
c0d007da:	9902      	ldr	r1, [sp, #8]
#define APDU_CODE_SIGN_VERIFY_ERROR         0x6F01


inline void set_code(uint8_t *buffer, uint8_t offset, uint16_t value)
{
    *(buffer + offset) = (uint8_t)(value >> 8);
c0d007dc:	b2ca      	uxtb	r2, r1
c0d007de:	18aa      	adds	r2, r5, r2
            break;
        default:
            THROW(APDU_CODE_INS_NOT_SUPPORTED);
            break;
    }
    if (result == 1) {
c0d007e0:	2801      	cmp	r0, #1
c0d007e2:	d109      	bne.n	c0d007f8 <tx_accept_sign+0x78>
c0d007e4:	2090      	movs	r0, #144	; 0x90
c0d007e6:	7010      	strb	r0, [r2, #0]
    *(buffer + offset + 1) = (uint8_t)(value & 0xFF);
c0d007e8:	7054      	strb	r4, [r2, #1]
        set_code(G_io_apdu_buffer, length, APDU_CODE_OK);
        io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, length + 2);
c0d007ea:	1c88      	adds	r0, r1, #2
c0d007ec:	b281      	uxth	r1, r0
c0d007ee:	2020      	movs	r0, #32
c0d007f0:	f001 fcec 	bl	c0d021cc <io_exchange>
        view_idle(0);
c0d007f4:	4620      	mov	r0, r4
c0d007f6:	e009      	b.n	c0d0080c <tx_accept_sign+0x8c>
#define APDU_CODE_SIGN_VERIFY_ERROR         0x6F01


inline void set_code(uint8_t *buffer, uint8_t offset, uint16_t value)
{
    *(buffer + offset) = (uint8_t)(value >> 8);
c0d007f8:	206f      	movs	r0, #111	; 0x6f
c0d007fa:	7010      	strb	r0, [r2, #0]
c0d007fc:	2001      	movs	r0, #1
    *(buffer + offset + 1) = (uint8_t)(value & 0xFF);
c0d007fe:	7050      	strb	r0, [r2, #1]
    } else {
        set_code(G_io_apdu_buffer, length, APDU_CODE_SIGN_VERIFY_ERROR);
        io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, length + 2);
c0d00800:	1c88      	adds	r0, r1, #2
c0d00802:	b281      	uxth	r1, r0
c0d00804:	2020      	movs	r0, #32
c0d00806:	f001 fce1 	bl	c0d021cc <io_exchange>
c0d0080a:	2000      	movs	r0, #0
c0d0080c:	f004 fe2e 	bl	c0d0546c <view_idle>
        view_idle(0);
    }
}
c0d00810:	b028      	add	sp, #160	; 0xa0
c0d00812:	bd70      	pop	{r4, r5, r6, pc}
                                    IO_APDU_BUFFER_SIZE,
                                    &length,
                                    &privateKey);
            break;
        default:
            THROW(APDU_CODE_INS_NOT_SUPPORTED);
c0d00814:	206d      	movs	r0, #109	; 0x6d
c0d00816:	0200      	lsls	r0, r0, #8
c0d00818:	f001 f94d 	bl	c0d01ab6 <os_longjmp>
c0d0081c:	20001915 	.word	0x20001915
c0d00820:	200018c0 	.word	0x200018c0
c0d00824:	20001898 	.word	0x20001898
c0d00828:	20001924 	.word	0x20001924

c0d0082c <tx_reject>:
        io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, length + 2);
        view_idle(0);
    }
}

void tx_reject() {
c0d0082c:	b580      	push	{r7, lr}
#define APDU_CODE_SIGN_VERIFY_ERROR         0x6F01


inline void set_code(uint8_t *buffer, uint8_t offset, uint16_t value)
{
    *(buffer + offset) = (uint8_t)(value >> 8);
c0d0082e:	4806      	ldr	r0, [pc, #24]	; (c0d00848 <tx_reject+0x1c>)
c0d00830:	2169      	movs	r1, #105	; 0x69
c0d00832:	7001      	strb	r1, [r0, #0]
    *(buffer + offset + 1) = (uint8_t)(value & 0xFF);
c0d00834:	2186      	movs	r1, #134	; 0x86
c0d00836:	7041      	strb	r1, [r0, #1]
    set_code(G_io_apdu_buffer, 0, APDU_CODE_COMMAND_NOT_ALLOWED);
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, 2);
c0d00838:	2020      	movs	r0, #32
c0d0083a:	2102      	movs	r1, #2
c0d0083c:	f001 fcc6 	bl	c0d021cc <io_exchange>
c0d00840:	2000      	movs	r0, #0
    view_idle(0);
c0d00842:	f004 fe13 	bl	c0d0546c <view_idle>
}
c0d00846:	bd80      	pop	{r7, pc}
c0d00848:	20001924 	.word	0x20001924

c0d0084c <addr_getData>:
                     char *key, int16_t max_key_length,
                     char *value, int16_t max_value_length,
                     int16_t page_index,
                     int16_t chunk_index,
                     int16_t *page_count_out,
                     int16_t *chunk_count_out) {
c0d0084c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0084e:	b081      	sub	sp, #4
c0d00850:	9300      	str	r3, [sp, #0]
c0d00852:	4616      	mov	r6, r2
c0d00854:	9a0b      	ldr	r2, [sp, #44]	; 0x2c
c0d00856:	9b0a      	ldr	r3, [sp, #40]	; 0x28

    if (page_count_out)
c0d00858:	2b00      	cmp	r3, #0
c0d0085a:	d001      	beq.n	c0d00860 <addr_getData+0x14>
        *page_count_out = 1;
c0d0085c:	2401      	movs	r4, #1
c0d0085e:	801c      	strh	r4, [r3, #0]
c0d00860:	9f08      	ldr	r7, [sp, #32]
c0d00862:	9d06      	ldr	r5, [sp, #24]
    if (chunk_count_out)
c0d00864:	2a00      	cmp	r2, #0
c0d00866:	d001      	beq.n	c0d0086c <addr_getData+0x20>
        *chunk_count_out = 1;
c0d00868:	2301      	movs	r3, #1
c0d0086a:	8013      	strh	r3, [r2, #0]

    snprintf(title, max_title_length, "Account %d", bip32_path[2] & 0x7FFFFFF);
c0d0086c:	221f      	movs	r2, #31
c0d0086e:	06d2      	lsls	r2, r2, #27
c0d00870:	4c0c      	ldr	r4, [pc, #48]	; (c0d008a4 <addr_getData+0x58>)
c0d00872:	68a3      	ldr	r3, [r4, #8]
c0d00874:	4393      	bics	r3, r2
c0d00876:	a20c      	add	r2, pc, #48	; (adr r2, c0d008a8 <addr_getData+0x5c>)
c0d00878:	f001 ffbe 	bl	c0d027f8 <snprintf>
    snprintf(key, max_key_length, "index %d", page_index);
c0d0087c:	a20d      	add	r2, pc, #52	; (adr r2, c0d008b4 <addr_getData+0x68>)
c0d0087e:	4630      	mov	r0, r6
c0d00880:	9900      	ldr	r1, [sp, #0]
c0d00882:	463b      	mov	r3, r7
c0d00884:	f001 ffb8 	bl	c0d027f8 <snprintf>
    bip32_path[bip32_depth - 1] = page_index;
c0d00888:	480d      	ldr	r0, [pc, #52]	; (c0d008c0 <addr_getData+0x74>)
c0d0088a:	7800      	ldrb	r0, [r0, #0]
c0d0088c:	0080      	lsls	r0, r0, #2
    if (page_count_out)
        *page_count_out = 1;
    if (chunk_count_out)
        *chunk_count_out = 1;

    snprintf(title, max_title_length, "Account %d", bip32_path[2] & 0x7FFFFFF);
c0d0088e:	1820      	adds	r0, r4, r0
    snprintf(key, max_key_length, "index %d", page_index);
    bip32_path[bip32_depth - 1] = page_index;
c0d00890:	2103      	movs	r1, #3
c0d00892:	43c9      	mvns	r1, r1
c0d00894:	5047      	str	r7, [r0, r1]

    // get address from the current bip32_path
    get_bech32_addr(value);
c0d00896:	4628      	mov	r0, r5
c0d00898:	f000 fbb4 	bl	c0d01004 <get_bech32_addr>
c0d0089c:	2000      	movs	r0, #0
    return 0;
c0d0089e:	b001      	add	sp, #4
c0d008a0:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d008a2:	46c0      	nop			; (mov r8, r8)
c0d008a4:	20001898 	.word	0x20001898
c0d008a8:	6f636341 	.word	0x6f636341
c0d008ac:	20746e75 	.word	0x20746e75
c0d008b0:	00006425 	.word	0x00006425
c0d008b4:	65646e69 	.word	0x65646e69
c0d008b8:	64252078 	.word	0x64252078
c0d008bc:	00000000 	.word	0x00000000
c0d008c0:	200018c0 	.word	0x200018c0

c0d008c4 <addr_accept>:
}

void addr_accept() {
c0d008c4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d008c6:	b081      	sub	sp, #4
#if defined(TARGET_NANOS)
    print_key("Returning");
c0d008c8:	4c36      	ldr	r4, [pc, #216]	; (c0d009a4 <addr_accept+0xe0>)
c0d008ca:	4620      	mov	r0, r4
c0d008cc:	301d      	adds	r0, #29
c0d008ce:	2140      	movs	r1, #64	; 0x40
c0d008d0:	a235      	add	r2, pc, #212	; (adr r2, c0d009a8 <addr_accept+0xe4>)
c0d008d2:	f001 ff91 	bl	c0d027f8 <snprintf>
    print_value("Address...");
c0d008d6:	345d      	adds	r4, #93	; 0x5d
c0d008d8:	21c0      	movs	r1, #192	; 0xc0
c0d008da:	a236      	add	r2, pc, #216	; (adr r2, c0d009b4 <addr_accept+0xf0>)
c0d008dc:	4620      	mov	r0, r4
c0d008de:	f001 ff8b 	bl	c0d027f8 <snprintf>
    view_status();
c0d008e2:	f004 fe65 	bl	c0d055b0 <view_status>
    UX_WAIT();
c0d008e6:	4e36      	ldr	r6, [pc, #216]	; (c0d009c0 <addr_accept+0xfc>)
c0d008e8:	6875      	ldr	r5, [r6, #4]
c0d008ea:	68b7      	ldr	r7, [r6, #8]
c0d008ec:	4835      	ldr	r0, [pc, #212]	; (c0d009c4 <addr_accept+0x100>)
c0d008ee:	2180      	movs	r1, #128	; 0x80
c0d008f0:	2200      	movs	r2, #0
c0d008f2:	9200      	str	r2, [sp, #0]
c0d008f4:	f002 fcb4 	bl	c0d03260 <io_seproxyhal_spi_recv>
c0d008f8:	42af      	cmp	r7, r5
c0d008fa:	d22d      	bcs.n	c0d00958 <addr_accept+0x94>
c0d008fc:	4d31      	ldr	r5, [pc, #196]	; (c0d009c4 <addr_accept+0x100>)
c0d008fe:	6830      	ldr	r0, [r6, #0]
c0d00900:	2800      	cmp	r0, #0
c0d00902:	d020      	beq.n	c0d00946 <addr_accept+0x82>
c0d00904:	68b0      	ldr	r0, [r6, #8]
c0d00906:	6871      	ldr	r1, [r6, #4]
c0d00908:	4288      	cmp	r0, r1
c0d0090a:	d21c      	bcs.n	c0d00946 <addr_accept+0x82>
c0d0090c:	f002 fc92 	bl	c0d03234 <io_seproxyhal_spi_is_status_sent>
c0d00910:	2800      	cmp	r0, #0
c0d00912:	d118      	bne.n	c0d00946 <addr_accept+0x82>
c0d00914:	68b0      	ldr	r0, [r6, #8]
c0d00916:	68f1      	ldr	r1, [r6, #12]
c0d00918:	2738      	movs	r7, #56	; 0x38
c0d0091a:	4378      	muls	r0, r7
c0d0091c:	6832      	ldr	r2, [r6, #0]
c0d0091e:	1810      	adds	r0, r2, r0
c0d00920:	2900      	cmp	r1, #0
c0d00922:	d002      	beq.n	c0d0092a <addr_accept+0x66>
c0d00924:	4788      	blx	r1
c0d00926:	2800      	cmp	r0, #0
c0d00928:	d007      	beq.n	c0d0093a <addr_accept+0x76>
c0d0092a:	2801      	cmp	r0, #1
c0d0092c:	d103      	bne.n	c0d00936 <addr_accept+0x72>
c0d0092e:	68b0      	ldr	r0, [r6, #8]
c0d00930:	4347      	muls	r7, r0
c0d00932:	6830      	ldr	r0, [r6, #0]
c0d00934:	19c0      	adds	r0, r0, r7
c0d00936:	f004 fe2d 	bl	c0d05594 <io_seproxyhal_display>
c0d0093a:	68b0      	ldr	r0, [r6, #8]
c0d0093c:	1c40      	adds	r0, r0, #1
c0d0093e:	60b0      	str	r0, [r6, #8]
c0d00940:	6831      	ldr	r1, [r6, #0]
c0d00942:	2900      	cmp	r1, #0
c0d00944:	d1df      	bne.n	c0d00906 <addr_accept+0x42>
c0d00946:	6877      	ldr	r7, [r6, #4]
c0d00948:	68b4      	ldr	r4, [r6, #8]
c0d0094a:	2180      	movs	r1, #128	; 0x80
c0d0094c:	2200      	movs	r2, #0
c0d0094e:	4628      	mov	r0, r5
c0d00950:	f002 fc86 	bl	c0d03260 <io_seproxyhal_spi_recv>
c0d00954:	42bc      	cmp	r4, r7
c0d00956:	d3d2      	bcc.n	c0d008fe <addr_accept+0x3a>
c0d00958:	f001 f8ba 	bl	c0d01ad0 <io_seproxyhal_general_status>
c0d0095c:	4819      	ldr	r0, [pc, #100]	; (c0d009c4 <addr_accept+0x100>)
c0d0095e:	2180      	movs	r1, #128	; 0x80
c0d00960:	9c00      	ldr	r4, [sp, #0]
c0d00962:	4622      	mov	r2, r4
c0d00964:	f002 fc7c 	bl	c0d03260 <io_seproxyhal_spi_recv>
#endif
    // Send pubkey
    uint8_t *pk = G_io_apdu_buffer;
    get_pk_compressed(pk);
c0d00968:	4d17      	ldr	r5, [pc, #92]	; (c0d009c8 <addr_accept+0x104>)
c0d0096a:	4628      	mov	r0, r5
c0d0096c:	f000 fb34 	bl	c0d00fd8 <get_pk_compressed>
    int pos = PK_COMPRESSED_LEN;

    // Convert pubkey to bech32 address
    char *bech32_out = (char *) (G_io_apdu_buffer + pos);
    get_bech32_addr(bech32_out);
c0d00970:	462e      	mov	r6, r5
c0d00972:	3621      	adds	r6, #33	; 0x21
c0d00974:	4630      	mov	r0, r6
c0d00976:	f000 fb45 	bl	c0d01004 <get_bech32_addr>
    pos += strlen(bech32_out);
c0d0097a:	4630      	mov	r0, r6
c0d0097c:	f005 fd80 	bl	c0d06480 <strlen>
c0d00980:	4601      	mov	r1, r0
c0d00982:	3121      	adds	r1, #33	; 0x21
#define APDU_CODE_SIGN_VERIFY_ERROR         0x6F01


inline void set_code(uint8_t *buffer, uint8_t offset, uint16_t value)
{
    *(buffer + offset) = (uint8_t)(value >> 8);
c0d00984:	b2c9      	uxtb	r1, r1
c0d00986:	2290      	movs	r2, #144	; 0x90
c0d00988:	546a      	strb	r2, [r5, r1]
c0d0098a:	1869      	adds	r1, r5, r1
    *(buffer + offset + 1) = (uint8_t)(value & 0xFF);
c0d0098c:	704c      	strb	r4, [r1, #1]

    set_code(G_io_apdu_buffer, pos, APDU_CODE_OK);
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, pos + 2);
c0d0098e:	3023      	adds	r0, #35	; 0x23
c0d00990:	b281      	uxth	r1, r0
c0d00992:	2020      	movs	r0, #32
c0d00994:	f001 fc1a 	bl	c0d021cc <io_exchange>
    view_idle(0);
c0d00998:	4620      	mov	r0, r4
c0d0099a:	f004 fd67 	bl	c0d0546c <view_idle>
}
c0d0099e:	b001      	add	sp, #4
c0d009a0:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d009a2:	46c0      	nop			; (mov r8, r8)
c0d009a4:	2000236c 	.word	0x2000236c
c0d009a8:	75746552 	.word	0x75746552
c0d009ac:	6e696e72 	.word	0x6e696e72
c0d009b0:	00000067 	.word	0x00000067
c0d009b4:	72646441 	.word	0x72646441
c0d009b8:	2e737365 	.word	0x2e737365
c0d009bc:	00002e2e 	.word	0x00002e2e
c0d009c0:	200022ac 	.word	0x200022ac
c0d009c4:	20001800 	.word	0x20001800
c0d009c8:	20001924 	.word	0x20001924

c0d009cc <addr_reject>:

void addr_reject() {
c0d009cc:	b580      	push	{r7, lr}
#define APDU_CODE_SIGN_VERIFY_ERROR         0x6F01


inline void set_code(uint8_t *buffer, uint8_t offset, uint16_t value)
{
    *(buffer + offset) = (uint8_t)(value >> 8);
c0d009ce:	4806      	ldr	r0, [pc, #24]	; (c0d009e8 <addr_reject+0x1c>)
c0d009d0:	2169      	movs	r1, #105	; 0x69
c0d009d2:	7001      	strb	r1, [r0, #0]
    *(buffer + offset + 1) = (uint8_t)(value & 0xFF);
c0d009d4:	2186      	movs	r1, #134	; 0x86
c0d009d6:	7041      	strb	r1, [r0, #1]
    set_code(G_io_apdu_buffer, 0, APDU_CODE_COMMAND_NOT_ALLOWED);
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, 2);
c0d009d8:	2020      	movs	r0, #32
c0d009da:	2102      	movs	r1, #2
c0d009dc:	f001 fbf6 	bl	c0d021cc <io_exchange>
c0d009e0:	2000      	movs	r0, #0
    view_idle(0);
c0d009e2:	f004 fd43 	bl	c0d0546c <view_idle>
}
c0d009e6:	bd80      	pop	{r7, pc}
c0d009e8:	20001924 	.word	0x20001924

c0d009ec <handleApdu>:

//endregion

void handleApdu(volatile uint32_t *flags, volatile uint32_t *tx, uint32_t rx) {
c0d009ec:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d009ee:	b0a1      	sub	sp, #132	; 0x84
c0d009f0:	4615      	mov	r5, r2
c0d009f2:	460c      	mov	r4, r1
c0d009f4:	4606      	mov	r6, r0
c0d009f6:	af16      	add	r7, sp, #88	; 0x58
    uint16_t sw = 0;

    BEGIN_TRY
    {
        TRY
c0d009f8:	4638      	mov	r0, r7
c0d009fa:	f005 fce3 	bl	c0d063c4 <setjmp>
c0d009fe:	8538      	strh	r0, [r7, #40]	; 0x28
c0d00a00:	b281      	uxth	r1, r0
c0d00a02:	2900      	cmp	r1, #0
c0d00a04:	d024      	beq.n	c0d00a50 <handleApdu+0x64>
c0d00a06:	2910      	cmp	r1, #16
c0d00a08:	d100      	bne.n	c0d00a0c <handleApdu+0x20>
c0d00a0a:	e0a4      	b.n	c0d00b56 <handleApdu+0x16a>
c0d00a0c:	a916      	add	r1, sp, #88	; 0x58
c0d00a0e:	2200      	movs	r2, #0
        }
        CATCH(EXCEPTION_IO_RESET)
        {
            THROW(EXCEPTION_IO_RESET);
        }
        CATCH_OTHER(e)
c0d00a10:	850a      	strh	r2, [r1, #40]	; 0x28
c0d00a12:	210f      	movs	r1, #15
c0d00a14:	030a      	lsls	r2, r1, #12
        {
            switch (e & 0xF000) {
c0d00a16:	4002      	ands	r2, r0
c0d00a18:	21ff      	movs	r1, #255	; 0xff
c0d00a1a:	0209      	lsls	r1, r1, #8
c0d00a1c:	4001      	ands	r1, r0
c0d00a1e:	0a09      	lsrs	r1, r1, #8
c0d00a20:	2303      	movs	r3, #3
c0d00a22:	035b      	lsls	r3, r3, #13
c0d00a24:	429a      	cmp	r2, r3
c0d00a26:	d009      	beq.n	c0d00a3c <handleApdu+0x50>
c0d00a28:	2309      	movs	r3, #9
c0d00a2a:	031b      	lsls	r3, r3, #12
c0d00a2c:	429a      	cmp	r2, r3
c0d00a2e:	d005      	beq.n	c0d00a3c <handleApdu+0x50>
                case 0x6000:
                case APDU_CODE_OK:
                    sw = e;
                    break;
                default:
                    sw = 0x6800 | (e & 0x7FF);
c0d00a30:	498e      	ldr	r1, [pc, #568]	; (c0d00c6c <handleApdu+0x280>)
c0d00a32:	4008      	ands	r0, r1
c0d00a34:	210d      	movs	r1, #13
c0d00a36:	02c9      	lsls	r1, r1, #11
c0d00a38:	4308      	orrs	r0, r1
                    break;
c0d00a3a:	0a01      	lsrs	r1, r0, #8
            }
            G_io_apdu_buffer[*tx] = sw >> 8;
c0d00a3c:	6822      	ldr	r2, [r4, #0]
c0d00a3e:	4b81      	ldr	r3, [pc, #516]	; (c0d00c44 <handleApdu+0x258>)
c0d00a40:	5499      	strb	r1, [r3, r2]
            G_io_apdu_buffer[*tx + 1] = sw;
c0d00a42:	6821      	ldr	r1, [r4, #0]
                    break;
                default:
                    sw = 0x6800 | (e & 0x7FF);
                    break;
            }
            G_io_apdu_buffer[*tx] = sw >> 8;
c0d00a44:	1859      	adds	r1, r3, r1
            G_io_apdu_buffer[*tx + 1] = sw;
c0d00a46:	7048      	strb	r0, [r1, #1]
            *tx += 2;
c0d00a48:	6820      	ldr	r0, [r4, #0]
c0d00a4a:	1c80      	adds	r0, r0, #2
c0d00a4c:	6020      	str	r0, [r4, #0]
c0d00a4e:	e073      	b.n	c0d00b38 <handleApdu+0x14c>
c0d00a50:	a816      	add	r0, sp, #88	; 0x58
void handleApdu(volatile uint32_t *flags, volatile uint32_t *tx, uint32_t rx) {
    uint16_t sw = 0;

    BEGIN_TRY
    {
        TRY
c0d00a52:	f000 fec8 	bl	c0d017e6 <try_context_set>
        {
            if (G_io_apdu_buffer[OFFSET_CLA] != CLA) {
c0d00a56:	497b      	ldr	r1, [pc, #492]	; (c0d00c44 <handleApdu+0x258>)
c0d00a58:	7808      	ldrb	r0, [r1, #0]
c0d00a5a:	2855      	cmp	r0, #85	; 0x55
c0d00a5c:	d000      	beq.n	c0d00a60 <handleApdu+0x74>
c0d00a5e:	e083      	b.n	c0d00b68 <handleApdu+0x17c>
                THROW(APDU_CODE_CLA_NOT_SUPPORTED);
            }

            if (rx < 5) {
c0d00a60:	2d04      	cmp	r5, #4
c0d00a62:	d800      	bhi.n	c0d00a66 <handleApdu+0x7a>
c0d00a64:	e084      	b.n	c0d00b70 <handleApdu+0x184>
c0d00a66:	7848      	ldrb	r0, [r1, #1]
c0d00a68:	2109      	movs	r1, #9
c0d00a6a:	0309      	lsls	r1, r1, #12
c0d00a6c:	4f76      	ldr	r7, [pc, #472]	; (c0d00c48 <handleApdu+0x25c>)
c0d00a6e:	4a77      	ldr	r2, [pc, #476]	; (c0d00c4c <handleApdu+0x260>)
                THROW(APDU_CODE_WRONG_LENGTH);
            }

            switch (G_io_apdu_buffer[OFFSET_INS]) {
c0d00a70:	2803      	cmp	r0, #3
c0d00a72:	dc20      	bgt.n	c0d00ab6 <handleApdu+0xca>
c0d00a74:	9101      	str	r1, [sp, #4]
c0d00a76:	2802      	cmp	r0, #2
c0d00a78:	d17e      	bne.n	c0d00b78 <handleApdu+0x18c>
                    *flags |= IO_ASYNCH_REPLY;
                    break;
                }

                case INS_SIGN_SECP256K1: {
                    current_sigtype = SECP256K1;
c0d00a7a:	4875      	ldr	r0, [pc, #468]	; (c0d00c50 <handleApdu+0x264>)
c0d00a7c:	2100      	movs	r1, #0
c0d00a7e:	7001      	strb	r1, [r0, #0]
c0d00a80:	2201      	movs	r2, #1
                    if (!process_chunk(tx, rx, true))
c0d00a82:	4629      	mov	r1, r5
c0d00a84:	f7ff fde2 	bl	c0d0064c <process_chunk>
c0d00a88:	2800      	cmp	r0, #0
c0d00a8a:	d100      	bne.n	c0d00a8e <handleApdu+0xa2>
c0d00a8c:	e0d2      	b.n	c0d00c34 <handleApdu+0x248>
                        THROW(APDU_CODE_OK);

                    const char *error_msg = transaction_parse();
c0d00a8e:	f002 fc23 	bl	c0d032d8 <transaction_parse>
c0d00a92:	4605      	mov	r5, r0
                    if (error_msg != NULL) {
c0d00a94:	2d00      	cmp	r5, #0
c0d00a96:	d000      	beq.n	c0d00a9a <handleApdu+0xae>
c0d00a98:	e0a2      	b.n	c0d00be0 <handleApdu+0x1f4>
                        os_memmove(G_io_apdu_buffer, error_msg, error_msg_length);
                        *tx += (error_msg_length);
                        THROW(APDU_CODE_BAD_KEY_HANDLE);
                    }

                    tx_display_index_root();
c0d00a9a:	f002 fc3b 	bl	c0d03314 <tx_display_index_root>

                    view_set_handlers(tx_getData, tx_accept_sign, tx_reject);
c0d00a9e:	4877      	ldr	r0, [pc, #476]	; (c0d00c7c <handleApdu+0x290>)
c0d00aa0:	4478      	add	r0, pc
c0d00aa2:	4977      	ldr	r1, [pc, #476]	; (c0d00c80 <handleApdu+0x294>)
c0d00aa4:	4479      	add	r1, pc
c0d00aa6:	4a77      	ldr	r2, [pc, #476]	; (c0d00c84 <handleApdu+0x298>)
c0d00aa8:	447a      	add	r2, pc
c0d00aaa:	f004 ff8d 	bl	c0d059c8 <view_set_handlers>
c0d00aae:	2000      	movs	r0, #0
                    view_tx_show(0);
c0d00ab0:	f004 fce6 	bl	c0d05480 <view_tx_show>
c0d00ab4:	e03c      	b.n	c0d00b30 <handleApdu+0x144>
c0d00ab6:	9200      	str	r2, [sp, #0]
c0d00ab8:	9702      	str	r7, [sp, #8]
c0d00aba:	2804      	cmp	r0, #4
c0d00abc:	d000      	beq.n	c0d00ac0 <handleApdu+0xd4>
c0d00abe:	e0bc      	b.n	c0d00c3a <handleApdu+0x24e>
                    break;
                }

                case INS_GET_ADDR_SECP256K1: {
                    // Parse arguments
                    if (!extractHRP(&bech32_hrp_len, bech32_hrp, rx, OFFSET_DATA)) {
c0d00ac0:	4c64      	ldr	r4, [pc, #400]	; (c0d00c54 <handleApdu+0x268>)
c0d00ac2:	4965      	ldr	r1, [pc, #404]	; (c0d00c58 <handleApdu+0x26c>)
c0d00ac4:	2305      	movs	r3, #5
c0d00ac6:	4620      	mov	r0, r4
c0d00ac8:	462a      	mov	r2, r5
c0d00aca:	f7ff fda1 	bl	c0d00610 <extractHRP>
                        THROW(APDU_CODE_DATA_INVALID);
                    }

                    if (!extractBip32(&bip32_depth, bip32_path, rx, OFFSET_DATA + bech32_hrp_len + 1)) {
c0d00ace:	7820      	ldrb	r0, [r4, #0]
c0d00ad0:	1d81      	adds	r1, r0, #6
    }
    return 0;
}

bool extractBip32(uint8_t *depth, uint32_t path[10], uint32_t rx, uint32_t offset) {
    if (rx < offset + 1) {
c0d00ad2:	1dc0      	adds	r0, r0, #7
c0d00ad4:	42a8      	cmp	r0, r5
c0d00ad6:	d844      	bhi.n	c0d00b62 <handleApdu+0x176>
c0d00ad8:	485a      	ldr	r0, [pc, #360]	; (c0d00c44 <handleApdu+0x258>)
c0d00ada:	4602      	mov	r2, r0
        return 0;
    }

    *depth = G_io_apdu_buffer[offset];
c0d00adc:	5c57      	ldrb	r7, [r2, r1]
c0d00ade:	485f      	ldr	r0, [pc, #380]	; (c0d00c5c <handleApdu+0x270>)
c0d00ae0:	7007      	strb	r7, [r0, #0]
c0d00ae2:	1850      	adds	r0, r2, r1
    const uint16_t req_offset = 4 * *depth + 1 + offset;
c0d00ae4:	00ba      	lsls	r2, r7, #2
c0d00ae6:	2301      	movs	r3, #1
c0d00ae8:	4313      	orrs	r3, r2
c0d00aea:	1859      	adds	r1, r3, r1

    if (rx < req_offset || *depth > 10) {
c0d00aec:	2f0a      	cmp	r7, #10
c0d00aee:	d838      	bhi.n	c0d00b62 <handleApdu+0x176>
c0d00af0:	42a9      	cmp	r1, r5
c0d00af2:	d836      	bhi.n	c0d00b62 <handleApdu+0x176>
        return 0;
    }

    memcpy(path, G_io_apdu_buffer + offset + 1, *depth * 4);
c0d00af4:	1c41      	adds	r1, r0, #1
c0d00af6:	4c5a      	ldr	r4, [pc, #360]	; (c0d00c60 <handleApdu+0x274>)
c0d00af8:	4620      	mov	r0, r4
c0d00afa:	f005 fbd3 	bl	c0d062a4 <__aeabi_memcpy>
c0d00afe:	9a00      	ldr	r2, [sp, #0]
bool validateCosmosPath(uint8_t depth, uint32_t path[10]) {
    // Only paths in the form 44'/118'/{account}'/0/{index} are supported
    if (bip32_depth != 5) {
        return 0;
    }
    if (path[0] != 0x8000002c || path[1] != 0x80000076 || path[3] != 0) {
c0d00b00:	4610      	mov	r0, r2
c0d00b02:	304a      	adds	r0, #74	; 0x4a
    return 1;
}

bool validateCosmosPath(uint8_t depth, uint32_t path[10]) {
    // Only paths in the form 44'/118'/{account}'/0/{index} are supported
    if (bip32_depth != 5) {
c0d00b04:	2f05      	cmp	r7, #5
c0d00b06:	d12c      	bne.n	c0d00b62 <handleApdu+0x176>
        return 0;
    }
    if (path[0] != 0x8000002c || path[1] != 0x80000076 || path[3] != 0) {
c0d00b08:	6821      	ldr	r1, [r4, #0]
c0d00b0a:	4291      	cmp	r1, r2
c0d00b0c:	d129      	bne.n	c0d00b62 <handleApdu+0x176>
c0d00b0e:	6861      	ldr	r1, [r4, #4]
c0d00b10:	4281      	cmp	r1, r0
c0d00b12:	d126      	bne.n	c0d00b62 <handleApdu+0x176>
c0d00b14:	68e0      	ldr	r0, [r4, #12]
c0d00b16:	2800      	cmp	r0, #0
c0d00b18:	d123      	bne.n	c0d00b62 <handleApdu+0x176>

                    if (!validateCosmosPath(bip32_depth, bip32_path)) {
                        THROW(APDU_CODE_DATA_INVALID);
                    }

                    view_set_handlers(addr_getData, addr_accept, addr_reject);
c0d00b1a:	4855      	ldr	r0, [pc, #340]	; (c0d00c70 <handleApdu+0x284>)
c0d00b1c:	4478      	add	r0, pc
c0d00b1e:	4955      	ldr	r1, [pc, #340]	; (c0d00c74 <handleApdu+0x288>)
c0d00b20:	4479      	add	r1, pc
c0d00b22:	4a55      	ldr	r2, [pc, #340]	; (c0d00c78 <handleApdu+0x28c>)
c0d00b24:	447a      	add	r2, pc
c0d00b26:	f004 ff4f 	bl	c0d059c8 <view_set_handlers>
c0d00b2a:	2000      	movs	r0, #0
                    view_addr_confirm(0);
c0d00b2c:	f004 ff30 	bl	c0d05990 <view_addr_confirm>
c0d00b30:	6830      	ldr	r0, [r6, #0]
c0d00b32:	2110      	movs	r1, #16
c0d00b34:	4301      	orrs	r1, r0
c0d00b36:	6031      	str	r1, [r6, #0]
            }
            G_io_apdu_buffer[*tx] = sw >> 8;
            G_io_apdu_buffer[*tx + 1] = sw;
            *tx += 2;
        }
        FINALLY
c0d00b38:	f000 ffc2 	bl	c0d01ac0 <try_context_get>
c0d00b3c:	a916      	add	r1, sp, #88	; 0x58
c0d00b3e:	4288      	cmp	r0, r1
c0d00b40:	d103      	bne.n	c0d00b4a <handleApdu+0x15e>
c0d00b42:	f000 ffbf 	bl	c0d01ac4 <try_context_get_previous>
c0d00b46:	f000 fe4e 	bl	c0d017e6 <try_context_set>
c0d00b4a:	a816      	add	r0, sp, #88	; 0x58
        {
        }
    }
    END_TRY;
c0d00b4c:	8d00      	ldrh	r0, [r0, #40]	; 0x28
c0d00b4e:	2800      	cmp	r0, #0
c0d00b50:	d108      	bne.n	c0d00b64 <handleApdu+0x178>
}
c0d00b52:	b021      	add	sp, #132	; 0x84
c0d00b54:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00b56:	a816      	add	r0, sp, #88	; 0x58

                default:
                    THROW(APDU_CODE_INS_NOT_SUPPORTED);
            }
        }
        CATCH(EXCEPTION_IO_RESET)
c0d00b58:	2100      	movs	r1, #0
c0d00b5a:	8501      	strh	r1, [r0, #40]	; 0x28
        {
            THROW(EXCEPTION_IO_RESET);
c0d00b5c:	2010      	movs	r0, #16
c0d00b5e:	f000 ffaa 	bl	c0d01ab6 <os_longjmp>
c0d00b62:	9802      	ldr	r0, [sp, #8]
c0d00b64:	f000 ffa7 	bl	c0d01ab6 <os_longjmp>
    BEGIN_TRY
    {
        TRY
        {
            if (G_io_apdu_buffer[OFFSET_CLA] != CLA) {
                THROW(APDU_CODE_CLA_NOT_SUPPORTED);
c0d00b68:	2037      	movs	r0, #55	; 0x37
c0d00b6a:	0240      	lsls	r0, r0, #9
c0d00b6c:	f000 ffa3 	bl	c0d01ab6 <os_longjmp>
            }

            if (rx < 5) {
                THROW(APDU_CODE_WRONG_LENGTH);
c0d00b70:	2067      	movs	r0, #103	; 0x67
c0d00b72:	0200      	lsls	r0, r0, #8
c0d00b74:	f000 ff9f 	bl	c0d01ab6 <os_longjmp>
c0d00b78:	9200      	str	r2, [sp, #0]
c0d00b7a:	2800      	cmp	r0, #0
c0d00b7c:	d040      	beq.n	c0d00c00 <handleApdu+0x214>
c0d00b7e:	2801      	cmp	r0, #1
c0d00b80:	d15b      	bne.n	c0d00c3a <handleApdu+0x24e>
    }
    return 0;
}

bool extractBip32(uint8_t *depth, uint32_t path[10], uint32_t rx, uint32_t offset) {
    if (rx < offset + 1) {
c0d00b82:	2d06      	cmp	r5, #6
c0d00b84:	d339      	bcc.n	c0d00bfa <handleApdu+0x20e>
        return 0;
    }

    *depth = G_io_apdu_buffer[offset];
c0d00b86:	482f      	ldr	r0, [pc, #188]	; (c0d00c44 <handleApdu+0x258>)
c0d00b88:	7946      	ldrb	r6, [r0, #5]
c0d00b8a:	4834      	ldr	r0, [pc, #208]	; (c0d00c5c <handleApdu+0x270>)
c0d00b8c:	7006      	strb	r6, [r0, #0]
    const uint16_t req_offset = 4 * *depth + 1 + offset;
c0d00b8e:	00b2      	lsls	r2, r6, #2
c0d00b90:	2001      	movs	r0, #1
c0d00b92:	4310      	orrs	r0, r2
c0d00b94:	1d40      	adds	r0, r0, #5

    if (rx < req_offset || *depth > 10) {
c0d00b96:	2e0a      	cmp	r6, #10
c0d00b98:	d82f      	bhi.n	c0d00bfa <handleApdu+0x20e>
c0d00b9a:	42a8      	cmp	r0, r5
c0d00b9c:	d82d      	bhi.n	c0d00bfa <handleApdu+0x20e>
        return 0;
    }

    memcpy(path, G_io_apdu_buffer + offset + 1, *depth * 4);
c0d00b9e:	4829      	ldr	r0, [pc, #164]	; (c0d00c44 <handleApdu+0x258>)
c0d00ba0:	1d81      	adds	r1, r0, #6
c0d00ba2:	4d2f      	ldr	r5, [pc, #188]	; (c0d00c60 <handleApdu+0x274>)
c0d00ba4:	4628      	mov	r0, r5
c0d00ba6:	f005 fb7d 	bl	c0d062a4 <__aeabi_memcpy>
bool validateCosmosPath(uint8_t depth, uint32_t path[10]) {
    // Only paths in the form 44'/118'/{account}'/0/{index} are supported
    if (bip32_depth != 5) {
        return 0;
    }
    if (path[0] != 0x8000002c || path[1] != 0x80000076 || path[3] != 0) {
c0d00baa:	9800      	ldr	r0, [sp, #0]
c0d00bac:	304a      	adds	r0, #74	; 0x4a
    return 1;
}

bool validateCosmosPath(uint8_t depth, uint32_t path[10]) {
    // Only paths in the form 44'/118'/{account}'/0/{index} are supported
    if (bip32_depth != 5) {
c0d00bae:	2e05      	cmp	r6, #5
c0d00bb0:	d123      	bne.n	c0d00bfa <handleApdu+0x20e>
        return 0;
    }
    if (path[0] != 0x8000002c || path[1] != 0x80000076 || path[3] != 0) {
c0d00bb2:	6829      	ldr	r1, [r5, #0]
c0d00bb4:	9a00      	ldr	r2, [sp, #0]
c0d00bb6:	4291      	cmp	r1, r2
c0d00bb8:	d11f      	bne.n	c0d00bfa <handleApdu+0x20e>
c0d00bba:	6869      	ldr	r1, [r5, #4]
c0d00bbc:	4281      	cmp	r1, r0
c0d00bbe:	d11c      	bne.n	c0d00bfa <handleApdu+0x20e>
c0d00bc0:	68e8      	ldr	r0, [r5, #12]
c0d00bc2:	2800      	cmp	r0, #0
c0d00bc4:	d119      	bne.n	c0d00bfa <handleApdu+0x20e>
c0d00bc6:	ad03      	add	r5, sp, #12
                    if (!validateCosmosPath(bip32_depth, bip32_path)) {
                        THROW(APDU_CODE_DATA_INVALID);
                    }

                    cx_ecfp_public_key_t publicKey;
                    getPubKey(&publicKey);
c0d00bc8:	4628      	mov	r0, r5
c0d00bca:	f000 f9eb 	bl	c0d00fa4 <getPubKey>

                    os_memmove(G_io_apdu_buffer, publicKey.W, 65);
c0d00bce:	3508      	adds	r5, #8
c0d00bd0:	481c      	ldr	r0, [pc, #112]	; (c0d00c44 <handleApdu+0x258>)
c0d00bd2:	2241      	movs	r2, #65	; 0x41
c0d00bd4:	4629      	mov	r1, r5
c0d00bd6:	f000 feba 	bl	c0d0194e <os_memmove>
                    *tx += 65;
c0d00bda:	6820      	ldr	r0, [r4, #0]
c0d00bdc:	3041      	adds	r0, #65	; 0x41
c0d00bde:	e028      	b.n	c0d00c32 <handleApdu+0x246>
                    if (!process_chunk(tx, rx, true))
                        THROW(APDU_CODE_OK);

                    const char *error_msg = transaction_parse();
                    if (error_msg != NULL) {
                        int error_msg_length = strlen(error_msg);
c0d00be0:	4628      	mov	r0, r5
c0d00be2:	f005 fc4d 	bl	c0d06480 <strlen>
c0d00be6:	4606      	mov	r6, r0
                        os_memmove(G_io_apdu_buffer, error_msg, error_msg_length);
c0d00be8:	4816      	ldr	r0, [pc, #88]	; (c0d00c44 <handleApdu+0x258>)
c0d00bea:	4629      	mov	r1, r5
c0d00bec:	4632      	mov	r2, r6
c0d00bee:	f000 feae 	bl	c0d0194e <os_memmove>
                        *tx += (error_msg_length);
c0d00bf2:	6820      	ldr	r0, [r4, #0]
c0d00bf4:	1980      	adds	r0, r0, r6
c0d00bf6:	6020      	str	r0, [r4, #0]
                        THROW(APDU_CODE_BAD_KEY_HANDLE);
c0d00bf8:	37fc      	adds	r7, #252	; 0xfc
c0d00bfa:	4638      	mov	r0, r7
c0d00bfc:	f000 ff5b 	bl	c0d01ab6 <os_longjmp>
c0d00c00:	2100      	movs	r1, #0
c0d00c02:	4810      	ldr	r0, [pc, #64]	; (c0d00c44 <handleApdu+0x258>)
c0d00c04:	4603      	mov	r3, r0
            switch (G_io_apdu_buffer[OFFSET_INS]) {
                case INS_GET_VERSION: {
#ifdef TESTING_ENABLED
                    G_io_apdu_buffer[0] = 0xFF;
#else
                    G_io_apdu_buffer[0] = 0;
c0d00c06:	7019      	strb	r1, [r3, #0]
c0d00c08:	2001      	movs	r0, #1
#endif
                    G_io_apdu_buffer[1] = LEDGER_MAJOR_VERSION;
c0d00c0a:	7058      	strb	r0, [r3, #1]
c0d00c0c:	2205      	movs	r2, #5
                    G_io_apdu_buffer[2] = LEDGER_MINOR_VERSION;
c0d00c0e:	709a      	strb	r2, [r3, #2]
c0d00c10:	2202      	movs	r2, #2
                    G_io_apdu_buffer[3] = LEDGER_PATCH_VERSION;
c0d00c12:	70da      	strb	r2, [r3, #3]
                    G_io_apdu_buffer[4] = !IS_UX_ALLOWED;
c0d00c14:	4a13      	ldr	r2, [pc, #76]	; (c0d00c64 <handleApdu+0x278>)
c0d00c16:	69d3      	ldr	r3, [r2, #28]
c0d00c18:	4a13      	ldr	r2, [pc, #76]	; (c0d00c68 <handleApdu+0x27c>)
c0d00c1a:	4293      	cmp	r3, r2
c0d00c1c:	4602      	mov	r2, r0
c0d00c1e:	d000      	beq.n	c0d00c22 <handleApdu+0x236>
c0d00c20:	460a      	mov	r2, r1
c0d00c22:	2b00      	cmp	r3, #0
c0d00c24:	d000      	beq.n	c0d00c28 <handleApdu+0x23c>
c0d00c26:	4608      	mov	r0, r1
c0d00c28:	4310      	orrs	r0, r2
c0d00c2a:	4906      	ldr	r1, [pc, #24]	; (c0d00c44 <handleApdu+0x258>)
c0d00c2c:	7108      	strb	r0, [r1, #4]

                    *tx += 5;
c0d00c2e:	6820      	ldr	r0, [r4, #0]
c0d00c30:	1d40      	adds	r0, r0, #5
c0d00c32:	6020      	str	r0, [r4, #0]
c0d00c34:	9801      	ldr	r0, [sp, #4]
c0d00c36:	f000 ff3e 	bl	c0d01ab6 <os_longjmp>
                }
                break;
#endif

                default:
                    THROW(APDU_CODE_INS_NOT_SUPPORTED);
c0d00c3a:	206d      	movs	r0, #109	; 0x6d
c0d00c3c:	0200      	lsls	r0, r0, #8
c0d00c3e:	f000 ff3a 	bl	c0d01ab6 <os_longjmp>
c0d00c42:	46c0      	nop			; (mov r8, r8)
c0d00c44:	20001924 	.word	0x20001924
c0d00c48:	00006984 	.word	0x00006984
c0d00c4c:	8000002c 	.word	0x8000002c
c0d00c50:	20001915 	.word	0x20001915
c0d00c54:	20001916 	.word	0x20001916
c0d00c58:	200018c1 	.word	0x200018c1
c0d00c5c:	200018c0 	.word	0x200018c0
c0d00c60:	20001898 	.word	0x20001898
c0d00c64:	200022ac 	.word	0x200022ac
c0d00c68:	b0105044 	.word	0xb0105044
c0d00c6c:	000007ff 	.word	0x000007ff
c0d00c70:	fffffd2d 	.word	0xfffffd2d
c0d00c74:	fffffda1 	.word	0xfffffda1
c0d00c78:	fffffea5 	.word	0xfffffea5
c0d00c7c:	fffffc31 	.word	0xfffffc31
c0d00c80:	fffffcd9 	.word	0xfffffcd9
c0d00c84:	fffffd81 	.word	0xfffffd81

c0d00c88 <handle_generic_apdu>:
        }
    }
    END_TRY;
}

void handle_generic_apdu(volatile uint32_t *flags, volatile uint32_t *tx, uint32_t rx) {
c0d00c88:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00c8a:	b081      	sub	sp, #4
c0d00c8c:	460c      	mov	r4, r1
    if (rx > 4 && os_memcmp(G_io_apdu_buffer, "\xE0\x01\x00\x00", 4) == 0) {
c0d00c8e:	2a05      	cmp	r2, #5
c0d00c90:	d308      	bcc.n	c0d00ca4 <handle_generic_apdu+0x1c>
c0d00c92:	4d15      	ldr	r5, [pc, #84]	; (c0d00ce8 <handle_generic_apdu+0x60>)
c0d00c94:	a115      	add	r1, pc, #84	; (adr r1, c0d00cec <handle_generic_apdu+0x64>)
c0d00c96:	2604      	movs	r6, #4
c0d00c98:	4628      	mov	r0, r5
c0d00c9a:	4632      	mov	r2, r6
c0d00c9c:	f000 fef4 	bl	c0d01a88 <os_memcmp>
c0d00ca0:	2800      	cmp	r0, #0
c0d00ca2:	d001      	beq.n	c0d00ca8 <handle_generic_apdu+0x20>
        p = p + 1 + *p;

        *tx = p - G_io_apdu_buffer;
        THROW(APDU_CODE_OK);
    }
}
c0d00ca4:	b001      	add	sp, #4
c0d00ca6:	bdf0      	pop	{r4, r5, r6, r7, pc}
void handle_generic_apdu(volatile uint32_t *flags, volatile uint32_t *tx, uint32_t rx) {
    if (rx > 4 && os_memcmp(G_io_apdu_buffer, "\xE0\x01\x00\x00", 4) == 0) {
        // Respond to get device info command
        uint8_t *p = G_io_apdu_buffer;
        // Target ID        4 bytes
        p[0]=(TARGET_ID >> 24) & 0xFF;
c0d00ca8:	2031      	movs	r0, #49	; 0x31
c0d00caa:	7028      	strb	r0, [r5, #0]
        p[1]=(TARGET_ID >> 16) & 0xFF;
c0d00cac:	2010      	movs	r0, #16
c0d00cae:	7068      	strb	r0, [r5, #1]
        p[2]=(TARGET_ID >> 8) & 0xFF;
c0d00cb0:	2700      	movs	r7, #0
c0d00cb2:	70af      	strb	r7, [r5, #2]
        p[3]=(TARGET_ID >> 0) & 0xFF;
c0d00cb4:	70ee      	strb	r6, [r5, #3]
        p += 4;
        // SE Version       [length][non-terminated string]
        *p = os_version(p + 1, 64);
c0d00cb6:	1d6e      	adds	r6, r5, #5
c0d00cb8:	2140      	movs	r1, #64	; 0x40
c0d00cba:	9100      	str	r1, [sp, #0]
c0d00cbc:	4630      	mov	r0, r6
c0d00cbe:	f002 fa5b 	bl	c0d03178 <os_version>
c0d00cc2:	7128      	strb	r0, [r5, #4]
        p = p + 1 + *p;
c0d00cc4:	b2c0      	uxtb	r0, r0
        // Flags            [length][flags]
        *p = 0;
c0d00cc6:	5437      	strb	r7, [r6, r0]
        p[2]=(TARGET_ID >> 8) & 0xFF;
        p[3]=(TARGET_ID >> 0) & 0xFF;
        p += 4;
        // SE Version       [length][non-terminated string]
        *p = os_version(p + 1, 64);
        p = p + 1 + *p;
c0d00cc8:	1837      	adds	r7, r6, r0
        // Flags            [length][flags]
        *p = 0;
        p++;
        // MCU Version      [length][non-terminated string]
        *p = os_seph_version(p + 1, 64);
c0d00cca:	1cbe      	adds	r6, r7, #2
c0d00ccc:	4630      	mov	r0, r6
c0d00cce:	9900      	ldr	r1, [sp, #0]
c0d00cd0:	f002 fa6a 	bl	c0d031a8 <os_seph_version>
c0d00cd4:	7078      	strb	r0, [r7, #1]
        p = p + 1 + *p;
c0d00cd6:	b2c0      	uxtb	r0, r0
c0d00cd8:	1830      	adds	r0, r6, r0

        *tx = p - G_io_apdu_buffer;
c0d00cda:	1b40      	subs	r0, r0, r5
c0d00cdc:	6020      	str	r0, [r4, #0]
        THROW(APDU_CODE_OK);
c0d00cde:	2009      	movs	r0, #9
c0d00ce0:	0300      	lsls	r0, r0, #12
c0d00ce2:	f000 fee8 	bl	c0d01ab6 <os_longjmp>
c0d00ce6:	46c0      	nop			; (mov r8, r8)
c0d00ce8:	20001924 	.word	0x20001924
c0d00cec:	000001e0 	.word	0x000001e0
c0d00cf0:	00000000 	.word	0x00000000

c0d00cf4 <app_init>:
    }
}

void app_init() {
c0d00cf4:	b510      	push	{r4, lr}
    io_seproxyhal_init();
c0d00cf6:	f001 f813 	bl	c0d01d20 <io_seproxyhal_init>
c0d00cfa:	2400      	movs	r4, #0
    USB_power(0);
c0d00cfc:	4620      	mov	r0, r4
c0d00cfe:	f004 fb07 	bl	c0d05310 <USB_power>
    USB_power(1);
c0d00d02:	2001      	movs	r0, #1
c0d00d04:	f004 fb04 	bl	c0d05310 <USB_power>
    view_idle(0);
c0d00d08:	4620      	mov	r0, r4
c0d00d0a:	f004 fbaf 	bl	c0d0546c <view_idle>
}
c0d00d0e:	bd10      	pop	{r4, pc}

c0d00d10 <app_main>:

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wmissing-noreturn"

void app_main() {
c0d00d10:	b570      	push	{r4, r5, r6, lr}
c0d00d12:	b090      	sub	sp, #64	; 0x40
c0d00d14:	2500      	movs	r5, #0
    volatile uint32_t rx = 0, tx = 0, flags = 0;
c0d00d16:	950f      	str	r5, [sp, #60]	; 0x3c
c0d00d18:	950e      	str	r5, [sp, #56]	; 0x38
c0d00d1a:	950d      	str	r5, [sp, #52]	; 0x34
c0d00d1c:	4e2f      	ldr	r6, [pc, #188]	; (c0d00ddc <app_main+0xcc>)
c0d00d1e:	a80c      	add	r0, sp, #48	; 0x30

    for (;;) {
        volatile uint16_t sw = 0;
c0d00d20:	8005      	strh	r5, [r0, #0]
c0d00d22:	ac01      	add	r4, sp, #4

        BEGIN_TRY;
        {
            TRY;
c0d00d24:	4620      	mov	r0, r4
c0d00d26:	f005 fb4d 	bl	c0d063c4 <setjmp>
c0d00d2a:	8520      	strh	r0, [r4, #40]	; 0x28
c0d00d2c:	4929      	ldr	r1, [pc, #164]	; (c0d00dd4 <app_main+0xc4>)
c0d00d2e:	4208      	tst	r0, r1
c0d00d30:	d00f      	beq.n	c0d00d52 <app_main+0x42>
c0d00d32:	a901      	add	r1, sp, #4

                handle_generic_apdu(&flags, &tx, rx);

                handleApdu(&flags, &tx, rx);
            }
            CATCH_OTHER(e);
c0d00d34:	850d      	strh	r5, [r1, #40]	; 0x28
c0d00d36:	210f      	movs	r1, #15
c0d00d38:	0309      	lsls	r1, r1, #12
            {
                switch (e & 0xF000) {
c0d00d3a:	4001      	ands	r1, r0
c0d00d3c:	2209      	movs	r2, #9
c0d00d3e:	0312      	lsls	r2, r2, #12
c0d00d40:	4291      	cmp	r1, r2
c0d00d42:	d003      	beq.n	c0d00d4c <app_main+0x3c>
c0d00d44:	2203      	movs	r2, #3
c0d00d46:	0352      	lsls	r2, r2, #13
c0d00d48:	4291      	cmp	r1, r2
c0d00d4a:	d11f      	bne.n	c0d00d8c <app_main+0x7c>
c0d00d4c:	a90c      	add	r1, sp, #48	; 0x30
                    case 0x6000:
                    case 0x9000:
                        sw = e;
c0d00d4e:	8008      	strh	r0, [r1, #0]
c0d00d50:	e023      	b.n	c0d00d9a <app_main+0x8a>
c0d00d52:	a801      	add	r0, sp, #4
    for (;;) {
        volatile uint16_t sw = 0;

        BEGIN_TRY;
        {
            TRY;
c0d00d54:	f000 fd47 	bl	c0d017e6 <try_context_set>
            {
                rx = tx;
c0d00d58:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d00d5a:	900f      	str	r0, [sp, #60]	; 0x3c
c0d00d5c:	2400      	movs	r4, #0
                tx = 0;
c0d00d5e:	940e      	str	r4, [sp, #56]	; 0x38
                rx = io_exchange(CHANNEL_APDU | flags, rx);
c0d00d60:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d00d62:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d00d64:	b2c0      	uxtb	r0, r0
c0d00d66:	b289      	uxth	r1, r1
c0d00d68:	f001 fa30 	bl	c0d021cc <io_exchange>
c0d00d6c:	900f      	str	r0, [sp, #60]	; 0x3c
                flags = 0;
c0d00d6e:	940d      	str	r4, [sp, #52]	; 0x34

                if (rx == 0)
c0d00d70:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d00d72:	2800      	cmp	r0, #0
c0d00d74:	d02b      	beq.n	c0d00dce <app_main+0xbe>
                    THROW(APDU_CODE_EMPTY_BUFFER);

                handle_generic_apdu(&flags, &tx, rx);
c0d00d76:	9a0f      	ldr	r2, [sp, #60]	; 0x3c
c0d00d78:	ac0e      	add	r4, sp, #56	; 0x38
c0d00d7a:	4621      	mov	r1, r4
c0d00d7c:	f7ff ff84 	bl	c0d00c88 <handle_generic_apdu>

                handleApdu(&flags, &tx, rx);
c0d00d80:	9a0f      	ldr	r2, [sp, #60]	; 0x3c
c0d00d82:	a80d      	add	r0, sp, #52	; 0x34
c0d00d84:	4621      	mov	r1, r4
c0d00d86:	f7ff fe31 	bl	c0d009ec <handleApdu>
c0d00d8a:	e011      	b.n	c0d00db0 <app_main+0xa0>
                    case 0x6000:
                    case 0x9000:
                        sw = e;
                        break;
                    default:
                        sw = 0x6800 | (e & 0x7FF);
c0d00d8c:	4912      	ldr	r1, [pc, #72]	; (c0d00dd8 <app_main+0xc8>)
c0d00d8e:	4008      	ands	r0, r1
c0d00d90:	210d      	movs	r1, #13
c0d00d92:	02c9      	lsls	r1, r1, #11
c0d00d94:	4301      	orrs	r1, r0
c0d00d96:	a80c      	add	r0, sp, #48	; 0x30
c0d00d98:	8001      	strh	r1, [r0, #0]
                        break;
                }
                G_io_apdu_buffer[tx] = sw >> 8;
c0d00d9a:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d00d9c:	0a00      	lsrs	r0, r0, #8
c0d00d9e:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d00da0:	5470      	strb	r0, [r6, r1]
                G_io_apdu_buffer[tx + 1] = sw;
c0d00da2:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d00da4:	990e      	ldr	r1, [sp, #56]	; 0x38
                        break;
                    default:
                        sw = 0x6800 | (e & 0x7FF);
                        break;
                }
                G_io_apdu_buffer[tx] = sw >> 8;
c0d00da6:	1871      	adds	r1, r6, r1
                G_io_apdu_buffer[tx + 1] = sw;
c0d00da8:	7048      	strb	r0, [r1, #1]
                tx += 2;
c0d00daa:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d00dac:	1c80      	adds	r0, r0, #2
c0d00dae:	900e      	str	r0, [sp, #56]	; 0x38
            }
            FINALLY;
c0d00db0:	f000 fe86 	bl	c0d01ac0 <try_context_get>
c0d00db4:	a901      	add	r1, sp, #4
c0d00db6:	4288      	cmp	r0, r1
c0d00db8:	d103      	bne.n	c0d00dc2 <app_main+0xb2>
c0d00dba:	f000 fe83 	bl	c0d01ac4 <try_context_get_previous>
c0d00dbe:	f000 fd12 	bl	c0d017e6 <try_context_set>
c0d00dc2:	a801      	add	r0, sp, #4
            {}
        }
        END_TRY;
c0d00dc4:	8d00      	ldrh	r0, [r0, #40]	; 0x28
c0d00dc6:	2800      	cmp	r0, #0
c0d00dc8:	d0a9      	beq.n	c0d00d1e <app_main+0xe>
c0d00dca:	f000 fe74 	bl	c0d01ab6 <os_longjmp>
                tx = 0;
                rx = io_exchange(CHANNEL_APDU | flags, rx);
                flags = 0;

                if (rx == 0)
                    THROW(APDU_CODE_EMPTY_BUFFER);
c0d00dce:	4804      	ldr	r0, [pc, #16]	; (c0d00de0 <app_main+0xd0>)
c0d00dd0:	f000 fe71 	bl	c0d01ab6 <os_longjmp>
c0d00dd4:	0000ffff 	.word	0x0000ffff
c0d00dd8:	000007ff 	.word	0x000007ff
c0d00ddc:	20001924 	.word	0x20001924
c0d00de0:	00006982 	.word	0x00006982

c0d00de4 <bech32EncodeFromBytes>:
#include "bittools.h"

void bech32EncodeFromBytes(char *output,
                           const char *hrp,
                           const uint8_t *data,
                           size_t data_len) {
c0d00de4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00de6:	b0a5      	sub	sp, #148	; 0x94
c0d00de8:	4616      	mov	r6, r2
c0d00dea:	460c      	mov	r4, r1
c0d00dec:	4605      	mov	r5, r0
    output[0] = 0;
c0d00dee:	2000      	movs	r0, #0
c0d00df0:	7028      	strb	r0, [r5, #0]
    if (data_len > 128) {
c0d00df2:	2b80      	cmp	r3, #128	; 0x80
c0d00df4:	d812      	bhi.n	c0d00e1c <bech32EncodeFromBytes+0x38>
        return;
    }

    uint8_t tmp_data[128];
    size_t tmp_size = 0;
c0d00df6:	9004      	str	r0, [sp, #16]

    convert_bits(tmp_data, &tmp_size, 5, data, data_len, 8, 0);
c0d00df8:	4669      	mov	r1, sp
c0d00dfa:	2208      	movs	r2, #8
c0d00dfc:	600b      	str	r3, [r1, #0]
c0d00dfe:	604a      	str	r2, [r1, #4]
c0d00e00:	6088      	str	r0, [r1, #8]
c0d00e02:	af05      	add	r7, sp, #20
c0d00e04:	a904      	add	r1, sp, #16
c0d00e06:	2205      	movs	r2, #5
c0d00e08:	4638      	mov	r0, r7
c0d00e0a:	4633      	mov	r3, r6
c0d00e0c:	f001 ffe0 	bl	c0d02dd0 <convert_bits>
    bech32_encode(output, hrp, tmp_data, tmp_size);
c0d00e10:	9b04      	ldr	r3, [sp, #16]
c0d00e12:	4628      	mov	r0, r5
c0d00e14:	4621      	mov	r1, r4
c0d00e16:	463a      	mov	r2, r7
c0d00e18:	f001 ff4a 	bl	c0d02cb0 <bech32_encode>
}
c0d00e1c:	b025      	add	sp, #148	; 0x94
c0d00e1e:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00e20 <buffering_init>:
buffer_state_t flash;       // Flash

void buffering_init(uint8_t *ram_buffer,
                    uint16_t ram_buffer_size,
                    uint8_t *flash_buffer,
                    uint16_t flash_buffer_size) {
c0d00e20:	b5b0      	push	{r4, r5, r7, lr}
    ram.data = ram_buffer;
c0d00e22:	4c09      	ldr	r4, [pc, #36]	; (c0d00e48 <buffering_init+0x28>)
c0d00e24:	6020      	str	r0, [r4, #0]
    ram.size = ram_buffer_size;
c0d00e26:	80a1      	strh	r1, [r4, #4]
    ram.pos = 0;
c0d00e28:	2000      	movs	r0, #0
c0d00e2a:	80e0      	strh	r0, [r4, #6]
    ram.in_use = 1;
c0d00e2c:	7a21      	ldrb	r1, [r4, #8]
c0d00e2e:	2501      	movs	r5, #1
c0d00e30:	430d      	orrs	r5, r1
c0d00e32:	7225      	strb	r5, [r4, #8]

    flash.data = flash_buffer;
c0d00e34:	4905      	ldr	r1, [pc, #20]	; (c0d00e4c <buffering_init+0x2c>)
c0d00e36:	600a      	str	r2, [r1, #0]
    flash.size = flash_buffer_size;
c0d00e38:	808b      	strh	r3, [r1, #4]
    flash.pos = 0;
c0d00e3a:	80c8      	strh	r0, [r1, #6]
    flash.in_use = 0;
c0d00e3c:	7a08      	ldrb	r0, [r1, #8]
c0d00e3e:	22fe      	movs	r2, #254	; 0xfe
c0d00e40:	4002      	ands	r2, r0
c0d00e42:	720a      	strb	r2, [r1, #8]
}
c0d00e44:	bdb0      	pop	{r4, r5, r7, pc}
c0d00e46:	46c0      	nop			; (mov r8, r8)
c0d00e48:	20001880 	.word	0x20001880
c0d00e4c:	2000188c 	.word	0x2000188c

c0d00e50 <buffering_reset>:

void buffering_reset() {
    ram.pos = 0;
c0d00e50:	4806      	ldr	r0, [pc, #24]	; (c0d00e6c <buffering_reset+0x1c>)
c0d00e52:	2100      	movs	r1, #0
c0d00e54:	80c1      	strh	r1, [r0, #6]
    ram.in_use = 1;
c0d00e56:	7a02      	ldrb	r2, [r0, #8]
c0d00e58:	2301      	movs	r3, #1
c0d00e5a:	4313      	orrs	r3, r2
c0d00e5c:	7203      	strb	r3, [r0, #8]
    flash.pos = 0;
c0d00e5e:	4804      	ldr	r0, [pc, #16]	; (c0d00e70 <buffering_reset+0x20>)
c0d00e60:	80c1      	strh	r1, [r0, #6]
    flash.in_use = 0;
c0d00e62:	7a01      	ldrb	r1, [r0, #8]
c0d00e64:	22fe      	movs	r2, #254	; 0xfe
c0d00e66:	400a      	ands	r2, r1
c0d00e68:	7202      	strb	r2, [r0, #8]
}
c0d00e6a:	4770      	bx	lr
c0d00e6c:	20001880 	.word	0x20001880
c0d00e70:	2000188c 	.word	0x2000188c

c0d00e74 <buffering_append>:

int buffering_append(uint8_t *data, int length) {
c0d00e74:	b570      	push	{r4, r5, r6, lr}
c0d00e76:	460c      	mov	r4, r1
c0d00e78:	4605      	mov	r5, r0
    if (ram.in_use) {
c0d00e7a:	4e1b      	ldr	r6, [pc, #108]	; (c0d00ee8 <buffering_append+0x74>)
c0d00e7c:	7a32      	ldrb	r2, [r6, #8]
c0d00e7e:	2001      	movs	r0, #1
c0d00e80:	4202      	tst	r2, r0
c0d00e82:	d10d      	bne.n	c0d00ea0 <buffering_append+0x2c>
            ram.pos = 0;
            return num_bytes;
        }
    } else {
        // Flash in use, append to flash
        if (flash.size - flash.pos >= length) {
c0d00e84:	4e19      	ldr	r6, [pc, #100]	; (c0d00eec <buffering_append+0x78>)
c0d00e86:	88f1      	ldrh	r1, [r6, #6]
c0d00e88:	88b0      	ldrh	r0, [r6, #4]
c0d00e8a:	1a42      	subs	r2, r0, r1
c0d00e8c:	2000      	movs	r0, #0
c0d00e8e:	42a2      	cmp	r2, r4
c0d00e90:	db29      	blt.n	c0d00ee6 <buffering_append+0x72>
            MEMCPY_NV(flash.data + flash.pos, data, length);
c0d00e92:	6830      	ldr	r0, [r6, #0]
c0d00e94:	1840      	adds	r0, r0, r1
c0d00e96:	4629      	mov	r1, r5
c0d00e98:	4622      	mov	r2, r4
c0d00e9a:	f002 f81b 	bl	c0d02ed4 <nvm_write>
c0d00e9e:	e01d      	b.n	c0d00edc <buffering_append+0x68>
    flash.in_use = 0;
}

int buffering_append(uint8_t *data, int length) {
    if (ram.in_use) {
        if (ram.size - ram.pos >= length) {
c0d00ea0:	88f1      	ldrh	r1, [r6, #6]
c0d00ea2:	88b3      	ldrh	r3, [r6, #4]
c0d00ea4:	1a5b      	subs	r3, r3, r1
c0d00ea6:	42a3      	cmp	r3, r4
c0d00ea8:	da12      	bge.n	c0d00ed0 <buffering_append+0x5c>
            // RAM in use, append to ram if there is enough space
            MEMCPY(ram.data + ram.pos, data, length);
            ram.pos += length;
        } else {
            // If RAM is not big enough copy memory to flash
            ram.in_use = 0;
c0d00eaa:	23fe      	movs	r3, #254	; 0xfe
c0d00eac:	401a      	ands	r2, r3
c0d00eae:	7232      	strb	r2, [r6, #8]
            flash.in_use = 1;
c0d00eb0:	4a0e      	ldr	r2, [pc, #56]	; (c0d00eec <buffering_append+0x78>)
c0d00eb2:	7a13      	ldrb	r3, [r2, #8]
c0d00eb4:	4303      	orrs	r3, r0
c0d00eb6:	7213      	strb	r3, [r2, #8]
            if (ram.pos > 0) {
c0d00eb8:	2900      	cmp	r1, #0
c0d00eba:	d002      	beq.n	c0d00ec2 <buffering_append+0x4e>
                buffering_append(ram.data, ram.pos);
c0d00ebc:	6830      	ldr	r0, [r6, #0]
c0d00ebe:	f7ff ffd9 	bl	c0d00e74 <buffering_append>
            }
            int num_bytes = buffering_append(data, length);
c0d00ec2:	4628      	mov	r0, r5
c0d00ec4:	4621      	mov	r1, r4
c0d00ec6:	f7ff ffd5 	bl	c0d00e74 <buffering_append>
            ram.pos = 0;
c0d00eca:	2100      	movs	r1, #0
c0d00ecc:	80f1      	strh	r1, [r6, #6]
        } else {
            return 0;
        }
    }
    return length;
}
c0d00ece:	bd70      	pop	{r4, r5, r6, pc}

int buffering_append(uint8_t *data, int length) {
    if (ram.in_use) {
        if (ram.size - ram.pos >= length) {
            // RAM in use, append to ram if there is enough space
            MEMCPY(ram.data + ram.pos, data, length);
c0d00ed0:	6830      	ldr	r0, [r6, #0]
c0d00ed2:	1840      	adds	r0, r0, r1
c0d00ed4:	4629      	mov	r1, r5
c0d00ed6:	4622      	mov	r2, r4
c0d00ed8:	f000 fd39 	bl	c0d0194e <os_memmove>
c0d00edc:	1db0      	adds	r0, r6, #6
c0d00ede:	8801      	ldrh	r1, [r0, #0]
c0d00ee0:	1909      	adds	r1, r1, r4
c0d00ee2:	8001      	strh	r1, [r0, #0]
c0d00ee4:	4620      	mov	r0, r4
        } else {
            return 0;
        }
    }
    return length;
}
c0d00ee6:	bd70      	pop	{r4, r5, r6, pc}
c0d00ee8:	20001880 	.word	0x20001880
c0d00eec:	2000188c 	.word	0x2000188c

c0d00ef0 <buffering_get_buffer>:
buffer_state_t *buffering_get_flash_buffer() {
    return &flash;
}

buffer_state_t *buffering_get_buffer() {
    if (ram.in_use) {
c0d00ef0:	4802      	ldr	r0, [pc, #8]	; (c0d00efc <buffering_get_buffer+0xc>)
c0d00ef2:	7a01      	ldrb	r1, [r0, #8]
        return &ram;
    }
    return &flash;
c0d00ef4:	07c9      	lsls	r1, r1, #31
c0d00ef6:	d100      	bne.n	c0d00efa <buffering_get_buffer+0xa>
c0d00ef8:	4801      	ldr	r0, [pc, #4]	; (c0d00f00 <buffering_get_buffer+0x10>)
}
c0d00efa:	4770      	bx	lr
c0d00efc:	20001880 	.word	0x20001880
c0d00f00:	2000188c 	.word	0x2000188c

c0d00f04 <keys_secp256k1>:
uint8_t bech32_hrp_len;
char bech32_hrp[MAX_BECH32_HRP_LEN + 1];

void keys_secp256k1(cx_ecfp_public_key_t *publicKey,
                    cx_ecfp_private_key_t *privateKey,
                    const uint8_t privateKeyData[32]) {
c0d00f04:	b570      	push	{r4, r5, r6, lr}
c0d00f06:	460c      	mov	r4, r1
c0d00f08:	4605      	mov	r5, r0
c0d00f0a:	2621      	movs	r6, #33	; 0x21
    cx_ecfp_init_private_key(CX_CURVE_256K1, privateKeyData, 32, privateKey);
c0d00f0c:	2320      	movs	r3, #32
c0d00f0e:	4630      	mov	r0, r6
c0d00f10:	4611      	mov	r1, r2
c0d00f12:	461a      	mov	r2, r3
c0d00f14:	4623      	mov	r3, r4
c0d00f16:	f002 f86d 	bl	c0d02ff4 <cx_ecfp_init_private_key>
    cx_ecfp_init_public_key(CX_CURVE_256K1, NULL, 0, publicKey);
c0d00f1a:	2100      	movs	r1, #0
c0d00f1c:	4630      	mov	r0, r6
c0d00f1e:	460a      	mov	r2, r1
c0d00f20:	462b      	mov	r3, r5
c0d00f22:	f002 f84f 	bl	c0d02fc4 <cx_ecfp_init_public_key>
    cx_ecfp_generate_pair(CX_CURVE_256K1, publicKey, privateKey, 1);
c0d00f26:	2301      	movs	r3, #1
c0d00f28:	4630      	mov	r0, r6
c0d00f2a:	4629      	mov	r1, r5
c0d00f2c:	4622      	mov	r2, r4
c0d00f2e:	f002 f879 	bl	c0d03024 <cx_ecfp_generate_pair>
}
c0d00f32:	bd70      	pop	{r4, r5, r6, pc}

c0d00f34 <sign_secp256k1>:
int sign_secp256k1(const uint8_t *message,
                   unsigned int message_length,
                   uint8_t *signature,
                   unsigned int signature_capacity,
                   unsigned int *signature_length,
                   cx_ecfp_private_key_t *privateKey) {
c0d00f34:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00f36:	b0a5      	sub	sp, #148	; 0x94
c0d00f38:	9307      	str	r3, [sp, #28]
c0d00f3a:	9206      	str	r2, [sp, #24]
c0d00f3c:	9d2b      	ldr	r5, [sp, #172]	; 0xac
c0d00f3e:	9524      	str	r5, [sp, #144]	; 0x90
c0d00f40:	aa1c      	add	r2, sp, #112	; 0x70
    uint8_t message_digest[CX_SHA256_SIZE];
    cx_hash_sha256(message, message_length, message_digest, CX_SHA256_SIZE);
c0d00f42:	9205      	str	r2, [sp, #20]
c0d00f44:	2320      	movs	r3, #32
c0d00f46:	9304      	str	r3, [sp, #16]
c0d00f48:	f002 f824 	bl	c0d02f94 <cx_hash_sha256>
c0d00f4c:	2421      	movs	r4, #33	; 0x21
c0d00f4e:	2700      	movs	r7, #0
c0d00f50:	ae09      	add	r6, sp, #36	; 0x24

    cx_ecfp_public_key_t publicKey;
    cx_ecdsa_init_public_key(CX_CURVE_256K1, NULL, 0, &publicKey);
c0d00f52:	4620      	mov	r0, r4
c0d00f54:	4639      	mov	r1, r7
c0d00f56:	463a      	mov	r2, r7
c0d00f58:	4633      	mov	r3, r6
c0d00f5a:	f002 f833 	bl	c0d02fc4 <cx_ecfp_init_public_key>
    cx_ecfp_generate_pair(CX_CURVE_256K1, &publicKey, privateKey, 1);
c0d00f5e:	2301      	movs	r3, #1
c0d00f60:	4620      	mov	r0, r4
c0d00f62:	4631      	mov	r1, r6
c0d00f64:	462a      	mov	r2, r5
c0d00f66:	461c      	mov	r4, r3
c0d00f68:	f002 f85c 	bl	c0d03024 <cx_ecfp_generate_pair>

    unsigned int info = 0;
c0d00f6c:	9708      	str	r7, [sp, #32]
c0d00f6e:	a808      	add	r0, sp, #32
    *signature_length = cx_ecdsa_sign(
c0d00f70:	4669      	mov	r1, sp
c0d00f72:	9a04      	ldr	r2, [sp, #16]
c0d00f74:	600a      	str	r2, [r1, #0]
c0d00f76:	9a06      	ldr	r2, [sp, #24]
c0d00f78:	604a      	str	r2, [r1, #4]
c0d00f7a:	9a07      	ldr	r2, [sp, #28]
c0d00f7c:	608a      	str	r2, [r1, #8]
c0d00f7e:	60c8      	str	r0, [r1, #12]
c0d00f80:	4907      	ldr	r1, [pc, #28]	; (c0d00fa0 <sign_secp256k1+0x6c>)
c0d00f82:	2203      	movs	r2, #3
c0d00f84:	4628      	mov	r0, r5
c0d00f86:	9b05      	ldr	r3, [sp, #20]
c0d00f88:	f002 f864 	bl	c0d03054 <cx_ecdsa_sign>
c0d00f8c:	992a      	ldr	r1, [sp, #168]	; 0xa8
c0d00f8e:	6008      	str	r0, [r1, #0]
c0d00f90:	a824      	add	r0, sp, #144	; 0x90
c0d00f92:	2204      	movs	r2, #4
            CX_SHA256_SIZE,
            signature,
            signature_capacity,
            &info);

    os_memset(&privateKey, 0, sizeof(privateKey));
c0d00f94:	4639      	mov	r1, r7
c0d00f96:	f000 fcd1 	bl	c0d0193c <os_memset>
            message_digest,
            CX_SHA256_SIZE,
            signature,
            *signature_length);
#else
    return 1;
c0d00f9a:	4620      	mov	r0, r4
c0d00f9c:	b025      	add	sp, #148	; 0x94
c0d00f9e:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00fa0:	00000601 	.word	0x00000601

c0d00fa4 <getPubKey>:
#endif
}

void getPubKey(cx_ecfp_public_key_t *publicKey) {
c0d00fa4:	b5b0      	push	{r4, r5, r7, lr}
c0d00fa6:	b094      	sub	sp, #80	; 0x50
c0d00fa8:	4604      	mov	r4, r0
    uint8_t privateKeyData[32];

    // Generate keys
    os_perso_derive_node_bip32(CX_CURVE_256K1,
                               bip32_path,
                               bip32_depth,
c0d00faa:	4809      	ldr	r0, [pc, #36]	; (c0d00fd0 <getPubKey+0x2c>)
c0d00fac:	7802      	ldrb	r2, [r0, #0]
c0d00fae:	2000      	movs	r0, #0
void getPubKey(cx_ecfp_public_key_t *publicKey) {
    cx_ecfp_private_key_t privateKey;
    uint8_t privateKeyData[32];

    // Generate keys
    os_perso_derive_node_bip32(CX_CURVE_256K1,
c0d00fb0:	4669      	mov	r1, sp
c0d00fb2:	6008      	str	r0, [r1, #0]
c0d00fb4:	2021      	movs	r0, #33	; 0x21
c0d00fb6:	4907      	ldr	r1, [pc, #28]	; (c0d00fd4 <getPubKey+0x30>)
c0d00fb8:	ad02      	add	r5, sp, #8
c0d00fba:	462b      	mov	r3, r5
c0d00fbc:	f002 f882 	bl	c0d030c4 <os_perso_derive_node_bip32>
c0d00fc0:	a90a      	add	r1, sp, #40	; 0x28
                               bip32_path,
                               bip32_depth,
                               privateKeyData, NULL);

    keys_secp256k1(publicKey, &privateKey, privateKeyData);
c0d00fc2:	4620      	mov	r0, r4
c0d00fc4:	462a      	mov	r2, r5
c0d00fc6:	f7ff ff9d 	bl	c0d00f04 <keys_secp256k1>
    memset(privateKeyData, 0, sizeof(privateKeyData));
    memset(&privateKey, 0, sizeof(privateKey));
}
c0d00fca:	b014      	add	sp, #80	; 0x50
c0d00fcc:	bdb0      	pop	{r4, r5, r7, pc}
c0d00fce:	46c0      	nop			; (mov r8, r8)
c0d00fd0:	200018c0 	.word	0x200018c0
c0d00fd4:	20001898 	.word	0x20001898

c0d00fd8 <get_pk_compressed>:
    cx_ripemd160_t rip160;
    cx_ripemd160_init(&rip160);
    cx_hash(&rip160.header, CX_LAST, in, CX_SHA256_SIZE, out, CX_RIPEMD160_SIZE);
}

void get_pk_compressed(uint8_t *pkc) {
c0d00fd8:	b5b0      	push	{r4, r5, r7, lr}
c0d00fda:	b094      	sub	sp, #80	; 0x50
c0d00fdc:	4604      	mov	r4, r0
c0d00fde:	ad01      	add	r5, sp, #4
    cx_ecfp_public_key_t publicKey;
    // Modify the last part of the path
    getPubKey(&publicKey);
c0d00fe0:	4628      	mov	r0, r5
c0d00fe2:	f7ff ffdf 	bl	c0d00fa4 <getPubKey>
    // "Compress" public key in place
    publicKey.W[0] = publicKey.W[64] & 1 ? 0x03 : 0x02;
c0d00fe6:	2048      	movs	r0, #72	; 0x48
c0d00fe8:	5c28      	ldrb	r0, [r5, r0]
c0d00fea:	2101      	movs	r1, #1
c0d00fec:	4001      	ands	r1, r0
c0d00fee:	2002      	movs	r0, #2
c0d00ff0:	4308      	orrs	r0, r1
c0d00ff2:	7228      	strb	r0, [r5, #8]
c0d00ff4:	3508      	adds	r5, #8
    memcpy(pkc, publicKey.W, PK_COMPRESSED_LEN);
c0d00ff6:	2221      	movs	r2, #33	; 0x21
c0d00ff8:	4620      	mov	r0, r4
c0d00ffa:	4629      	mov	r1, r5
c0d00ffc:	f005 f952 	bl	c0d062a4 <__aeabi_memcpy>
}
c0d01000:	b014      	add	sp, #80	; 0x50
c0d01002:	bdb0      	pop	{r4, r5, r7, pc}

c0d01004 <get_bech32_addr>:

void get_bech32_addr(char *bech32_addr) {
c0d01004:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01006:	b0ab      	sub	sp, #172	; 0xac
c0d01008:	9004      	str	r0, [sp, #16]
c0d0100a:	af13      	add	r7, sp, #76	; 0x4c
}

void get_pk_compressed(uint8_t *pkc) {
    cx_ecfp_public_key_t publicKey;
    // Modify the last part of the path
    getPubKey(&publicKey);
c0d0100c:	4638      	mov	r0, r7
c0d0100e:	f7ff ffc9 	bl	c0d00fa4 <getPubKey>
    // "Compress" public key in place
    publicKey.W[0] = publicKey.W[64] & 1 ? 0x03 : 0x02;
c0d01012:	2048      	movs	r0, #72	; 0x48
c0d01014:	5c38      	ldrb	r0, [r7, r0]
c0d01016:	2101      	movs	r1, #1
c0d01018:	9103      	str	r1, [sp, #12]
c0d0101a:	4008      	ands	r0, r1
c0d0101c:	2102      	movs	r1, #2
c0d0101e:	4301      	orrs	r1, r0
c0d01020:	7239      	strb	r1, [r7, #8]
c0d01022:	3708      	adds	r7, #8
c0d01024:	ae0a      	add	r6, sp, #40	; 0x28
    memcpy(pkc, publicKey.W, PK_COMPRESSED_LEN);
c0d01026:	4630      	mov	r0, r6
c0d01028:	cf1e      	ldmia	r7!, {r1, r2, r3, r4}
c0d0102a:	c01e      	stmia	r0!, {r1, r2, r3, r4}
c0d0102c:	cf1e      	ldmia	r7!, {r1, r2, r3, r4}
c0d0102e:	c01e      	stmia	r0!, {r1, r2, r3, r4}
c0d01030:	7839      	ldrb	r1, [r7, #0]
c0d01032:	7001      	strb	r1, [r0, #0]
c0d01034:	2121      	movs	r1, #33	; 0x21
void get_bech32_addr(char *bech32_addr) {
    uint8_t tmp[PK_COMPRESSED_LEN];
    get_pk_compressed(tmp);

    uint8_t hashed_pk[CX_RIPEMD160_SIZE];
    cx_hash_sha256(tmp, PK_COMPRESSED_LEN, tmp, CX_SHA256_SIZE);
c0d01036:	2320      	movs	r3, #32
c0d01038:	9302      	str	r3, [sp, #8]
c0d0103a:	4630      	mov	r0, r6
c0d0103c:	4632      	mov	r2, r6
c0d0103e:	f001 ffa9 	bl	c0d02f94 <cx_hash_sha256>
c0d01042:	ac13      	add	r4, sp, #76	; 0x4c
    memset(&privateKey, 0, sizeof(privateKey));
}

void ripemd160_32(uint8_t *out, uint8_t *in) {
    cx_ripemd160_t rip160;
    cx_ripemd160_init(&rip160);
c0d01044:	4620      	mov	r0, r4
c0d01046:	f001 ff8f 	bl	c0d02f68 <cx_ripemd160_init>
    cx_hash(&rip160.header, CX_LAST, in, CX_SHA256_SIZE, out, CX_RIPEMD160_SIZE);
c0d0104a:	2514      	movs	r5, #20
c0d0104c:	4668      	mov	r0, sp
c0d0104e:	6045      	str	r5, [r0, #4]
c0d01050:	af05      	add	r7, sp, #20
c0d01052:	6007      	str	r7, [r0, #0]
c0d01054:	4620      	mov	r0, r4
c0d01056:	9903      	ldr	r1, [sp, #12]
c0d01058:	4632      	mov	r2, r6
c0d0105a:	9b02      	ldr	r3, [sp, #8]
c0d0105c:	f001 ff68 	bl	c0d02f30 <cx_hash>

    uint8_t hashed_pk[CX_RIPEMD160_SIZE];
    cx_hash_sha256(tmp, PK_COMPRESSED_LEN, tmp, CX_SHA256_SIZE);
    ripemd160_32(hashed_pk, tmp);

    bech32EncodeFromBytes(bech32_addr, bech32_hrp, hashed_pk, CX_RIPEMD160_SIZE);
c0d01060:	4903      	ldr	r1, [pc, #12]	; (c0d01070 <get_bech32_addr+0x6c>)
c0d01062:	9804      	ldr	r0, [sp, #16]
c0d01064:	463a      	mov	r2, r7
c0d01066:	462b      	mov	r3, r5
c0d01068:	f7ff febc 	bl	c0d00de4 <bech32EncodeFromBytes>
}
c0d0106c:	b02b      	add	sp, #172	; 0xac
c0d0106e:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01070:	200018c1 	.word	0x200018c1

c0d01074 <jsmn_parse>:

/**
 * Parse JSON string and fill tokens.
 */
int jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
		jsmntok_t *tokens, unsigned int num_tokens) {
c0d01074:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01076:	b08f      	sub	sp, #60	; 0x3c
c0d01078:	4614      	mov	r4, r2
c0d0107a:	910d      	str	r1, [sp, #52]	; 0x34
    short int r;
	short int i;
	jsmntok_t *token;
	short int count = parser->toknext;

	for (; parser->pos < len && js[parser->pos] != '\0'; parser->pos++) {
c0d0107c:	8807      	ldrh	r7, [r0, #0]
int jsmn_parse(jsmn_parser *parser, const char *js, size_t len,
		jsmntok_t *tokens, unsigned int num_tokens) {
    short int r;
	short int i;
	jsmntok_t *token;
	short int count = parser->toknext;
c0d0107e:	8841      	ldrh	r1, [r0, #2]
#endif
		}
	}

	if (tokens != NULL) {
		for (i = parser->toknext - 1; i >= 0; i--) {
c0d01080:	2200      	movs	r2, #0
c0d01082:	9204      	str	r2, [sp, #16]
c0d01084:	43d6      	mvns	r6, r2
c0d01086:	2202      	movs	r2, #2
c0d01088:	9203      	str	r2, [sp, #12]
c0d0108a:	43d5      	mvns	r5, r2
c0d0108c:	4af0      	ldr	r2, [pc, #960]	; (c0d01450 <jsmn_parse+0x3dc>)
    short int r;
	short int i;
	jsmntok_t *token;
	short int count = parser->toknext;

	for (; parser->pos < len && js[parser->pos] != '\0'; parser->pos++) {
c0d0108e:	9205      	str	r2, [sp, #20]
c0d01090:	940e      	str	r4, [sp, #56]	; 0x38
c0d01092:	42a7      	cmp	r7, r4
c0d01094:	930a      	str	r3, [sp, #40]	; 0x28
c0d01096:	9107      	str	r1, [sp, #28]
c0d01098:	d209      	bcs.n	c0d010ae <jsmn_parse+0x3a>
c0d0109a:	9a14      	ldr	r2, [sp, #80]	; 0x50
c0d0109c:	9202      	str	r2, [sp, #8]
c0d0109e:	1c9a      	adds	r2, r3, #2
#ifdef JSMN_PARENT_LINKS
					token->parent = parser->toksuper;
#endif
				}
				token->type = (c == '{' ? JSMN_OBJECT : JSMN_ARRAY);
				token->start = parser->pos;
c0d010a0:	9200      	str	r2, [sp, #0]
c0d010a2:	970b      	str	r7, [sp, #44]	; 0x2c
c0d010a4:	9106      	str	r1, [sp, #24]
c0d010a6:	9508      	str	r5, [sp, #32]
c0d010a8:	9609      	str	r6, [sp, #36]	; 0x24
c0d010aa:	900c      	str	r0, [sp, #48]	; 0x30
c0d010ac:	e0ea      	b.n	c0d01284 <jsmn_parse+0x210>
c0d010ae:	9106      	str	r1, [sp, #24]
c0d010b0:	9a0a      	ldr	r2, [sp, #40]	; 0x28
				return JSMN_ERROR_INVAL;
#endif
		}
	}

	if (tokens != NULL) {
c0d010b2:	2a00      	cmp	r2, #0
c0d010b4:	d019      	beq.n	c0d010ea <jsmn_parse+0x76>
		for (i = parser->toknext - 1; i >= 0; i--) {
c0d010b6:	9807      	ldr	r0, [sp, #28]
c0d010b8:	b280      	uxth	r0, r0
c0d010ba:	9905      	ldr	r1, [sp, #20]
c0d010bc:	1841      	adds	r1, r0, r1
c0d010be:	b208      	sxth	r0, r1
c0d010c0:	42b0      	cmp	r0, r6
c0d010c2:	dd12      	ble.n	c0d010ea <jsmn_parse+0x76>
c0d010c4:	0408      	lsls	r0, r1, #16
c0d010c6:	1340      	asrs	r0, r0, #13
c0d010c8:	1810      	adds	r0, r2, r0
c0d010ca:	1c80      	adds	r0, r0, #2
			/* Unmatched opened object or array */
			if (tokens[i].start != -1 && tokens[i].end == -1) {
c0d010cc:	b2b2      	uxth	r2, r6
c0d010ce:	8803      	ldrh	r3, [r0, #0]
c0d010d0:	4293      	cmp	r3, r2
c0d010d2:	d003      	beq.n	c0d010dc <jsmn_parse+0x68>
c0d010d4:	8843      	ldrh	r3, [r0, #2]
c0d010d6:	4293      	cmp	r3, r2
c0d010d8:	d100      	bne.n	c0d010dc <jsmn_parse+0x68>
c0d010da:	e201      	b.n	c0d014e0 <jsmn_parse+0x46c>
#endif
		}
	}

	if (tokens != NULL) {
		for (i = parser->toknext - 1; i >= 0; i--) {
c0d010dc:	00ea      	lsls	r2, r5, #3
c0d010de:	1880      	adds	r0, r0, r2
c0d010e0:	3010      	adds	r0, #16
c0d010e2:	1e49      	subs	r1, r1, #1
c0d010e4:	b209      	sxth	r1, r1
c0d010e6:	42b1      	cmp	r1, r6
c0d010e8:	dcf0      	bgt.n	c0d010cc <jsmn_parse+0x58>
				return JSMN_ERROR_PART;
			}
		}
	}

	return count;
c0d010ea:	9806      	ldr	r0, [sp, #24]
c0d010ec:	b204      	sxth	r4, r0
c0d010ee:	e1f4      	b.n	c0d014da <jsmn_parse+0x466>
c0d010f0:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d010f2:	e001      	b.n	c0d010f8 <jsmn_parse+0x84>
c0d010f4:	9b0d      	ldr	r3, [sp, #52]	; 0x34
c0d010f6:	5c9b      	ldrb	r3, [r3, r2]
c0d010f8:	b2df      	uxtb	r7, r3
	jsmntok_t *token;
	short int start;

	start = parser->pos;

	for (; parser->pos < len && js[parser->pos] != '\0'; parser->pos++) {
c0d010fa:	2f1f      	cmp	r7, #31
c0d010fc:	dd0e      	ble.n	c0d0111c <jsmn_parse+0xa8>
c0d010fe:	463a      	mov	r2, r7
c0d01100:	3a20      	subs	r2, #32
c0d01102:	2a1a      	cmp	r2, #26
c0d01104:	d805      	bhi.n	c0d01112 <jsmn_parse+0x9e>
c0d01106:	2401      	movs	r4, #1
c0d01108:	4094      	lsls	r4, r2
c0d0110a:	4afa      	ldr	r2, [pc, #1000]	; (c0d014f4 <jsmn_parse+0x480>)
c0d0110c:	4214      	tst	r4, r2
c0d0110e:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d01110:	d116      	bne.n	c0d01140 <jsmn_parse+0xcc>
c0d01112:	2f5d      	cmp	r7, #93	; 0x5d
c0d01114:	d014      	beq.n	c0d01140 <jsmn_parse+0xcc>
c0d01116:	2f7d      	cmp	r7, #125	; 0x7d
c0d01118:	d107      	bne.n	c0d0112a <jsmn_parse+0xb6>
c0d0111a:	e011      	b.n	c0d01140 <jsmn_parse+0xcc>
c0d0111c:	2f0d      	cmp	r7, #13
c0d0111e:	d804      	bhi.n	c0d0112a <jsmn_parse+0xb6>
c0d01120:	2201      	movs	r2, #1
c0d01122:	40ba      	lsls	r2, r7
c0d01124:	4cf2      	ldr	r4, [pc, #968]	; (c0d014f0 <jsmn_parse+0x47c>)
c0d01126:	4222      	tst	r2, r4
c0d01128:	d10a      	bne.n	c0d01140 <jsmn_parse+0xcc>
#endif
			case '\t' : case '\r' : case '\n' : case ' ' :
			case ','  : case ']'  : case '}' :
				goto found;
		}
		if (js[parser->pos] < 32 || js[parser->pos] >= 127) {
c0d0112a:	3b20      	subs	r3, #32
c0d0112c:	b2da      	uxtb	r2, r3
c0d0112e:	2a5e      	cmp	r2, #94	; 0x5e
c0d01130:	d900      	bls.n	c0d01134 <jsmn_parse+0xc0>
c0d01132:	e1ce      	b.n	c0d014d2 <jsmn_parse+0x45e>
	jsmntok_t *token;
	short int start;

	start = parser->pos;

	for (; parser->pos < len && js[parser->pos] != '\0'; parser->pos++) {
c0d01134:	1c49      	adds	r1, r1, #1
c0d01136:	8001      	strh	r1, [r0, #0]
c0d01138:	b28a      	uxth	r2, r1
c0d0113a:	9b0e      	ldr	r3, [sp, #56]	; 0x38
c0d0113c:	429a      	cmp	r2, r3
c0d0113e:	d3d9      	bcc.n	c0d010f4 <jsmn_parse+0x80>
c0d01140:	9b0a      	ldr	r3, [sp, #40]	; 0x28
	parser->pos = start;
	return JSMN_ERROR_PART;
#endif

found:
	if (tokens == NULL) {
c0d01142:	2b00      	cmp	r3, #0
c0d01144:	d01f      	beq.n	c0d01186 <jsmn_parse+0x112>
c0d01146:	9f07      	ldr	r7, [sp, #28]
 * Allocates a fresh unused token from the token pull.
 */
static jsmntok_t *jsmn_alloc_token(jsmn_parser *parser,
		jsmntok_t *tokens, size_t num_tokens) {
	jsmntok_t *tok;
	if (parser->toknext >= num_tokens) {
c0d01148:	b2b8      	uxth	r0, r7
c0d0114a:	9a02      	ldr	r2, [sp, #8]
c0d0114c:	4290      	cmp	r0, r2
c0d0114e:	d300      	bcc.n	c0d01152 <jsmn_parse+0xde>
c0d01150:	e1c8      	b.n	c0d014e4 <jsmn_parse+0x470>
		return NULL;
	}
	tok = &tokens[parser->toknext++];
c0d01152:	1c7f      	adds	r7, r7, #1
c0d01154:	9a0c      	ldr	r2, [sp, #48]	; 0x30
c0d01156:	8057      	strh	r7, [r2, #2]
c0d01158:	00c0      	lsls	r0, r0, #3
c0d0115a:	9a0a      	ldr	r2, [sp, #40]	; 0x28
c0d0115c:	1810      	adds	r0, r2, r0
	tok->start = tok->end = -1;
c0d0115e:	8086      	strh	r6, [r0, #4]
c0d01160:	8046      	strh	r6, [r0, #2]
	tok->size = 0;
c0d01162:	9a04      	ldr	r2, [sp, #16]
c0d01164:	80c2      	strh	r2, [r0, #6]
c0d01166:	1d82      	adds	r2, r0, #6
	jsmntok_t *tok;
	if (parser->toknext >= num_tokens) {
		return NULL;
	}
	tok = &tokens[parser->toknext++];
	tok->start = tok->end = -1;
c0d01168:	1c84      	adds	r4, r0, #2
c0d0116a:	1d03      	adds	r3, r0, #4
	if (tokens == NULL) {
		parser->pos--;
		return 0;
	}
	token = jsmn_alloc_token(parser, tokens, num_tokens);
	if (token == NULL) {
c0d0116c:	2800      	cmp	r0, #0
c0d0116e:	d100      	bne.n	c0d01172 <jsmn_parse+0xfe>
c0d01170:	e1b8      	b.n	c0d014e4 <jsmn_parse+0x470>
c0d01172:	9707      	str	r7, [sp, #28]
/**
 * Fills token type and boundaries.
 */
static void jsmn_fill_token(jsmntok_t *token, jsmntype_t type,
                            short int start, short int end) {
	token->type = type;
c0d01174:	2504      	movs	r5, #4
c0d01176:	7005      	strb	r5, [r0, #0]
	token->start = start;
c0d01178:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d0117a:	8020      	strh	r0, [r4, #0]
	token->end = end;
c0d0117c:	8019      	strh	r1, [r3, #0]
	token->size = 0;
c0d0117e:	9804      	ldr	r0, [sp, #16]
c0d01180:	8010      	strh	r0, [r2, #0]
c0d01182:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d01184:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d01186:	1e49      	subs	r1, r1, #1
c0d01188:	910b      	str	r1, [sp, #44]	; 0x2c
c0d0118a:	8001      	strh	r1, [r0, #0]
c0d0118c:	9a06      	ldr	r2, [sp, #24]
			/* In non-strict mode every unquoted value is a primitive */
			default:
#endif
				r = jsmn_parse_primitive(parser, js, len, tokens, num_tokens);
				if (r < 0) return r;
				count++;
c0d0118e:	1c52      	adds	r2, r2, #1
				if (parser->toksuper != -1 && tokens != NULL)
c0d01190:	2b00      	cmp	r3, #0
c0d01192:	9206      	str	r2, [sp, #24]
c0d01194:	d009      	beq.n	c0d011aa <jsmn_parse+0x136>
c0d01196:	8880      	ldrh	r0, [r0, #4]
c0d01198:	b2b1      	uxth	r1, r6
c0d0119a:	4288      	cmp	r0, r1
c0d0119c:	d005      	beq.n	c0d011aa <jsmn_parse+0x136>
c0d0119e:	b200      	sxth	r0, r0
					tokens[parser->toksuper].size++;
c0d011a0:	00c0      	lsls	r0, r0, #3
c0d011a2:	1818      	adds	r0, r3, r0
c0d011a4:	88c1      	ldrh	r1, [r0, #6]
c0d011a6:	1c49      	adds	r1, r1, #1
c0d011a8:	80c1      	strh	r1, [r0, #6]
c0d011aa:	9d08      	ldr	r5, [sp, #32]
c0d011ac:	e05a      	b.n	c0d01264 <jsmn_parse+0x1f0>
				}
#else
				for (i = parser->toknext - 1; i >= 0; i--) {
					token = &tokens[i];
					if (token->start != -1 && token->end == -1) {
						if (token->type != type) {
c0d011ae:	2201      	movs	r2, #1
c0d011b0:	2b7d      	cmp	r3, #125	; 0x7d
c0d011b2:	d000      	beq.n	c0d011b6 <jsmn_parse+0x142>
c0d011b4:	9a03      	ldr	r2, [sp, #12]
c0d011b6:	00fb      	lsls	r3, r7, #3
c0d011b8:	9c0a      	ldr	r4, [sp, #40]	; 0x28
c0d011ba:	5ce3      	ldrb	r3, [r4, r3]
c0d011bc:	9d08      	ldr	r5, [sp, #32]
c0d011be:	1c6c      	adds	r4, r5, #1
c0d011c0:	4293      	cmp	r3, r2
c0d011c2:	d000      	beq.n	c0d011c6 <jsmn_parse+0x152>
c0d011c4:	e189      	b.n	c0d014da <jsmn_parse+0x466>
c0d011c6:	9b09      	ldr	r3, [sp, #36]	; 0x24
c0d011c8:	9c0c      	ldr	r4, [sp, #48]	; 0x30
							return JSMN_ERROR_INVAL;
						}
						parser->toksuper = -1;
c0d011ca:	80a3      	strh	r3, [r4, #4]
						token->end = parser->pos + 1;
c0d011cc:	9a0b      	ldr	r2, [sp, #44]	; 0x2c
c0d011ce:	1c52      	adds	r2, r2, #1
c0d011d0:	8082      	strh	r2, [r0, #4]
				}
#else
				for (i = parser->toknext - 1; i >= 0; i--) {
					token = &tokens[i];
					if (token->start != -1 && token->end == -1) {
						if (token->type != type) {
c0d011d2:	b238      	sxth	r0, r7
						break;
					}
				}
				/* Error if unmatched closing bracket */
				if (i == -1) return JSMN_ERROR_INVAL;
				for (; i >= 0; i--) {
c0d011d4:	4298      	cmp	r0, r3
c0d011d6:	dd45      	ble.n	c0d01264 <jsmn_parse+0x1f0>
					token = &tokens[i];
					if (token->start != -1 && token->end == -1) {
c0d011d8:	8808      	ldrh	r0, [r1, #0]
c0d011da:	42b0      	cmp	r0, r6
c0d011dc:	d002      	beq.n	c0d011e4 <jsmn_parse+0x170>
c0d011de:	8848      	ldrh	r0, [r1, #2]
c0d011e0:	42b0      	cmp	r0, r6
c0d011e2:	d04a      	beq.n	c0d0127a <jsmn_parse+0x206>
						break;
					}
				}
				/* Error if unmatched closing bracket */
				if (i == -1) return JSMN_ERROR_INVAL;
				for (; i >= 0; i--) {
c0d011e4:	00e8      	lsls	r0, r5, #3
c0d011e6:	1809      	adds	r1, r1, r0
c0d011e8:	3110      	adds	r1, #16
c0d011ea:	1e78      	subs	r0, r7, #1
c0d011ec:	2f00      	cmp	r7, #0
c0d011ee:	4607      	mov	r7, r0
c0d011f0:	dcf2      	bgt.n	c0d011d8 <jsmn_parse+0x164>
c0d011f2:	e037      	b.n	c0d01264 <jsmn_parse+0x1f0>
	for (; parser->pos < len && js[parser->pos] != '\0'; parser->pos++) {
		char c = js[parser->pos];

		/* Quote: end of string */
		if (c == '\"') {
			if (tokens == NULL) {
c0d011f4:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d011f6:	2800      	cmp	r0, #0
c0d011f8:	d030      	beq.n	c0d0125c <jsmn_parse+0x1e8>
c0d011fa:	1cac      	adds	r4, r5, #2
c0d011fc:	9a07      	ldr	r2, [sp, #28]
 * Allocates a fresh unused token from the token pull.
 */
static jsmntok_t *jsmn_alloc_token(jsmn_parser *parser,
		jsmntok_t *tokens, size_t num_tokens) {
	jsmntok_t *tok;
	if (parser->toknext >= num_tokens) {
c0d011fe:	b290      	uxth	r0, r2
c0d01200:	9902      	ldr	r1, [sp, #8]
c0d01202:	4288      	cmp	r0, r1
c0d01204:	d300      	bcc.n	c0d01208 <jsmn_parse+0x194>
c0d01206:	e165      	b.n	c0d014d4 <jsmn_parse+0x460>
		return NULL;
	}
	tok = &tokens[parser->toknext++];
c0d01208:	1c52      	adds	r2, r2, #1
c0d0120a:	990c      	ldr	r1, [sp, #48]	; 0x30
c0d0120c:	9207      	str	r2, [sp, #28]
c0d0120e:	804a      	strh	r2, [r1, #2]
c0d01210:	00c0      	lsls	r0, r0, #3
c0d01212:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d01214:	1808      	adds	r0, r1, r0
c0d01216:	9909      	ldr	r1, [sp, #36]	; 0x24
	tok->start = tok->end = -1;
c0d01218:	8081      	strh	r1, [r0, #4]
c0d0121a:	8041      	strh	r1, [r0, #2]
	tok->size = 0;
c0d0121c:	9904      	ldr	r1, [sp, #16]
c0d0121e:	80c1      	strh	r1, [r0, #6]
c0d01220:	1d81      	adds	r1, r0, #6
	jsmntok_t *tok;
	if (parser->toknext >= num_tokens) {
		return NULL;
	}
	tok = &tokens[parser->toknext++];
	tok->start = tok->end = -1;
c0d01222:	1c86      	adds	r6, r0, #2
c0d01224:	1d02      	adds	r2, r0, #4
		if (c == '\"') {
			if (tokens == NULL) {
				return 0;
			}
			token = jsmn_alloc_token(parser, tokens, num_tokens);
			if (token == NULL) {
c0d01226:	2800      	cmp	r0, #0
c0d01228:	d100      	bne.n	c0d0122c <jsmn_parse+0x1b8>
c0d0122a:	e153      	b.n	c0d014d4 <jsmn_parse+0x460>
/**
 * Fills token type and boundaries.
 */
static void jsmn_fill_token(jsmntok_t *token, jsmntype_t type,
                            short int start, short int end) {
	token->type = type;
c0d0122c:	2403      	movs	r4, #3
c0d0122e:	7004      	strb	r4, [r0, #0]
			token = jsmn_alloc_token(parser, tokens, num_tokens);
			if (token == NULL) {
				parser->pos = start;
				return JSMN_ERROR_NOMEM;
			}
			jsmn_fill_token(token, JSMN_STRING, start+1, parser->pos);
c0d01230:	1c78      	adds	r0, r7, #1
 * Fills token type and boundaries.
 */
static void jsmn_fill_token(jsmntok_t *token, jsmntype_t type,
                            short int start, short int end) {
	token->type = type;
	token->start = start;
c0d01232:	8030      	strh	r0, [r6, #0]
	token->end = end;
c0d01234:	8013      	strh	r3, [r2, #0]
	token->size = 0;
c0d01236:	9804      	ldr	r0, [sp, #16]
c0d01238:	8008      	strh	r0, [r1, #0]
#endif
				break;
			case '\"':
				r = jsmn_parse_string(parser, js, len, tokens, num_tokens);
				if (r < 0) return r;
				count++;
c0d0123a:	9806      	ldr	r0, [sp, #24]
c0d0123c:	1c40      	adds	r0, r0, #1
				if (parser->toksuper != -1 && tokens != NULL)
c0d0123e:	9006      	str	r0, [sp, #24]
c0d01240:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d01242:	8880      	ldrh	r0, [r0, #4]
c0d01244:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d01246:	b289      	uxth	r1, r1
c0d01248:	4288      	cmp	r0, r1
c0d0124a:	d00a      	beq.n	c0d01262 <jsmn_parse+0x1ee>
c0d0124c:	b200      	sxth	r0, r0
					tokens[parser->toksuper].size++;
c0d0124e:	00c0      	lsls	r0, r0, #3
c0d01250:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d01252:	1808      	adds	r0, r1, r0
c0d01254:	88c1      	ldrh	r1, [r0, #6]
c0d01256:	1c49      	adds	r1, r1, #1
c0d01258:	80c1      	strh	r1, [r0, #6]
c0d0125a:	e002      	b.n	c0d01262 <jsmn_parse+0x1ee>
#endif
				break;
			case '\"':
				r = jsmn_parse_string(parser, js, len, tokens, num_tokens);
				if (r < 0) return r;
				count++;
c0d0125c:	9806      	ldr	r0, [sp, #24]
c0d0125e:	1c40      	adds	r0, r0, #1
    short int r;
	short int i;
	jsmntok_t *token;
	short int count = parser->toknext;

	for (; parser->pos < len && js[parser->pos] != '\0'; parser->pos++) {
c0d01260:	9006      	str	r0, [sp, #24]
c0d01262:	930b      	str	r3, [sp, #44]	; 0x2c
c0d01264:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d01266:	1c49      	adds	r1, r1, #1
c0d01268:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d0126a:	8001      	strh	r1, [r0, #0]
c0d0126c:	910b      	str	r1, [sp, #44]	; 0x2c
c0d0126e:	b28f      	uxth	r7, r1
c0d01270:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d01272:	428f      	cmp	r7, r1
c0d01274:	9e09      	ldr	r6, [sp, #36]	; 0x24
c0d01276:	d305      	bcc.n	c0d01284 <jsmn_parse+0x210>
c0d01278:	e71a      	b.n	c0d010b0 <jsmn_parse+0x3c>
				/* Error if unmatched closing bracket */
				if (i == -1) return JSMN_ERROR_INVAL;
				for (; i >= 0; i--) {
					token = &tokens[i];
					if (token->start != -1 && token->end == -1) {
						parser->toksuper = i;
c0d0127a:	80a7      	strh	r7, [r4, #4]
c0d0127c:	e7f2      	b.n	c0d01264 <jsmn_parse+0x1f0>
					parser->toksuper = tokens[parser->toksuper].parent;
#else
					for (i = parser->toknext - 1; i >= 0; i--) {
						if (tokens[i].type == JSMN_ARRAY || tokens[i].type == JSMN_OBJECT) {
							if (tokens[i].start != -1 && tokens[i].end == -1) {
								parser->toksuper = i;
c0d0127e:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d01280:	8083      	strh	r3, [r0, #4]
c0d01282:	e7ef      	b.n	c0d01264 <jsmn_parse+0x1f0>
    short int r;
	short int i;
	jsmntok_t *token;
	short int count = parser->toknext;

	for (; parser->pos < len && js[parser->pos] != '\0'; parser->pos++) {
c0d01284:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d01286:	5dcb      	ldrb	r3, [r1, r7]
c0d01288:	2b2b      	cmp	r3, #43	; 0x2b
c0d0128a:	dd0b      	ble.n	c0d012a4 <jsmn_parse+0x230>
c0d0128c:	2b5c      	cmp	r3, #92	; 0x5c
c0d0128e:	dc78      	bgt.n	c0d01382 <jsmn_parse+0x30e>
c0d01290:	2b2c      	cmp	r3, #44	; 0x2c
c0d01292:	d100      	bne.n	c0d01296 <jsmn_parse+0x222>
c0d01294:	e0de      	b.n	c0d01454 <jsmn_parse+0x3e0>
c0d01296:	2b3a      	cmp	r3, #58	; 0x3a
c0d01298:	d100      	bne.n	c0d0129c <jsmn_parse+0x228>
c0d0129a:	e10e      	b.n	c0d014ba <jsmn_parse+0x446>
c0d0129c:	2b5b      	cmp	r3, #91	; 0x5b
c0d0129e:	d100      	bne.n	c0d012a2 <jsmn_parse+0x22e>
c0d012a0:	e0a0      	b.n	c0d013e4 <jsmn_parse+0x370>
c0d012a2:	e725      	b.n	c0d010f0 <jsmn_parse+0x7c>
c0d012a4:	4619      	mov	r1, r3
c0d012a6:	3909      	subs	r1, #9
c0d012a8:	2919      	cmp	r1, #25
c0d012aa:	d900      	bls.n	c0d012ae <jsmn_parse+0x23a>
c0d012ac:	e10a      	b.n	c0d014c4 <jsmn_parse+0x450>
c0d012ae:	2001      	movs	r0, #1
c0d012b0:	4602      	mov	r2, r0
c0d012b2:	408a      	lsls	r2, r1
c0d012b4:	4c8c      	ldr	r4, [pc, #560]	; (c0d014e8 <jsmn_parse+0x474>)
c0d012b6:	4222      	tst	r2, r4
c0d012b8:	d1d4      	bne.n	c0d01264 <jsmn_parse+0x1f0>
c0d012ba:	9001      	str	r0, [sp, #4]
c0d012bc:	2919      	cmp	r1, #25
c0d012be:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d012c0:	d000      	beq.n	c0d012c4 <jsmn_parse+0x250>
c0d012c2:	e0ff      	b.n	c0d014c4 <jsmn_parse+0x450>
c0d012c4:	9a0b      	ldr	r2, [sp, #44]	; 0x2c
c0d012c6:	1c53      	adds	r3, r2, #1
c0d012c8:	8003      	strh	r3, [r0, #0]
	short int start = parser->pos;

	parser->pos++;

	/* Skip starting quote */
	for (; parser->pos < len && js[parser->pos] != '\0'; parser->pos++) {
c0d012ca:	b298      	uxth	r0, r3
c0d012cc:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d012ce:	4288      	cmp	r0, r1
c0d012d0:	d300      	bcc.n	c0d012d4 <jsmn_parse+0x260>
c0d012d2:	e0fc      	b.n	c0d014ce <jsmn_parse+0x45a>
c0d012d4:	4616      	mov	r6, r2
c0d012d6:	4632      	mov	r2, r6
c0d012d8:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d012da:	5c0c      	ldrb	r4, [r1, r0]
c0d012dc:	2c5c      	cmp	r4, #92	; 0x5c
c0d012de:	d006      	beq.n	c0d012ee <jsmn_parse+0x27a>
c0d012e0:	2c00      	cmp	r4, #0
c0d012e2:	d100      	bne.n	c0d012e6 <jsmn_parse+0x272>
c0d012e4:	e0f3      	b.n	c0d014ce <jsmn_parse+0x45a>
c0d012e6:	2c22      	cmp	r4, #34	; 0x22
c0d012e8:	d084      	beq.n	c0d011f4 <jsmn_parse+0x180>
c0d012ea:	461e      	mov	r6, r3
c0d012ec:	e015      	b.n	c0d0131a <jsmn_parse+0x2a6>
#endif
			return 0;
		}

		/* Backslash: Quoted symbol expected */
		if (c == '\\' && parser->pos + 1 < len) {
c0d012ee:	1c40      	adds	r0, r0, #1
c0d012f0:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d012f2:	4288      	cmp	r0, r1
c0d012f4:	461e      	mov	r6, r3
c0d012f6:	d210      	bcs.n	c0d0131a <jsmn_parse+0x2a6>
			short int i;
			parser->pos++;
c0d012f8:	1c96      	adds	r6, r2, #2
c0d012fa:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d012fc:	8006      	strh	r6, [r0, #0]
			switch (js[parser->pos]) {
c0d012fe:	b2b0      	uxth	r0, r6
c0d01300:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d01302:	5c08      	ldrb	r0, [r1, r0]
c0d01304:	4603      	mov	r3, r0
c0d01306:	3b5c      	subs	r3, #92	; 0x5c
c0d01308:	1c6c      	adds	r4, r5, #1
c0d0130a:	2b19      	cmp	r3, #25
c0d0130c:	d834      	bhi.n	c0d01378 <jsmn_parse+0x304>
c0d0130e:	9d01      	ldr	r5, [sp, #4]
c0d01310:	409d      	lsls	r5, r3
c0d01312:	4976      	ldr	r1, [pc, #472]	; (c0d014ec <jsmn_parse+0x478>)
c0d01314:	420d      	tst	r5, r1
c0d01316:	d008      	beq.n	c0d0132a <jsmn_parse+0x2b6>
c0d01318:	9d08      	ldr	r5, [sp, #32]
c0d0131a:	1c73      	adds	r3, r6, #1
c0d0131c:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d0131e:	8003      	strh	r3, [r0, #0]
	short int start = parser->pos;

	parser->pos++;

	/* Skip starting quote */
	for (; parser->pos < len && js[parser->pos] != '\0'; parser->pos++) {
c0d01320:	b298      	uxth	r0, r3
c0d01322:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d01324:	4288      	cmp	r0, r1
c0d01326:	d3d6      	bcc.n	c0d012d6 <jsmn_parse+0x262>
c0d01328:	e0d1      	b.n	c0d014ce <jsmn_parse+0x45a>
c0d0132a:	2b19      	cmp	r3, #25
c0d0132c:	9d08      	ldr	r5, [sp, #32]
c0d0132e:	d123      	bne.n	c0d01378 <jsmn_parse+0x304>
				case '\"': case '/' : case '\\' : case 'b' :
				case 'f' : case 'r' : case 'n'  : case 't' :
					break;
				/* Allows escaped symbol \uXXXX */
				case 'u':
					parser->pos++;
c0d01330:	1cd3      	adds	r3, r2, #3
c0d01332:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d01334:	8003      	strh	r3, [r0, #0]
c0d01336:	9a04      	ldr	r2, [sp, #16]
					for(i = 0; i < 4 && parser->pos < len && js[parser->pos] != '\0'; i++) {
c0d01338:	b298      	uxth	r0, r3
c0d0133a:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d0133c:	4288      	cmp	r0, r1
c0d0133e:	d217      	bcs.n	c0d01370 <jsmn_parse+0x2fc>
c0d01340:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d01342:	5c08      	ldrb	r0, [r1, r0]
c0d01344:	2800      	cmp	r0, #0
c0d01346:	d013      	beq.n	c0d01370 <jsmn_parse+0x2fc>
						/* If it isn't a hex character we have an error */
						if(!((js[parser->pos] >= 48 && js[parser->pos] <= 57) || /* 0-9 */
c0d01348:	4601      	mov	r1, r0
c0d0134a:	3930      	subs	r1, #48	; 0x30
c0d0134c:	b2c9      	uxtb	r1, r1
c0d0134e:	290a      	cmp	r1, #10
c0d01350:	d307      	bcc.n	c0d01362 <jsmn_parse+0x2ee>
c0d01352:	4601      	mov	r1, r0
c0d01354:	3961      	subs	r1, #97	; 0x61
c0d01356:	2906      	cmp	r1, #6
c0d01358:	d303      	bcc.n	c0d01362 <jsmn_parse+0x2ee>
c0d0135a:	3841      	subs	r0, #65	; 0x41
c0d0135c:	2805      	cmp	r0, #5
c0d0135e:	d900      	bls.n	c0d01362 <jsmn_parse+0x2ee>
c0d01360:	e0b8      	b.n	c0d014d4 <jsmn_parse+0x460>
									(js[parser->pos] >= 65 && js[parser->pos] <= 70) || /* A-F */
									(js[parser->pos] >= 97 && js[parser->pos] <= 102))) { /* a-f */
							parser->pos = start;
							return JSMN_ERROR_INVAL;
						}
						parser->pos++;
c0d01362:	1c5b      	adds	r3, r3, #1
c0d01364:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d01366:	8003      	strh	r3, [r0, #0]
				case 'f' : case 'r' : case 'n'  : case 't' :
					break;
				/* Allows escaped symbol \uXXXX */
				case 'u':
					parser->pos++;
					for(i = 0; i < 4 && parser->pos < len && js[parser->pos] != '\0'; i++) {
c0d01368:	1c50      	adds	r0, r2, #1
c0d0136a:	b202      	sxth	r2, r0
c0d0136c:	2a04      	cmp	r2, #4
c0d0136e:	dbe3      	blt.n	c0d01338 <jsmn_parse+0x2c4>
							parser->pos = start;
							return JSMN_ERROR_INVAL;
						}
						parser->pos++;
					}
					parser->pos--;
c0d01370:	1e5e      	subs	r6, r3, #1
c0d01372:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d01374:	8006      	strh	r6, [r0, #0]
c0d01376:	e7d0      	b.n	c0d0131a <jsmn_parse+0x2a6>
c0d01378:	2822      	cmp	r0, #34	; 0x22
c0d0137a:	d0ce      	beq.n	c0d0131a <jsmn_parse+0x2a6>
c0d0137c:	282f      	cmp	r0, #47	; 0x2f
c0d0137e:	d0cc      	beq.n	c0d0131a <jsmn_parse+0x2a6>
c0d01380:	e0a8      	b.n	c0d014d4 <jsmn_parse+0x460>
c0d01382:	2b5d      	cmp	r3, #93	; 0x5d
c0d01384:	d004      	beq.n	c0d01390 <jsmn_parse+0x31c>
c0d01386:	2b7b      	cmp	r3, #123	; 0x7b
c0d01388:	d02c      	beq.n	c0d013e4 <jsmn_parse+0x370>
c0d0138a:	2b7d      	cmp	r3, #125	; 0x7d
c0d0138c:	d000      	beq.n	c0d01390 <jsmn_parse+0x31c>
c0d0138e:	e6af      	b.n	c0d010f0 <jsmn_parse+0x7c>
				token->type = (c == '{' ? JSMN_OBJECT : JSMN_ARRAY);
				token->start = parser->pos;
				parser->toksuper = parser->toknext - 1;
				break;
			case '}': case ']':
				if (tokens == NULL)
c0d01390:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d01392:	2800      	cmp	r0, #0
c0d01394:	d100      	bne.n	c0d01398 <jsmn_parse+0x324>
c0d01396:	e765      	b.n	c0d01264 <jsmn_parse+0x1f0>
						break;
					}
					token = &tokens[token->parent];
				}
#else
				for (i = parser->toknext - 1; i >= 0; i--) {
c0d01398:	9807      	ldr	r0, [sp, #28]
c0d0139a:	b280      	uxth	r0, r0
c0d0139c:	9905      	ldr	r1, [sp, #20]
c0d0139e:	1840      	adds	r0, r0, r1
c0d013a0:	b202      	sxth	r2, r0
c0d013a2:	42b2      	cmp	r2, r6
c0d013a4:	dd1a      	ble.n	c0d013dc <jsmn_parse+0x368>
c0d013a6:	0401      	lsls	r1, r0, #16
c0d013a8:	134c      	asrs	r4, r1, #13
c0d013aa:	9900      	ldr	r1, [sp, #0]
c0d013ac:	1909      	adds	r1, r1, r4
c0d013ae:	b207      	sxth	r7, r0
c0d013b0:	4602      	mov	r2, r0
					token = &tokens[i];
					if (token->start != -1 && token->end == -1) {
c0d013b2:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d013b4:	1900      	adds	r0, r0, r4
c0d013b6:	8845      	ldrh	r5, [r0, #2]
c0d013b8:	b2b6      	uxth	r6, r6
c0d013ba:	42b5      	cmp	r5, r6
c0d013bc:	d003      	beq.n	c0d013c6 <jsmn_parse+0x352>
c0d013be:	8885      	ldrh	r5, [r0, #4]
c0d013c0:	42b5      	cmp	r5, r6
c0d013c2:	d100      	bne.n	c0d013c6 <jsmn_parse+0x352>
c0d013c4:	e6f3      	b.n	c0d011ae <jsmn_parse+0x13a>
c0d013c6:	9d08      	ldr	r5, [sp, #32]
						break;
					}
					token = &tokens[token->parent];
				}
#else
				for (i = parser->toknext - 1; i >= 0; i--) {
c0d013c8:	00e8      	lsls	r0, r5, #3
c0d013ca:	1809      	adds	r1, r1, r0
c0d013cc:	3110      	adds	r1, #16
c0d013ce:	3c08      	subs	r4, #8
c0d013d0:	1e7f      	subs	r7, r7, #1
c0d013d2:	1e50      	subs	r0, r2, #1
c0d013d4:	b202      	sxth	r2, r0
c0d013d6:	9e09      	ldr	r6, [sp, #36]	; 0x24
c0d013d8:	42b2      	cmp	r2, r6
c0d013da:	dcea      	bgt.n	c0d013b2 <jsmn_parse+0x33e>
c0d013dc:	1c6c      	adds	r4, r5, #1
						token->end = parser->pos + 1;
						break;
					}
				}
				/* Error if unmatched closing bracket */
				if (i == -1) return JSMN_ERROR_INVAL;
c0d013de:	42b2      	cmp	r2, r6
c0d013e0:	d07b      	beq.n	c0d014da <jsmn_parse+0x466>
c0d013e2:	e73f      	b.n	c0d01264 <jsmn_parse+0x1f0>
		jsmntype_t type;

		c = js[parser->pos];
		switch (c) {
			case '{': case '[':
				count++;
c0d013e4:	9806      	ldr	r0, [sp, #24]
c0d013e6:	1c40      	adds	r0, r0, #1
				if (tokens == NULL) {
c0d013e8:	9006      	str	r0, [sp, #24]
c0d013ea:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d013ec:	2800      	cmp	r0, #0
c0d013ee:	d100      	bne.n	c0d013f2 <jsmn_parse+0x37e>
c0d013f0:	e738      	b.n	c0d01264 <jsmn_parse+0x1f0>
c0d013f2:	1cac      	adds	r4, r5, #2
c0d013f4:	9a07      	ldr	r2, [sp, #28]
 * Allocates a fresh unused token from the token pull.
 */
static jsmntok_t *jsmn_alloc_token(jsmn_parser *parser,
		jsmntok_t *tokens, size_t num_tokens) {
	jsmntok_t *tok;
	if (parser->toknext >= num_tokens) {
c0d013f6:	b290      	uxth	r0, r2
c0d013f8:	9902      	ldr	r1, [sp, #8]
c0d013fa:	4288      	cmp	r0, r1
c0d013fc:	d26d      	bcs.n	c0d014da <jsmn_parse+0x466>
		return NULL;
	}
	tok = &tokens[parser->toknext++];
c0d013fe:	1c52      	adds	r2, r2, #1
c0d01400:	990c      	ldr	r1, [sp, #48]	; 0x30
c0d01402:	9207      	str	r2, [sp, #28]
c0d01404:	804a      	strh	r2, [r1, #2]
c0d01406:	00c0      	lsls	r0, r0, #3
c0d01408:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d0140a:	1809      	adds	r1, r1, r0
	tok->start = tok->end = -1;
c0d0140c:	808e      	strh	r6, [r1, #4]
c0d0140e:	804e      	strh	r6, [r1, #2]
	tok->size = 0;
c0d01410:	9804      	ldr	r0, [sp, #16]
c0d01412:	80c8      	strh	r0, [r1, #6]
	jsmntok_t *tok;
	if (parser->toknext >= num_tokens) {
		return NULL;
	}
	tok = &tokens[parser->toknext++];
	tok->start = tok->end = -1;
c0d01414:	1c88      	adds	r0, r1, #2
				count++;
				if (tokens == NULL) {
					break;
				}
				token = jsmn_alloc_token(parser, tokens, num_tokens);
				if (token == NULL)
c0d01416:	2900      	cmp	r1, #0
c0d01418:	d05f      	beq.n	c0d014da <jsmn_parse+0x466>
					return JSMN_ERROR_NOMEM;
				if (parser->toksuper != -1) {
c0d0141a:	9a0c      	ldr	r2, [sp, #48]	; 0x30
c0d0141c:	8892      	ldrh	r2, [r2, #4]
c0d0141e:	9c09      	ldr	r4, [sp, #36]	; 0x24
c0d01420:	b2a4      	uxth	r4, r4
c0d01422:	42a2      	cmp	r2, r4
c0d01424:	d006      	beq.n	c0d01434 <jsmn_parse+0x3c0>
c0d01426:	b212      	sxth	r2, r2
					tokens[parser->toksuper].size++;
c0d01428:	00d2      	lsls	r2, r2, #3
c0d0142a:	9c0a      	ldr	r4, [sp, #40]	; 0x28
c0d0142c:	18a2      	adds	r2, r4, r2
c0d0142e:	88d4      	ldrh	r4, [r2, #6]
c0d01430:	1c64      	adds	r4, r4, #1
c0d01432:	80d4      	strh	r4, [r2, #6]
#ifdef JSMN_PARENT_LINKS
					token->parent = parser->toksuper;
#endif
				}
				token->type = (c == '{' ? JSMN_OBJECT : JSMN_ARRAY);
c0d01434:	2201      	movs	r2, #1
c0d01436:	2402      	movs	r4, #2
c0d01438:	2b7b      	cmp	r3, #123	; 0x7b
c0d0143a:	9b07      	ldr	r3, [sp, #28]
c0d0143c:	9e0b      	ldr	r6, [sp, #44]	; 0x2c
c0d0143e:	d000      	beq.n	c0d01442 <jsmn_parse+0x3ce>
c0d01440:	4622      	mov	r2, r4
c0d01442:	700a      	strb	r2, [r1, #0]
				token->start = parser->pos;
c0d01444:	8006      	strh	r6, [r0, #0]
				parser->toksuper = parser->toknext - 1;
c0d01446:	9805      	ldr	r0, [sp, #20]
c0d01448:	1818      	adds	r0, r3, r0
c0d0144a:	990c      	ldr	r1, [sp, #48]	; 0x30
c0d0144c:	8088      	strh	r0, [r1, #4]
c0d0144e:	e709      	b.n	c0d01264 <jsmn_parse+0x1f0>
c0d01450:	0000ffff 	.word	0x0000ffff
c0d01454:	9a0a      	ldr	r2, [sp, #40]	; 0x28
				break;
			case ':':
				parser->toksuper = parser->toknext - 1;
				break;
			case ',':
				if (tokens != NULL && parser->toksuper != -1 &&
c0d01456:	2a00      	cmp	r2, #0
c0d01458:	d100      	bne.n	c0d0145c <jsmn_parse+0x3e8>
c0d0145a:	e703      	b.n	c0d01264 <jsmn_parse+0x1f0>
c0d0145c:	8880      	ldrh	r0, [r0, #4]
c0d0145e:	b2b1      	uxth	r1, r6
c0d01460:	4288      	cmp	r0, r1
c0d01462:	d100      	bne.n	c0d01466 <jsmn_parse+0x3f2>
c0d01464:	e6fe      	b.n	c0d01264 <jsmn_parse+0x1f0>
c0d01466:	b200      	sxth	r0, r0
						tokens[parser->toksuper].type != JSMN_ARRAY &&
c0d01468:	00c0      	lsls	r0, r0, #3
c0d0146a:	5c10      	ldrb	r0, [r2, r0]
c0d0146c:	1e40      	subs	r0, r0, #1
c0d0146e:	b2c0      	uxtb	r0, r0
c0d01470:	2802      	cmp	r0, #2
c0d01472:	d200      	bcs.n	c0d01476 <jsmn_parse+0x402>
c0d01474:	e6f6      	b.n	c0d01264 <jsmn_parse+0x1f0>
						tokens[parser->toksuper].type != JSMN_OBJECT) {
#ifdef JSMN_PARENT_LINKS
					parser->toksuper = tokens[parser->toksuper].parent;
#else
					for (i = parser->toknext - 1; i >= 0; i--) {
c0d01476:	9807      	ldr	r0, [sp, #28]
c0d01478:	b280      	uxth	r0, r0
c0d0147a:	9a05      	ldr	r2, [sp, #20]
c0d0147c:	1884      	adds	r4, r0, r2
c0d0147e:	b223      	sxth	r3, r4
c0d01480:	42b3      	cmp	r3, r6
c0d01482:	dc00      	bgt.n	c0d01486 <jsmn_parse+0x412>
c0d01484:	e6ee      	b.n	c0d01264 <jsmn_parse+0x1f0>
c0d01486:	0420      	lsls	r0, r4, #16
c0d01488:	1340      	asrs	r0, r0, #13
c0d0148a:	9a00      	ldr	r2, [sp, #0]
c0d0148c:	1812      	adds	r2, r2, r0
c0d0148e:	1950      	adds	r0, r2, r5
						if (tokens[i].type == JSMN_ARRAY || tokens[i].type == JSMN_OBJECT) {
c0d01490:	7840      	ldrb	r0, [r0, #1]
c0d01492:	1e40      	subs	r0, r0, #1
c0d01494:	b2c0      	uxtb	r0, r0
c0d01496:	2801      	cmp	r0, #1
c0d01498:	d806      	bhi.n	c0d014a8 <jsmn_parse+0x434>
							if (tokens[i].start != -1 && tokens[i].end == -1) {
c0d0149a:	8810      	ldrh	r0, [r2, #0]
c0d0149c:	4288      	cmp	r0, r1
c0d0149e:	d003      	beq.n	c0d014a8 <jsmn_parse+0x434>
c0d014a0:	8850      	ldrh	r0, [r2, #2]
c0d014a2:	4288      	cmp	r0, r1
c0d014a4:	d100      	bne.n	c0d014a8 <jsmn_parse+0x434>
c0d014a6:	e6ea      	b.n	c0d0127e <jsmn_parse+0x20a>
						tokens[parser->toksuper].type != JSMN_ARRAY &&
						tokens[parser->toksuper].type != JSMN_OBJECT) {
#ifdef JSMN_PARENT_LINKS
					parser->toksuper = tokens[parser->toksuper].parent;
#else
					for (i = parser->toknext - 1; i >= 0; i--) {
c0d014a8:	00e8      	lsls	r0, r5, #3
c0d014aa:	1812      	adds	r2, r2, r0
c0d014ac:	3210      	adds	r2, #16
c0d014ae:	1e5b      	subs	r3, r3, #1
c0d014b0:	1e60      	subs	r0, r4, #1
c0d014b2:	b204      	sxth	r4, r0
c0d014b4:	42b4      	cmp	r4, r6
c0d014b6:	dcea      	bgt.n	c0d0148e <jsmn_parse+0x41a>
c0d014b8:	e6d4      	b.n	c0d01264 <jsmn_parse+0x1f0>
					tokens[parser->toksuper].size++;
				break;
			case '\t' : case '\r' : case '\n' : case ' ':
				break;
			case ':':
				parser->toksuper = parser->toknext - 1;
c0d014ba:	9907      	ldr	r1, [sp, #28]
c0d014bc:	9a05      	ldr	r2, [sp, #20]
c0d014be:	1889      	adds	r1, r1, r2
c0d014c0:	8081      	strh	r1, [r0, #4]
c0d014c2:	e6cf      	b.n	c0d01264 <jsmn_parse+0x1f0>
c0d014c4:	2b00      	cmp	r3, #0
c0d014c6:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d014c8:	d000      	beq.n	c0d014cc <jsmn_parse+0x458>
c0d014ca:	e615      	b.n	c0d010f8 <jsmn_parse+0x84>
c0d014cc:	e5f0      	b.n	c0d010b0 <jsmn_parse+0x3c>
c0d014ce:	462c      	mov	r4, r5
c0d014d0:	e000      	b.n	c0d014d4 <jsmn_parse+0x460>
c0d014d2:	1c6c      	adds	r4, r5, #1
c0d014d4:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d014d6:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d014d8:	8001      	strh	r1, [r0, #0]
			}
		}
	}

	return count;
}
c0d014da:	4620      	mov	r0, r4
c0d014dc:	b00f      	add	sp, #60	; 0x3c
c0d014de:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d014e0:	462c      	mov	r4, r5
c0d014e2:	e7fa      	b.n	c0d014da <jsmn_parse+0x466>
c0d014e4:	1cac      	adds	r4, r5, #2
c0d014e6:	e7f5      	b.n	c0d014d4 <jsmn_parse+0x460>
c0d014e8:	00800013 	.word	0x00800013
c0d014ec:	01440441 	.word	0x01440441
c0d014f0:	00002601 	.word	0x00002601
c0d014f4:	04001001 	.word	0x04001001

c0d014f8 <jsmn_init>:
/**
 * Creates a new parser based over a given  buffer with an array of tokens
 * available.
 */
void jsmn_init(jsmn_parser *parser) {
	parser->pos = 0;
c0d014f8:	2100      	movs	r1, #0
c0d014fa:	8001      	strh	r1, [r0, #0]
	parser->toknext = 0;
c0d014fc:	8041      	strh	r1, [r0, #2]
	parser->toksuper = -1;
c0d014fe:	4901      	ldr	r1, [pc, #4]	; (c0d01504 <jsmn_init+0xc>)
c0d01500:	8081      	strh	r1, [r0, #4]
}
c0d01502:	4770      	bx	lr
c0d01504:	0000ffff 	.word	0x0000ffff

c0d01508 <json_parse_s>:

}

const char *json_parse_s(parsed_json_t *parsed_json,
                         const char *transaction,
                         uint16_t transaction_length) {
c0d01508:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0150a:	b083      	sub	sp, #12
c0d0150c:	4615      	mov	r5, r2
c0d0150e:	460e      	mov	r6, r1
c0d01510:	4604      	mov	r4, r0
c0d01512:	af01      	add	r7, sp, #4
    jsmn_parser parser;
    jsmn_init(&parser);
c0d01514:	4638      	mov	r0, r7
c0d01516:	f7ff ffef 	bl	c0d014f8 <jsmn_init>
#else
    #define EQUALS(_P, _Q, _LEN) (memcmp( (_P), (_Q), (_LEN))==0)
#endif

void reset_parsed_json(parsed_json_t *parser_data) {
    memset(parser_data, 0, sizeof(parsed_json_t));
c0d0151a:	4916      	ldr	r1, [pc, #88]	; (c0d01574 <json_parse_s+0x6c>)
c0d0151c:	4620      	mov	r0, r4
c0d0151e:	f004 febb 	bl	c0d06298 <__aeabi_memclr>
    jsmn_parser parser;
    jsmn_init(&parser);

    reset_parsed_json(parsed_json);

    int num_tokens = jsmn_parse(
c0d01522:	2080      	movs	r0, #128	; 0x80
c0d01524:	4669      	mov	r1, sp
c0d01526:	6008      	str	r0, [r1, #0]
            &parser,
            transaction,
            transaction_length,
            parsed_json->Tokens,
c0d01528:	1d23      	adds	r3, r4, #4
    jsmn_parser parser;
    jsmn_init(&parser);

    reset_parsed_json(parsed_json);

    int num_tokens = jsmn_parse(
c0d0152a:	4638      	mov	r0, r7
c0d0152c:	4631      	mov	r1, r6
c0d0152e:	462a      	mov	r2, r5
c0d01530:	f7ff fda0 	bl	c0d01074 <jsmn_parse>
c0d01534:	4601      	mov	r1, r0
            transaction,
            transaction_length,
            parsed_json->Tokens,
            MAX_NUMBER_OF_TOKENS);

    switch (num_tokens) {
c0d01536:	3003      	adds	r0, #3
c0d01538:	d007      	beq.n	c0d0154a <json_parse_s+0x42>
c0d0153a:	4608      	mov	r0, r1
c0d0153c:	3001      	adds	r0, #1
c0d0153e:	d006      	beq.n	c0d0154e <json_parse_s+0x46>
c0d01540:	4608      	mov	r0, r1
c0d01542:	3002      	adds	r0, #2
c0d01544:	d105      	bne.n	c0d01552 <json_parse_s+0x4a>
c0d01546:	a01e      	add	r0, pc, #120	; (adr r0, c0d015c0 <json_parse_s+0xb8>)
c0d01548:	e012      	b.n	c0d01570 <json_parse_s+0x68>
c0d0154a:	a016      	add	r0, pc, #88	; (adr r0, c0d015a4 <json_parse_s+0x9c>)
c0d0154c:	e010      	b.n	c0d01570 <json_parse_s+0x68>
c0d0154e:	a00a      	add	r0, pc, #40	; (adr r0, c0d01578 <json_parse_s+0x70>)
c0d01550:	e00e      	b.n	c0d01570 <json_parse_s+0x68>
c0d01552:	2000      	movs	r0, #0
            return "Invalid character in JSON string";
        case JSMN_ERROR_PART:
            return "JSON string is not complete";
    }

    parsed_json->NumberOfTokens = 0;
c0d01554:	8060      	strh	r0, [r4, #2]
    parsed_json->IsValid = 0;
c0d01556:	7020      	strb	r0, [r4, #0]

    // Parsing error
    if (num_tokens <= 0) {
c0d01558:	2901      	cmp	r1, #1
c0d0155a:	db04      	blt.n	c0d01566 <json_parse_s+0x5e>
        return "Unknown parser error";
    }

    // We cannot support if number of tokens exceeds the limit
    if (num_tokens > MAX_NUMBER_OF_TOKENS) {
c0d0155c:	2980      	cmp	r1, #128	; 0x80
c0d0155e:	dd04      	ble.n	c0d0156a <json_parse_s+0x62>
c0d01560:	4826      	ldr	r0, [pc, #152]	; (c0d015fc <json_parse_s+0xf4>)
c0d01562:	4478      	add	r0, pc
c0d01564:	e004      	b.n	c0d01570 <json_parse_s+0x68>
c0d01566:	a01f      	add	r0, pc, #124	; (adr r0, c0d015e4 <json_parse_s+0xdc>)
c0d01568:	e002      	b.n	c0d01570 <json_parse_s+0x68>
        return "TOK: JSON string contains too many tokens";
    }

    parsed_json->NumberOfTokens = num_tokens;
c0d0156a:	8061      	strh	r1, [r4, #2]
    parsed_json->IsValid = true;
c0d0156c:	2101      	movs	r1, #1
c0d0156e:	7021      	strb	r1, [r4, #0]
    return NULL;
}
c0d01570:	b003      	add	sp, #12
c0d01572:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01574:	00000404 	.word	0x00000404
c0d01578:	454d4f4e 	.word	0x454d4f4e
c0d0157c:	4a203a4d 	.word	0x4a203a4d
c0d01580:	204e4f53 	.word	0x204e4f53
c0d01584:	69727473 	.word	0x69727473
c0d01588:	6320676e 	.word	0x6320676e
c0d0158c:	61746e6f 	.word	0x61746e6f
c0d01590:	20736e69 	.word	0x20736e69
c0d01594:	206f6f74 	.word	0x206f6f74
c0d01598:	796e616d 	.word	0x796e616d
c0d0159c:	6b6f7420 	.word	0x6b6f7420
c0d015a0:	00736e65 	.word	0x00736e65
c0d015a4:	4e4f534a 	.word	0x4e4f534a
c0d015a8:	72747320 	.word	0x72747320
c0d015ac:	20676e69 	.word	0x20676e69
c0d015b0:	6e207369 	.word	0x6e207369
c0d015b4:	6320746f 	.word	0x6320746f
c0d015b8:	6c706d6f 	.word	0x6c706d6f
c0d015bc:	00657465 	.word	0x00657465
c0d015c0:	61766e49 	.word	0x61766e49
c0d015c4:	2064696c 	.word	0x2064696c
c0d015c8:	72616863 	.word	0x72616863
c0d015cc:	65746361 	.word	0x65746361
c0d015d0:	6e692072 	.word	0x6e692072
c0d015d4:	4f534a20 	.word	0x4f534a20
c0d015d8:	7473204e 	.word	0x7473204e
c0d015dc:	676e6972 	.word	0x676e6972
c0d015e0:	00000000 	.word	0x00000000
c0d015e4:	6e6b6e55 	.word	0x6e6b6e55
c0d015e8:	206e776f 	.word	0x206e776f
c0d015ec:	73726170 	.word	0x73726170
c0d015f0:	65207265 	.word	0x65207265
c0d015f4:	726f7272 	.word	0x726f7272
c0d015f8:	00000000 	.word	0x00000000
c0d015fc:	000050a2 	.word	0x000050a2

c0d01600 <array_get_nth_element>:
    return element_count;
}

int16_t array_get_nth_element(uint16_t array_token_index,
                              uint16_t element_index,
                              const parsed_json_t *parsed_transaction) {
c0d01600:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01602:	b083      	sub	sp, #12
    if (array_token_index < 0 || array_token_index > parsed_transaction->NumberOfTokens) {
c0d01604:	8854      	ldrh	r4, [r2, #2]
c0d01606:	4b15      	ldr	r3, [pc, #84]	; (c0d0165c <array_get_nth_element+0x5c>)
c0d01608:	4284      	cmp	r4, r0
c0d0160a:	d201      	bcs.n	c0d01610 <array_get_nth_element+0x10>
c0d0160c:	4618      	mov	r0, r3
c0d0160e:	e021      	b.n	c0d01654 <array_get_nth_element+0x54>
c0d01610:	9302      	str	r3, [sp, #8]
c0d01612:	9101      	str	r1, [sp, #4]
        return -1;
    }

    jsmntok_t array_token = parsed_transaction->Tokens[array_token_index];
c0d01614:	00c3      	lsls	r3, r0, #3
c0d01616:	18d3      	adds	r3, r2, r3
c0d01618:	2508      	movs	r5, #8
c0d0161a:	5f5d      	ldrsh	r5, [r3, r5]
c0d0161c:	1d9f      	adds	r7, r3, #6
c0d0161e:	2100      	movs	r1, #0
c0d01620:	883e      	ldrh	r6, [r7, #0]
    uint16_t token_index = array_token_index;
    uint16_t element_count = 0;
    uint16_t prev_element_end = array_token.start;
    while (true) {
        token_index++;
c0d01622:	1c40      	adds	r0, r0, #1
c0d01624:	b283      	uxth	r3, r0
        if (token_index >= parsed_transaction->NumberOfTokens) {
c0d01626:	42a3      	cmp	r3, r4
c0d01628:	d213      	bcs.n	c0d01652 <array_get_nth_element+0x52>
            break;
        }
        jsmntok_t current_token = parsed_transaction->Tokens[token_index];
c0d0162a:	00db      	lsls	r3, r3, #3
c0d0162c:	18d7      	adds	r7, r2, r3
c0d0162e:	2306      	movs	r3, #6
c0d01630:	5efb      	ldrsh	r3, [r7, r3]
        if (current_token.start > array_token.end) {
c0d01632:	42ab      	cmp	r3, r5
c0d01634:	dc0d      	bgt.n	c0d01652 <array_get_nth_element+0x52>
            break;
        }
        if (current_token.start <= prev_element_end) {
c0d01636:	42b3      	cmp	r3, r6
c0d01638:	ddf3      	ble.n	c0d01622 <array_get_nth_element+0x22>
c0d0163a:	460b      	mov	r3, r1
            continue;
        }
        prev_element_end = current_token.end;
        if (element_count == element_index) {
c0d0163c:	b29e      	uxth	r6, r3
c0d0163e:	1c5b      	adds	r3, r3, #1
c0d01640:	9300      	str	r3, [sp, #0]
c0d01642:	9b01      	ldr	r3, [sp, #4]
c0d01644:	429e      	cmp	r6, r3
c0d01646:	d000      	beq.n	c0d0164a <array_get_nth_element+0x4a>
c0d01648:	9900      	ldr	r1, [sp, #0]
    while (true) {
        token_index++;
        if (token_index >= parsed_transaction->NumberOfTokens) {
            break;
        }
        jsmntok_t current_token = parsed_transaction->Tokens[token_index];
c0d0164a:	3708      	adds	r7, #8
c0d0164c:	429e      	cmp	r6, r3
c0d0164e:	d1e7      	bne.n	c0d01620 <array_get_nth_element+0x20>
c0d01650:	e000      	b.n	c0d01654 <array_get_nth_element+0x54>
c0d01652:	9802      	ldr	r0, [sp, #8]
        }
        element_count++;
    }

    return -1;
}
c0d01654:	b200      	sxth	r0, r0
c0d01656:	b003      	add	sp, #12
c0d01658:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0165a:	46c0      	nop			; (mov r8, r8)
c0d0165c:	0000ffff 	.word	0x0000ffff

c0d01660 <object_get_element_count>:

uint16_t object_get_element_count(uint16_t object_token_index,
                                  const parsed_json_t *parsed_transaction) {
c0d01660:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01662:	b082      	sub	sp, #8
    if (object_token_index < 0 || object_token_index > parsed_transaction->NumberOfTokens) {
c0d01664:	884f      	ldrh	r7, [r1, #2]
c0d01666:	2400      	movs	r4, #0
c0d01668:	4287      	cmp	r7, r0
c0d0166a:	d328      	bcc.n	c0d016be <object_get_element_count+0x5e>
        return 0;
    }

    jsmntok_t object_token = parsed_transaction->Tokens[object_token_index];
c0d0166c:	00c2      	lsls	r2, r0, #3
c0d0166e:	188b      	adds	r3, r1, r2
c0d01670:	2508      	movs	r5, #8
    uint16_t token_index = object_token_index;
    uint16_t element_count = 0;
    uint16_t prev_element_end = object_token.start;
    token_index++;
c0d01672:	1c40      	adds	r0, r0, #1
c0d01674:	b282      	uxth	r2, r0
    while (true) {
        if (token_index >= parsed_transaction->NumberOfTokens) {
c0d01676:	42ba      	cmp	r2, r7
c0d01678:	d221      	bcs.n	c0d016be <object_get_element_count+0x5e>
                                  const parsed_json_t *parsed_transaction) {
    if (object_token_index < 0 || object_token_index > parsed_transaction->NumberOfTokens) {
        return 0;
    }

    jsmntok_t object_token = parsed_transaction->Tokens[object_token_index];
c0d0167a:	5f5a      	ldrsh	r2, [r3, r5]
c0d0167c:	9200      	str	r2, [sp, #0]
c0d0167e:	88da      	ldrh	r2, [r3, #6]
c0d01680:	9201      	str	r2, [sp, #4]
c0d01682:	2600      	movs	r6, #0
c0d01684:	463d      	mov	r5, r7
    uint16_t token_index = object_token_index;
    uint16_t element_count = 0;
    uint16_t prev_element_end = object_token.start;
    token_index++;
    while (true) {
        if (token_index >= parsed_transaction->NumberOfTokens) {
c0d01686:	b282      	uxth	r2, r0
            break;
        }
        jsmntok_t key_token = parsed_transaction->Tokens[token_index++];
c0d01688:	00d2      	lsls	r2, r2, #3
c0d0168a:	188a      	adds	r2, r1, r2
c0d0168c:	2306      	movs	r3, #6
c0d0168e:	5ed7      	ldrsh	r7, [r2, r3]
c0d01690:	1c40      	adds	r0, r0, #1
        jsmntok_t value_token = parsed_transaction->Tokens[token_index];
        if (key_token.start > object_token.end) {
c0d01692:	9a00      	ldr	r2, [sp, #0]
c0d01694:	4297      	cmp	r7, r2
c0d01696:	dc11      	bgt.n	c0d016bc <object_get_element_count+0x5c>
            break;
        }
        if (key_token.start <= prev_element_end) {
c0d01698:	9a01      	ldr	r2, [sp, #4]
c0d0169a:	b293      	uxth	r3, r2
c0d0169c:	1c74      	adds	r4, r6, #1
c0d0169e:	429f      	cmp	r7, r3
c0d016a0:	dc00      	bgt.n	c0d016a4 <object_get_element_count+0x44>
c0d016a2:	4634      	mov	r4, r6
    while (true) {
        if (token_index >= parsed_transaction->NumberOfTokens) {
            break;
        }
        jsmntok_t key_token = parsed_transaction->Tokens[token_index++];
        jsmntok_t value_token = parsed_transaction->Tokens[token_index];
c0d016a4:	b286      	uxth	r6, r0
c0d016a6:	00f2      	lsls	r2, r6, #3
c0d016a8:	188a      	adds	r2, r1, r2
        if (key_token.start > object_token.end) {
            break;
        }
        if (key_token.start <= prev_element_end) {
c0d016aa:	429f      	cmp	r7, r3
c0d016ac:	dd01      	ble.n	c0d016b2 <object_get_element_count+0x52>
    while (true) {
        if (token_index >= parsed_transaction->NumberOfTokens) {
            break;
        }
        jsmntok_t key_token = parsed_transaction->Tokens[token_index++];
        jsmntok_t value_token = parsed_transaction->Tokens[token_index];
c0d016ae:	8912      	ldrh	r2, [r2, #8]
c0d016b0:	9201      	str	r2, [sp, #4]
c0d016b2:	462f      	mov	r7, r5
    uint16_t token_index = object_token_index;
    uint16_t element_count = 0;
    uint16_t prev_element_end = object_token.start;
    token_index++;
    while (true) {
        if (token_index >= parsed_transaction->NumberOfTokens) {
c0d016b4:	42be      	cmp	r6, r7
c0d016b6:	4626      	mov	r6, r4
c0d016b8:	d3e4      	bcc.n	c0d01684 <object_get_element_count+0x24>
c0d016ba:	e000      	b.n	c0d016be <object_get_element_count+0x5e>
c0d016bc:	4634      	mov	r4, r6
        prev_element_end = value_token.end;
        element_count++;
    }

    return element_count;
}
c0d016be:	b2a0      	uxth	r0, r4
c0d016c0:	b002      	add	sp, #8
c0d016c2:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d016c4 <object_get_nth_key>:

int16_t object_get_nth_key(uint16_t object_token_index,
                           uint16_t object_element_index,
                           const parsed_json_t *parsed_transaction) {
c0d016c4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d016c6:	b083      	sub	sp, #12
    if (object_token_index < 0 || object_token_index > parsed_transaction->NumberOfTokens) {
c0d016c8:	8854      	ldrh	r4, [r2, #2]
c0d016ca:	4b15      	ldr	r3, [pc, #84]	; (c0d01720 <object_get_nth_key+0x5c>)
c0d016cc:	4284      	cmp	r4, r0
c0d016ce:	d324      	bcc.n	c0d0171a <object_get_nth_key+0x56>
c0d016d0:	9101      	str	r1, [sp, #4]
c0d016d2:	9302      	str	r3, [sp, #8]
        return -1;
    }

    jsmntok_t object_token = parsed_transaction->Tokens[object_token_index];
c0d016d4:	00c3      	lsls	r3, r0, #3
c0d016d6:	18d3      	adds	r3, r2, r3
c0d016d8:	2508      	movs	r5, #8
c0d016da:	5f5d      	ldrsh	r5, [r3, r5]
c0d016dc:	1d9f      	adds	r7, r3, #6
    uint16_t token_index = object_token_index;
    uint16_t element_count = 0;
    uint16_t prev_element_end = object_token.start;
    token_index++;
c0d016de:	1c40      	adds	r0, r0, #1
c0d016e0:	2600      	movs	r6, #0
c0d016e2:	883f      	ldrh	r7, [r7, #0]
    while (true) {
        if (token_index >= parsed_transaction->NumberOfTokens) {
c0d016e4:	b283      	uxth	r3, r0
c0d016e6:	42a3      	cmp	r3, r4
c0d016e8:	d216      	bcs.n	c0d01718 <object_get_nth_key+0x54>
            break;
        }
        jsmntok_t key_token = parsed_transaction->Tokens[token_index++];
c0d016ea:	00db      	lsls	r3, r3, #3
c0d016ec:	18d3      	adds	r3, r2, r3
c0d016ee:	2106      	movs	r1, #6
c0d016f0:	5e5b      	ldrsh	r3, [r3, r1]
c0d016f2:	1c40      	adds	r0, r0, #1
        jsmntok_t value_token = parsed_transaction->Tokens[token_index];
        if (key_token.start > object_token.end) {
c0d016f4:	42ab      	cmp	r3, r5
c0d016f6:	dc0f      	bgt.n	c0d01718 <object_get_nth_key+0x54>
            break;
        }
        if (key_token.start <= prev_element_end) {
c0d016f8:	42bb      	cmp	r3, r7
c0d016fa:	ddf3      	ble.n	c0d016e4 <object_get_nth_key+0x20>
    while (true) {
        if (token_index >= parsed_transaction->NumberOfTokens) {
            break;
        }
        jsmntok_t key_token = parsed_transaction->Tokens[token_index++];
        jsmntok_t value_token = parsed_transaction->Tokens[token_index];
c0d016fc:	b283      	uxth	r3, r0
c0d016fe:	00d9      	lsls	r1, r3, #3
c0d01700:	1857      	adds	r7, r2, r1
c0d01702:	3708      	adds	r7, #8
        }
        prev_element_end = value_token.end;
        if (element_count == object_element_index) {
            return token_index - 1;
        }
        element_count++;
c0d01704:	1c71      	adds	r1, r6, #1
        }
        if (key_token.start <= prev_element_end) {
            continue;
        }
        prev_element_end = value_token.end;
        if (element_count == object_element_index) {
c0d01706:	9100      	str	r1, [sp, #0]
c0d01708:	b2b6      	uxth	r6, r6
c0d0170a:	9901      	ldr	r1, [sp, #4]
c0d0170c:	428e      	cmp	r6, r1
c0d0170e:	9e00      	ldr	r6, [sp, #0]
c0d01710:	d1e7      	bne.n	c0d016e2 <object_get_nth_key+0x1e>
            return token_index - 1;
c0d01712:	4803      	ldr	r0, [pc, #12]	; (c0d01720 <object_get_nth_key+0x5c>)
c0d01714:	181b      	adds	r3, r3, r0
c0d01716:	e000      	b.n	c0d0171a <object_get_nth_key+0x56>
c0d01718:	9b02      	ldr	r3, [sp, #8]
        }
        element_count++;
    }

    return -1;
}
c0d0171a:	b218      	sxth	r0, r3
c0d0171c:	b003      	add	sp, #12
c0d0171e:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01720:	0000ffff 	.word	0x0000ffff

c0d01724 <object_get_nth_value>:

int16_t object_get_nth_value(uint16_t object_token_index,
                             uint16_t object_element_index,
                             const parsed_json_t *parsed_transaction) {
c0d01724:	b510      	push	{r4, lr}
    if (object_token_index < 0 || object_token_index > parsed_transaction->NumberOfTokens) {
c0d01726:	8853      	ldrh	r3, [r2, #2]
c0d01728:	4c05      	ldr	r4, [pc, #20]	; (c0d01740 <object_get_nth_value+0x1c>)
c0d0172a:	4283      	cmp	r3, r0
c0d0172c:	d305      	bcc.n	c0d0173a <object_get_nth_value+0x16>
        return -1;
    }

    int key_index = object_get_nth_key(object_token_index, object_element_index, parsed_transaction);
c0d0172e:	f7ff ffc9 	bl	c0d016c4 <object_get_nth_key>
c0d01732:	b280      	uxth	r0, r0
    if (key_index != -1) {
c0d01734:	42a0      	cmp	r0, r4
c0d01736:	d000      	beq.n	c0d0173a <object_get_nth_value+0x16>
        return key_index + 1;
c0d01738:	1c44      	adds	r4, r0, #1
    }
    return -1;
}
c0d0173a:	b220      	sxth	r0, r4
c0d0173c:	bd10      	pop	{r4, pc}
c0d0173e:	46c0      	nop			; (mov r8, r8)
c0d01740:	0000ffff 	.word	0x0000ffff

c0d01744 <object_get_value>:

int16_t object_get_value(uint16_t object_token_index,
                         const char *key_name,
                         const parsed_json_t *parsed_transaction,
                         const char *transaction) {
c0d01744:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01746:	b089      	sub	sp, #36	; 0x24
    if (object_token_index < 0 || object_token_index > parsed_transaction->NumberOfTokens) {
c0d01748:	8855      	ldrh	r5, [r2, #2]
c0d0174a:	4c24      	ldr	r4, [pc, #144]	; (c0d017dc <object_get_value+0x98>)
c0d0174c:	4285      	cmp	r5, r0
c0d0174e:	d341      	bcc.n	c0d017d4 <object_get_value+0x90>
c0d01750:	9105      	str	r1, [sp, #20]
c0d01752:	9406      	str	r4, [sp, #24]
        return -1;
    }

    const jsmntok_t object_token = parsed_transaction->Tokens[object_token_index];
c0d01754:	00c4      	lsls	r4, r0, #3
c0d01756:	9208      	str	r2, [sp, #32]
c0d01758:	1912      	adds	r2, r2, r4
c0d0175a:	2106      	movs	r1, #6
c0d0175c:	9107      	str	r1, [sp, #28]

    int token_index = object_token_index;
    int prev_element_end = object_token.start;
c0d0175e:	5e57      	ldrsh	r7, [r2, r1]
                         const char *transaction) {
    if (object_token_index < 0 || object_token_index > parsed_transaction->NumberOfTokens) {
        return -1;
    }

    const jsmntok_t object_token = parsed_transaction->Tokens[object_token_index];
c0d01760:	2108      	movs	r1, #8
c0d01762:	9104      	str	r1, [sp, #16]
c0d01764:	5e52      	ldrsh	r2, [r2, r1]

    int token_index = object_token_index;
    int prev_element_end = object_token.start;
    token_index++;
c0d01766:	1c44      	adds	r4, r0, #1
c0d01768:	e003      	b.n	c0d01772 <object_get_value+0x2e>
c0d0176a:	9808      	ldr	r0, [sp, #32]
c0d0176c:	8845      	ldrh	r5, [r0, #2]
c0d0176e:	9b03      	ldr	r3, [sp, #12]
c0d01770:	9a02      	ldr	r2, [sp, #8]
c0d01772:	b2ad      	uxth	r5, r5
        return -1;
    }

    const jsmntok_t object_token = parsed_transaction->Tokens[object_token_index];

    int token_index = object_token_index;
c0d01774:	00e0      	lsls	r0, r4, #3
c0d01776:	9908      	ldr	r1, [sp, #32]
c0d01778:	1808      	adds	r0, r1, r0
c0d0177a:	9907      	ldr	r1, [sp, #28]
    int prev_element_end = object_token.start;
    token_index++;

    while (token_index < parsed_transaction->NumberOfTokens) {
c0d0177c:	42ac      	cmp	r4, r5
c0d0177e:	da28      	bge.n	c0d017d2 <object_get_value+0x8e>
        const jsmntok_t key_token = parsed_transaction->Tokens[token_index];
c0d01780:	5e46      	ldrsh	r6, [r0, r1]
        token_index++;
c0d01782:	1c64      	adds	r4, r4, #1
        const jsmntok_t value_token = parsed_transaction->Tokens[token_index];

        if (key_token.start > object_token.end) {
c0d01784:	4296      	cmp	r6, r2
c0d01786:	dc24      	bgt.n	c0d017d2 <object_get_value+0x8e>
            break;
        }
        if (key_token.start <= prev_element_end) {
c0d01788:	3008      	adds	r0, #8
c0d0178a:	42be      	cmp	r6, r7
c0d0178c:	ddf6      	ble.n	c0d0177c <object_get_value+0x38>
            continue;
        }
        prev_element_end = value_token.end;
c0d0178e:	9904      	ldr	r1, [sp, #16]
c0d01790:	5e47      	ldrsh	r7, [r0, r1]

        if ( ((uint16_t) strlen(key_name)) == (key_token.end - key_token.start)) {
c0d01792:	8800      	ldrh	r0, [r0, #0]
c0d01794:	b200      	sxth	r0, r0
c0d01796:	1b80      	subs	r0, r0, r6
c0d01798:	9001      	str	r0, [sp, #4]
c0d0179a:	9805      	ldr	r0, [sp, #20]
c0d0179c:	9303      	str	r3, [sp, #12]
c0d0179e:	9202      	str	r2, [sp, #8]
c0d017a0:	f004 fe6e 	bl	c0d06480 <strlen>
c0d017a4:	9a02      	ldr	r2, [sp, #8]
c0d017a6:	9b03      	ldr	r3, [sp, #12]
c0d017a8:	b280      	uxth	r0, r0
c0d017aa:	9901      	ldr	r1, [sp, #4]
c0d017ac:	4288      	cmp	r0, r1
c0d017ae:	d1e1      	bne.n	c0d01774 <object_get_value+0x30>
c0d017b0:	9001      	str	r0, [sp, #4]
            if (EQUALS(key_name, transaction + key_token.start, key_token.end - key_token.start)) {
c0d017b2:	9805      	ldr	r0, [sp, #20]
c0d017b4:	461d      	mov	r5, r3
c0d017b6:	f001 fa35 	bl	c0d02c24 <pic>
c0d017ba:	9000      	str	r0, [sp, #0]
c0d017bc:	1970      	adds	r0, r6, r5
c0d017be:	f001 fa31 	bl	c0d02c24 <pic>
c0d017c2:	4601      	mov	r1, r0
c0d017c4:	9800      	ldr	r0, [sp, #0]
c0d017c6:	9a01      	ldr	r2, [sp, #4]
c0d017c8:	f000 f95e 	bl	c0d01a88 <os_memcmp>
c0d017cc:	2800      	cmp	r0, #0
c0d017ce:	d1cc      	bne.n	c0d0176a <object_get_value+0x26>
c0d017d0:	e000      	b.n	c0d017d4 <object_get_value+0x90>
c0d017d2:	9c06      	ldr	r4, [sp, #24]
            }
        }
    }

    return -1;
}
c0d017d4:	b220      	sxth	r0, r4
c0d017d6:	b009      	add	sp, #36	; 0x24
c0d017d8:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d017da:	46c0      	nop			; (mov r8, r8)
c0d017dc:	0000ffff 	.word	0x0000ffff

c0d017e0 <os_boot>:
  //                ^ platform register
  return (try_context_t*) current_ctx->jmp_buf[5];
}

void try_context_set(try_context_t* ctx) {
  __asm volatile ("mov r9, %0"::"r"(ctx));
c0d017e0:	2000      	movs	r0, #0
c0d017e2:	4681      	mov	r9, r0

void os_boot(void) {
  // TODO patch entry point when romming (f)
  // set the default try context to nothing
  try_context_set(NULL);
}
c0d017e4:	4770      	bx	lr

c0d017e6 <try_context_set>:
  //                ^ platform register
  return (try_context_t*) current_ctx->jmp_buf[5];
}

void try_context_set(try_context_t* ctx) {
  __asm volatile ("mov r9, %0"::"r"(ctx));
c0d017e6:	4681      	mov	r9, r0
}
c0d017e8:	4770      	bx	lr
	...

c0d017ec <io_usb_hid_receive>:
volatile unsigned int   G_io_usb_hid_channel;
volatile unsigned int   G_io_usb_hid_remaining_length;
volatile unsigned int   G_io_usb_hid_sequence_number;
volatile unsigned char* G_io_usb_hid_current_buffer;

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
c0d017ec:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d017ee:	b081      	sub	sp, #4
c0d017f0:	9200      	str	r2, [sp, #0]
c0d017f2:	460f      	mov	r7, r1
c0d017f4:	4605      	mov	r5, r0
  // avoid over/under flows
  if (buffer != G_io_usb_ep_buffer) {
c0d017f6:	4b48      	ldr	r3, [pc, #288]	; (c0d01918 <io_usb_hid_receive+0x12c>)
c0d017f8:	429f      	cmp	r7, r3
c0d017fa:	d00f      	beq.n	c0d0181c <io_usb_hid_receive+0x30>
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d017fc:	4c46      	ldr	r4, [pc, #280]	; (c0d01918 <io_usb_hid_receive+0x12c>)
c0d017fe:	2640      	movs	r6, #64	; 0x40
c0d01800:	4620      	mov	r0, r4
c0d01802:	4631      	mov	r1, r6
c0d01804:	f004 fd48 	bl	c0d06298 <__aeabi_memclr>
c0d01808:	9800      	ldr	r0, [sp, #0]

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
  // avoid over/under flows
  if (buffer != G_io_usb_ep_buffer) {
    os_memset(G_io_usb_ep_buffer, 0, sizeof(G_io_usb_ep_buffer));
    os_memmove(G_io_usb_ep_buffer, buffer, MIN(l, sizeof(G_io_usb_ep_buffer)));
c0d0180a:	2840      	cmp	r0, #64	; 0x40
c0d0180c:	4602      	mov	r2, r0
c0d0180e:	d300      	bcc.n	c0d01812 <io_usb_hid_receive+0x26>
c0d01810:	4632      	mov	r2, r6
c0d01812:	4620      	mov	r0, r4
c0d01814:	4639      	mov	r1, r7
c0d01816:	f000 f89a 	bl	c0d0194e <os_memmove>
c0d0181a:	4b3f      	ldr	r3, [pc, #252]	; (c0d01918 <io_usb_hid_receive+0x12c>)
c0d0181c:	7898      	ldrb	r0, [r3, #2]
  }

  // process the chunk content
  switch(G_io_usb_ep_buffer[2]) {
c0d0181e:	2801      	cmp	r0, #1
c0d01820:	dc0b      	bgt.n	c0d0183a <io_usb_hid_receive+0x4e>
c0d01822:	2800      	cmp	r0, #0
c0d01824:	d02b      	beq.n	c0d0187e <io_usb_hid_receive+0x92>
c0d01826:	2801      	cmp	r0, #1
c0d01828:	d169      	bne.n	c0d018fe <io_usb_hid_receive+0x112>
    // await for the next chunk
    goto apdu_reset;

  case 0x01: // ALLOCATE CHANNEL
    // do not reset the current apdu reception if any
    cx_rng(G_io_usb_ep_buffer+3, 4);
c0d0182a:	1cd8      	adds	r0, r3, #3
c0d0182c:	2104      	movs	r1, #4
c0d0182e:	461c      	mov	r4, r3
c0d01830:	f001 fb66 	bl	c0d02f00 <cx_rng>
    // send the response
    sndfct(G_io_usb_ep_buffer, IO_HID_EP_LENGTH);
c0d01834:	2140      	movs	r1, #64	; 0x40
c0d01836:	4620      	mov	r0, r4
c0d01838:	e02c      	b.n	c0d01894 <io_usb_hid_receive+0xa8>
c0d0183a:	2802      	cmp	r0, #2
c0d0183c:	d028      	beq.n	c0d01890 <io_usb_hid_receive+0xa4>
c0d0183e:	2805      	cmp	r0, #5
c0d01840:	d15d      	bne.n	c0d018fe <io_usb_hid_receive+0x112>

  // process the chunk content
  switch(G_io_usb_ep_buffer[2]) {
  case 0x05:
    // ensure sequence idx is 0 for the first chunk ! 
    if ((unsigned int)U2BE(G_io_usb_ep_buffer, 3) != (unsigned int)G_io_usb_hid_sequence_number) {
c0d01842:	7918      	ldrb	r0, [r3, #4]
c0d01844:	78d9      	ldrb	r1, [r3, #3]
c0d01846:	0209      	lsls	r1, r1, #8
c0d01848:	4301      	orrs	r1, r0
c0d0184a:	4a34      	ldr	r2, [pc, #208]	; (c0d0191c <io_usb_hid_receive+0x130>)
c0d0184c:	6810      	ldr	r0, [r2, #0]
c0d0184e:	2400      	movs	r4, #0
c0d01850:	4281      	cmp	r1, r0
c0d01852:	d15a      	bne.n	c0d0190a <io_usb_hid_receive+0x11e>
c0d01854:	4e32      	ldr	r6, [pc, #200]	; (c0d01920 <io_usb_hid_receive+0x134>)
      // ignore packet
      goto apdu_reset;
    }
    // cid, tag, seq
    l -= 2+1+2;
c0d01856:	9800      	ldr	r0, [sp, #0]
c0d01858:	1980      	adds	r0, r0, r6
c0d0185a:	1f07      	subs	r7, r0, #4
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
c0d0185c:	6810      	ldr	r0, [r2, #0]
c0d0185e:	2800      	cmp	r0, #0
c0d01860:	d01b      	beq.n	c0d0189a <io_usb_hid_receive+0xae>
c0d01862:	4614      	mov	r4, r2
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_usb_ep_buffer+7, l);
    }
    else {
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (l > G_io_usb_hid_remaining_length) {
c0d01864:	4639      	mov	r1, r7
c0d01866:	4031      	ands	r1, r6
c0d01868:	482e      	ldr	r0, [pc, #184]	; (c0d01924 <io_usb_hid_receive+0x138>)
c0d0186a:	6802      	ldr	r2, [r0, #0]
c0d0186c:	4291      	cmp	r1, r2
c0d0186e:	d900      	bls.n	c0d01872 <io_usb_hid_receive+0x86>
        l = G_io_usb_hid_remaining_length;
c0d01870:	6807      	ldr	r7, [r0, #0]
      }

      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_usb_ep_buffer+5, l);
c0d01872:	463a      	mov	r2, r7
c0d01874:	4032      	ands	r2, r6
c0d01876:	482c      	ldr	r0, [pc, #176]	; (c0d01928 <io_usb_hid_receive+0x13c>)
c0d01878:	6800      	ldr	r0, [r0, #0]
c0d0187a:	1d59      	adds	r1, r3, #5
c0d0187c:	e031      	b.n	c0d018e2 <io_usb_hid_receive+0xf6>
c0d0187e:	2400      	movs	r4, #0
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d01880:	719c      	strb	r4, [r3, #6]
c0d01882:	715c      	strb	r4, [r3, #5]
c0d01884:	711c      	strb	r4, [r3, #4]
c0d01886:	70dc      	strb	r4, [r3, #3]

  case 0x00: // get version ID
    // do not reset the current apdu reception if any
    os_memset(G_io_usb_ep_buffer+3, 0, 4); // PROTOCOL VERSION is 0
    // send the response
    sndfct(G_io_usb_ep_buffer, IO_HID_EP_LENGTH);
c0d01888:	2140      	movs	r1, #64	; 0x40
c0d0188a:	4618      	mov	r0, r3
c0d0188c:	47a8      	blx	r5
c0d0188e:	e03c      	b.n	c0d0190a <io_usb_hid_receive+0x11e>
    goto apdu_reset;

  case 0x02: // ECHO|PING
    // do not reset the current apdu reception if any
    // send the response
    sndfct(G_io_usb_ep_buffer, IO_HID_EP_LENGTH);
c0d01890:	4821      	ldr	r0, [pc, #132]	; (c0d01918 <io_usb_hid_receive+0x12c>)
c0d01892:	2140      	movs	r1, #64	; 0x40
c0d01894:	47a8      	blx	r5
c0d01896:	2400      	movs	r4, #0
c0d01898:	e037      	b.n	c0d0190a <io_usb_hid_receive+0x11e>
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
      /// This is the apdu first chunk
      // total apdu size to receive
      G_io_usb_hid_total_length = U2BE(G_io_usb_ep_buffer, 5); //(G_io_usb_ep_buffer[5]<<8)+(G_io_usb_ep_buffer[6]&0xFF);
c0d0189a:	7998      	ldrb	r0, [r3, #6]
c0d0189c:	7959      	ldrb	r1, [r3, #5]
c0d0189e:	0209      	lsls	r1, r1, #8
c0d018a0:	4301      	orrs	r1, r0
c0d018a2:	4822      	ldr	r0, [pc, #136]	; (c0d0192c <io_usb_hid_receive+0x140>)
c0d018a4:	6001      	str	r1, [r0, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
c0d018a6:	6801      	ldr	r1, [r0, #0]
c0d018a8:	0849      	lsrs	r1, r1, #1
c0d018aa:	29a8      	cmp	r1, #168	; 0xa8
c0d018ac:	d82d      	bhi.n	c0d0190a <io_usb_hid_receive+0x11e>
c0d018ae:	4614      	mov	r4, r2
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
c0d018b0:	6801      	ldr	r1, [r0, #0]
c0d018b2:	481c      	ldr	r0, [pc, #112]	; (c0d01924 <io_usb_hid_receive+0x138>)
c0d018b4:	6001      	str	r1, [r0, #0]
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d018b6:	491c      	ldr	r1, [pc, #112]	; (c0d01928 <io_usb_hid_receive+0x13c>)
c0d018b8:	4a1d      	ldr	r2, [pc, #116]	; (c0d01930 <io_usb_hid_receive+0x144>)
c0d018ba:	600a      	str	r2, [r1, #0]

      // retain the channel id to use for the reply
      G_io_usb_hid_channel = U2BE(G_io_usb_ep_buffer, 0);
c0d018bc:	7859      	ldrb	r1, [r3, #1]
c0d018be:	781a      	ldrb	r2, [r3, #0]
c0d018c0:	0212      	lsls	r2, r2, #8
c0d018c2:	430a      	orrs	r2, r1
c0d018c4:	491b      	ldr	r1, [pc, #108]	; (c0d01934 <io_usb_hid_receive+0x148>)
c0d018c6:	600a      	str	r2, [r1, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
c0d018c8:	491b      	ldr	r1, [pc, #108]	; (c0d01938 <io_usb_hid_receive+0x14c>)
c0d018ca:	9a00      	ldr	r2, [sp, #0]
c0d018cc:	1857      	adds	r7, r2, r1
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;

      // retain the channel id to use for the reply
      G_io_usb_hid_channel = U2BE(G_io_usb_ep_buffer, 0);

      if (l > G_io_usb_hid_remaining_length) {
c0d018ce:	4639      	mov	r1, r7
c0d018d0:	4031      	ands	r1, r6
c0d018d2:	6802      	ldr	r2, [r0, #0]
c0d018d4:	4291      	cmp	r1, r2
c0d018d6:	d900      	bls.n	c0d018da <io_usb_hid_receive+0xee>
        l = G_io_usb_hid_remaining_length;
c0d018d8:	6807      	ldr	r7, [r0, #0]
      }
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_usb_ep_buffer+7, l);
c0d018da:	463a      	mov	r2, r7
c0d018dc:	4032      	ands	r2, r6
c0d018de:	1dd9      	adds	r1, r3, #7
c0d018e0:	4813      	ldr	r0, [pc, #76]	; (c0d01930 <io_usb_hid_receive+0x144>)
c0d018e2:	f000 f834 	bl	c0d0194e <os_memmove>
      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_usb_ep_buffer+5, l);
    }
    // factorize (f)
    G_io_usb_hid_current_buffer += l;
c0d018e6:	4037      	ands	r7, r6
c0d018e8:	480f      	ldr	r0, [pc, #60]	; (c0d01928 <io_usb_hid_receive+0x13c>)
c0d018ea:	6801      	ldr	r1, [r0, #0]
c0d018ec:	19c9      	adds	r1, r1, r7
c0d018ee:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_remaining_length -= l;
c0d018f0:	480c      	ldr	r0, [pc, #48]	; (c0d01924 <io_usb_hid_receive+0x138>)
c0d018f2:	6801      	ldr	r1, [r0, #0]
c0d018f4:	1bc9      	subs	r1, r1, r7
c0d018f6:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_sequence_number++;
c0d018f8:	6820      	ldr	r0, [r4, #0]
c0d018fa:	1c40      	adds	r0, r0, #1
c0d018fc:	6020      	str	r0, [r4, #0]
    // await for the next chunk
    goto apdu_reset;
  }

  // if more data to be received, notify it
  if (G_io_usb_hid_remaining_length) {
c0d018fe:	4809      	ldr	r0, [pc, #36]	; (c0d01924 <io_usb_hid_receive+0x138>)
c0d01900:	6801      	ldr	r1, [r0, #0]
c0d01902:	2001      	movs	r0, #1
c0d01904:	2402      	movs	r4, #2
c0d01906:	2900      	cmp	r1, #0
c0d01908:	d103      	bne.n	c0d01912 <io_usb_hid_receive+0x126>
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d0190a:	4804      	ldr	r0, [pc, #16]	; (c0d0191c <io_usb_hid_receive+0x130>)
c0d0190c:	2100      	movs	r1, #0
c0d0190e:	6001      	str	r1, [r0, #0]
c0d01910:	4620      	mov	r0, r4
  return IO_USB_APDU_RECEIVED;

apdu_reset:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}
c0d01912:	b2c0      	uxtb	r0, r0
c0d01914:	b001      	add	sp, #4
c0d01916:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01918:	20001b38 	.word	0x20001b38
c0d0191c:	20001918 	.word	0x20001918
c0d01920:	0000ffff 	.word	0x0000ffff
c0d01924:	20001920 	.word	0x20001920
c0d01928:	20001a78 	.word	0x20001a78
c0d0192c:	2000191c 	.word	0x2000191c
c0d01930:	20001924 	.word	0x20001924
c0d01934:	20001a7c 	.word	0x20001a7c
c0d01938:	0001fff9 	.word	0x0001fff9

c0d0193c <os_memset>:
    }
  }
#undef DSTCHAR
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
c0d0193c:	b580      	push	{r7, lr}
c0d0193e:	460b      	mov	r3, r1
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
c0d01940:	2a00      	cmp	r2, #0
c0d01942:	d003      	beq.n	c0d0194c <os_memset+0x10>
    DSTCHAR[length] = c;
c0d01944:	4611      	mov	r1, r2
c0d01946:	461a      	mov	r2, r3
c0d01948:	f004 fcb0 	bl	c0d062ac <__aeabi_memset>
  }
#undef DSTCHAR
}
c0d0194c:	bd80      	pop	{r7, pc}

c0d0194e <os_memmove>:
  }
}

#endif // HAVE_USB_APDU

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
c0d0194e:	b5b0      	push	{r4, r5, r7, lr}
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
c0d01950:	4288      	cmp	r0, r1
c0d01952:	d90d      	bls.n	c0d01970 <os_memmove+0x22>
    while(length--) {
c0d01954:	2a00      	cmp	r2, #0
c0d01956:	d014      	beq.n	c0d01982 <os_memmove+0x34>
c0d01958:	1e49      	subs	r1, r1, #1
c0d0195a:	4252      	negs	r2, r2
c0d0195c:	1e40      	subs	r0, r0, #1
c0d0195e:	2300      	movs	r3, #0
c0d01960:	43db      	mvns	r3, r3
      DSTCHAR[length] = SRCCHAR[length];
c0d01962:	461c      	mov	r4, r3
c0d01964:	4354      	muls	r4, r2
c0d01966:	5d0d      	ldrb	r5, [r1, r4]
c0d01968:	5505      	strb	r5, [r0, r4]

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
    while(length--) {
c0d0196a:	1c52      	adds	r2, r2, #1
c0d0196c:	d1f9      	bne.n	c0d01962 <os_memmove+0x14>
c0d0196e:	e008      	b.n	c0d01982 <os_memmove+0x34>
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d01970:	2a00      	cmp	r2, #0
c0d01972:	d006      	beq.n	c0d01982 <os_memmove+0x34>
c0d01974:	2300      	movs	r3, #0
      DSTCHAR[l] = SRCCHAR[l];
c0d01976:	b29c      	uxth	r4, r3
c0d01978:	5d0d      	ldrb	r5, [r1, r4]
c0d0197a:	5505      	strb	r5, [r0, r4]
      l++;
c0d0197c:	1c5b      	adds	r3, r3, #1
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d0197e:	1e52      	subs	r2, r2, #1
c0d01980:	d1f9      	bne.n	c0d01976 <os_memmove+0x28>
      DSTCHAR[l] = SRCCHAR[l];
      l++;
    }
  }
#undef DSTCHAR
}
c0d01982:	bdb0      	pop	{r4, r5, r7, pc}

c0d01984 <io_usb_hid_init>:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d01984:	4801      	ldr	r0, [pc, #4]	; (c0d0198c <io_usb_hid_init+0x8>)
c0d01986:	2100      	movs	r1, #0
c0d01988:	6001      	str	r1, [r0, #0]
  //G_io_usb_hid_remaining_length = 0; // not really needed
  //G_io_usb_hid_total_length = 0; // not really needed
  //G_io_usb_hid_current_buffer = G_io_apdu_buffer; // not really needed
}
c0d0198a:	4770      	bx	lr
c0d0198c:	20001918 	.word	0x20001918

c0d01990 <io_usb_hid_sent>:

/**
 * sent the next io_usb_hid transport chunk (rx on the host, tx on the device)
 */
void io_usb_hid_sent(io_send_t sndfct) {
c0d01990:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01992:	b081      	sub	sp, #4
  unsigned int l;

  // only prepare next chunk if some data to be sent remain
  if (G_io_usb_hid_remaining_length) {
c0d01994:	4f29      	ldr	r7, [pc, #164]	; (c0d01a3c <io_usb_hid_sent+0xac>)
c0d01996:	6839      	ldr	r1, [r7, #0]
c0d01998:	2900      	cmp	r1, #0
c0d0199a:	d026      	beq.n	c0d019ea <io_usb_hid_sent+0x5a>
c0d0199c:	9000      	str	r0, [sp, #0]
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d0199e:	4c28      	ldr	r4, [pc, #160]	; (c0d01a40 <io_usb_hid_sent+0xb0>)
c0d019a0:	1d66      	adds	r6, r4, #5
c0d019a2:	2539      	movs	r5, #57	; 0x39
c0d019a4:	4630      	mov	r0, r6
c0d019a6:	4629      	mov	r1, r5
c0d019a8:	f004 fc76 	bl	c0d06298 <__aeabi_memclr>
  if (G_io_usb_hid_remaining_length) {
    // fill the chunk
    os_memset(G_io_usb_ep_buffer, 0, IO_HID_EP_LENGTH-2);

    // keep the channel identifier
    G_io_usb_ep_buffer[0] = (G_io_usb_hid_channel>>8)&0xFF;
c0d019ac:	4825      	ldr	r0, [pc, #148]	; (c0d01a44 <io_usb_hid_sent+0xb4>)
c0d019ae:	6801      	ldr	r1, [r0, #0]
c0d019b0:	0a09      	lsrs	r1, r1, #8
c0d019b2:	7021      	strb	r1, [r4, #0]
    G_io_usb_ep_buffer[1] = G_io_usb_hid_channel&0xFF;
c0d019b4:	6800      	ldr	r0, [r0, #0]
c0d019b6:	7060      	strb	r0, [r4, #1]
c0d019b8:	2005      	movs	r0, #5
    G_io_usb_ep_buffer[2] = 0x05;
c0d019ba:	70a0      	strb	r0, [r4, #2]
    G_io_usb_ep_buffer[3] = G_io_usb_hid_sequence_number>>8;
c0d019bc:	4a22      	ldr	r2, [pc, #136]	; (c0d01a48 <io_usb_hid_sent+0xb8>)
c0d019be:	6810      	ldr	r0, [r2, #0]
c0d019c0:	0a00      	lsrs	r0, r0, #8
c0d019c2:	70e0      	strb	r0, [r4, #3]
    G_io_usb_ep_buffer[4] = G_io_usb_hid_sequence_number;
c0d019c4:	6810      	ldr	r0, [r2, #0]
c0d019c6:	7120      	strb	r0, [r4, #4]

    if (G_io_usb_hid_sequence_number == 0) {
c0d019c8:	6811      	ldr	r1, [r2, #0]
c0d019ca:	6838      	ldr	r0, [r7, #0]
c0d019cc:	2900      	cmp	r1, #0
c0d019ce:	d014      	beq.n	c0d019fa <io_usb_hid_sent+0x6a>
c0d019d0:	4614      	mov	r4, r2
c0d019d2:	253b      	movs	r5, #59	; 0x3b
      G_io_usb_hid_current_buffer += l;
      G_io_usb_hid_remaining_length -= l;
      l += 7;
    }
    else {
      l = ((G_io_usb_hid_remaining_length>IO_HID_EP_LENGTH-5) ? IO_HID_EP_LENGTH-5 : G_io_usb_hid_remaining_length);
c0d019d4:	283b      	cmp	r0, #59	; 0x3b
c0d019d6:	d800      	bhi.n	c0d019da <io_usb_hid_sent+0x4a>
c0d019d8:	683d      	ldr	r5, [r7, #0]
      os_memmove(G_io_usb_ep_buffer+5, (const void*)G_io_usb_hid_current_buffer, l);
c0d019da:	481c      	ldr	r0, [pc, #112]	; (c0d01a4c <io_usb_hid_sent+0xbc>)
c0d019dc:	6801      	ldr	r1, [r0, #0]
c0d019de:	4630      	mov	r0, r6
c0d019e0:	462a      	mov	r2, r5
c0d019e2:	f7ff ffb4 	bl	c0d0194e <os_memmove>
c0d019e6:	9a00      	ldr	r2, [sp, #0]
c0d019e8:	e018      	b.n	c0d01a1c <io_usb_hid_sent+0x8c>
    // always pad :)
    sndfct(G_io_usb_ep_buffer, sizeof(G_io_usb_ep_buffer));
  }
  // cleanup when everything has been sent (ack for the last sent usb in packet)
  else {
    G_io_usb_hid_sequence_number = 0; 
c0d019ea:	4817      	ldr	r0, [pc, #92]	; (c0d01a48 <io_usb_hid_sent+0xb8>)
c0d019ec:	2100      	movs	r1, #0
c0d019ee:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_current_buffer = NULL;
c0d019f0:	4816      	ldr	r0, [pc, #88]	; (c0d01a4c <io_usb_hid_sent+0xbc>)
c0d019f2:	6001      	str	r1, [r0, #0]

    // we sent the whole response
    G_io_apdu_state = APDU_IDLE;
c0d019f4:	4816      	ldr	r0, [pc, #88]	; (c0d01a50 <io_usb_hid_sent+0xc0>)
c0d019f6:	7001      	strb	r1, [r0, #0]
c0d019f8:	e01d      	b.n	c0d01a36 <io_usb_hid_sent+0xa6>
c0d019fa:	4616      	mov	r6, r2
    G_io_usb_ep_buffer[2] = 0x05;
    G_io_usb_ep_buffer[3] = G_io_usb_hid_sequence_number>>8;
    G_io_usb_ep_buffer[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((G_io_usb_hid_remaining_length>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : G_io_usb_hid_remaining_length);
c0d019fc:	2839      	cmp	r0, #57	; 0x39
c0d019fe:	d800      	bhi.n	c0d01a02 <io_usb_hid_sent+0x72>
c0d01a00:	683d      	ldr	r5, [r7, #0]
      G_io_usb_ep_buffer[5] = G_io_usb_hid_remaining_length>>8;
c0d01a02:	6838      	ldr	r0, [r7, #0]
c0d01a04:	0a00      	lsrs	r0, r0, #8
c0d01a06:	7160      	strb	r0, [r4, #5]
      G_io_usb_ep_buffer[6] = G_io_usb_hid_remaining_length;
c0d01a08:	6838      	ldr	r0, [r7, #0]
c0d01a0a:	71a0      	strb	r0, [r4, #6]
      os_memmove(G_io_usb_ep_buffer+7, (const void*)G_io_usb_hid_current_buffer, l);
c0d01a0c:	480f      	ldr	r0, [pc, #60]	; (c0d01a4c <io_usb_hid_sent+0xbc>)
c0d01a0e:	6801      	ldr	r1, [r0, #0]
c0d01a10:	1de0      	adds	r0, r4, #7
c0d01a12:	462a      	mov	r2, r5
c0d01a14:	f7ff ff9b 	bl	c0d0194e <os_memmove>
c0d01a18:	9a00      	ldr	r2, [sp, #0]
c0d01a1a:	4634      	mov	r4, r6
c0d01a1c:	480b      	ldr	r0, [pc, #44]	; (c0d01a4c <io_usb_hid_sent+0xbc>)
c0d01a1e:	6801      	ldr	r1, [r0, #0]
c0d01a20:	1949      	adds	r1, r1, r5
c0d01a22:	6001      	str	r1, [r0, #0]
c0d01a24:	6838      	ldr	r0, [r7, #0]
c0d01a26:	1b40      	subs	r0, r0, r5
c0d01a28:	6038      	str	r0, [r7, #0]
      G_io_usb_hid_current_buffer += l;
      G_io_usb_hid_remaining_length -= l;
      l += 5;
    }
    // prepare next chunk numbering
    G_io_usb_hid_sequence_number++;
c0d01a2a:	6820      	ldr	r0, [r4, #0]
c0d01a2c:	1c40      	adds	r0, r0, #1
c0d01a2e:	6020      	str	r0, [r4, #0]
    // send the chunk
    // always pad :)
    sndfct(G_io_usb_ep_buffer, sizeof(G_io_usb_ep_buffer));
c0d01a30:	4803      	ldr	r0, [pc, #12]	; (c0d01a40 <io_usb_hid_sent+0xb0>)
c0d01a32:	2140      	movs	r1, #64	; 0x40
c0d01a34:	4790      	blx	r2
    G_io_usb_hid_current_buffer = NULL;

    // we sent the whole response
    G_io_apdu_state = APDU_IDLE;
  }
}
c0d01a36:	b001      	add	sp, #4
c0d01a38:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01a3a:	46c0      	nop			; (mov r8, r8)
c0d01a3c:	20001920 	.word	0x20001920
c0d01a40:	20001b38 	.word	0x20001b38
c0d01a44:	20001a7c 	.word	0x20001a7c
c0d01a48:	20001918 	.word	0x20001918
c0d01a4c:	20001a78 	.word	0x20001a78
c0d01a50:	20001a96 	.word	0x20001a96

c0d01a54 <io_usb_hid_send>:

void io_usb_hid_send(io_send_t sndfct, unsigned short sndlength) {
c0d01a54:	b580      	push	{r7, lr}
  // perform send
  if (sndlength) {
c0d01a56:	2900      	cmp	r1, #0
c0d01a58:	d00b      	beq.n	c0d01a72 <io_usb_hid_send+0x1e>
    G_io_usb_hid_sequence_number = 0; 
c0d01a5a:	4a06      	ldr	r2, [pc, #24]	; (c0d01a74 <io_usb_hid_send+0x20>)
c0d01a5c:	2300      	movs	r3, #0
c0d01a5e:	6013      	str	r3, [r2, #0]
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d01a60:	4a05      	ldr	r2, [pc, #20]	; (c0d01a78 <io_usb_hid_send+0x24>)
c0d01a62:	4b06      	ldr	r3, [pc, #24]	; (c0d01a7c <io_usb_hid_send+0x28>)
c0d01a64:	6013      	str	r3, [r2, #0]
    G_io_usb_hid_remaining_length = sndlength;
c0d01a66:	4a06      	ldr	r2, [pc, #24]	; (c0d01a80 <io_usb_hid_send+0x2c>)
c0d01a68:	6011      	str	r1, [r2, #0]
    G_io_usb_hid_total_length = sndlength;
c0d01a6a:	4a06      	ldr	r2, [pc, #24]	; (c0d01a84 <io_usb_hid_send+0x30>)
c0d01a6c:	6011      	str	r1, [r2, #0]
    io_usb_hid_sent(sndfct);
c0d01a6e:	f7ff ff8f 	bl	c0d01990 <io_usb_hid_sent>
  }
}
c0d01a72:	bd80      	pop	{r7, pc}
c0d01a74:	20001918 	.word	0x20001918
c0d01a78:	20001a78 	.word	0x20001a78
c0d01a7c:	20001924 	.word	0x20001924
c0d01a80:	20001920 	.word	0x20001920
c0d01a84:	2000191c 	.word	0x2000191c

c0d01a88 <os_memcmp>:
    DSTCHAR[length] = c;
  }
#undef DSTCHAR
}

char os_memcmp(const void WIDE * buf1, const void WIDE * buf2, unsigned int length) {
c0d01a88:	b570      	push	{r4, r5, r6, lr}
#define BUF1 ((unsigned char const WIDE *)buf1)
#define BUF2 ((unsigned char const WIDE *)buf2)
  while(length--) {
c0d01a8a:	1e43      	subs	r3, r0, #1
c0d01a8c:	1e49      	subs	r1, r1, #1
c0d01a8e:	4252      	negs	r2, r2
c0d01a90:	2000      	movs	r0, #0
c0d01a92:	43c4      	mvns	r4, r0
c0d01a94:	2a00      	cmp	r2, #0
c0d01a96:	d00c      	beq.n	c0d01ab2 <os_memcmp+0x2a>
    if (BUF1[length] != BUF2[length]) {
c0d01a98:	4626      	mov	r6, r4
c0d01a9a:	4356      	muls	r6, r2
c0d01a9c:	5d8d      	ldrb	r5, [r1, r6]
c0d01a9e:	5d9e      	ldrb	r6, [r3, r6]
c0d01aa0:	1c52      	adds	r2, r2, #1
c0d01aa2:	42ae      	cmp	r6, r5
c0d01aa4:	d0f6      	beq.n	c0d01a94 <os_memcmp+0xc>
      return (BUF1[length] > BUF2[length])? 1:-1;
c0d01aa6:	2000      	movs	r0, #0
c0d01aa8:	43c1      	mvns	r1, r0
c0d01aaa:	2001      	movs	r0, #1
c0d01aac:	42ae      	cmp	r6, r5
c0d01aae:	d800      	bhi.n	c0d01ab2 <os_memcmp+0x2a>
c0d01ab0:	4608      	mov	r0, r1
  }
  return 0;
#undef BUF1
#undef BUF2

}
c0d01ab2:	b2c0      	uxtb	r0, r0
c0d01ab4:	bd70      	pop	{r4, r5, r6, pc}

c0d01ab6 <os_longjmp>:
void try_context_set(try_context_t* ctx) {
  __asm volatile ("mov r9, %0"::"r"(ctx));
}

#ifndef HAVE_BOLOS
void os_longjmp(unsigned int exception) {
c0d01ab6:	b580      	push	{r7, lr}
c0d01ab8:	4601      	mov	r1, r0
  return xoracc;
}

try_context_t* try_context_get(void) {
  try_context_t* current_ctx;
  __asm volatile ("mov %0, r9":"=r"(current_ctx));
c0d01aba:	4648      	mov	r0, r9
  __asm volatile ("mov r9, %0"::"r"(ctx));
}

#ifndef HAVE_BOLOS
void os_longjmp(unsigned int exception) {
  longjmp(try_context_get()->jmp_buf, exception);
c0d01abc:	f004 fc8e 	bl	c0d063dc <longjmp>

c0d01ac0 <try_context_get>:
  return xoracc;
}

try_context_t* try_context_get(void) {
  try_context_t* current_ctx;
  __asm volatile ("mov %0, r9":"=r"(current_ctx));
c0d01ac0:	4648      	mov	r0, r9
  return current_ctx;
c0d01ac2:	4770      	bx	lr

c0d01ac4 <try_context_get_previous>:
}

try_context_t* try_context_get_previous(void) {
c0d01ac4:	2000      	movs	r0, #0
  try_context_t* current_ctx;
  __asm volatile ("mov %0, r9":"=r"(current_ctx));
c0d01ac6:	4649      	mov	r1, r9

  // first context reached ?
  if (current_ctx == NULL) {
c0d01ac8:	2900      	cmp	r1, #0
c0d01aca:	d000      	beq.n	c0d01ace <try_context_get_previous+0xa>
  }

  // return r9 content saved on the current context. It links to the previous context.
  // r4 r5 r6 r7 r8 r9 r10 r11 sp lr
  //                ^ platform register
  return (try_context_t*) current_ctx->jmp_buf[5];
c0d01acc:	6948      	ldr	r0, [r1, #20]
}
c0d01ace:	4770      	bx	lr

c0d01ad0 <io_seproxyhal_general_status>:

#ifndef IO_RAPDU_TRANSMIT_TIMEOUT_MS 
#define IO_RAPDU_TRANSMIT_TIMEOUT_MS 2000UL
#endif // IO_RAPDU_TRANSMIT_TIMEOUT_MS

void io_seproxyhal_general_status(void) {
c0d01ad0:	b580      	push	{r7, lr}
  // avoid troubles
  if (io_seproxyhal_spi_is_status_sent()) {
c0d01ad2:	f001 fbaf 	bl	c0d03234 <io_seproxyhal_spi_is_status_sent>
c0d01ad6:	2800      	cmp	r0, #0
c0d01ad8:	d10b      	bne.n	c0d01af2 <io_seproxyhal_general_status+0x22>
    return;
  }
  // send the general status
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_GENERAL_STATUS;
c0d01ada:	4806      	ldr	r0, [pc, #24]	; (c0d01af4 <io_seproxyhal_general_status+0x24>)
c0d01adc:	2160      	movs	r1, #96	; 0x60
c0d01ade:	7001      	strb	r1, [r0, #0]
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d01ae0:	2100      	movs	r1, #0
c0d01ae2:	7041      	strb	r1, [r0, #1]
  G_io_seproxyhal_spi_buffer[2] = 2;
c0d01ae4:	2202      	movs	r2, #2
c0d01ae6:	7082      	strb	r2, [r0, #2]
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND>>8;
c0d01ae8:	70c1      	strb	r1, [r0, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND;
c0d01aea:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
c0d01aec:	2105      	movs	r1, #5
c0d01aee:	f001 fb8b 	bl	c0d03208 <io_seproxyhal_spi_send>
}
c0d01af2:	bd80      	pop	{r7, pc}
c0d01af4:	20001800 	.word	0x20001800

c0d01af8 <io_seproxyhal_handle_usb_event>:
} G_io_usb_ep_timeouts[IO_USB_MAX_ENDPOINTS];
#include "usbd_def.h"
#include "usbd_core.h"
extern USBD_HandleTypeDef USBD_Device;

void io_seproxyhal_handle_usb_event(void) {
c0d01af8:	b510      	push	{r4, lr}
  switch(G_io_seproxyhal_spi_buffer[3]) {
c0d01afa:	4819      	ldr	r0, [pc, #100]	; (c0d01b60 <io_seproxyhal_handle_usb_event+0x68>)
c0d01afc:	78c0      	ldrb	r0, [r0, #3]
c0d01afe:	2803      	cmp	r0, #3
c0d01b00:	dc07      	bgt.n	c0d01b12 <io_seproxyhal_handle_usb_event+0x1a>
c0d01b02:	2801      	cmp	r0, #1
c0d01b04:	d00d      	beq.n	c0d01b22 <io_seproxyhal_handle_usb_event+0x2a>
c0d01b06:	2802      	cmp	r0, #2
c0d01b08:	d126      	bne.n	c0d01b58 <io_seproxyhal_handle_usb_event+0x60>
      }
      os_memset(G_io_usb_ep_xfer_len, 0, sizeof(G_io_usb_ep_xfer_len));
      os_memset(G_io_usb_ep_timeouts, 0, sizeof(G_io_usb_ep_timeouts));
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
c0d01b0a:	4816      	ldr	r0, [pc, #88]	; (c0d01b64 <io_seproxyhal_handle_usb_event+0x6c>)
c0d01b0c:	f003 f801 	bl	c0d04b12 <USBD_LL_SOF>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d01b10:	bd10      	pop	{r4, pc}
c0d01b12:	2804      	cmp	r0, #4
c0d01b14:	d01d      	beq.n	c0d01b52 <io_seproxyhal_handle_usb_event+0x5a>
c0d01b16:	2808      	cmp	r0, #8
c0d01b18:	d11e      	bne.n	c0d01b58 <io_seproxyhal_handle_usb_event+0x60>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
c0d01b1a:	4812      	ldr	r0, [pc, #72]	; (c0d01b64 <io_seproxyhal_handle_usb_event+0x6c>)
c0d01b1c:	f002 fff7 	bl	c0d04b0e <USBD_LL_Resume>
      break;
  }
}
c0d01b20:	bd10      	pop	{r4, pc}
extern USBD_HandleTypeDef USBD_Device;

void io_seproxyhal_handle_usb_event(void) {
  switch(G_io_seproxyhal_spi_buffer[3]) {
    case SEPROXYHAL_TAG_USB_EVENT_RESET:
      USBD_LL_SetSpeed(&USBD_Device, USBD_SPEED_FULL);  
c0d01b22:	4c10      	ldr	r4, [pc, #64]	; (c0d01b64 <io_seproxyhal_handle_usb_event+0x6c>)
c0d01b24:	2101      	movs	r1, #1
c0d01b26:	4620      	mov	r0, r4
c0d01b28:	f002 ffec 	bl	c0d04b04 <USBD_LL_SetSpeed>
      USBD_LL_Reset(&USBD_Device);
c0d01b2c:	4620      	mov	r0, r4
c0d01b2e:	f002 ffc8 	bl	c0d04ac2 <USBD_LL_Reset>
      // ongoing APDU detected, throw a reset, even if not the media. to avoid potential troubles.
      if (G_io_apdu_media != IO_APDU_MEDIA_NONE) {
c0d01b32:	480d      	ldr	r0, [pc, #52]	; (c0d01b68 <io_seproxyhal_handle_usb_event+0x70>)
c0d01b34:	7800      	ldrb	r0, [r0, #0]
c0d01b36:	2800      	cmp	r0, #0
c0d01b38:	d10f      	bne.n	c0d01b5a <io_seproxyhal_handle_usb_event+0x62>
        THROW(EXCEPTION_IO_RESET);
      }
      os_memset(G_io_usb_ep_xfer_len, 0, sizeof(G_io_usb_ep_xfer_len));
c0d01b3a:	480c      	ldr	r0, [pc, #48]	; (c0d01b6c <io_seproxyhal_handle_usb_event+0x74>)
c0d01b3c:	2400      	movs	r4, #0
c0d01b3e:	2207      	movs	r2, #7
c0d01b40:	4621      	mov	r1, r4
c0d01b42:	f7ff fefb 	bl	c0d0193c <os_memset>
      os_memset(G_io_usb_ep_timeouts, 0, sizeof(G_io_usb_ep_timeouts));
c0d01b46:	480a      	ldr	r0, [pc, #40]	; (c0d01b70 <io_seproxyhal_handle_usb_event+0x78>)
c0d01b48:	220e      	movs	r2, #14
c0d01b4a:	4621      	mov	r1, r4
c0d01b4c:	f7ff fef6 	bl	c0d0193c <os_memset>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d01b50:	bd10      	pop	{r4, pc}
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
c0d01b52:	4804      	ldr	r0, [pc, #16]	; (c0d01b64 <io_seproxyhal_handle_usb_event+0x6c>)
c0d01b54:	f002 ffd9 	bl	c0d04b0a <USBD_LL_Suspend>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d01b58:	bd10      	pop	{r4, pc}
    case SEPROXYHAL_TAG_USB_EVENT_RESET:
      USBD_LL_SetSpeed(&USBD_Device, USBD_SPEED_FULL);  
      USBD_LL_Reset(&USBD_Device);
      // ongoing APDU detected, throw a reset, even if not the media. to avoid potential troubles.
      if (G_io_apdu_media != IO_APDU_MEDIA_NONE) {
        THROW(EXCEPTION_IO_RESET);
c0d01b5a:	2010      	movs	r0, #16
c0d01b5c:	f7ff ffab 	bl	c0d01ab6 <os_longjmp>
c0d01b60:	20001800 	.word	0x20001800
c0d01b64:	20002160 	.word	0x20002160
c0d01b68:	20001a80 	.word	0x20001a80
c0d01b6c:	20001a81 	.word	0x20001a81
c0d01b70:	20001a88 	.word	0x20001a88

c0d01b74 <io_seproxyhal_get_ep_rx_size>:
      break;
  }
}

uint16_t io_seproxyhal_get_ep_rx_size(uint8_t epnum) {
  return G_io_usb_ep_xfer_len[epnum&0x7F];
c0d01b74:	217f      	movs	r1, #127	; 0x7f
c0d01b76:	4001      	ands	r1, r0
c0d01b78:	4801      	ldr	r0, [pc, #4]	; (c0d01b80 <io_seproxyhal_get_ep_rx_size+0xc>)
c0d01b7a:	5c40      	ldrb	r0, [r0, r1]
c0d01b7c:	4770      	bx	lr
c0d01b7e:	46c0      	nop			; (mov r8, r8)
c0d01b80:	20001a81 	.word	0x20001a81

c0d01b84 <io_seproxyhal_handle_usb_ep_xfer_event>:
}

void io_seproxyhal_handle_usb_ep_xfer_event(void) {
c0d01b84:	b510      	push	{r4, lr}
  switch(G_io_seproxyhal_spi_buffer[4]) {
c0d01b86:	4815      	ldr	r0, [pc, #84]	; (c0d01bdc <io_seproxyhal_handle_usb_ep_xfer_event+0x58>)
c0d01b88:	7901      	ldrb	r1, [r0, #4]
c0d01b8a:	2904      	cmp	r1, #4
c0d01b8c:	d017      	beq.n	c0d01bbe <io_seproxyhal_handle_usb_ep_xfer_event+0x3a>
c0d01b8e:	2902      	cmp	r1, #2
c0d01b90:	d006      	beq.n	c0d01ba0 <io_seproxyhal_handle_usb_ep_xfer_event+0x1c>
c0d01b92:	2901      	cmp	r1, #1
c0d01b94:	d120      	bne.n	c0d01bd8 <io_seproxyhal_handle_usb_ep_xfer_event+0x54>
    /* This event is received when a new SETUP token had been received on a control endpoint */
    case SEPROXYHAL_TAG_USB_EP_XFER_SETUP:
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
c0d01b96:	1d81      	adds	r1, r0, #6
c0d01b98:	4812      	ldr	r0, [pc, #72]	; (c0d01be4 <io_seproxyhal_handle_usb_ep_xfer_event+0x60>)
c0d01b9a:	f002 fe8b 	bl	c0d048b4 <USBD_LL_SetupStage>
        // prepare reception
        USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      }
      break;
  }
}
c0d01b9e:	bd10      	pop	{r4, pc}
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
      break;

    /* This event is received after the prepare data packet has been flushed to the usb host */
    case SEPROXYHAL_TAG_USB_EP_XFER_IN:
      if ((G_io_seproxyhal_spi_buffer[3]&0x7F) < IO_USB_MAX_ENDPOINTS) {
c0d01ba0:	78c2      	ldrb	r2, [r0, #3]
c0d01ba2:	217f      	movs	r1, #127	; 0x7f
c0d01ba4:	4011      	ands	r1, r2
c0d01ba6:	2906      	cmp	r1, #6
c0d01ba8:	d816      	bhi.n	c0d01bd8 <io_seproxyhal_handle_usb_ep_xfer_event+0x54>
c0d01baa:	b2c9      	uxtb	r1, r1
        // discard ep timeout as we received the sent packet confirmation
        G_io_usb_ep_timeouts[G_io_seproxyhal_spi_buffer[3]&0x7F].timeout = 0;
c0d01bac:	004a      	lsls	r2, r1, #1
c0d01bae:	4b0e      	ldr	r3, [pc, #56]	; (c0d01be8 <io_seproxyhal_handle_usb_ep_xfer_event+0x64>)
c0d01bb0:	2400      	movs	r4, #0
c0d01bb2:	529c      	strh	r4, [r3, r2]
        // propagate sending ack of the data
        USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d01bb4:	1d82      	adds	r2, r0, #6
c0d01bb6:	480b      	ldr	r0, [pc, #44]	; (c0d01be4 <io_seproxyhal_handle_usb_ep_xfer_event+0x60>)
c0d01bb8:	f002 ff0a 	bl	c0d049d0 <USBD_LL_DataInStage>
        // prepare reception
        USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      }
      break;
  }
}
c0d01bbc:	bd10      	pop	{r4, pc}
      }
      break;

    /* This event is received when a new DATA token is received on an endpoint */
    case SEPROXYHAL_TAG_USB_EP_XFER_OUT:
      if ((G_io_seproxyhal_spi_buffer[3]&0x7F) < IO_USB_MAX_ENDPOINTS) {
c0d01bbe:	78c2      	ldrb	r2, [r0, #3]
c0d01bc0:	217f      	movs	r1, #127	; 0x7f
c0d01bc2:	4011      	ands	r1, r2
c0d01bc4:	2906      	cmp	r1, #6
c0d01bc6:	d807      	bhi.n	c0d01bd8 <io_seproxyhal_handle_usb_ep_xfer_event+0x54>
        // saved just in case it is needed ...
        G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
c0d01bc8:	7942      	ldrb	r2, [r0, #5]
      }
      break;

    /* This event is received when a new DATA token is received on an endpoint */
    case SEPROXYHAL_TAG_USB_EP_XFER_OUT:
      if ((G_io_seproxyhal_spi_buffer[3]&0x7F) < IO_USB_MAX_ENDPOINTS) {
c0d01bca:	b2c9      	uxtb	r1, r1
        // saved just in case it is needed ...
        G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
c0d01bcc:	4b04      	ldr	r3, [pc, #16]	; (c0d01be0 <io_seproxyhal_handle_usb_ep_xfer_event+0x5c>)
c0d01bce:	545a      	strb	r2, [r3, r1]
        // prepare reception
        USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d01bd0:	1d82      	adds	r2, r0, #6
c0d01bd2:	4804      	ldr	r0, [pc, #16]	; (c0d01be4 <io_seproxyhal_handle_usb_ep_xfer_event+0x60>)
c0d01bd4:	f002 fe9d 	bl	c0d04912 <USBD_LL_DataOutStage>
      }
      break;
  }
}
c0d01bd8:	bd10      	pop	{r4, pc}
c0d01bda:	46c0      	nop			; (mov r8, r8)
c0d01bdc:	20001800 	.word	0x20001800
c0d01be0:	20001a81 	.word	0x20001a81
c0d01be4:	20002160 	.word	0x20002160
c0d01be8:	20001a88 	.word	0x20001a88

c0d01bec <io_usb_send_ep>:
#endif // HAVE_L4_USBLIB

// TODO, refactor this using the USB DataIn event like for the U2F tunnel
// TODO add a blocking parameter, for HID KBD sending, or use a USB busy flag per channel to know if 
// the transfer has been processed or not. and move on to the next transfer on the same endpoint
void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
c0d01bec:	b570      	push	{r4, r5, r6, lr}
c0d01bee:	4615      	mov	r5, r2
c0d01bf0:	460e      	mov	r6, r1
c0d01bf2:	4604      	mov	r4, r0
  if (timeout) {
    timeout++;
  }

  // won't send if overflowing seproxyhal buffer format
  if (length > 255) {
c0d01bf4:	2dff      	cmp	r5, #255	; 0xff
c0d01bf6:	d81a      	bhi.n	c0d01c2e <io_usb_send_ep+0x42>
    return;
  }
  
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d01bf8:	480d      	ldr	r0, [pc, #52]	; (c0d01c30 <io_usb_send_ep+0x44>)
c0d01bfa:	2150      	movs	r1, #80	; 0x50
c0d01bfc:	7001      	strb	r1, [r0, #0]
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
c0d01bfe:	1ce9      	adds	r1, r5, #3
c0d01c00:	0a0a      	lsrs	r2, r1, #8
c0d01c02:	7042      	strb	r2, [r0, #1]
  G_io_seproxyhal_spi_buffer[2] = (3+length);
c0d01c04:	7081      	strb	r1, [r0, #2]
  G_io_seproxyhal_spi_buffer[3] = ep|0x80;
c0d01c06:	2180      	movs	r1, #128	; 0x80
c0d01c08:	4321      	orrs	r1, r4
c0d01c0a:	70c1      	strb	r1, [r0, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d01c0c:	2120      	movs	r1, #32
c0d01c0e:	7101      	strb	r1, [r0, #4]
  G_io_seproxyhal_spi_buffer[5] = length;
c0d01c10:	7145      	strb	r5, [r0, #5]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 6);
c0d01c12:	2106      	movs	r1, #6
c0d01c14:	f001 faf8 	bl	c0d03208 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(buffer, length);
c0d01c18:	4630      	mov	r0, r6
c0d01c1a:	4629      	mov	r1, r5
c0d01c1c:	f001 faf4 	bl	c0d03208 <io_seproxyhal_spi_send>
  // setup timeout of the endpoint
  G_io_usb_ep_timeouts[ep&0x7F].timeout = IO_RAPDU_TRANSMIT_TIMEOUT_MS;
c0d01c20:	207f      	movs	r0, #127	; 0x7f
c0d01c22:	4020      	ands	r0, r4
c0d01c24:	0040      	lsls	r0, r0, #1
c0d01c26:	217d      	movs	r1, #125	; 0x7d
c0d01c28:	0109      	lsls	r1, r1, #4
c0d01c2a:	4a02      	ldr	r2, [pc, #8]	; (c0d01c34 <io_usb_send_ep+0x48>)
c0d01c2c:	5211      	strh	r1, [r2, r0]

}
c0d01c2e:	bd70      	pop	{r4, r5, r6, pc}
c0d01c30:	20001800 	.word	0x20001800
c0d01c34:	20001a88 	.word	0x20001a88

c0d01c38 <io_usb_send_apdu_data>:

void io_usb_send_apdu_data(unsigned char* buffer, unsigned short length) {
c0d01c38:	b580      	push	{r7, lr}
c0d01c3a:	460a      	mov	r2, r1
c0d01c3c:	4601      	mov	r1, r0
  // wait for 20 events before hanging up and timeout (~2 seconds of timeout)
  io_usb_send_ep(0x82, buffer, length, 20);
c0d01c3e:	2082      	movs	r0, #130	; 0x82
c0d01c40:	2314      	movs	r3, #20
c0d01c42:	f7ff ffd3 	bl	c0d01bec <io_usb_send_ep>
}
c0d01c46:	bd80      	pop	{r7, pc}

c0d01c48 <io_seproxyhal_handle_capdu_event>:

}
#endif


void io_seproxyhal_handle_capdu_event(void) {
c0d01c48:	b580      	push	{r7, lr}
  if(G_io_apdu_state == APDU_IDLE) 
c0d01c4a:	480d      	ldr	r0, [pc, #52]	; (c0d01c80 <io_seproxyhal_handle_capdu_event+0x38>)
c0d01c4c:	7801      	ldrb	r1, [r0, #0]
c0d01c4e:	2900      	cmp	r1, #0
c0d01c50:	d115      	bne.n	c0d01c7e <io_seproxyhal_handle_capdu_event+0x36>
  {
    G_io_apdu_media = IO_APDU_MEDIA_RAW; // for application code
c0d01c52:	490c      	ldr	r1, [pc, #48]	; (c0d01c84 <io_seproxyhal_handle_capdu_event+0x3c>)
c0d01c54:	2206      	movs	r2, #6
c0d01c56:	700a      	strb	r2, [r1, #0]
    G_io_apdu_state = APDU_RAW; // for next call to io_exchange
c0d01c58:	210a      	movs	r1, #10
c0d01c5a:	7001      	strb	r1, [r0, #0]
    G_io_apdu_length = MIN(U2BE(G_io_seproxyhal_spi_buffer, 1), sizeof(G_io_apdu_buffer)); 
c0d01c5c:	480a      	ldr	r0, [pc, #40]	; (c0d01c88 <io_seproxyhal_handle_capdu_event+0x40>)
c0d01c5e:	7882      	ldrb	r2, [r0, #2]
c0d01c60:	7841      	ldrb	r1, [r0, #1]
c0d01c62:	0209      	lsls	r1, r1, #8
c0d01c64:	4311      	orrs	r1, r2
c0d01c66:	22ff      	movs	r2, #255	; 0xff
c0d01c68:	3252      	adds	r2, #82	; 0x52
c0d01c6a:	4291      	cmp	r1, r2
c0d01c6c:	d300      	bcc.n	c0d01c70 <io_seproxyhal_handle_capdu_event+0x28>
c0d01c6e:	4611      	mov	r1, r2
c0d01c70:	4a06      	ldr	r2, [pc, #24]	; (c0d01c8c <io_seproxyhal_handle_capdu_event+0x44>)
c0d01c72:	8011      	strh	r1, [r2, #0]
    // copy apdu to apdu buffer
    os_memmove(G_io_apdu_buffer, G_io_seproxyhal_spi_buffer+3, G_io_apdu_length);
c0d01c74:	8812      	ldrh	r2, [r2, #0]
c0d01c76:	1cc1      	adds	r1, r0, #3
c0d01c78:	4805      	ldr	r0, [pc, #20]	; (c0d01c90 <io_seproxyhal_handle_capdu_event+0x48>)
c0d01c7a:	f7ff fe68 	bl	c0d0194e <os_memmove>
  }
}
c0d01c7e:	bd80      	pop	{r7, pc}
c0d01c80:	20001a96 	.word	0x20001a96
c0d01c84:	20001a80 	.word	0x20001a80
c0d01c88:	20001800 	.word	0x20001800
c0d01c8c:	20001a98 	.word	0x20001a98
c0d01c90:	20001924 	.word	0x20001924

c0d01c94 <io_seproxyhal_handle_event>:

unsigned int io_seproxyhal_handle_event(void) {
c0d01c94:	b5b0      	push	{r4, r5, r7, lr}
  unsigned int rx_len = U2BE(G_io_seproxyhal_spi_buffer, 1);
c0d01c96:	481e      	ldr	r0, [pc, #120]	; (c0d01d10 <io_seproxyhal_handle_event+0x7c>)
c0d01c98:	7882      	ldrb	r2, [r0, #2]
c0d01c9a:	7841      	ldrb	r1, [r0, #1]
c0d01c9c:	0209      	lsls	r1, r1, #8
c0d01c9e:	4311      	orrs	r1, r2
c0d01ca0:	7800      	ldrb	r0, [r0, #0]

  switch(G_io_seproxyhal_spi_buffer[0]) {
c0d01ca2:	280f      	cmp	r0, #15
c0d01ca4:	dc09      	bgt.n	c0d01cba <io_seproxyhal_handle_event+0x26>
c0d01ca6:	280e      	cmp	r0, #14
c0d01ca8:	d00e      	beq.n	c0d01cc8 <io_seproxyhal_handle_event+0x34>
c0d01caa:	280f      	cmp	r0, #15
c0d01cac:	d11f      	bne.n	c0d01cee <io_seproxyhal_handle_event+0x5a>
c0d01cae:	2000      	movs	r0, #0
  #ifdef HAVE_IO_USB
    case SEPROXYHAL_TAG_USB_EVENT:
      if (rx_len != 1) {
c0d01cb0:	2901      	cmp	r1, #1
c0d01cb2:	d126      	bne.n	c0d01d02 <io_seproxyhal_handle_event+0x6e>
        return 0;
      }
      io_seproxyhal_handle_usb_event();
c0d01cb4:	f7ff ff20 	bl	c0d01af8 <io_seproxyhal_handle_usb_event>
c0d01cb8:	e022      	b.n	c0d01d00 <io_seproxyhal_handle_event+0x6c>
c0d01cba:	2810      	cmp	r0, #16
c0d01cbc:	d01b      	beq.n	c0d01cf6 <io_seproxyhal_handle_event+0x62>
c0d01cbe:	2816      	cmp	r0, #22
c0d01cc0:	d115      	bne.n	c0d01cee <io_seproxyhal_handle_event+0x5a>
      }
      return 1;
  #endif // HAVE_BLE

    case SEPROXYHAL_TAG_CAPDU_EVENT:
      io_seproxyhal_handle_capdu_event();
c0d01cc2:	f7ff ffc1 	bl	c0d01c48 <io_seproxyhal_handle_capdu_event>
c0d01cc6:	e01b      	b.n	c0d01d00 <io_seproxyhal_handle_event+0x6c>
c0d01cc8:	2000      	movs	r0, #0
c0d01cca:	4912      	ldr	r1, [pc, #72]	; (c0d01d14 <io_seproxyhal_handle_event+0x80>)
      // process ticker events to timeout the IO transfers, and forward to the user io_event function too
#ifdef HAVE_IO_USB
      {
        unsigned int i = IO_USB_MAX_ENDPOINTS;
        while(i--) {
          if (G_io_usb_ep_timeouts[i].timeout) {
c0d01ccc:	1a0a      	subs	r2, r1, r0
c0d01cce:	8993      	ldrh	r3, [r2, #12]
c0d01cd0:	2b00      	cmp	r3, #0
c0d01cd2:	d009      	beq.n	c0d01ce8 <io_seproxyhal_handle_event+0x54>
            G_io_usb_ep_timeouts[i].timeout-=MIN(G_io_usb_ep_timeouts[i].timeout, 100);
c0d01cd4:	2464      	movs	r4, #100	; 0x64
c0d01cd6:	2b64      	cmp	r3, #100	; 0x64
c0d01cd8:	461d      	mov	r5, r3
c0d01cda:	d300      	bcc.n	c0d01cde <io_seproxyhal_handle_event+0x4a>
c0d01cdc:	4625      	mov	r5, r4
c0d01cde:	1b5b      	subs	r3, r3, r5
c0d01ce0:	8193      	strh	r3, [r2, #12]
c0d01ce2:	4a0d      	ldr	r2, [pc, #52]	; (c0d01d18 <io_seproxyhal_handle_event+0x84>)
            if (!G_io_usb_ep_timeouts[i].timeout) {
c0d01ce4:	4213      	tst	r3, r2
c0d01ce6:	d00d      	beq.n	c0d01d04 <io_seproxyhal_handle_event+0x70>
    case SEPROXYHAL_TAG_TICKER_EVENT:
      // process ticker events to timeout the IO transfers, and forward to the user io_event function too
#ifdef HAVE_IO_USB
      {
        unsigned int i = IO_USB_MAX_ENDPOINTS;
        while(i--) {
c0d01ce8:	1c80      	adds	r0, r0, #2
c0d01cea:	280e      	cmp	r0, #14
c0d01cec:	d1ee      	bne.n	c0d01ccc <io_seproxyhal_handle_event+0x38>
        }
      }
#endif // HAVE_IO_USB
      // no break is intentional
    default:
      return io_event(CHANNEL_SPI);
c0d01cee:	2002      	movs	r0, #2
c0d01cf0:	f7fe f9b4 	bl	c0d0005c <io_event>
  }
  // defaultly return as not processed
  return 0;
}
c0d01cf4:	bdb0      	pop	{r4, r5, r7, pc}
c0d01cf6:	2000      	movs	r0, #0
      }
      io_seproxyhal_handle_usb_event();
      return 1;

    case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
      if (rx_len < 3) {
c0d01cf8:	2903      	cmp	r1, #3
c0d01cfa:	d302      	bcc.n	c0d01d02 <io_seproxyhal_handle_event+0x6e>
        // error !
        return 0;
      }
      io_seproxyhal_handle_usb_ep_xfer_event();
c0d01cfc:	f7ff ff42 	bl	c0d01b84 <io_seproxyhal_handle_usb_ep_xfer_event>
c0d01d00:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaultly return as not processed
  return 0;
}
c0d01d02:	bdb0      	pop	{r4, r5, r7, pc}
        while(i--) {
          if (G_io_usb_ep_timeouts[i].timeout) {
            G_io_usb_ep_timeouts[i].timeout-=MIN(G_io_usb_ep_timeouts[i].timeout, 100);
            if (!G_io_usb_ep_timeouts[i].timeout) {
              // timeout !
              G_io_apdu_state = APDU_IDLE;
c0d01d04:	4805      	ldr	r0, [pc, #20]	; (c0d01d1c <io_seproxyhal_handle_event+0x88>)
c0d01d06:	2100      	movs	r1, #0
c0d01d08:	7001      	strb	r1, [r0, #0]
              THROW(EXCEPTION_IO_RESET);
c0d01d0a:	2010      	movs	r0, #16
c0d01d0c:	f7ff fed3 	bl	c0d01ab6 <os_longjmp>
c0d01d10:	20001800 	.word	0x20001800
c0d01d14:	20001a88 	.word	0x20001a88
c0d01d18:	0000ffff 	.word	0x0000ffff
c0d01d1c:	20001a96 	.word	0x20001a96

c0d01d20 <io_seproxyhal_init>:
#ifdef HAVE_BOLOS_APP_STACK_CANARY
#define APP_STACK_CANARY_MAGIC 0xDEAD0031
extern unsigned int app_stack_canary;
#endif // HAVE_BOLOS_APP_STACK_CANARY

void io_seproxyhal_init(void) {
c0d01d20:	b510      	push	{r4, lr}
  // Enforce OS compatibility
  check_api_level(CX_COMPAT_APILEVEL);
c0d01d22:	2009      	movs	r0, #9
c0d01d24:	f001 f8ac 	bl	c0d02e80 <check_api_level>

#ifdef HAVE_BOLOS_APP_STACK_CANARY
  app_stack_canary = APP_STACK_CANARY_MAGIC;
c0d01d28:	4809      	ldr	r0, [pc, #36]	; (c0d01d50 <io_seproxyhal_init+0x30>)
c0d01d2a:	490a      	ldr	r1, [pc, #40]	; (c0d01d54 <io_seproxyhal_init+0x34>)
c0d01d2c:	6001      	str	r1, [r0, #0]
#endif // HAVE_BOLOS_APP_STACK_CANARY  

  G_io_apdu_state = APDU_IDLE;
c0d01d2e:	480a      	ldr	r0, [pc, #40]	; (c0d01d58 <io_seproxyhal_init+0x38>)
c0d01d30:	2400      	movs	r4, #0
c0d01d32:	7004      	strb	r4, [r0, #0]
  G_io_apdu_length = 0;
c0d01d34:	4809      	ldr	r0, [pc, #36]	; (c0d01d5c <io_seproxyhal_init+0x3c>)
c0d01d36:	8004      	strh	r4, [r0, #0]
  G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d01d38:	4809      	ldr	r0, [pc, #36]	; (c0d01d60 <io_seproxyhal_init+0x40>)
c0d01d3a:	7004      	strb	r4, [r0, #0]
  debug_apdus_offset = 0;
  #endif // DEBUG_APDU


  #ifdef HAVE_USB_APDU
  io_usb_hid_init();
c0d01d3c:	f7ff fe22 	bl	c0d01984 <io_usb_hid_init>
  io_seproxyhal_init_button();
}

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d01d40:	4808      	ldr	r0, [pc, #32]	; (c0d01d64 <io_seproxyhal_init+0x44>)
c0d01d42:	6004      	str	r4, [r0, #0]
}

void io_seproxyhal_init_button(void) {
  // no button push so far
  G_button_mask = 0;
c0d01d44:	4808      	ldr	r0, [pc, #32]	; (c0d01d68 <io_seproxyhal_init+0x48>)
c0d01d46:	6004      	str	r4, [r0, #0]
  G_button_same_mask_counter = 0;
c0d01d48:	4808      	ldr	r0, [pc, #32]	; (c0d01d6c <io_seproxyhal_init+0x4c>)
c0d01d4a:	6004      	str	r4, [r0, #0]
  io_usb_hid_init();
  #endif // HAVE_USB_APDU

  io_seproxyhal_init_ux();
  io_seproxyhal_init_button();
}
c0d01d4c:	bd10      	pop	{r4, pc}
c0d01d4e:	46c0      	nop			; (mov r8, r8)
c0d01d50:	2000248c 	.word	0x2000248c
c0d01d54:	dead0031 	.word	0xdead0031
c0d01d58:	20001a96 	.word	0x20001a96
c0d01d5c:	20001a98 	.word	0x20001a98
c0d01d60:	20001a80 	.word	0x20001a80
c0d01d64:	20001a9c 	.word	0x20001a9c
c0d01d68:	20001aa0 	.word	0x20001aa0
c0d01d6c:	20001aa4 	.word	0x20001aa4

c0d01d70 <io_seproxyhal_init_ux>:

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d01d70:	4801      	ldr	r0, [pc, #4]	; (c0d01d78 <io_seproxyhal_init_ux+0x8>)
c0d01d72:	2100      	movs	r1, #0
c0d01d74:	6001      	str	r1, [r0, #0]
}
c0d01d76:	4770      	bx	lr
c0d01d78:	20001a9c 	.word	0x20001a9c

c0d01d7c <io_seproxyhal_init_button>:

void io_seproxyhal_init_button(void) {
  // no button push so far
  G_button_mask = 0;
c0d01d7c:	4802      	ldr	r0, [pc, #8]	; (c0d01d88 <io_seproxyhal_init_button+0xc>)
c0d01d7e:	2100      	movs	r1, #0
c0d01d80:	6001      	str	r1, [r0, #0]
  G_button_same_mask_counter = 0;
c0d01d82:	4802      	ldr	r0, [pc, #8]	; (c0d01d8c <io_seproxyhal_init_button+0x10>)
c0d01d84:	6001      	str	r1, [r0, #0]
}
c0d01d86:	4770      	bx	lr
c0d01d88:	20001aa0 	.word	0x20001aa0
c0d01d8c:	20001aa4 	.word	0x20001aa4

c0d01d90 <io_seproxyhal_touch_out>:

#ifdef HAVE_BAGL

unsigned int io_seproxyhal_touch_out(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d01d90:	b5b0      	push	{r4, r5, r7, lr}
c0d01d92:	460d      	mov	r5, r1
c0d01d94:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->out != NULL) {
c0d01d96:	6b20      	ldr	r0, [r4, #48]	; 0x30
c0d01d98:	2800      	cmp	r0, #0
c0d01d9a:	d00c      	beq.n	c0d01db6 <io_seproxyhal_touch_out+0x26>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->out))(element));
c0d01d9c:	f000 ff42 	bl	c0d02c24 <pic>
c0d01da0:	4601      	mov	r1, r0
c0d01da2:	4620      	mov	r0, r4
c0d01da4:	4788      	blx	r1
c0d01da6:	f000 ff3d 	bl	c0d02c24 <pic>
c0d01daa:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (! el) {
c0d01dac:	2800      	cmp	r0, #0
c0d01dae:	d010      	beq.n	c0d01dd2 <io_seproxyhal_touch_out+0x42>
c0d01db0:	2801      	cmp	r0, #1
c0d01db2:	d000      	beq.n	c0d01db6 <io_seproxyhal_touch_out+0x26>
c0d01db4:	4604      	mov	r4, r0
      element = el;
    }
  }

  // out function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d01db6:	2d00      	cmp	r5, #0
c0d01db8:	d007      	beq.n	c0d01dca <io_seproxyhal_touch_out+0x3a>
    el = before_display(element);
c0d01dba:	4620      	mov	r0, r4
c0d01dbc:	47a8      	blx	r5
c0d01dbe:	2100      	movs	r1, #0
    if (!el) {
c0d01dc0:	2800      	cmp	r0, #0
c0d01dc2:	d006      	beq.n	c0d01dd2 <io_seproxyhal_touch_out+0x42>
c0d01dc4:	2801      	cmp	r0, #1
c0d01dc6:	d000      	beq.n	c0d01dca <io_seproxyhal_touch_out+0x3a>
c0d01dc8:	4604      	mov	r4, r0
    if ((unsigned int)el != 1) {
      element = el;
    }
  }

  io_seproxyhal_display(element);
c0d01dca:	4620      	mov	r0, r4
c0d01dcc:	f003 fbe2 	bl	c0d05594 <io_seproxyhal_display>
c0d01dd0:	2101      	movs	r1, #1
  return 1;
}
c0d01dd2:	4608      	mov	r0, r1
c0d01dd4:	bdb0      	pop	{r4, r5, r7, pc}

c0d01dd6 <io_seproxyhal_touch_over>:

unsigned int io_seproxyhal_touch_over(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d01dd6:	b5b0      	push	{r4, r5, r7, lr}
c0d01dd8:	b08e      	sub	sp, #56	; 0x38
c0d01dda:	460d      	mov	r5, r1
c0d01ddc:	4604      	mov	r4, r0
  bagl_element_t e;
  const bagl_element_t* el;
  if (element->over != NULL) {
c0d01dde:	6b60      	ldr	r0, [r4, #52]	; 0x34
c0d01de0:	2800      	cmp	r0, #0
c0d01de2:	d00c      	beq.n	c0d01dfe <io_seproxyhal_touch_over+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->over))(element));
c0d01de4:	f000 ff1e 	bl	c0d02c24 <pic>
c0d01de8:	4601      	mov	r1, r0
c0d01dea:	4620      	mov	r0, r4
c0d01dec:	4788      	blx	r1
c0d01dee:	f000 ff19 	bl	c0d02c24 <pic>
c0d01df2:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d01df4:	2800      	cmp	r0, #0
c0d01df6:	d01b      	beq.n	c0d01e30 <io_seproxyhal_touch_over+0x5a>
c0d01df8:	2801      	cmp	r0, #1
c0d01dfa:	d000      	beq.n	c0d01dfe <io_seproxyhal_touch_over+0x28>
c0d01dfc:	4604      	mov	r4, r0
      element = el;
    }
  }

  // over function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d01dfe:	2d00      	cmp	r5, #0
c0d01e00:	d008      	beq.n	c0d01e14 <io_seproxyhal_touch_over+0x3e>
    el = before_display(element);
c0d01e02:	4620      	mov	r0, r4
c0d01e04:	47a8      	blx	r5
c0d01e06:	466c      	mov	r4, sp
c0d01e08:	2100      	movs	r1, #0
    element = &e;
    if (!el) {
c0d01e0a:	2800      	cmp	r0, #0
c0d01e0c:	d010      	beq.n	c0d01e30 <io_seproxyhal_touch_over+0x5a>
c0d01e0e:	2801      	cmp	r0, #1
c0d01e10:	d000      	beq.n	c0d01e14 <io_seproxyhal_touch_over+0x3e>
c0d01e12:	4604      	mov	r4, r0
c0d01e14:	466d      	mov	r5, sp
      element = el;
    }
  }

  // swap colors
  os_memmove(&e, (void*)element, sizeof(bagl_element_t));
c0d01e16:	2238      	movs	r2, #56	; 0x38
c0d01e18:	4628      	mov	r0, r5
c0d01e1a:	4621      	mov	r1, r4
c0d01e1c:	f7ff fd97 	bl	c0d0194e <os_memmove>
  e.component.fgcolor = element->overfgcolor;
c0d01e20:	6a60      	ldr	r0, [r4, #36]	; 0x24
c0d01e22:	9004      	str	r0, [sp, #16]
  e.component.bgcolor = element->overbgcolor;
c0d01e24:	6aa0      	ldr	r0, [r4, #40]	; 0x28
c0d01e26:	9005      	str	r0, [sp, #20]

  io_seproxyhal_display(&e);
c0d01e28:	4628      	mov	r0, r5
c0d01e2a:	f003 fbb3 	bl	c0d05594 <io_seproxyhal_display>
c0d01e2e:	2101      	movs	r1, #1
  return 1;
}
c0d01e30:	4608      	mov	r0, r1
c0d01e32:	b00e      	add	sp, #56	; 0x38
c0d01e34:	bdb0      	pop	{r4, r5, r7, pc}

c0d01e36 <io_seproxyhal_touch_tap>:

unsigned int io_seproxyhal_touch_tap(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d01e36:	b5b0      	push	{r4, r5, r7, lr}
c0d01e38:	460d      	mov	r5, r1
c0d01e3a:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->tap != NULL) {
c0d01e3c:	6ae0      	ldr	r0, [r4, #44]	; 0x2c
c0d01e3e:	2800      	cmp	r0, #0
c0d01e40:	d00c      	beq.n	c0d01e5c <io_seproxyhal_touch_tap+0x26>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->tap))(element));
c0d01e42:	f000 feef 	bl	c0d02c24 <pic>
c0d01e46:	4601      	mov	r1, r0
c0d01e48:	4620      	mov	r0, r4
c0d01e4a:	4788      	blx	r1
c0d01e4c:	f000 feea 	bl	c0d02c24 <pic>
c0d01e50:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d01e52:	2800      	cmp	r0, #0
c0d01e54:	d010      	beq.n	c0d01e78 <io_seproxyhal_touch_tap+0x42>
c0d01e56:	2801      	cmp	r0, #1
c0d01e58:	d000      	beq.n	c0d01e5c <io_seproxyhal_touch_tap+0x26>
c0d01e5a:	4604      	mov	r4, r0
      element = el;
    }
  }

  // tap function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d01e5c:	2d00      	cmp	r5, #0
c0d01e5e:	d007      	beq.n	c0d01e70 <io_seproxyhal_touch_tap+0x3a>
    el = before_display(element);
c0d01e60:	4620      	mov	r0, r4
c0d01e62:	47a8      	blx	r5
c0d01e64:	2100      	movs	r1, #0
    if (!el) {
c0d01e66:	2800      	cmp	r0, #0
c0d01e68:	d006      	beq.n	c0d01e78 <io_seproxyhal_touch_tap+0x42>
c0d01e6a:	2801      	cmp	r0, #1
c0d01e6c:	d000      	beq.n	c0d01e70 <io_seproxyhal_touch_tap+0x3a>
c0d01e6e:	4604      	mov	r4, r0
    }
    if ((unsigned int)el != 1) {
      element = el;
    }
  }
  io_seproxyhal_display(element);
c0d01e70:	4620      	mov	r0, r4
c0d01e72:	f003 fb8f 	bl	c0d05594 <io_seproxyhal_display>
c0d01e76:	2101      	movs	r1, #1
  return 1;
}
c0d01e78:	4608      	mov	r0, r1
c0d01e7a:	bdb0      	pop	{r4, r5, r7, pc}

c0d01e7c <io_seproxyhal_touch_element_callback>:
  io_seproxyhal_touch_element_callback(elements, element_count, x, y, event_kind, NULL);  
}

// browse all elements and until an element has changed state, continue browsing
// return if processed or not
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
c0d01e7c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01e7e:	b087      	sub	sp, #28
c0d01e80:	9302      	str	r3, [sp, #8]
c0d01e82:	9203      	str	r2, [sp, #12]
c0d01e84:	9105      	str	r1, [sp, #20]
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d01e86:	2900      	cmp	r1, #0
c0d01e88:	d077      	beq.n	c0d01f7a <io_seproxyhal_touch_element_callback+0xfe>
c0d01e8a:	9004      	str	r0, [sp, #16]
c0d01e8c:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01e8e:	9001      	str	r0, [sp, #4]
c0d01e90:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d01e92:	9000      	str	r0, [sp, #0]
c0d01e94:	2500      	movs	r5, #0
c0d01e96:	4b3c      	ldr	r3, [pc, #240]	; (c0d01f88 <io_seproxyhal_touch_element_callback+0x10c>)
c0d01e98:	9506      	str	r5, [sp, #24]
c0d01e9a:	462f      	mov	r7, r5
c0d01e9c:	461e      	mov	r6, r3
    // process all components matching the x/y/w/h (no break) => fishy for the released out of zone
    // continue processing only if a status has not been sent
    if (io_seproxyhal_spi_is_status_sent()) {
c0d01e9e:	f001 f9c9 	bl	c0d03234 <io_seproxyhal_spi_is_status_sent>
c0d01ea2:	2800      	cmp	r0, #0
c0d01ea4:	d155      	bne.n	c0d01f52 <io_seproxyhal_touch_element_callback+0xd6>
      // continue instead of return to process all elemnts and therefore discard last touched element
      break;
    }

    // only perform out callback when element was in the current array, else, leave it be
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
c0d01ea6:	2038      	movs	r0, #56	; 0x38
c0d01ea8:	4368      	muls	r0, r5
c0d01eaa:	9c04      	ldr	r4, [sp, #16]
c0d01eac:	1825      	adds	r5, r4, r0
c0d01eae:	4633      	mov	r3, r6
c0d01eb0:	681a      	ldr	r2, [r3, #0]
c0d01eb2:	2101      	movs	r1, #1
c0d01eb4:	4295      	cmp	r5, r2
c0d01eb6:	d000      	beq.n	c0d01eba <io_seproxyhal_touch_element_callback+0x3e>
c0d01eb8:	9906      	ldr	r1, [sp, #24]
c0d01eba:	9106      	str	r1, [sp, #24]
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d01ebc:	5620      	ldrsb	r0, [r4, r0]
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
c0d01ebe:	2800      	cmp	r0, #0
c0d01ec0:	da41      	bge.n	c0d01f46 <io_seproxyhal_touch_element_callback+0xca>
c0d01ec2:	2020      	movs	r0, #32
c0d01ec4:	5c28      	ldrb	r0, [r5, r0]
c0d01ec6:	2102      	movs	r1, #2
c0d01ec8:	5e69      	ldrsh	r1, [r5, r1]
c0d01eca:	1a0a      	subs	r2, r1, r0
c0d01ecc:	9c03      	ldr	r4, [sp, #12]
c0d01ece:	42a2      	cmp	r2, r4
c0d01ed0:	dc39      	bgt.n	c0d01f46 <io_seproxyhal_touch_element_callback+0xca>
c0d01ed2:	1841      	adds	r1, r0, r1
c0d01ed4:	88ea      	ldrh	r2, [r5, #6]
c0d01ed6:	1889      	adds	r1, r1, r2
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {
c0d01ed8:	9a03      	ldr	r2, [sp, #12]
c0d01eda:	428a      	cmp	r2, r1
c0d01edc:	da33      	bge.n	c0d01f46 <io_seproxyhal_touch_element_callback+0xca>
c0d01ede:	2104      	movs	r1, #4
c0d01ee0:	5e6c      	ldrsh	r4, [r5, r1]
c0d01ee2:	1a22      	subs	r2, r4, r0
c0d01ee4:	9902      	ldr	r1, [sp, #8]
c0d01ee6:	428a      	cmp	r2, r1
c0d01ee8:	dc2d      	bgt.n	c0d01f46 <io_seproxyhal_touch_element_callback+0xca>
c0d01eea:	1820      	adds	r0, r4, r0
c0d01eec:	8929      	ldrh	r1, [r5, #8]
c0d01eee:	1840      	adds	r0, r0, r1
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d01ef0:	9902      	ldr	r1, [sp, #8]
c0d01ef2:	4281      	cmp	r1, r0
c0d01ef4:	da27      	bge.n	c0d01f46 <io_seproxyhal_touch_element_callback+0xca>
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d01ef6:	6818      	ldr	r0, [r3, #0]
              && G_bagl_last_touched_not_released_component != NULL) {
c0d01ef8:	4285      	cmp	r5, r0
c0d01efa:	d010      	beq.n	c0d01f1e <io_seproxyhal_touch_element_callback+0xa2>
c0d01efc:	6818      	ldr	r0, [r3, #0]
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d01efe:	2800      	cmp	r0, #0
c0d01f00:	d00d      	beq.n	c0d01f1e <io_seproxyhal_touch_element_callback+0xa2>
              && G_bagl_last_touched_not_released_component != NULL) {
        // only out the previous element if the newly matching will be displayed 
        if (!before_display || before_display(&elements[comp_idx])) {
c0d01f02:	9801      	ldr	r0, [sp, #4]
c0d01f04:	2800      	cmp	r0, #0
c0d01f06:	d005      	beq.n	c0d01f14 <io_seproxyhal_touch_element_callback+0x98>
c0d01f08:	4628      	mov	r0, r5
c0d01f0a:	9901      	ldr	r1, [sp, #4]
c0d01f0c:	4788      	blx	r1
c0d01f0e:	4633      	mov	r3, r6
c0d01f10:	2800      	cmp	r0, #0
c0d01f12:	d018      	beq.n	c0d01f46 <io_seproxyhal_touch_element_callback+0xca>
          if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d01f14:	6818      	ldr	r0, [r3, #0]
c0d01f16:	9901      	ldr	r1, [sp, #4]
c0d01f18:	f7ff ff3a 	bl	c0d01d90 <io_seproxyhal_touch_out>
c0d01f1c:	e008      	b.n	c0d01f30 <io_seproxyhal_touch_element_callback+0xb4>
c0d01f1e:	9800      	ldr	r0, [sp, #0]
        continue;
      }
      */
      
      // callback the hal to notify the component impacted by the user input
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_RELEASE) {
c0d01f20:	2801      	cmp	r0, #1
c0d01f22:	d009      	beq.n	c0d01f38 <io_seproxyhal_touch_element_callback+0xbc>
c0d01f24:	2802      	cmp	r0, #2
c0d01f26:	d10e      	bne.n	c0d01f46 <io_seproxyhal_touch_element_callback+0xca>
        if (io_seproxyhal_touch_tap(&elements[comp_idx], before_display)) {
c0d01f28:	4628      	mov	r0, r5
c0d01f2a:	9901      	ldr	r1, [sp, #4]
c0d01f2c:	f7ff ff83 	bl	c0d01e36 <io_seproxyhal_touch_tap>
c0d01f30:	4633      	mov	r3, r6
c0d01f32:	2800      	cmp	r0, #0
c0d01f34:	d007      	beq.n	c0d01f46 <io_seproxyhal_touch_element_callback+0xca>
c0d01f36:	e022      	b.n	c0d01f7e <io_seproxyhal_touch_element_callback+0x102>
          return;
        }
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
c0d01f38:	4628      	mov	r0, r5
c0d01f3a:	9901      	ldr	r1, [sp, #4]
c0d01f3c:	f7ff ff4b 	bl	c0d01dd6 <io_seproxyhal_touch_over>
c0d01f40:	4633      	mov	r3, r6
c0d01f42:	2800      	cmp	r0, #0
c0d01f44:	d11e      	bne.n	c0d01f84 <io_seproxyhal_touch_element_callback+0x108>
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d01f46:	1c7f      	adds	r7, r7, #1
c0d01f48:	b2fd      	uxtb	r5, r7
c0d01f4a:	9805      	ldr	r0, [sp, #20]
c0d01f4c:	4285      	cmp	r5, r0
c0d01f4e:	d3a5      	bcc.n	c0d01e9c <io_seproxyhal_touch_element_callback+0x20>
c0d01f50:	e000      	b.n	c0d01f54 <io_seproxyhal_touch_element_callback+0xd8>
c0d01f52:	4633      	mov	r3, r6
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
    && G_bagl_last_touched_not_released_component != NULL) {
c0d01f54:	9806      	ldr	r0, [sp, #24]
c0d01f56:	0600      	lsls	r0, r0, #24
c0d01f58:	d00f      	beq.n	c0d01f7a <io_seproxyhal_touch_element_callback+0xfe>
c0d01f5a:	6818      	ldr	r0, [r3, #0]
      }
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
c0d01f5c:	2800      	cmp	r0, #0
c0d01f5e:	d00c      	beq.n	c0d01f7a <io_seproxyhal_touch_element_callback+0xfe>
    && G_bagl_last_touched_not_released_component != NULL) {

    // we won't be able to notify the out, don't do it, in case a diplay refused the dra of the relased element and the position matched another element of the array (in autocomplete for example)
    if (io_seproxyhal_spi_is_status_sent()) {
c0d01f60:	f001 f968 	bl	c0d03234 <io_seproxyhal_spi_is_status_sent>
c0d01f64:	4631      	mov	r1, r6
c0d01f66:	2800      	cmp	r0, #0
c0d01f68:	d107      	bne.n	c0d01f7a <io_seproxyhal_touch_element_callback+0xfe>
      return;
    }
    
    if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d01f6a:	6808      	ldr	r0, [r1, #0]
c0d01f6c:	9901      	ldr	r1, [sp, #4]
c0d01f6e:	f7ff ff0f 	bl	c0d01d90 <io_seproxyhal_touch_out>
c0d01f72:	2800      	cmp	r0, #0
c0d01f74:	d001      	beq.n	c0d01f7a <io_seproxyhal_touch_element_callback+0xfe>
      // ok component out has been emitted
      G_bagl_last_touched_not_released_component = NULL;
c0d01f76:	2000      	movs	r0, #0
c0d01f78:	6030      	str	r0, [r6, #0]
    }
  }

  // not processed
}
c0d01f7a:	b007      	add	sp, #28
c0d01f7c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01f7e:	2000      	movs	r0, #0
c0d01f80:	6018      	str	r0, [r3, #0]
c0d01f82:	e7fa      	b.n	c0d01f7a <io_seproxyhal_touch_element_callback+0xfe>
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
          // remember the last touched component
          G_bagl_last_touched_not_released_component = (bagl_element_t*)&elements[comp_idx];
c0d01f84:	601d      	str	r5, [r3, #0]
c0d01f86:	e7f8      	b.n	c0d01f7a <io_seproxyhal_touch_element_callback+0xfe>
c0d01f88:	20001a9c 	.word	0x20001a9c

c0d01f8c <io_seproxyhal_display_icon>:
  // remaining length of bitmap bits to be displayed
  return len;
}
#endif // SEPROXYHAL_TAG_SCREEN_DISPLAY_RAW_STATUS

void io_seproxyhal_display_icon(bagl_component_t* icon_component, bagl_icon_details_t* icon_details) {
c0d01f8c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01f8e:	b089      	sub	sp, #36	; 0x24
c0d01f90:	460c      	mov	r4, r1
c0d01f92:	4601      	mov	r1, r0
c0d01f94:	ad02      	add	r5, sp, #8
c0d01f96:	221c      	movs	r2, #28
  bagl_component_t icon_component_mod;
  // ensure not being out of bounds in the icon component agianst the declared icon real size
  os_memmove(&icon_component_mod, icon_component, sizeof(bagl_component_t));
c0d01f98:	4628      	mov	r0, r5
c0d01f9a:	9201      	str	r2, [sp, #4]
c0d01f9c:	f7ff fcd7 	bl	c0d0194e <os_memmove>
  icon_component_mod.width = icon_details->width;
c0d01fa0:	6821      	ldr	r1, [r4, #0]
c0d01fa2:	80e9      	strh	r1, [r5, #6]
  icon_component_mod.height = icon_details->height;
c0d01fa4:	6862      	ldr	r2, [r4, #4]
c0d01fa6:	812a      	strh	r2, [r5, #8]
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d01fa8:	68a0      	ldr	r0, [r4, #8]
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
                          +w; /* image bitmap size */
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d01faa:	4f1a      	ldr	r7, [pc, #104]	; (c0d02014 <_nvram_data_size+0x14>)
c0d01fac:	2365      	movs	r3, #101	; 0x65
c0d01fae:	703b      	strb	r3, [r7, #0]


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
c0d01fb0:	b292      	uxth	r2, r2
c0d01fb2:	4342      	muls	r2, r0
c0d01fb4:	b28b      	uxth	r3, r1
c0d01fb6:	4353      	muls	r3, r2
c0d01fb8:	08d9      	lsrs	r1, r3, #3
c0d01fba:	1c4e      	adds	r6, r1, #1
c0d01fbc:	2207      	movs	r2, #7
c0d01fbe:	4213      	tst	r3, r2
c0d01fc0:	d100      	bne.n	c0d01fc4 <io_seproxyhal_display_icon+0x38>
c0d01fc2:	460e      	mov	r6, r1
c0d01fc4:	4631      	mov	r1, r6
c0d01fc6:	9100      	str	r1, [sp, #0]
c0d01fc8:	2604      	movs	r6, #4
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d01fca:	4086      	lsls	r6, r0
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
c0d01fcc:	1870      	adds	r0, r6, r1
                          +w; /* image bitmap size */
c0d01fce:	301d      	adds	r0, #29
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
  G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d01fd0:	0a01      	lsrs	r1, r0, #8
c0d01fd2:	7079      	strb	r1, [r7, #1]
  G_io_seproxyhal_spi_buffer[2] = length;
c0d01fd4:	70b8      	strb	r0, [r7, #2]
c0d01fd6:	2103      	movs	r1, #3
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d01fd8:	4638      	mov	r0, r7
c0d01fda:	f001 f915 	bl	c0d03208 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)icon_component, sizeof(bagl_component_t));
c0d01fde:	4628      	mov	r0, r5
c0d01fe0:	9901      	ldr	r1, [sp, #4]
c0d01fe2:	f001 f911 	bl	c0d03208 <io_seproxyhal_spi_send>
  G_io_seproxyhal_spi_buffer[0] = icon_details->bpp;
c0d01fe6:	68a0      	ldr	r0, [r4, #8]
c0d01fe8:	7038      	strb	r0, [r7, #0]
c0d01fea:	2101      	movs	r1, #1
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 1);
c0d01fec:	4638      	mov	r0, r7
c0d01fee:	f001 f90b 	bl	c0d03208 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->colors), h);
c0d01ff2:	68e0      	ldr	r0, [r4, #12]
c0d01ff4:	f000 fe16 	bl	c0d02c24 <pic>
c0d01ff8:	b2b1      	uxth	r1, r6
c0d01ffa:	f001 f905 	bl	c0d03208 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->bitmap), w);
c0d01ffe:	9800      	ldr	r0, [sp, #0]

c0d02000 <_nvram_data_size>:
c0d02000:	b285      	uxth	r5, r0
c0d02002:	6920      	ldr	r0, [r4, #16]
c0d02004:	f000 fe0e 	bl	c0d02c24 <pic>
c0d02008:	4629      	mov	r1, r5
c0d0200a:	f001 f8fd 	bl	c0d03208 <io_seproxyhal_spi_send>
#endif // !SEPROXYHAL_TAG_SCREEN_DISPLAY_RAW_STATUS
}
c0d0200e:	b009      	add	sp, #36	; 0x24
c0d02010:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02012:	46c0      	nop			; (mov r8, r8)
c0d02014:	20001800 	.word	0x20001800

c0d02018 <io_seproxyhal_display_default>:

void io_seproxyhal_display_default(const bagl_element_t * element) {
c0d02018:	b570      	push	{r4, r5, r6, lr}
c0d0201a:	4604      	mov	r4, r0
  // process automagically address from rom and from ram
  unsigned int type = (element->component.type & ~(BAGL_FLAG_TOUCHABLE));
c0d0201c:	7820      	ldrb	r0, [r4, #0]
c0d0201e:	267f      	movs	r6, #127	; 0x7f
c0d02020:	4006      	ands	r6, r0

  // avoid sending another status :), fixes a lot of bugs in the end
  if (io_seproxyhal_spi_is_status_sent()) {
c0d02022:	f001 f907 	bl	c0d03234 <io_seproxyhal_spi_is_status_sent>
c0d02026:	2800      	cmp	r0, #0
c0d02028:	d130      	bne.n	c0d0208c <io_seproxyhal_display_default+0x74>
c0d0202a:	2e00      	cmp	r6, #0
c0d0202c:	d02e      	beq.n	c0d0208c <io_seproxyhal_display_default+0x74>
    return;
  }

  if (type != BAGL_NONE) {
    if (element->text != NULL) {
c0d0202e:	69e0      	ldr	r0, [r4, #28]
c0d02030:	2800      	cmp	r0, #0
c0d02032:	d01d      	beq.n	c0d02070 <io_seproxyhal_display_default+0x58>
      unsigned int text_adr = PIC((unsigned int)element->text);
c0d02034:	f000 fdf6 	bl	c0d02c24 <pic>
c0d02038:	4605      	mov	r5, r0
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
c0d0203a:	2e05      	cmp	r6, #5
c0d0203c:	d102      	bne.n	c0d02044 <io_seproxyhal_display_default+0x2c>
c0d0203e:	7ea0      	ldrb	r0, [r4, #26]
c0d02040:	2800      	cmp	r0, #0
c0d02042:	d024      	beq.n	c0d0208e <io_seproxyhal_display_default+0x76>
        io_seproxyhal_display_icon((bagl_component_t*)&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d02044:	4628      	mov	r0, r5
c0d02046:	f004 fa1b 	bl	c0d06480 <strlen>
c0d0204a:	4606      	mov	r6, r0
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d0204c:	4812      	ldr	r0, [pc, #72]	; (c0d02098 <io_seproxyhal_display_default+0x80>)
c0d0204e:	2165      	movs	r1, #101	; 0x65
c0d02050:	7001      	strb	r1, [r0, #0]
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon((bagl_component_t*)&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d02052:	4631      	mov	r1, r6
c0d02054:	311c      	adds	r1, #28
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
        G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d02056:	0a0a      	lsrs	r2, r1, #8
c0d02058:	7042      	strb	r2, [r0, #1]
        G_io_seproxyhal_spi_buffer[2] = length;
c0d0205a:	7081      	strb	r1, [r0, #2]
        io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d0205c:	2103      	movs	r1, #3
c0d0205e:	f001 f8d3 	bl	c0d03208 <io_seproxyhal_spi_send>
c0d02062:	211c      	movs	r1, #28
        io_seproxyhal_spi_send((unsigned char*)&element->component, sizeof(bagl_component_t));
c0d02064:	4620      	mov	r0, r4
c0d02066:	f001 f8cf 	bl	c0d03208 <io_seproxyhal_spi_send>
        io_seproxyhal_spi_send((unsigned char*)text_adr, length-sizeof(bagl_component_t));
c0d0206a:	b2b1      	uxth	r1, r6
c0d0206c:	4628      	mov	r0, r5
c0d0206e:	e00b      	b.n	c0d02088 <io_seproxyhal_display_default+0x70>
      }
    }
    else {
      unsigned short length = sizeof(bagl_component_t);
      G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d02070:	4809      	ldr	r0, [pc, #36]	; (c0d02098 <io_seproxyhal_display_default+0x80>)
c0d02072:	2165      	movs	r1, #101	; 0x65
c0d02074:	7001      	strb	r1, [r0, #0]
      G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d02076:	2100      	movs	r1, #0
c0d02078:	7041      	strb	r1, [r0, #1]
c0d0207a:	251c      	movs	r5, #28
      G_io_seproxyhal_spi_buffer[2] = length;
c0d0207c:	7085      	strb	r5, [r0, #2]
      io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d0207e:	2103      	movs	r1, #3
c0d02080:	f001 f8c2 	bl	c0d03208 <io_seproxyhal_spi_send>
      io_seproxyhal_spi_send((unsigned char*)&element->component, sizeof(bagl_component_t));
c0d02084:	4620      	mov	r0, r4
c0d02086:	4629      	mov	r1, r5
c0d02088:	f001 f8be 	bl	c0d03208 <io_seproxyhal_spi_send>
    }
  }
}
c0d0208c:	bd70      	pop	{r4, r5, r6, pc}
  if (type != BAGL_NONE) {
    if (element->text != NULL) {
      unsigned int text_adr = PIC((unsigned int)element->text);
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon((bagl_component_t*)&element->component, (bagl_icon_details_t*)text_adr);
c0d0208e:	4620      	mov	r0, r4
c0d02090:	4629      	mov	r1, r5
c0d02092:	f7ff ff7b 	bl	c0d01f8c <io_seproxyhal_display_icon>
      G_io_seproxyhal_spi_buffer[2] = length;
      io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
      io_seproxyhal_spi_send((unsigned char*)&element->component, sizeof(bagl_component_t));
    }
  }
}
c0d02096:	bd70      	pop	{r4, r5, r6, pc}
c0d02098:	20001800 	.word	0x20001800

c0d0209c <bagl_label_roundtrip_duration_ms>:

unsigned int bagl_label_roundtrip_duration_ms(const bagl_element_t* e, unsigned int average_char_width) {
c0d0209c:	b580      	push	{r7, lr}
c0d0209e:	460a      	mov	r2, r1
  return bagl_label_roundtrip_duration_ms_buf(e, e->text, average_char_width);
c0d020a0:	69c1      	ldr	r1, [r0, #28]
c0d020a2:	f000 f801 	bl	c0d020a8 <bagl_label_roundtrip_duration_ms_buf>
c0d020a6:	bd80      	pop	{r7, pc}

c0d020a8 <bagl_label_roundtrip_duration_ms_buf>:
}

unsigned int bagl_label_roundtrip_duration_ms_buf(const bagl_element_t* e, const char* str, unsigned int average_char_width) {
c0d020a8:	b570      	push	{r4, r5, r6, lr}
c0d020aa:	4616      	mov	r6, r2
c0d020ac:	4604      	mov	r4, r0
c0d020ae:	2500      	movs	r5, #0
  // not a scrollable label
  if (e == NULL || (e->component.type != BAGL_LABEL && e->component.type != BAGL_LABELINE)) {
c0d020b0:	2c00      	cmp	r4, #0
c0d020b2:	d01c      	beq.n	c0d020ee <bagl_label_roundtrip_duration_ms_buf+0x46>
c0d020b4:	7820      	ldrb	r0, [r4, #0]
c0d020b6:	2807      	cmp	r0, #7
c0d020b8:	d001      	beq.n	c0d020be <bagl_label_roundtrip_duration_ms_buf+0x16>
c0d020ba:	2802      	cmp	r0, #2
c0d020bc:	d117      	bne.n	c0d020ee <bagl_label_roundtrip_duration_ms_buf+0x46>
    return 0;
  }
  
  unsigned int text_adr = PIC((unsigned int)str);
c0d020be:	4608      	mov	r0, r1
c0d020c0:	f000 fdb0 	bl	c0d02c24 <pic>
  unsigned int textlen = 0;
  
  // no delay, no text to display
  if (!text_adr) {
c0d020c4:	2800      	cmp	r0, #0
c0d020c6:	d012      	beq.n	c0d020ee <bagl_label_roundtrip_duration_ms_buf+0x46>
    return 0;
  }
  textlen = strlen((const char*)text_adr);
c0d020c8:	f004 f9da 	bl	c0d06480 <strlen>
  
  // no delay, all text fits
  textlen = textlen * average_char_width;
c0d020cc:	4346      	muls	r6, r0
  if (textlen <= e->component.width) {
c0d020ce:	88e0      	ldrh	r0, [r4, #6]
c0d020d0:	4286      	cmp	r6, r0
c0d020d2:	d90c      	bls.n	c0d020ee <bagl_label_roundtrip_duration_ms_buf+0x46>
    return 0; 
  }
  
  // compute scrolled text length
  return 2*(textlen - e->component.width)*1000/e->component.icon_id + 2*(e->component.stroke & ~(0x80))*100;
c0d020d4:	1a31      	subs	r1, r6, r0
c0d020d6:	207d      	movs	r0, #125	; 0x7d
c0d020d8:	0100      	lsls	r0, r0, #4
c0d020da:	4348      	muls	r0, r1
c0d020dc:	7ea1      	ldrb	r1, [r4, #26]
c0d020de:	f003 ff65 	bl	c0d05fac <__aeabi_uidiv>
c0d020e2:	7aa1      	ldrb	r1, [r4, #10]
c0d020e4:	0049      	lsls	r1, r1, #1
c0d020e6:	b2c9      	uxtb	r1, r1
c0d020e8:	2264      	movs	r2, #100	; 0x64
c0d020ea:	434a      	muls	r2, r1
c0d020ec:	1815      	adds	r5, r2, r0
}
c0d020ee:	4628      	mov	r0, r5
c0d020f0:	bd70      	pop	{r4, r5, r6, pc}
	...

c0d020f4 <io_seproxyhal_se_reset>:
  G_io_seproxyhal_spi_buffer[2] = 0;
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
  for(;;);
}

void io_seproxyhal_se_reset(void) {
c0d020f4:	b580      	push	{r7, lr}
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SE_POWER_OFF;
c0d020f6:	4805      	ldr	r0, [pc, #20]	; (c0d0210c <io_seproxyhal_se_reset+0x18>)
c0d020f8:	2146      	movs	r1, #70	; 0x46
c0d020fa:	7001      	strb	r1, [r0, #0]
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d020fc:	2100      	movs	r1, #0
c0d020fe:	7041      	strb	r1, [r0, #1]
  G_io_seproxyhal_spi_buffer[2] = 0;
c0d02100:	7081      	strb	r1, [r0, #2]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d02102:	2103      	movs	r1, #3
c0d02104:	f001 f880 	bl	c0d03208 <io_seproxyhal_spi_send>
  for(;;);
c0d02108:	e7fe      	b.n	c0d02108 <io_seproxyhal_se_reset+0x14>
c0d0210a:	46c0      	nop			; (mov r8, r8)
c0d0210c:	20001800 	.word	0x20001800

c0d02110 <io_seproxyhal_button_push>:
  G_io_seproxyhal_spi_buffer[3] = (backlight_percentage?0x80:0)|(flags & 0x7F); // power on
  G_io_seproxyhal_spi_buffer[4] = backlight_percentage;
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
}

void io_seproxyhal_button_push(button_push_callback_t button_callback, unsigned int new_button_mask) {
c0d02110:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02112:	b081      	sub	sp, #4
c0d02114:	4604      	mov	r4, r0
  if (button_callback) {
c0d02116:	2c00      	cmp	r4, #0
c0d02118:	d02b      	beq.n	c0d02172 <io_seproxyhal_button_push+0x62>
    unsigned int button_mask;
    unsigned int button_same_mask_counter;
    // enable speeded up long push
    if (new_button_mask == G_button_mask) {
c0d0211a:	4817      	ldr	r0, [pc, #92]	; (c0d02178 <io_seproxyhal_button_push+0x68>)
c0d0211c:	6802      	ldr	r2, [r0, #0]
c0d0211e:	428a      	cmp	r2, r1
c0d02120:	d103      	bne.n	c0d0212a <io_seproxyhal_button_push+0x1a>
      // each 100ms ~
      G_button_same_mask_counter++;
c0d02122:	4a16      	ldr	r2, [pc, #88]	; (c0d0217c <io_seproxyhal_button_push+0x6c>)
c0d02124:	6813      	ldr	r3, [r2, #0]
c0d02126:	1c5b      	adds	r3, r3, #1
c0d02128:	6013      	str	r3, [r2, #0]
    }

    // append the button mask
    button_mask = G_button_mask | new_button_mask;
c0d0212a:	6806      	ldr	r6, [r0, #0]
c0d0212c:	430e      	orrs	r6, r1

    // pre reset variable due to os_sched_exit
    button_same_mask_counter = G_button_same_mask_counter;
c0d0212e:	4a13      	ldr	r2, [pc, #76]	; (c0d0217c <io_seproxyhal_button_push+0x6c>)
c0d02130:	6815      	ldr	r5, [r2, #0]
c0d02132:	4f13      	ldr	r7, [pc, #76]	; (c0d02180 <io_seproxyhal_button_push+0x70>)

    // reset button mask
    if (new_button_mask == 0) {
c0d02134:	2900      	cmp	r1, #0
c0d02136:	d001      	beq.n	c0d0213c <io_seproxyhal_button_push+0x2c>

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
    }
    else {
      G_button_mask = button_mask;
c0d02138:	6006      	str	r6, [r0, #0]
c0d0213a:	e004      	b.n	c0d02146 <io_seproxyhal_button_push+0x36>
c0d0213c:	2300      	movs	r3, #0
    button_same_mask_counter = G_button_same_mask_counter;

    // reset button mask
    if (new_button_mask == 0) {
      // reset next state when button are released
      G_button_mask = 0;
c0d0213e:	6003      	str	r3, [r0, #0]
      G_button_same_mask_counter=0;
c0d02140:	6013      	str	r3, [r2, #0]

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
c0d02142:	1c7b      	adds	r3, r7, #1
c0d02144:	431e      	orrs	r6, r3
    else {
      G_button_mask = button_mask;
    }

    // reset counter when button mask changes
    if (new_button_mask != G_button_mask) {
c0d02146:	6800      	ldr	r0, [r0, #0]
c0d02148:	4288      	cmp	r0, r1
c0d0214a:	d001      	beq.n	c0d02150 <io_seproxyhal_button_push+0x40>
      G_button_same_mask_counter=0;
c0d0214c:	2000      	movs	r0, #0
c0d0214e:	6010      	str	r0, [r2, #0]
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
c0d02150:	2d08      	cmp	r5, #8
c0d02152:	d30b      	bcc.n	c0d0216c <io_seproxyhal_button_push+0x5c>
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d02154:	2103      	movs	r1, #3
c0d02156:	4628      	mov	r0, r5
c0d02158:	f003 ffae 	bl	c0d060b8 <__aeabi_uidivmod>
        button_mask |= BUTTON_EVT_FAST;
c0d0215c:	2001      	movs	r0, #1
c0d0215e:	0780      	lsls	r0, r0, #30
c0d02160:	4330      	orrs	r0, r6
      G_button_same_mask_counter=0;
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d02162:	2900      	cmp	r1, #0
c0d02164:	d000      	beq.n	c0d02168 <io_seproxyhal_button_push+0x58>
c0d02166:	4630      	mov	r0, r6
      }
      */

      // discard the release event after a fastskip has been detected, to avoid strange at release behavior
      // and also to enable user to cancel an operation by starting triggering the fast skip
      button_mask &= ~BUTTON_EVT_RELEASED;
c0d02168:	4038      	ands	r0, r7
c0d0216a:	e000      	b.n	c0d0216e <io_seproxyhal_button_push+0x5e>
c0d0216c:	4630      	mov	r0, r6
    }

    // indicate if button have been released
    button_callback(button_mask, button_same_mask_counter);
c0d0216e:	4629      	mov	r1, r5
c0d02170:	47a0      	blx	r4
  }
}
c0d02172:	b001      	add	sp, #4
c0d02174:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02176:	46c0      	nop			; (mov r8, r8)
c0d02178:	20001aa0 	.word	0x20001aa0
c0d0217c:	20001aa4 	.word	0x20001aa4
c0d02180:	7fffffff 	.word	0x7fffffff

c0d02184 <os_io_seproxyhal_get_app_name_and_version>:
#ifdef HAVE_IO_U2F
u2f_service_t G_io_u2f;
#endif // HAVE_IO_U2F

unsigned int os_io_seproxyhal_get_app_name_and_version(void) __attribute__((weak));
unsigned int os_io_seproxyhal_get_app_name_and_version(void) {
c0d02184:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02186:	b081      	sub	sp, #4
  unsigned int tx_len, len;
  // build the get app name and version reply
  tx_len = 0;
  G_io_apdu_buffer[tx_len++] = 1; // format ID
c0d02188:	4e0f      	ldr	r6, [pc, #60]	; (c0d021c8 <os_io_seproxyhal_get_app_name_and_version+0x44>)
c0d0218a:	2401      	movs	r4, #1
c0d0218c:	7034      	strb	r4, [r6, #0]

  // append app name
  len = os_registry_get_current_app_tag(BOLOS_TAG_APPNAME, G_io_apdu_buffer+tx_len+1, sizeof(G_io_apdu_buffer)-tx_len);
c0d0218e:	1cb1      	adds	r1, r6, #2
c0d02190:	27ff      	movs	r7, #255	; 0xff
c0d02192:	3750      	adds	r7, #80	; 0x50
c0d02194:	1c7a      	adds	r2, r7, #1
c0d02196:	4620      	mov	r0, r4
c0d02198:	f001 f81e 	bl	c0d031d8 <os_registry_get_current_app_tag>
c0d0219c:	4605      	mov	r5, r0
  G_io_apdu_buffer[tx_len++] = len;
c0d0219e:	7075      	strb	r5, [r6, #1]
  tx_len += len;
  // append app version
  len = os_registry_get_current_app_tag(BOLOS_TAG_APPVERSION, G_io_apdu_buffer+tx_len+1, sizeof(G_io_apdu_buffer)-tx_len);
c0d021a0:	1b7a      	subs	r2, r7, r5
unsigned int os_io_seproxyhal_get_app_name_and_version(void) __attribute__((weak));
unsigned int os_io_seproxyhal_get_app_name_and_version(void) {
  unsigned int tx_len, len;
  // build the get app name and version reply
  tx_len = 0;
  G_io_apdu_buffer[tx_len++] = 1; // format ID
c0d021a2:	1977      	adds	r7, r6, r5
  // append app name
  len = os_registry_get_current_app_tag(BOLOS_TAG_APPNAME, G_io_apdu_buffer+tx_len+1, sizeof(G_io_apdu_buffer)-tx_len);
  G_io_apdu_buffer[tx_len++] = len;
  tx_len += len;
  // append app version
  len = os_registry_get_current_app_tag(BOLOS_TAG_APPVERSION, G_io_apdu_buffer+tx_len+1, sizeof(G_io_apdu_buffer)-tx_len);
c0d021a4:	1cf9      	adds	r1, r7, #3
c0d021a6:	2002      	movs	r0, #2
c0d021a8:	f001 f816 	bl	c0d031d8 <os_registry_get_current_app_tag>
  G_io_apdu_buffer[tx_len++] = len;
c0d021ac:	70b8      	strb	r0, [r7, #2]
c0d021ae:	182d      	adds	r5, r5, r0
unsigned int os_io_seproxyhal_get_app_name_and_version(void) __attribute__((weak));
unsigned int os_io_seproxyhal_get_app_name_and_version(void) {
  unsigned int tx_len, len;
  // build the get app name and version reply
  tx_len = 0;
  G_io_apdu_buffer[tx_len++] = 1; // format ID
c0d021b0:	1976      	adds	r6, r6, r5
  // append app version
  len = os_registry_get_current_app_tag(BOLOS_TAG_APPVERSION, G_io_apdu_buffer+tx_len+1, sizeof(G_io_apdu_buffer)-tx_len);
  G_io_apdu_buffer[tx_len++] = len;
  tx_len += len;
  // return OS flags to notify of platform's global state (pin lock etc)
  G_io_apdu_buffer[tx_len++] = 1; // flags length
c0d021b2:	70f4      	strb	r4, [r6, #3]
  G_io_apdu_buffer[tx_len++] = os_flags();
c0d021b4:	f000 ffca 	bl	c0d0314c <os_flags>
c0d021b8:	7130      	strb	r0, [r6, #4]

  // status words
  G_io_apdu_buffer[tx_len++] = 0x90;
c0d021ba:	2090      	movs	r0, #144	; 0x90
c0d021bc:	7170      	strb	r0, [r6, #5]
  G_io_apdu_buffer[tx_len++] = 0x00;
c0d021be:	2000      	movs	r0, #0
c0d021c0:	71b0      	strb	r0, [r6, #6]
c0d021c2:	1de8      	adds	r0, r5, #7
  return tx_len;
c0d021c4:	b001      	add	sp, #4
c0d021c6:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d021c8:	20001924 	.word	0x20001924

c0d021cc <io_exchange>:
}


unsigned short io_exchange(unsigned char channel, unsigned short tx_len) {
c0d021cc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d021ce:	b087      	sub	sp, #28
  unsigned short rx_len;

#ifdef HAVE_BOLOS_APP_STACK_CANARY
  // behavior upon detected stack overflow is to reset the SE
  if (app_stack_canary != APP_STACK_CANARY_MAGIC) {
c0d021d0:	4a86      	ldr	r2, [pc, #536]	; (c0d023ec <io_exchange+0x220>)
c0d021d2:	6813      	ldr	r3, [r2, #0]
c0d021d4:	4a86      	ldr	r2, [pc, #536]	; (c0d023f0 <io_exchange+0x224>)
c0d021d6:	4293      	cmp	r3, r2
c0d021d8:	d000      	beq.n	c0d021dc <io_exchange+0x10>
c0d021da:	e104      	b.n	c0d023e6 <io_exchange+0x21a>
  }
  after_debug:
#endif // DEBUG_APDU

reply_apdu:
  switch(channel&~(IO_FLAGS)) {
c0d021dc:	2207      	movs	r2, #7
c0d021de:	4210      	tst	r0, r2
c0d021e0:	d006      	beq.n	c0d021f0 <io_exchange+0x24>
c0d021e2:	4607      	mov	r7, r0
      }
    }
    break;

  default:
    return io_exchange_al(channel, tx_len);
c0d021e4:	b2f8      	uxtb	r0, r7
c0d021e6:	f7fe f9f1 	bl	c0d005cc <io_exchange_al>
  }
}
c0d021ea:	b280      	uxth	r0, r0
c0d021ec:	b007      	add	sp, #28
c0d021ee:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d021f0:	9203      	str	r2, [sp, #12]
c0d021f2:	4a80      	ldr	r2, [pc, #512]	; (c0d023f4 <io_exchange+0x228>)
          goto reply_apdu; 
        }
        // exit app after replied
        else if (os_memcmp(G_io_apdu_buffer, "\xB0\xA7\x00\x00", 4) == 0) {
          tx_len = 0;
          G_io_apdu_buffer[tx_len++] = 0x90;
c0d021f4:	9201      	str	r2, [sp, #4]
c0d021f6:	2283      	movs	r2, #131	; 0x83
c0d021f8:	9204      	str	r2, [sp, #16]
c0d021fa:	4c7f      	ldr	r4, [pc, #508]	; (c0d023f8 <io_exchange+0x22c>)
c0d021fc:	4e80      	ldr	r6, [pc, #512]	; (c0d02400 <io_exchange+0x234>)
c0d021fe:	4607      	mov	r7, r0
c0d02200:	e011      	b.n	c0d02226 <io_exchange+0x5a>
c0d02202:	9804      	ldr	r0, [sp, #16]
c0d02204:	300d      	adds	r0, #13
c0d02206:	497f      	ldr	r1, [pc, #508]	; (c0d02404 <io_exchange+0x238>)
c0d02208:	7008      	strb	r0, [r1, #0]
          G_io_apdu_buffer[tx_len++] = 0x00;
c0d0220a:	704d      	strb	r5, [r1, #1]
c0d0220c:	9806      	ldr	r0, [sp, #24]
          // exit app after replied
          channel |= IO_RESET_AFTER_REPLIED;
c0d0220e:	4307      	orrs	r7, r0
c0d02210:	2102      	movs	r1, #2
  }
  after_debug:
#endif // DEBUG_APDU

reply_apdu:
  switch(channel&~(IO_FLAGS)) {
c0d02212:	9a03      	ldr	r2, [sp, #12]
c0d02214:	4210      	tst	r0, r2
c0d02216:	4638      	mov	r0, r7
c0d02218:	d005      	beq.n	c0d02226 <io_exchange+0x5a>
c0d0221a:	e7e3      	b.n	c0d021e4 <io_exchange+0x18>
      // an apdu has been received asynchroneously, return it
      if (G_io_apdu_state != APDU_IDLE && G_io_apdu_length > 0) {
        // handle reserved apdus
        // get name and version
        if (os_memcmp(G_io_apdu_buffer, "\xB0\x01\x00\x00", 4) == 0) {
          tx_len = os_io_seproxyhal_get_app_name_and_version();
c0d0221c:	f7ff ffb2 	bl	c0d02184 <os_io_seproxyhal_get_app_name_and_version>
c0d02220:	4601      	mov	r1, r0
c0d02222:	4628      	mov	r0, r5
c0d02224:	462f      	mov	r7, r5
reply_apdu:
  switch(channel&~(IO_FLAGS)) {
  case CHANNEL_APDU:
    // TODO work up the spi state machine over the HAL proxy until an APDU is available

    if (tx_len && !(channel&IO_ASYNCH_REPLY)) {
c0d02226:	2210      	movs	r2, #16
c0d02228:	4002      	ands	r2, r0
c0d0222a:	b28d      	uxth	r5, r1
c0d0222c:	2d00      	cmp	r5, #0
c0d0222e:	9006      	str	r0, [sp, #24]
c0d02230:	d100      	bne.n	c0d02234 <io_exchange+0x68>
c0d02232:	e08c      	b.n	c0d0234e <io_exchange+0x182>
c0d02234:	2a00      	cmp	r2, #0
c0d02236:	d000      	beq.n	c0d0223a <io_exchange+0x6e>
c0d02238:	e089      	b.n	c0d0234e <io_exchange+0x182>
c0d0223a:	7820      	ldrb	r0, [r4, #0]
      // until the whole RAPDU is transmitted, send chunks using the current mode for communication
      for (;;) {
        switch(G_io_apdu_state) {
c0d0223c:	2808      	cmp	r0, #8
c0d0223e:	9205      	str	r2, [sp, #20]
c0d02240:	dd19      	ble.n	c0d02276 <io_exchange+0xaa>
c0d02242:	2809      	cmp	r0, #9
c0d02244:	d01f      	beq.n	c0d02286 <io_exchange+0xba>
c0d02246:	280a      	cmp	r0, #10
c0d02248:	d158      	bne.n	c0d022fc <io_exchange+0x130>
            LOG("invalid state for APDU reply\n");
            THROW(INVALID_STATE);
            break;

          case APDU_RAW:
            if (tx_len > sizeof(G_io_apdu_buffer)) {
c0d0224a:	486f      	ldr	r0, [pc, #444]	; (c0d02408 <io_exchange+0x23c>)
c0d0224c:	4008      	ands	r0, r1
c0d0224e:	0840      	lsrs	r0, r0, #1
c0d02250:	28a9      	cmp	r0, #169	; 0xa9
c0d02252:	d300      	bcc.n	c0d02256 <io_exchange+0x8a>
c0d02254:	e0c4      	b.n	c0d023e0 <io_exchange+0x214>
              THROW(INVALID_PARAMETER);
            }
            // reply the RAW APDU over SEPROXYHAL protocol
            G_io_seproxyhal_spi_buffer[0]  = SEPROXYHAL_TAG_RAPDU;
c0d02256:	2053      	movs	r0, #83	; 0x53
c0d02258:	7030      	strb	r0, [r6, #0]
            G_io_seproxyhal_spi_buffer[1]  = (tx_len)>>8;
c0d0225a:	0a28      	lsrs	r0, r5, #8
c0d0225c:	7070      	strb	r0, [r6, #1]
            G_io_seproxyhal_spi_buffer[2]  = (tx_len);
c0d0225e:	70b1      	strb	r1, [r6, #2]
            io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d02260:	2103      	movs	r1, #3
c0d02262:	4630      	mov	r0, r6
c0d02264:	f000 ffd0 	bl	c0d03208 <io_seproxyhal_spi_send>
            io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);
c0d02268:	4866      	ldr	r0, [pc, #408]	; (c0d02404 <io_exchange+0x238>)
c0d0226a:	4629      	mov	r1, r5
c0d0226c:	f000 ffcc 	bl	c0d03208 <io_seproxyhal_spi_send>

            // isngle packet reply, mark immediate idle
            G_io_apdu_state = APDU_IDLE;
c0d02270:	2000      	movs	r0, #0
c0d02272:	7020      	strb	r0, [r4, #0]
c0d02274:	e052      	b.n	c0d0231c <io_exchange+0x150>
c0d02276:	2807      	cmp	r0, #7
c0d02278:	d13e      	bne.n	c0d022f8 <io_exchange+0x12c>
            goto break_send;

#ifdef HAVE_USB_APDU
          case APDU_USB_HID:
            // only send, don't perform synchronous reception of the next command (will be done later by the seproxyhal packet processing)
            io_usb_hid_send(io_usb_send_apdu_data, tx_len);
c0d0227a:	486a      	ldr	r0, [pc, #424]	; (c0d02424 <io_exchange+0x258>)
c0d0227c:	4478      	add	r0, pc
c0d0227e:	4629      	mov	r1, r5
c0d02280:	f7ff fbe8 	bl	c0d01a54 <io_usb_hid_send>
c0d02284:	e04a      	b.n	c0d0231c <io_exchange+0x150>
c0d02286:	2100      	movs	r1, #0
c0d02288:	4f5c      	ldr	r7, [pc, #368]	; (c0d023fc <io_exchange+0x230>)
          // case to handle U2F channels. u2f apdu to be dispatched in the upper layers
          case APDU_U2F:
            // prepare reply, the remaining segments will be pumped during USB/BLE events handling while waiting for the next APDU

            // the reply has been prepared by the application, stop sending anti timeouts
            u2f_message_set_autoreply_wait_user_presence(&G_io_u2f, false);
c0d0228a:	4638      	mov	r0, r7
c0d0228c:	9102      	str	r1, [sp, #8]
c0d0228e:	f002 f921 	bl	c0d044d4 <u2f_message_set_autoreply_wait_user_presence>

            // continue processing currently received command until completely received.
            while(!u2f_message_repliable(&G_io_u2f)) {
c0d02292:	4638      	mov	r0, r7
c0d02294:	f002 f931 	bl	c0d044fa <u2f_message_repliable>
c0d02298:	2800      	cmp	r0, #0
c0d0229a:	d10d      	bne.n	c0d022b8 <io_exchange+0xec>
              io_seproxyhal_general_status();
c0d0229c:	f7ff fc18 	bl	c0d01ad0 <io_seproxyhal_general_status>
              io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d022a0:	2180      	movs	r1, #128	; 0x80
c0d022a2:	2200      	movs	r2, #0
c0d022a4:	4630      	mov	r0, r6
c0d022a6:	f000 ffdb 	bl	c0d03260 <io_seproxyhal_spi_recv>
              // if packet is not well formed, then too bad ...
              io_seproxyhal_handle_event();
c0d022aa:	f7ff fcf3 	bl	c0d01c94 <io_seproxyhal_handle_event>

            // the reply has been prepared by the application, stop sending anti timeouts
            u2f_message_set_autoreply_wait_user_presence(&G_io_u2f, false);

            // continue processing currently received command until completely received.
            while(!u2f_message_repliable(&G_io_u2f)) {
c0d022ae:	4638      	mov	r0, r7
c0d022b0:	f002 f923 	bl	c0d044fa <u2f_message_repliable>
c0d022b4:	2801      	cmp	r0, #1
c0d022b6:	d1f1      	bne.n	c0d0229c <io_exchange+0xd0>
              // if packet is not well formed, then too bad ...
              io_seproxyhal_handle_event();
            }          

            // user presence + counter + rapdu + sw must fit the apdu buffer
            if (1U+ 4U+ tx_len +2U > sizeof(G_io_apdu_buffer)) {
c0d022b8:	1def      	adds	r7, r5, #7
c0d022ba:	0878      	lsrs	r0, r7, #1
c0d022bc:	28a9      	cmp	r0, #169	; 0xa9
c0d022be:	d300      	bcc.n	c0d022c2 <io_exchange+0xf6>
c0d022c0:	e08e      	b.n	c0d023e0 <io_exchange+0x214>
              THROW(INVALID_PARAMETER);
            }

            // u2F tunnel needs the status words to be included in the signature response BLOB, do it now.
            // always return 9000 in the signature to avoid error @ transport level in u2f layers. 
            G_io_apdu_buffer[tx_len] = 0x90; //G_io_apdu_buffer[tx_len-2];
c0d022c2:	9804      	ldr	r0, [sp, #16]
c0d022c4:	300d      	adds	r0, #13
c0d022c6:	494f      	ldr	r1, [pc, #316]	; (c0d02404 <io_exchange+0x238>)
c0d022c8:	5548      	strb	r0, [r1, r5]
c0d022ca:	1948      	adds	r0, r1, r5
            G_io_apdu_buffer[tx_len+1] = 0x00; //G_io_apdu_buffer[tx_len-1];
c0d022cc:	9a02      	ldr	r2, [sp, #8]
c0d022ce:	7042      	strb	r2, [r0, #1]
            tx_len += 2;
            os_memmove(G_io_apdu_buffer+5, G_io_apdu_buffer, tx_len);
c0d022d0:	9801      	ldr	r0, [sp, #4]
c0d022d2:	1d00      	adds	r0, r0, #4

            // u2F tunnel needs the status words to be included in the signature response BLOB, do it now.
            // always return 9000 in the signature to avoid error @ transport level in u2f layers. 
            G_io_apdu_buffer[tx_len] = 0x90; //G_io_apdu_buffer[tx_len-2];
            G_io_apdu_buffer[tx_len+1] = 0x00; //G_io_apdu_buffer[tx_len-1];
            tx_len += 2;
c0d022d4:	1caa      	adds	r2, r5, #2
            os_memmove(G_io_apdu_buffer+5, G_io_apdu_buffer, tx_len);
c0d022d6:	4002      	ands	r2, r0
c0d022d8:	1d48      	adds	r0, r1, #5
c0d022da:	460d      	mov	r5, r1
c0d022dc:	f7ff fb37 	bl	c0d0194e <os_memmove>
c0d022e0:	2205      	movs	r2, #5
            // zeroize user presence and counter
            os_memset(G_io_apdu_buffer, 0, 5);
c0d022e2:	4628      	mov	r0, r5
c0d022e4:	9902      	ldr	r1, [sp, #8]
c0d022e6:	f7ff fb29 	bl	c0d0193c <os_memset>
            u2f_message_reply(&G_io_u2f, U2F_CMD_MSG, G_io_apdu_buffer, tx_len+5);
c0d022ea:	b2bb      	uxth	r3, r7
c0d022ec:	4843      	ldr	r0, [pc, #268]	; (c0d023fc <io_exchange+0x230>)
c0d022ee:	9904      	ldr	r1, [sp, #16]
c0d022f0:	462a      	mov	r2, r5
c0d022f2:	f002 f91a 	bl	c0d0452a <u2f_message_reply>
c0d022f6:	e011      	b.n	c0d0231c <io_exchange+0x150>
c0d022f8:	2800      	cmp	r0, #0
c0d022fa:	d06e      	beq.n	c0d023da <io_exchange+0x20e>
      // until the whole RAPDU is transmitted, send chunks using the current mode for communication
      for (;;) {
        switch(G_io_apdu_state) {
          default: 
            // delegate to the hal in case of not generic transport mode (or asynch)
            if (io_exchange_al(channel, tx_len) == 0) {
c0d022fc:	b2f8      	uxtb	r0, r7
c0d022fe:	4629      	mov	r1, r5
c0d02300:	f7fe f964 	bl	c0d005cc <io_exchange_al>
c0d02304:	2800      	cmp	r0, #0
c0d02306:	d009      	beq.n	c0d0231c <io_exchange+0x150>
c0d02308:	e067      	b.n	c0d023da <io_exchange+0x20e>
        // wait end of reply transmission
        while (G_io_apdu_state != APDU_IDLE) {
#ifdef HAVE_TINY_COROUTINE
          tcr_yield();
#else // HAVE_TINY_COROUTINE
          io_seproxyhal_general_status();
c0d0230a:	f7ff fbe1 	bl	c0d01ad0 <io_seproxyhal_general_status>
          io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d0230e:	2180      	movs	r1, #128	; 0x80
c0d02310:	2200      	movs	r2, #0
c0d02312:	4630      	mov	r0, r6
c0d02314:	f000 ffa4 	bl	c0d03260 <io_seproxyhal_spi_recv>
          // if packet is not well formed, then too bad ...
          io_seproxyhal_handle_event();
c0d02318:	f7ff fcbc 	bl	c0d01c94 <io_seproxyhal_handle_event>
c0d0231c:	7820      	ldrb	r0, [r4, #0]
c0d0231e:	2800      	cmp	r0, #0
c0d02320:	d1f3      	bne.n	c0d0230a <io_exchange+0x13e>
c0d02322:	2000      	movs	r0, #0
#endif // HAVE_TINY_COROUTINE
        }

        // reset apdu state
        G_io_apdu_state = APDU_IDLE;
c0d02324:	7020      	strb	r0, [r4, #0]
        G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d02326:	4939      	ldr	r1, [pc, #228]	; (c0d0240c <io_exchange+0x240>)
c0d02328:	7008      	strb	r0, [r1, #0]

        G_io_apdu_length = 0;
c0d0232a:	4939      	ldr	r1, [pc, #228]	; (c0d02410 <io_exchange+0x244>)
c0d0232c:	8008      	strh	r0, [r1, #0]

        // continue sending commands, don't issue status yet
        if (channel & IO_RETURN_AFTER_TX) {
c0d0232e:	9906      	ldr	r1, [sp, #24]
c0d02330:	0689      	lsls	r1, r1, #26
c0d02332:	d500      	bpl.n	c0d02336 <io_exchange+0x16a>
c0d02334:	e759      	b.n	c0d021ea <io_exchange+0x1e>
          return 0;
        }
        // acknowledge the write request (general status OK) and no more command to follow (wait until another APDU container is received to continue unwrapping)
        io_seproxyhal_general_status();
c0d02336:	f7ff fbcb 	bl	c0d01ad0 <io_seproxyhal_general_status>
c0d0233a:	9806      	ldr	r0, [sp, #24]
        break;
      }

      // perform reset after io exchange
      if (channel & IO_RESET_AFTER_REPLIED) {
c0d0233c:	0601      	lsls	r1, r0, #24
c0d0233e:	9a05      	ldr	r2, [sp, #20]
c0d02340:	d505      	bpl.n	c0d0234e <io_exchange+0x182>
        os_sched_exit(1);
c0d02342:	2001      	movs	r0, #1
c0d02344:	4615      	mov	r5, r2
c0d02346:	f000 fed5 	bl	c0d030f4 <os_sched_exit>
c0d0234a:	462a      	mov	r2, r5
c0d0234c:	9806      	ldr	r0, [sp, #24]
        //reset();
      }
    }

#ifndef HAVE_TINY_COROUTINE
    if (!(channel&IO_ASYNCH_REPLY)) {
c0d0234e:	2a00      	cmp	r2, #0
c0d02350:	d105      	bne.n	c0d0235e <io_exchange+0x192>
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
c0d02352:	0640      	lsls	r0, r0, #25
c0d02354:	d43c      	bmi.n	c0d023d0 <io_exchange+0x204>
        // return apdu data - header
        return G_io_apdu_length-5;
      }

      // reply has ended, proceed to next apdu reception (reset status only after asynch reply)
      G_io_apdu_state = APDU_IDLE;
c0d02356:	2000      	movs	r0, #0
c0d02358:	7020      	strb	r0, [r4, #0]
      G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d0235a:	492c      	ldr	r1, [pc, #176]	; (c0d0240c <io_exchange+0x240>)
c0d0235c:	7008      	strb	r0, [r1, #0]
    }
#endif // HAVE_TINY_COROUTINE

    // reset the received apdu length
    G_io_apdu_length = 0;
c0d0235e:	2000      	movs	r0, #0
c0d02360:	492b      	ldr	r1, [pc, #172]	; (c0d02410 <io_exchange+0x244>)
c0d02362:	8008      	strh	r0, [r1, #0]
#ifdef HAVE_TINY_COROUTINE
      // give back hand to the seph task which interprets all incoming events first
      tcr_yield();
#else // HAVE_TINY_COROUTINE

      if (!io_seproxyhal_spi_is_status_sent()) {
c0d02364:	f000 ff66 	bl	c0d03234 <io_seproxyhal_spi_is_status_sent>
c0d02368:	2800      	cmp	r0, #0
c0d0236a:	d101      	bne.n	c0d02370 <io_exchange+0x1a4>
        io_seproxyhal_general_status();
c0d0236c:	f7ff fbb0 	bl	c0d01ad0 <io_seproxyhal_general_status>
      }
      // wait until a SPI packet is available
      // NOTE: on ST31, dual wait ISO & RF (ISO instead of SPI)
      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d02370:	2780      	movs	r7, #128	; 0x80
c0d02372:	2500      	movs	r5, #0
c0d02374:	4630      	mov	r0, r6
c0d02376:	4639      	mov	r1, r7
c0d02378:	462a      	mov	r2, r5
c0d0237a:	f000 ff71 	bl	c0d03260 <io_seproxyhal_spi_recv>

      // can't process split TLV, continue
      if (rx_len < 3 && rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
c0d0237e:	2802      	cmp	r0, #2
c0d02380:	d806      	bhi.n	c0d02390 <io_exchange+0x1c4>
c0d02382:	78b1      	ldrb	r1, [r6, #2]
c0d02384:	7872      	ldrb	r2, [r6, #1]
c0d02386:	0212      	lsls	r2, r2, #8
c0d02388:	430a      	orrs	r2, r1
c0d0238a:	1ec0      	subs	r0, r0, #3
c0d0238c:	4290      	cmp	r0, r2
c0d0238e:	d109      	bne.n	c0d023a4 <io_exchange+0x1d8>
        G_io_apdu_state = APDU_IDLE;
        G_io_apdu_length = 0;
        continue;
      }

        io_seproxyhal_handle_event();
c0d02390:	f7ff fc80 	bl	c0d01c94 <io_seproxyhal_handle_event>
#endif // HAVE_TINY_COROUTINE

      // an apdu has been received asynchroneously, return it
      if (G_io_apdu_state != APDU_IDLE && G_io_apdu_length > 0) {
c0d02394:	7820      	ldrb	r0, [r4, #0]
c0d02396:	2800      	cmp	r0, #0
c0d02398:	d0e4      	beq.n	c0d02364 <io_exchange+0x198>
c0d0239a:	481d      	ldr	r0, [pc, #116]	; (c0d02410 <io_exchange+0x244>)
c0d0239c:	8800      	ldrh	r0, [r0, #0]
c0d0239e:	2800      	cmp	r0, #0
c0d023a0:	d0e0      	beq.n	c0d02364 <io_exchange+0x198>
c0d023a2:	e002      	b.n	c0d023aa <io_exchange+0x1de>
c0d023a4:	2000      	movs	r0, #0
      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);

      // can't process split TLV, continue
      if (rx_len < 3 && rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
        LOG("invalid TLV format\n");
        G_io_apdu_state = APDU_IDLE;
c0d023a6:	7020      	strb	r0, [r4, #0]
c0d023a8:	e7da      	b.n	c0d02360 <io_exchange+0x194>

      // an apdu has been received asynchroneously, return it
      if (G_io_apdu_state != APDU_IDLE && G_io_apdu_length > 0) {
        // handle reserved apdus
        // get name and version
        if (os_memcmp(G_io_apdu_buffer, "\xB0\x01\x00\x00", 4) == 0) {
c0d023aa:	2204      	movs	r2, #4
c0d023ac:	4815      	ldr	r0, [pc, #84]	; (c0d02404 <io_exchange+0x238>)
c0d023ae:	a119      	add	r1, pc, #100	; (adr r1, c0d02414 <io_exchange+0x248>)
c0d023b0:	f7ff fb6a 	bl	c0d01a88 <os_memcmp>
c0d023b4:	2800      	cmp	r0, #0
c0d023b6:	d100      	bne.n	c0d023ba <io_exchange+0x1ee>
c0d023b8:	e730      	b.n	c0d0221c <io_exchange+0x50>
          // disable 'return after tx' and 'asynch reply' flags
          channel &= ~IO_FLAGS;
          goto reply_apdu; 
        }
        // exit app after replied
        else if (os_memcmp(G_io_apdu_buffer, "\xB0\xA7\x00\x00", 4) == 0) {
c0d023ba:	2204      	movs	r2, #4
c0d023bc:	4811      	ldr	r0, [pc, #68]	; (c0d02404 <io_exchange+0x238>)
c0d023be:	a117      	add	r1, pc, #92	; (adr r1, c0d0241c <io_exchange+0x250>)
c0d023c0:	f7ff fb62 	bl	c0d01a88 <os_memcmp>
c0d023c4:	2800      	cmp	r0, #0
c0d023c6:	d100      	bne.n	c0d023ca <io_exchange+0x1fe>
c0d023c8:	e71b      	b.n	c0d02202 <io_exchange+0x36>
          // disable 'return after tx' and 'asynch reply' flags
          channel &= ~IO_FLAGS;
          goto reply_apdu; 
        }
#endif // HAVE_BOLOS_WITH_VIRGIN_ATTESTATION
        return G_io_apdu_length;
c0d023ca:	4811      	ldr	r0, [pc, #68]	; (c0d02410 <io_exchange+0x244>)
c0d023cc:	8800      	ldrh	r0, [r0, #0]
c0d023ce:	e70c      	b.n	c0d021ea <io_exchange+0x1e>
    if (!(channel&IO_ASYNCH_REPLY)) {
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
        // return apdu data - header
        return G_io_apdu_length-5;
c0d023d0:	480f      	ldr	r0, [pc, #60]	; (c0d02410 <io_exchange+0x244>)
c0d023d2:	8800      	ldrh	r0, [r0, #0]
c0d023d4:	9901      	ldr	r1, [sp, #4]
c0d023d6:	1840      	adds	r0, r0, r1
c0d023d8:	e707      	b.n	c0d021ea <io_exchange+0x1e>
            if (io_exchange_al(channel, tx_len) == 0) {
              goto break_send;
            }
          case APDU_IDLE:
            LOG("invalid state for APDU reply\n");
            THROW(INVALID_STATE);
c0d023da:	2009      	movs	r0, #9
c0d023dc:	f7ff fb6b 	bl	c0d01ab6 <os_longjmp>
c0d023e0:	2002      	movs	r0, #2
c0d023e2:	f7ff fb68 	bl	c0d01ab6 <os_longjmp>
  unsigned short rx_len;

#ifdef HAVE_BOLOS_APP_STACK_CANARY
  // behavior upon detected stack overflow is to reset the SE
  if (app_stack_canary != APP_STACK_CANARY_MAGIC) {
    io_seproxyhal_se_reset();
c0d023e6:	f7ff fe85 	bl	c0d020f4 <io_seproxyhal_se_reset>
c0d023ea:	46c0      	nop			; (mov r8, r8)
c0d023ec:	2000248c 	.word	0x2000248c
c0d023f0:	dead0031 	.word	0xdead0031
c0d023f4:	0000fffb 	.word	0x0000fffb
c0d023f8:	20001a96 	.word	0x20001a96
c0d023fc:	20001aa8 	.word	0x20001aa8
c0d02400:	20001800 	.word	0x20001800
c0d02404:	20001924 	.word	0x20001924
c0d02408:	0000fffe 	.word	0x0000fffe
c0d0240c:	20001a80 	.word	0x20001a80
c0d02410:	20001a98 	.word	0x20001a98
c0d02414:	000001b0 	.word	0x000001b0
c0d02418:	00000000 	.word	0x00000000
c0d0241c:	0000a7b0 	.word	0x0000a7b0
c0d02420:	00000000 	.word	0x00000000
c0d02424:	fffff9b9 	.word	0xfffff9b9

c0d02428 <ux_menu_element_preprocessor>:
    return ux_menu.menu_iterator(entry_idx);
  } 
  return &ux_menu.menu_entries[entry_idx];
} 

const bagl_element_t* ux_menu_element_preprocessor(const bagl_element_t* element) {
c0d02428:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0242a:	b081      	sub	sp, #4
c0d0242c:	4607      	mov	r7, r0
  //todo avoid center alignment when text_x or icon_x AND text_x are not 0
  os_memmove(&ux_menu.tmp_element, element, sizeof(bagl_element_t));
c0d0242e:	4c5f      	ldr	r4, [pc, #380]	; (c0d025ac <ux_menu_element_preprocessor+0x184>)
c0d02430:	4625      	mov	r5, r4
c0d02432:	3514      	adds	r5, #20
c0d02434:	2238      	movs	r2, #56	; 0x38
c0d02436:	4628      	mov	r0, r5
c0d02438:	4639      	mov	r1, r7
c0d0243a:	f7ff fa88 	bl	c0d0194e <os_memmove>
  {{BAGL_LABELINE                       , 0x22,  14,  26, 100,  12, 0, 0, 0        , 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_EXTRABOLD_11px|BAGL_FONT_ALIGNMENT_CENTER, 0  }, NULL, 0, 0, 0, NULL, NULL, NULL },

};

const ux_menu_entry_t* ux_menu_get_entry (unsigned int entry_idx) {
  if (ux_menu.menu_iterator) {
c0d0243e:	6921      	ldr	r1, [r4, #16]
const bagl_element_t* ux_menu_element_preprocessor(const bagl_element_t* element) {
  //todo avoid center alignment when text_x or icon_x AND text_x are not 0
  os_memmove(&ux_menu.tmp_element, element, sizeof(bagl_element_t));

  // ask the current entry first, to setup other entries
  const ux_menu_entry_t* current_entry = ux_menu_get_entry(ux_menu.current_entry);
c0d02440:	68a0      	ldr	r0, [r4, #8]
  {{BAGL_LABELINE                       , 0x22,  14,  26, 100,  12, 0, 0, 0        , 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_EXTRABOLD_11px|BAGL_FONT_ALIGNMENT_CENTER, 0  }, NULL, 0, 0, 0, NULL, NULL, NULL },

};

const ux_menu_entry_t* ux_menu_get_entry (unsigned int entry_idx) {
  if (ux_menu.menu_iterator) {
c0d02442:	2900      	cmp	r1, #0
c0d02444:	d003      	beq.n	c0d0244e <ux_menu_element_preprocessor+0x26>
    return ux_menu.menu_iterator(entry_idx);
c0d02446:	4788      	blx	r1
c0d02448:	4603      	mov	r3, r0
c0d0244a:	68a0      	ldr	r0, [r4, #8]
c0d0244c:	e003      	b.n	c0d02456 <ux_menu_element_preprocessor+0x2e>
  } 
  return &ux_menu.menu_entries[entry_idx];
c0d0244e:	211c      	movs	r1, #28
c0d02450:	4341      	muls	r1, r0
c0d02452:	6822      	ldr	r2, [r4, #0]
c0d02454:	1853      	adds	r3, r2, r1
c0d02456:	2600      	movs	r6, #0

  // ask the current entry first, to setup other entries
  const ux_menu_entry_t* current_entry = ux_menu_get_entry(ux_menu.current_entry);

  const ux_menu_entry_t* previous_entry = NULL;
  if (ux_menu.current_entry) {
c0d02458:	2800      	cmp	r0, #0
c0d0245a:	d010      	beq.n	c0d0247e <ux_menu_element_preprocessor+0x56>
  {{BAGL_LABELINE                       , 0x22,  14,  26, 100,  12, 0, 0, 0        , 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_EXTRABOLD_11px|BAGL_FONT_ALIGNMENT_CENTER, 0  }, NULL, 0, 0, 0, NULL, NULL, NULL },

};

const ux_menu_entry_t* ux_menu_get_entry (unsigned int entry_idx) {
  if (ux_menu.menu_iterator) {
c0d0245c:	6922      	ldr	r2, [r4, #16]
  // ask the current entry first, to setup other entries
  const ux_menu_entry_t* current_entry = ux_menu_get_entry(ux_menu.current_entry);

  const ux_menu_entry_t* previous_entry = NULL;
  if (ux_menu.current_entry) {
    previous_entry = ux_menu_get_entry(ux_menu.current_entry-1);
c0d0245e:	1e41      	subs	r1, r0, #1
  {{BAGL_LABELINE                       , 0x22,  14,  26, 100,  12, 0, 0, 0        , 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_EXTRABOLD_11px|BAGL_FONT_ALIGNMENT_CENTER, 0  }, NULL, 0, 0, 0, NULL, NULL, NULL },

};

const ux_menu_entry_t* ux_menu_get_entry (unsigned int entry_idx) {
  if (ux_menu.menu_iterator) {
c0d02460:	2a00      	cmp	r2, #0
c0d02462:	d00f      	beq.n	c0d02484 <ux_menu_element_preprocessor+0x5c>
    return ux_menu.menu_iterator(entry_idx);
c0d02464:	4608      	mov	r0, r1
c0d02466:	9700      	str	r7, [sp, #0]
c0d02468:	4637      	mov	r7, r6
c0d0246a:	462e      	mov	r6, r5
c0d0246c:	461d      	mov	r5, r3
c0d0246e:	4790      	blx	r2
c0d02470:	462b      	mov	r3, r5
c0d02472:	4635      	mov	r5, r6
c0d02474:	463e      	mov	r6, r7
c0d02476:	9f00      	ldr	r7, [sp, #0]
c0d02478:	4602      	mov	r2, r0
c0d0247a:	68a0      	ldr	r0, [r4, #8]
c0d0247c:	e006      	b.n	c0d0248c <ux_menu_element_preprocessor+0x64>
  const ux_menu_entry_t* previous_entry = NULL;
  if (ux_menu.current_entry) {
    previous_entry = ux_menu_get_entry(ux_menu.current_entry-1);
  }
  const ux_menu_entry_t* next_entry = NULL;
  if (ux_menu.current_entry < ux_menu.menu_entries_count-1) {
c0d0247e:	4630      	mov	r0, r6
c0d02480:	4632      	mov	r2, r6
c0d02482:	e003      	b.n	c0d0248c <ux_menu_element_preprocessor+0x64>

const ux_menu_entry_t* ux_menu_get_entry (unsigned int entry_idx) {
  if (ux_menu.menu_iterator) {
    return ux_menu.menu_iterator(entry_idx);
  } 
  return &ux_menu.menu_entries[entry_idx];
c0d02484:	221c      	movs	r2, #28
c0d02486:	434a      	muls	r2, r1
c0d02488:	6821      	ldr	r1, [r4, #0]
c0d0248a:	188a      	adds	r2, r1, r2
  const ux_menu_entry_t* previous_entry = NULL;
  if (ux_menu.current_entry) {
    previous_entry = ux_menu_get_entry(ux_menu.current_entry-1);
  }
  const ux_menu_entry_t* next_entry = NULL;
  if (ux_menu.current_entry < ux_menu.menu_entries_count-1) {
c0d0248c:	6861      	ldr	r1, [r4, #4]
c0d0248e:	1e49      	subs	r1, r1, #1
c0d02490:	4288      	cmp	r0, r1
c0d02492:	d210      	bcs.n	c0d024b6 <ux_menu_element_preprocessor+0x8e>
  {{BAGL_LABELINE                       , 0x22,  14,  26, 100,  12, 0, 0, 0        , 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_EXTRABOLD_11px|BAGL_FONT_ALIGNMENT_CENTER, 0  }, NULL, 0, 0, 0, NULL, NULL, NULL },

};

const ux_menu_entry_t* ux_menu_get_entry (unsigned int entry_idx) {
  if (ux_menu.menu_iterator) {
c0d02494:	6921      	ldr	r1, [r4, #16]
  if (ux_menu.current_entry) {
    previous_entry = ux_menu_get_entry(ux_menu.current_entry-1);
  }
  const ux_menu_entry_t* next_entry = NULL;
  if (ux_menu.current_entry < ux_menu.menu_entries_count-1) {
    next_entry = ux_menu_get_entry(ux_menu.current_entry+1);
c0d02496:	1c40      	adds	r0, r0, #1
  {{BAGL_LABELINE                       , 0x22,  14,  26, 100,  12, 0, 0, 0        , 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_EXTRABOLD_11px|BAGL_FONT_ALIGNMENT_CENTER, 0  }, NULL, 0, 0, 0, NULL, NULL, NULL },

};

const ux_menu_entry_t* ux_menu_get_entry (unsigned int entry_idx) {
  if (ux_menu.menu_iterator) {
c0d02498:	2900      	cmp	r1, #0
c0d0249a:	d008      	beq.n	c0d024ae <ux_menu_element_preprocessor+0x86>
c0d0249c:	9500      	str	r5, [sp, #0]
c0d0249e:	461d      	mov	r5, r3
c0d024a0:	4616      	mov	r6, r2
    return ux_menu.menu_iterator(entry_idx);
c0d024a2:	4788      	blx	r1
c0d024a4:	4632      	mov	r2, r6
c0d024a6:	462b      	mov	r3, r5
c0d024a8:	9d00      	ldr	r5, [sp, #0]
c0d024aa:	4606      	mov	r6, r0
c0d024ac:	e003      	b.n	c0d024b6 <ux_menu_element_preprocessor+0x8e>
  } 
  return &ux_menu.menu_entries[entry_idx];
c0d024ae:	211c      	movs	r1, #28
c0d024b0:	4341      	muls	r1, r0
c0d024b2:	6820      	ldr	r0, [r4, #0]
c0d024b4:	1846      	adds	r6, r0, r1
c0d024b6:	7878      	ldrb	r0, [r7, #1]
  const ux_menu_entry_t* next_entry = NULL;
  if (ux_menu.current_entry < ux_menu.menu_entries_count-1) {
    next_entry = ux_menu_get_entry(ux_menu.current_entry+1);
  }

  switch(element->component.userid) {
c0d024b8:	2840      	cmp	r0, #64	; 0x40
c0d024ba:	dc0a      	bgt.n	c0d024d2 <ux_menu_element_preprocessor+0xaa>
c0d024bc:	2820      	cmp	r0, #32
c0d024be:	dc22      	bgt.n	c0d02506 <ux_menu_element_preprocessor+0xde>
c0d024c0:	2810      	cmp	r0, #16
c0d024c2:	d034      	beq.n	c0d0252e <ux_menu_element_preprocessor+0x106>
c0d024c4:	2820      	cmp	r0, #32
c0d024c6:	d167      	bne.n	c0d02598 <ux_menu_element_preprocessor+0x170>
      if (current_entry->icon_x) {
        ux_menu.tmp_element.component.x = current_entry->icon_x;
      }
      break;
    case 0x20:
      if (current_entry->line2 != NULL) {
c0d024c8:	6959      	ldr	r1, [r3, #20]
c0d024ca:	2000      	movs	r0, #0
c0d024cc:	2900      	cmp	r1, #0
c0d024ce:	d16b      	bne.n	c0d025a8 <ux_menu_element_preprocessor+0x180>
c0d024d0:	e051      	b.n	c0d02576 <ux_menu_element_preprocessor+0x14e>
c0d024d2:	2880      	cmp	r0, #128	; 0x80
c0d024d4:	dc22      	bgt.n	c0d0251c <ux_menu_element_preprocessor+0xf4>
c0d024d6:	2841      	cmp	r0, #65	; 0x41
c0d024d8:	d033      	beq.n	c0d02542 <ux_menu_element_preprocessor+0x11a>
c0d024da:	2842      	cmp	r0, #66	; 0x42
c0d024dc:	d15c      	bne.n	c0d02598 <ux_menu_element_preprocessor+0x170>
      }
      ux_menu.tmp_element.text = previous_entry->line1;
      break;
    // next setting name
    case 0x42:
      if (current_entry->line2 != NULL 
c0d024de:	6959      	ldr	r1, [r3, #20]
c0d024e0:	2000      	movs	r0, #0
        || current_entry->icon != NULL
c0d024e2:	2900      	cmp	r1, #0
c0d024e4:	d160      	bne.n	c0d025a8 <ux_menu_element_preprocessor+0x180>
c0d024e6:	68d9      	ldr	r1, [r3, #12]
        || ux_menu.current_entry == ux_menu.menu_entries_count-1
c0d024e8:	2900      	cmp	r1, #0
c0d024ea:	d15d      	bne.n	c0d025a8 <ux_menu_element_preprocessor+0x180>
c0d024ec:	6862      	ldr	r2, [r4, #4]
c0d024ee:	1e51      	subs	r1, r2, #1
        || ux_menu.menu_entries_count == 1
c0d024f0:	2a01      	cmp	r2, #1
c0d024f2:	d059      	beq.n	c0d025a8 <ux_menu_element_preprocessor+0x180>
      break;
    // next setting name
    case 0x42:
      if (current_entry->line2 != NULL 
        || current_entry->icon != NULL
        || ux_menu.current_entry == ux_menu.menu_entries_count-1
c0d024f4:	68a2      	ldr	r2, [r4, #8]
c0d024f6:	428a      	cmp	r2, r1
c0d024f8:	d056      	beq.n	c0d025a8 <ux_menu_element_preprocessor+0x180>
        || ux_menu.menu_entries_count == 1
        || next_entry->icon != NULL) {
c0d024fa:	68f1      	ldr	r1, [r6, #12]
      }
      ux_menu.tmp_element.text = previous_entry->line1;
      break;
    // next setting name
    case 0x42:
      if (current_entry->line2 != NULL 
c0d024fc:	2900      	cmp	r1, #0
c0d024fe:	d153      	bne.n	c0d025a8 <ux_menu_element_preprocessor+0x180>
        || ux_menu.current_entry == ux_menu.menu_entries_count-1
        || ux_menu.menu_entries_count == 1
        || next_entry->icon != NULL) {
        return NULL;
      }
      ux_menu.tmp_element.text = next_entry->line1;
c0d02500:	6930      	ldr	r0, [r6, #16]
c0d02502:	6320      	str	r0, [r4, #48]	; 0x30
c0d02504:	e048      	b.n	c0d02598 <ux_menu_element_preprocessor+0x170>
c0d02506:	2821      	cmp	r0, #33	; 0x21
c0d02508:	d031      	beq.n	c0d0256e <ux_menu_element_preprocessor+0x146>
c0d0250a:	2822      	cmp	r0, #34	; 0x22
c0d0250c:	d144      	bne.n	c0d02598 <ux_menu_element_preprocessor+0x170>
        return NULL;
      }
      ux_menu.tmp_element.text = current_entry->line1;
      goto adjust_text_x;
    case 0x22:
      if (current_entry->line2 == NULL) {
c0d0250e:	4619      	mov	r1, r3
c0d02510:	3114      	adds	r1, #20
c0d02512:	695a      	ldr	r2, [r3, #20]
c0d02514:	2000      	movs	r0, #0
c0d02516:	2a00      	cmp	r2, #0
c0d02518:	d12f      	bne.n	c0d0257a <ux_menu_element_preprocessor+0x152>
c0d0251a:	e045      	b.n	c0d025a8 <ux_menu_element_preprocessor+0x180>
c0d0251c:	2882      	cmp	r0, #130	; 0x82
c0d0251e:	d035      	beq.n	c0d0258c <ux_menu_element_preprocessor+0x164>
c0d02520:	2881      	cmp	r0, #129	; 0x81
c0d02522:	d139      	bne.n	c0d02598 <ux_menu_element_preprocessor+0x170>
    next_entry = ux_menu_get_entry(ux_menu.current_entry+1);
  }

  switch(element->component.userid) {
    case 0x81:
      if (ux_menu.current_entry == 0) {
c0d02524:	68a1      	ldr	r1, [r4, #8]
c0d02526:	2000      	movs	r0, #0
c0d02528:	2900      	cmp	r1, #0
c0d0252a:	d135      	bne.n	c0d02598 <ux_menu_element_preprocessor+0x170>
c0d0252c:	e03c      	b.n	c0d025a8 <ux_menu_element_preprocessor+0x180>
        return NULL;
      }
      ux_menu.tmp_element.text = next_entry->line1;
      break;
    case 0x10:
      if (current_entry->icon == NULL) {
c0d0252e:	68d9      	ldr	r1, [r3, #12]
c0d02530:	2000      	movs	r0, #0
c0d02532:	2900      	cmp	r1, #0
c0d02534:	d038      	beq.n	c0d025a8 <ux_menu_element_preprocessor+0x180>
        return NULL;
      }
      ux_menu.tmp_element.text = (const char*)current_entry->icon;
c0d02536:	6321      	str	r1, [r4, #48]	; 0x30
      if (current_entry->icon_x) {
c0d02538:	7e58      	ldrb	r0, [r3, #25]
c0d0253a:	2800      	cmp	r0, #0
c0d0253c:	d02c      	beq.n	c0d02598 <ux_menu_element_preprocessor+0x170>
        ux_menu.tmp_element.component.x = current_entry->icon_x;
c0d0253e:	82e0      	strh	r0, [r4, #22]
c0d02540:	e02a      	b.n	c0d02598 <ux_menu_element_preprocessor+0x170>
        return NULL;
      }
      break;
    // previous setting name
    case 0x41:
      if (current_entry->line2 != NULL 
c0d02542:	6959      	ldr	r1, [r3, #20]
c0d02544:	2000      	movs	r0, #0
        || current_entry->icon != NULL
c0d02546:	2900      	cmp	r1, #0
c0d02548:	d12e      	bne.n	c0d025a8 <ux_menu_element_preprocessor+0x180>
c0d0254a:	68d9      	ldr	r1, [r3, #12]
        || ux_menu.current_entry == 0
c0d0254c:	2900      	cmp	r1, #0
c0d0254e:	d12b      	bne.n	c0d025a8 <ux_menu_element_preprocessor+0x180>
c0d02550:	68a1      	ldr	r1, [r4, #8]
c0d02552:	2900      	cmp	r1, #0
c0d02554:	d028      	beq.n	c0d025a8 <ux_menu_element_preprocessor+0x180>
        || ux_menu.menu_entries_count == 1 
c0d02556:	6861      	ldr	r1, [r4, #4]
c0d02558:	2901      	cmp	r1, #1
c0d0255a:	d025      	beq.n	c0d025a8 <ux_menu_element_preprocessor+0x180>
        || previous_entry->icon != NULL
c0d0255c:	68d1      	ldr	r1, [r2, #12]
        || previous_entry->line2 != NULL) {
c0d0255e:	2900      	cmp	r1, #0
c0d02560:	d122      	bne.n	c0d025a8 <ux_menu_element_preprocessor+0x180>
c0d02562:	6951      	ldr	r1, [r2, #20]
        return NULL;
      }
      break;
    // previous setting name
    case 0x41:
      if (current_entry->line2 != NULL 
c0d02564:	2900      	cmp	r1, #0
c0d02566:	d11f      	bne.n	c0d025a8 <ux_menu_element_preprocessor+0x180>
        || ux_menu.menu_entries_count == 1 
        || previous_entry->icon != NULL
        || previous_entry->line2 != NULL) {
        return 0;
      }
      ux_menu.tmp_element.text = previous_entry->line1;
c0d02568:	6910      	ldr	r0, [r2, #16]
c0d0256a:	6320      	str	r0, [r4, #48]	; 0x30
c0d0256c:	e014      	b.n	c0d02598 <ux_menu_element_preprocessor+0x170>
        return NULL;
      }
      ux_menu.tmp_element.text = current_entry->line1;
      goto adjust_text_x;
    case 0x21:
      if (current_entry->line2 == NULL) {
c0d0256e:	6959      	ldr	r1, [r3, #20]
c0d02570:	2000      	movs	r0, #0
c0d02572:	2900      	cmp	r1, #0
c0d02574:	d018      	beq.n	c0d025a8 <ux_menu_element_preprocessor+0x180>
c0d02576:	4619      	mov	r1, r3
c0d02578:	3110      	adds	r1, #16
c0d0257a:	6808      	ldr	r0, [r1, #0]
c0d0257c:	6320      	str	r0, [r4, #48]	; 0x30
      if (current_entry->line2 == NULL) {
        return NULL;
      }
      ux_menu.tmp_element.text = current_entry->line2;
    adjust_text_x:
      if (current_entry->text_x) {
c0d0257e:	7e18      	ldrb	r0, [r3, #24]
c0d02580:	2800      	cmp	r0, #0
c0d02582:	d009      	beq.n	c0d02598 <ux_menu_element_preprocessor+0x170>
        ux_menu.tmp_element.component.x = current_entry->text_x;
c0d02584:	82e0      	strh	r0, [r4, #22]
        // discard the 'center' flag
        ux_menu.tmp_element.component.font_id = BAGL_FONT_OPEN_SANS_EXTRABOLD_11px;
c0d02586:	2008      	movs	r0, #8
c0d02588:	85a0      	strh	r0, [r4, #44]	; 0x2c
c0d0258a:	e005      	b.n	c0d02598 <ux_menu_element_preprocessor+0x170>
      if (ux_menu.current_entry == 0) {
        return NULL;
      }
      break;
    case 0x82:
      if (ux_menu.current_entry == ux_menu.menu_entries_count-1) {
c0d0258c:	6860      	ldr	r0, [r4, #4]
c0d0258e:	68a1      	ldr	r1, [r4, #8]
c0d02590:	1e42      	subs	r2, r0, #1
c0d02592:	2000      	movs	r0, #0
c0d02594:	4291      	cmp	r1, r2
c0d02596:	d007      	beq.n	c0d025a8 <ux_menu_element_preprocessor+0x180>
        ux_menu.tmp_element.component.font_id = BAGL_FONT_OPEN_SANS_EXTRABOLD_11px;
      }
      break;
  }
  // ensure prepro agrees to the element to be displayed
  if (ux_menu.menu_entry_preprocessor) {
c0d02598:	68e2      	ldr	r2, [r4, #12]
c0d0259a:	2a00      	cmp	r2, #0
c0d0259c:	4628      	mov	r0, r5
c0d0259e:	d003      	beq.n	c0d025a8 <ux_menu_element_preprocessor+0x180>
    // menu is denied by the menu entry preprocessor
    return ux_menu.menu_entry_preprocessor(current_entry, &ux_menu.tmp_element);
c0d025a0:	3414      	adds	r4, #20
c0d025a2:	4618      	mov	r0, r3
c0d025a4:	4621      	mov	r1, r4
c0d025a6:	4790      	blx	r2
  }

  return &ux_menu.tmp_element;
}
c0d025a8:	b001      	add	sp, #4
c0d025aa:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d025ac:	20001aec 	.word	0x20001aec

c0d025b0 <ux_menu_elements_button>:

unsigned int ux_menu_elements_button (unsigned int button_mask, unsigned int button_mask_counter) {
c0d025b0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d025b2:	b081      	sub	sp, #4
c0d025b4:	4605      	mov	r5, r0
  UNUSED(button_mask_counter);

  const ux_menu_entry_t* current_entry = ux_menu_get_entry(ux_menu.current_entry);
c0d025b6:	4f3d      	ldr	r7, [pc, #244]	; (c0d026ac <ux_menu_elements_button+0xfc>)
  {{BAGL_LABELINE                       , 0x22,  14,  26, 100,  12, 0, 0, 0        , 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_EXTRABOLD_11px|BAGL_FONT_ALIGNMENT_CENTER, 0  }, NULL, 0, 0, 0, NULL, NULL, NULL },

};

const ux_menu_entry_t* ux_menu_get_entry (unsigned int entry_idx) {
  if (ux_menu.menu_iterator) {
c0d025b8:	6939      	ldr	r1, [r7, #16]
}

unsigned int ux_menu_elements_button (unsigned int button_mask, unsigned int button_mask_counter) {
  UNUSED(button_mask_counter);

  const ux_menu_entry_t* current_entry = ux_menu_get_entry(ux_menu.current_entry);
c0d025ba:	68b8      	ldr	r0, [r7, #8]
  {{BAGL_LABELINE                       , 0x22,  14,  26, 100,  12, 0, 0, 0        , 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_EXTRABOLD_11px|BAGL_FONT_ALIGNMENT_CENTER, 0  }, NULL, 0, 0, 0, NULL, NULL, NULL },

};

const ux_menu_entry_t* ux_menu_get_entry (unsigned int entry_idx) {
  if (ux_menu.menu_iterator) {
c0d025bc:	2900      	cmp	r1, #0
c0d025be:	d002      	beq.n	c0d025c6 <ux_menu_elements_button+0x16>
    return ux_menu.menu_iterator(entry_idx);
c0d025c0:	4788      	blx	r1
c0d025c2:	4606      	mov	r6, r0
c0d025c4:	e003      	b.n	c0d025ce <ux_menu_elements_button+0x1e>
  } 
  return &ux_menu.menu_entries[entry_idx];
c0d025c6:	211c      	movs	r1, #28
c0d025c8:	4341      	muls	r1, r0
c0d025ca:	6838      	ldr	r0, [r7, #0]
c0d025cc:	1846      	adds	r6, r0, r1
c0d025ce:	2401      	movs	r4, #1
unsigned int ux_menu_elements_button (unsigned int button_mask, unsigned int button_mask_counter) {
  UNUSED(button_mask_counter);

  const ux_menu_entry_t* current_entry = ux_menu_get_entry(ux_menu.current_entry);

  switch (button_mask) {
c0d025d0:	4837      	ldr	r0, [pc, #220]	; (c0d026b0 <ux_menu_elements_button+0x100>)
c0d025d2:	4285      	cmp	r5, r0
c0d025d4:	dd14      	ble.n	c0d02600 <ux_menu_elements_button+0x50>
c0d025d6:	4837      	ldr	r0, [pc, #220]	; (c0d026b4 <ux_menu_elements_button+0x104>)
c0d025d8:	4285      	cmp	r5, r0
c0d025da:	d017      	beq.n	c0d0260c <ux_menu_elements_button+0x5c>
c0d025dc:	4836      	ldr	r0, [pc, #216]	; (c0d026b8 <ux_menu_elements_button+0x108>)
c0d025de:	4285      	cmp	r5, r0
c0d025e0:	d01c      	beq.n	c0d0261c <ux_menu_elements_button+0x6c>
c0d025e2:	4836      	ldr	r0, [pc, #216]	; (c0d026bc <ux_menu_elements_button+0x10c>)
c0d025e4:	4285      	cmp	r5, r0
c0d025e6:	d15e      	bne.n	c0d026a6 <ux_menu_elements_button+0xf6>
    // enter menu or exit menu
    case BUTTON_EVT_RELEASED|BUTTON_LEFT|BUTTON_RIGHT:
      // menu is priority 1
      if (current_entry->menu) {
c0d025e8:	6830      	ldr	r0, [r6, #0]
c0d025ea:	2800      	cmp	r0, #0
c0d025ec:	d052      	beq.n	c0d02694 <ux_menu_elements_button+0xe4>
        // use userid as the pointer to current entry in the parent menu
        UX_MENU_DISPLAY(current_entry->userid, (const ux_menu_entry_t*)PIC(current_entry->menu), ux_menu.menu_entry_preprocessor);
c0d025ee:	68b4      	ldr	r4, [r6, #8]
c0d025f0:	f000 fb18 	bl	c0d02c24 <pic>
c0d025f4:	4601      	mov	r1, r0
c0d025f6:	68fa      	ldr	r2, [r7, #12]
c0d025f8:	4620      	mov	r0, r4
c0d025fa:	f000 f86d 	bl	c0d026d8 <ux_menu_display>
c0d025fe:	e051      	b.n	c0d026a4 <ux_menu_elements_button+0xf4>
c0d02600:	482f      	ldr	r0, [pc, #188]	; (c0d026c0 <ux_menu_elements_button+0x110>)
c0d02602:	4285      	cmp	r5, r0
c0d02604:	d00a      	beq.n	c0d0261c <ux_menu_elements_button+0x6c>
c0d02606:	482a      	ldr	r0, [pc, #168]	; (c0d026b0 <ux_menu_elements_button+0x100>)
c0d02608:	4285      	cmp	r5, r0
c0d0260a:	d14c      	bne.n	c0d026a6 <ux_menu_elements_button+0xf6>
      goto redraw;

    case BUTTON_EVT_FAST|BUTTON_RIGHT:
    case BUTTON_EVT_RELEASED|BUTTON_RIGHT:
      // entry 0 is the number of entries in the menu list
      if (ux_menu.current_entry >= ux_menu.menu_entries_count-1) {
c0d0260c:	6879      	ldr	r1, [r7, #4]
c0d0260e:	68b8      	ldr	r0, [r7, #8]
c0d02610:	1e4a      	subs	r2, r1, #1
c0d02612:	2400      	movs	r4, #0
c0d02614:	2101      	movs	r1, #1
c0d02616:	4290      	cmp	r0, r2
c0d02618:	d305      	bcc.n	c0d02626 <ux_menu_elements_button+0x76>
c0d0261a:	e044      	b.n	c0d026a6 <ux_menu_elements_button+0xf6>
c0d0261c:	2400      	movs	r4, #0
c0d0261e:	43e1      	mvns	r1, r4
      break;

    case BUTTON_EVT_FAST|BUTTON_LEFT:
    case BUTTON_EVT_RELEASED|BUTTON_LEFT:
      // entry 0 is the number of entries in the menu list
      if (ux_menu.current_entry == 0) {
c0d02620:	68b8      	ldr	r0, [r7, #8]
c0d02622:	2800      	cmp	r0, #0
c0d02624:	d03f      	beq.n	c0d026a6 <ux_menu_elements_button+0xf6>
c0d02626:	1840      	adds	r0, r0, r1
c0d02628:	60b8      	str	r0, [r7, #8]
  io_seproxyhal_init_button();
}

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d0262a:	4826      	ldr	r0, [pc, #152]	; (c0d026c4 <ux_menu_elements_button+0x114>)
c0d0262c:	2400      	movs	r4, #0
c0d0262e:	6004      	str	r4, [r0, #0]
}

void io_seproxyhal_init_button(void) {
  // no button push so far
  G_button_mask = 0;
c0d02630:	4825      	ldr	r0, [pc, #148]	; (c0d026c8 <ux_menu_elements_button+0x118>)
c0d02632:	6004      	str	r4, [r0, #0]
  G_button_same_mask_counter = 0;
c0d02634:	4825      	ldr	r0, [pc, #148]	; (c0d026cc <ux_menu_elements_button+0x11c>)
c0d02636:	6004      	str	r4, [r0, #0]
      ux_menu.current_entry++;
    redraw:
#ifdef HAVE_BOLOS_UX
      screen_display_init(0);
#else
      UX_REDISPLAY();
c0d02638:	4d25      	ldr	r5, [pc, #148]	; (c0d026d0 <ux_menu_elements_button+0x120>)
c0d0263a:	60ac      	str	r4, [r5, #8]
c0d0263c:	6828      	ldr	r0, [r5, #0]
c0d0263e:	2800      	cmp	r0, #0
c0d02640:	d031      	beq.n	c0d026a6 <ux_menu_elements_button+0xf6>
c0d02642:	69e8      	ldr	r0, [r5, #28]
c0d02644:	4923      	ldr	r1, [pc, #140]	; (c0d026d4 <ux_menu_elements_button+0x124>)
c0d02646:	4288      	cmp	r0, r1
c0d02648:	d02d      	beq.n	c0d026a6 <ux_menu_elements_button+0xf6>
c0d0264a:	2800      	cmp	r0, #0
c0d0264c:	d02b      	beq.n	c0d026a6 <ux_menu_elements_button+0xf6>
c0d0264e:	2400      	movs	r4, #0
c0d02650:	4620      	mov	r0, r4
c0d02652:	6869      	ldr	r1, [r5, #4]
c0d02654:	4288      	cmp	r0, r1
c0d02656:	d226      	bcs.n	c0d026a6 <ux_menu_elements_button+0xf6>
c0d02658:	f000 fdec 	bl	c0d03234 <io_seproxyhal_spi_is_status_sent>
c0d0265c:	2800      	cmp	r0, #0
c0d0265e:	d122      	bne.n	c0d026a6 <ux_menu_elements_button+0xf6>
c0d02660:	68a8      	ldr	r0, [r5, #8]
c0d02662:	68e9      	ldr	r1, [r5, #12]
c0d02664:	2638      	movs	r6, #56	; 0x38
c0d02666:	4370      	muls	r0, r6
c0d02668:	682a      	ldr	r2, [r5, #0]
c0d0266a:	1810      	adds	r0, r2, r0
c0d0266c:	2900      	cmp	r1, #0
c0d0266e:	d002      	beq.n	c0d02676 <ux_menu_elements_button+0xc6>
c0d02670:	4788      	blx	r1
c0d02672:	2800      	cmp	r0, #0
c0d02674:	d007      	beq.n	c0d02686 <ux_menu_elements_button+0xd6>
c0d02676:	2801      	cmp	r0, #1
c0d02678:	d103      	bne.n	c0d02682 <ux_menu_elements_button+0xd2>
c0d0267a:	68a8      	ldr	r0, [r5, #8]
c0d0267c:	4346      	muls	r6, r0
c0d0267e:	6828      	ldr	r0, [r5, #0]
c0d02680:	1980      	adds	r0, r0, r6
c0d02682:	f002 ff87 	bl	c0d05594 <io_seproxyhal_display>
c0d02686:	68a8      	ldr	r0, [r5, #8]
c0d02688:	1c40      	adds	r0, r0, #1
c0d0268a:	60a8      	str	r0, [r5, #8]
c0d0268c:	6829      	ldr	r1, [r5, #0]
c0d0268e:	2900      	cmp	r1, #0
c0d02690:	d1df      	bne.n	c0d02652 <ux_menu_elements_button+0xa2>
c0d02692:	e008      	b.n	c0d026a6 <ux_menu_elements_button+0xf6>
        // use userid as the pointer to current entry in the parent menu
        UX_MENU_DISPLAY(current_entry->userid, (const ux_menu_entry_t*)PIC(current_entry->menu), ux_menu.menu_entry_preprocessor);
        return 0;
      }
      // else callback
      else if (current_entry->callback) {
c0d02694:	6870      	ldr	r0, [r6, #4]
c0d02696:	2800      	cmp	r0, #0
c0d02698:	d005      	beq.n	c0d026a6 <ux_menu_elements_button+0xf6>
        ((ux_menu_callback_t)PIC(current_entry->callback))(current_entry->userid);
c0d0269a:	f000 fac3 	bl	c0d02c24 <pic>
c0d0269e:	4601      	mov	r1, r0
c0d026a0:	68b0      	ldr	r0, [r6, #8]
c0d026a2:	4788      	blx	r1
c0d026a4:	2400      	movs	r4, #0
      UX_REDISPLAY();
#endif
      return 0;
  }
  return 1;
}
c0d026a6:	4620      	mov	r0, r4
c0d026a8:	b001      	add	sp, #4
c0d026aa:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d026ac:	20001aec 	.word	0x20001aec
c0d026b0:	80000002 	.word	0x80000002
c0d026b4:	40000002 	.word	0x40000002
c0d026b8:	40000001 	.word	0x40000001
c0d026bc:	80000003 	.word	0x80000003
c0d026c0:	80000001 	.word	0x80000001
c0d026c4:	20001a9c 	.word	0x20001a9c
c0d026c8:	20001aa0 	.word	0x20001aa0
c0d026cc:	20001aa4 	.word	0x20001aa4
c0d026d0:	200022ac 	.word	0x200022ac
c0d026d4:	b0105044 	.word	0xb0105044

c0d026d8 <ux_menu_display>:

const ux_menu_entry_t UX_MENU_END_ENTRY = UX_MENU_END;

void ux_menu_display(unsigned int current_entry, 
                     const ux_menu_entry_t* menu_entries,
                     ux_menu_preprocessor_t menu_entry_preprocessor) {
c0d026d8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d026da:	b083      	sub	sp, #12
c0d026dc:	9202      	str	r2, [sp, #8]
c0d026de:	460d      	mov	r5, r1
c0d026e0:	9001      	str	r0, [sp, #4]
  // reset to first entry
  ux_menu.menu_entries_count = 0;
c0d026e2:	4e39      	ldr	r6, [pc, #228]	; (c0d027c8 <ux_menu_display+0xf0>)
c0d026e4:	2000      	movs	r0, #0
c0d026e6:	9000      	str	r0, [sp, #0]
c0d026e8:	6070      	str	r0, [r6, #4]

  // count entries
  if (menu_entries) {
c0d026ea:	2d00      	cmp	r5, #0
c0d026ec:	d015      	beq.n	c0d0271a <ux_menu_display+0x42>
    for(;;) {
      if (os_memcmp(&menu_entries[ux_menu.menu_entries_count], &UX_MENU_END_ENTRY, sizeof(ux_menu_entry_t)) == 0) {
c0d026ee:	493c      	ldr	r1, [pc, #240]	; (c0d027e0 <ux_menu_display+0x108>)
c0d026f0:	4479      	add	r1, pc
c0d026f2:	271c      	movs	r7, #28
c0d026f4:	4628      	mov	r0, r5
c0d026f6:	463a      	mov	r2, r7
c0d026f8:	f7ff f9c6 	bl	c0d01a88 <os_memcmp>
c0d026fc:	2800      	cmp	r0, #0
c0d026fe:	d00c      	beq.n	c0d0271a <ux_menu_display+0x42>
c0d02700:	4c38      	ldr	r4, [pc, #224]	; (c0d027e4 <ux_menu_display+0x10c>)
c0d02702:	447c      	add	r4, pc
        break;
      }
      ux_menu.menu_entries_count++;
c0d02704:	6870      	ldr	r0, [r6, #4]
c0d02706:	1c40      	adds	r0, r0, #1
c0d02708:	6070      	str	r0, [r6, #4]
  ux_menu.menu_entries_count = 0;

  // count entries
  if (menu_entries) {
    for(;;) {
      if (os_memcmp(&menu_entries[ux_menu.menu_entries_count], &UX_MENU_END_ENTRY, sizeof(ux_menu_entry_t)) == 0) {
c0d0270a:	4378      	muls	r0, r7
c0d0270c:	1828      	adds	r0, r5, r0
c0d0270e:	4621      	mov	r1, r4
c0d02710:	463a      	mov	r2, r7
c0d02712:	f7ff f9b9 	bl	c0d01a88 <os_memcmp>
c0d02716:	2800      	cmp	r0, #0
c0d02718:	d1f4      	bne.n	c0d02704 <ux_menu_display+0x2c>
c0d0271a:	9901      	ldr	r1, [sp, #4]
      }
      ux_menu.menu_entries_count++;
    }
  }

  if (current_entry != UX_MENU_UNCHANGED_ENTRY) {
c0d0271c:	4608      	mov	r0, r1
c0d0271e:	3001      	adds	r0, #1
c0d02720:	d005      	beq.n	c0d0272e <ux_menu_display+0x56>
    ux_menu.current_entry = current_entry;
    if (ux_menu.current_entry > ux_menu.menu_entries_count) {
c0d02722:	6870      	ldr	r0, [r6, #4]
c0d02724:	4288      	cmp	r0, r1
c0d02726:	9800      	ldr	r0, [sp, #0]
c0d02728:	d300      	bcc.n	c0d0272c <ux_menu_display+0x54>
c0d0272a:	4608      	mov	r0, r1
      ux_menu.current_entry = 0;
c0d0272c:	60b0      	str	r0, [r6, #8]
    }
  }
  ux_menu.menu_entries = menu_entries;
c0d0272e:	6035      	str	r5, [r6, #0]
c0d02730:	2500      	movs	r5, #0
  ux_menu.menu_entry_preprocessor = menu_entry_preprocessor;
c0d02732:	9802      	ldr	r0, [sp, #8]
c0d02734:	60f0      	str	r0, [r6, #12]
  ux_menu.menu_iterator = NULL;
c0d02736:	6135      	str	r5, [r6, #16]
  G_bolos_ux_context.screen_stack[0].button_push_callback = ux_menu_elements_button;

  screen_display_init(0);
#else
  // display the menu current entry
  UX_DISPLAY(ux_menu_elements, ux_menu_element_preprocessor);
c0d02738:	4c24      	ldr	r4, [pc, #144]	; (c0d027cc <ux_menu_display+0xf4>)
c0d0273a:	482b      	ldr	r0, [pc, #172]	; (c0d027e8 <ux_menu_display+0x110>)
c0d0273c:	4478      	add	r0, pc
c0d0273e:	6020      	str	r0, [r4, #0]
c0d02740:	2009      	movs	r0, #9
c0d02742:	6060      	str	r0, [r4, #4]
c0d02744:	4829      	ldr	r0, [pc, #164]	; (c0d027ec <ux_menu_display+0x114>)
c0d02746:	4478      	add	r0, pc
c0d02748:	6120      	str	r0, [r4, #16]
c0d0274a:	4829      	ldr	r0, [pc, #164]	; (c0d027f0 <ux_menu_display+0x118>)
c0d0274c:	4478      	add	r0, pc
c0d0274e:	60e0      	str	r0, [r4, #12]
c0d02750:	2003      	movs	r0, #3
c0d02752:	7620      	strb	r0, [r4, #24]
c0d02754:	61e5      	str	r5, [r4, #28]
c0d02756:	4620      	mov	r0, r4
c0d02758:	3018      	adds	r0, #24
c0d0275a:	f000 fce1 	bl	c0d03120 <os_ux>
c0d0275e:	61e0      	str	r0, [r4, #28]
c0d02760:	f000 f848 	bl	c0d027f4 <ux_check_status_default>
  io_seproxyhal_init_button();
}

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d02764:	481a      	ldr	r0, [pc, #104]	; (c0d027d0 <ux_menu_display+0xf8>)
c0d02766:	6005      	str	r5, [r0, #0]
}

void io_seproxyhal_init_button(void) {
  // no button push so far
  G_button_mask = 0;
c0d02768:	481a      	ldr	r0, [pc, #104]	; (c0d027d4 <ux_menu_display+0xfc>)
c0d0276a:	6005      	str	r5, [r0, #0]
  G_button_same_mask_counter = 0;
c0d0276c:	481a      	ldr	r0, [pc, #104]	; (c0d027d8 <ux_menu_display+0x100>)
c0d0276e:	6005      	str	r5, [r0, #0]
  G_bolos_ux_context.screen_stack[0].button_push_callback = ux_menu_elements_button;

  screen_display_init(0);
#else
  // display the menu current entry
  UX_DISPLAY(ux_menu_elements, ux_menu_element_preprocessor);
c0d02770:	60a5      	str	r5, [r4, #8]
c0d02772:	6820      	ldr	r0, [r4, #0]
c0d02774:	2800      	cmp	r0, #0
c0d02776:	d024      	beq.n	c0d027c2 <ux_menu_display+0xea>
c0d02778:	69e0      	ldr	r0, [r4, #28]
c0d0277a:	4918      	ldr	r1, [pc, #96]	; (c0d027dc <ux_menu_display+0x104>)
c0d0277c:	4288      	cmp	r0, r1
c0d0277e:	d11e      	bne.n	c0d027be <ux_menu_display+0xe6>
c0d02780:	e01f      	b.n	c0d027c2 <ux_menu_display+0xea>
c0d02782:	6860      	ldr	r0, [r4, #4]
c0d02784:	4285      	cmp	r5, r0
c0d02786:	d21c      	bcs.n	c0d027c2 <ux_menu_display+0xea>
c0d02788:	f000 fd54 	bl	c0d03234 <io_seproxyhal_spi_is_status_sent>
c0d0278c:	2800      	cmp	r0, #0
c0d0278e:	d118      	bne.n	c0d027c2 <ux_menu_display+0xea>
c0d02790:	68a0      	ldr	r0, [r4, #8]
c0d02792:	68e1      	ldr	r1, [r4, #12]
c0d02794:	2538      	movs	r5, #56	; 0x38
c0d02796:	4368      	muls	r0, r5
c0d02798:	6822      	ldr	r2, [r4, #0]
c0d0279a:	1810      	adds	r0, r2, r0
c0d0279c:	2900      	cmp	r1, #0
c0d0279e:	d002      	beq.n	c0d027a6 <ux_menu_display+0xce>
c0d027a0:	4788      	blx	r1
c0d027a2:	2800      	cmp	r0, #0
c0d027a4:	d007      	beq.n	c0d027b6 <ux_menu_display+0xde>
c0d027a6:	2801      	cmp	r0, #1
c0d027a8:	d103      	bne.n	c0d027b2 <ux_menu_display+0xda>
c0d027aa:	68a0      	ldr	r0, [r4, #8]
c0d027ac:	4345      	muls	r5, r0
c0d027ae:	6820      	ldr	r0, [r4, #0]
c0d027b0:	1940      	adds	r0, r0, r5
c0d027b2:	f002 feef 	bl	c0d05594 <io_seproxyhal_display>
c0d027b6:	68a0      	ldr	r0, [r4, #8]
c0d027b8:	1c45      	adds	r5, r0, #1
c0d027ba:	60a5      	str	r5, [r4, #8]
c0d027bc:	6820      	ldr	r0, [r4, #0]
c0d027be:	2800      	cmp	r0, #0
c0d027c0:	d1df      	bne.n	c0d02782 <ux_menu_display+0xaa>
#endif
}
c0d027c2:	b003      	add	sp, #12
c0d027c4:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d027c6:	46c0      	nop			; (mov r8, r8)
c0d027c8:	20001aec 	.word	0x20001aec
c0d027cc:	200022ac 	.word	0x200022ac
c0d027d0:	20001a9c 	.word	0x20001a9c
c0d027d4:	20001aa0 	.word	0x20001aa0
c0d027d8:	20001aa4 	.word	0x20001aa4
c0d027dc:	b0105044 	.word	0xb0105044
c0d027e0:	00004138 	.word	0x00004138
c0d027e4:	00004126 	.word	0x00004126
c0d027e8:	00003ef4 	.word	0x00003ef4
c0d027ec:	fffffe67 	.word	0xfffffe67
c0d027f0:	fffffcd9 	.word	0xfffffcd9

c0d027f4 <ux_check_status_default>:
}

void ux_check_status_default(unsigned int status) {
  // nothing to be done here by default.
  UNUSED(status);
}
c0d027f4:	4770      	bx	lr
	...

c0d027f8 <snprintf>:
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
c0d027f8:	b081      	sub	sp, #4
c0d027fa:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d027fc:	b090      	sub	sp, #64	; 0x40
c0d027fe:	4616      	mov	r6, r2
c0d02800:	460c      	mov	r4, r1
c0d02802:	900a      	str	r0, [sp, #40]	; 0x28
c0d02804:	9315      	str	r3, [sp, #84]	; 0x54
    char cStrlenSet;
    
    //
    // Check the arguments.
    //
    if(format == 0 || str == 0 ||str_size < 2) {
c0d02806:	2c02      	cmp	r4, #2
c0d02808:	d200      	bcs.n	c0d0280c <snprintf+0x14>
c0d0280a:	e1f0      	b.n	c0d02bee <snprintf+0x3f6>
c0d0280c:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d0280e:	2800      	cmp	r0, #0
c0d02810:	d100      	bne.n	c0d02814 <snprintf+0x1c>
c0d02812:	e1ec      	b.n	c0d02bee <snprintf+0x3f6>
c0d02814:	2e00      	cmp	r6, #0
c0d02816:	d100      	bne.n	c0d0281a <snprintf+0x22>
c0d02818:	e1e9      	b.n	c0d02bee <snprintf+0x3f6>
c0d0281a:	2100      	movs	r1, #0
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
c0d0281c:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d0281e:	9107      	str	r1, [sp, #28]
c0d02820:	4622      	mov	r2, r4
c0d02822:	f7ff f88b 	bl	c0d0193c <os_memset>
c0d02826:	a815      	add	r0, sp, #84	; 0x54


    //
    // Start the varargs processing.
    //
    va_start(vaArgP, format);
c0d02828:	900b      	str	r0, [sp, #44]	; 0x2c

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d0282a:	7830      	ldrb	r0, [r6, #0]
c0d0282c:	2800      	cmp	r0, #0
c0d0282e:	d100      	bne.n	c0d02832 <snprintf+0x3a>
c0d02830:	e1dd      	b.n	c0d02bee <snprintf+0x3f6>
c0d02832:	9907      	ldr	r1, [sp, #28]
c0d02834:	43c9      	mvns	r1, r1
      return 0;
    }

    // ensure terminating string with a \0
    os_memset(str, 0, str_size);
    str_size--;
c0d02836:	1e65      	subs	r5, r4, #1
c0d02838:	9105      	str	r1, [sp, #20]
c0d0283a:	e1bd      	b.n	c0d02bb8 <snprintf+0x3c0>
        }

        //
        // Skip the portion of the string that was written.
        //
        format += ulIdx;
c0d0283c:	1930      	adds	r0, r6, r4

        //
        // See if the next character is a %.
        //
        if(*format == '%')
c0d0283e:	5d31      	ldrb	r1, [r6, r4]
c0d02840:	2925      	cmp	r1, #37	; 0x25
c0d02842:	d10b      	bne.n	c0d0285c <snprintf+0x64>
c0d02844:	9303      	str	r3, [sp, #12]
c0d02846:	9202      	str	r2, [sp, #8]
        {
            //
            // Skip the %.
            //
            format++;
c0d02848:	1c43      	adds	r3, r0, #1
c0d0284a:	2000      	movs	r0, #0
c0d0284c:	2120      	movs	r1, #32
c0d0284e:	9108      	str	r1, [sp, #32]
c0d02850:	210a      	movs	r1, #10
c0d02852:	9101      	str	r1, [sp, #4]
c0d02854:	9000      	str	r0, [sp, #0]
c0d02856:	9004      	str	r0, [sp, #16]
c0d02858:	9009      	str	r0, [sp, #36]	; 0x24
c0d0285a:	e056      	b.n	c0d0290a <snprintf+0x112>
c0d0285c:	4606      	mov	r6, r0
c0d0285e:	920a      	str	r2, [sp, #40]	; 0x28
c0d02860:	e11e      	b.n	c0d02aa0 <snprintf+0x2a8>
c0d02862:	4633      	mov	r3, r6
c0d02864:	4608      	mov	r0, r1
c0d02866:	e04b      	b.n	c0d02900 <snprintf+0x108>
c0d02868:	2b47      	cmp	r3, #71	; 0x47
c0d0286a:	dc13      	bgt.n	c0d02894 <snprintf+0x9c>
c0d0286c:	4619      	mov	r1, r3
c0d0286e:	3930      	subs	r1, #48	; 0x30
c0d02870:	290a      	cmp	r1, #10
c0d02872:	d234      	bcs.n	c0d028de <snprintf+0xe6>
                {
                    //
                    // If this is a zero, and it is the first digit, then the
                    // fill character is a zero instead of a space.
                    //
                    if((format[-1] == '0') && (ulCount == 0))
c0d02874:	2b30      	cmp	r3, #48	; 0x30
c0d02876:	9908      	ldr	r1, [sp, #32]
c0d02878:	d100      	bne.n	c0d0287c <snprintf+0x84>
c0d0287a:	4619      	mov	r1, r3
c0d0287c:	9d09      	ldr	r5, [sp, #36]	; 0x24
c0d0287e:	2d00      	cmp	r5, #0
c0d02880:	d000      	beq.n	c0d02884 <snprintf+0x8c>
c0d02882:	9908      	ldr	r1, [sp, #32]
                    }

                    //
                    // Update the digit count.
                    //
                    ulCount *= 10;
c0d02884:	220a      	movs	r2, #10
c0d02886:	436a      	muls	r2, r5
                    ulCount += format[-1] - '0';
c0d02888:	18d2      	adds	r2, r2, r3
c0d0288a:	3a30      	subs	r2, #48	; 0x30
c0d0288c:	9209      	str	r2, [sp, #36]	; 0x24
c0d0288e:	4633      	mov	r3, r6
c0d02890:	9108      	str	r1, [sp, #32]
c0d02892:	e03a      	b.n	c0d0290a <snprintf+0x112>
c0d02894:	2b67      	cmp	r3, #103	; 0x67
c0d02896:	dd04      	ble.n	c0d028a2 <snprintf+0xaa>
c0d02898:	2b72      	cmp	r3, #114	; 0x72
c0d0289a:	dd09      	ble.n	c0d028b0 <snprintf+0xb8>
c0d0289c:	2b73      	cmp	r3, #115	; 0x73
c0d0289e:	d146      	bne.n	c0d0292e <snprintf+0x136>
c0d028a0:	e00a      	b.n	c0d028b8 <snprintf+0xc0>
c0d028a2:	2b62      	cmp	r3, #98	; 0x62
c0d028a4:	dc48      	bgt.n	c0d02938 <snprintf+0x140>
c0d028a6:	2b48      	cmp	r3, #72	; 0x48
c0d028a8:	d155      	bne.n	c0d02956 <snprintf+0x15e>
c0d028aa:	2201      	movs	r2, #1
c0d028ac:	9204      	str	r2, [sp, #16]
c0d028ae:	e001      	b.n	c0d028b4 <snprintf+0xbc>
c0d028b0:	2b68      	cmp	r3, #104	; 0x68
c0d028b2:	d156      	bne.n	c0d02962 <snprintf+0x16a>
c0d028b4:	2210      	movs	r2, #16
c0d028b6:	9201      	str	r2, [sp, #4]
                case_s:
                {
                    //
                    // Get the string pointer from the varargs.
                    //
                    pcStr = va_arg(vaArgP, char *);
c0d028b8:	9a0b      	ldr	r2, [sp, #44]	; 0x2c
c0d028ba:	1d13      	adds	r3, r2, #4
c0d028bc:	930b      	str	r3, [sp, #44]	; 0x2c
c0d028be:	2303      	movs	r3, #3
c0d028c0:	4018      	ands	r0, r3
c0d028c2:	1c4d      	adds	r5, r1, #1
c0d028c4:	6811      	ldr	r1, [r2, #0]

                    //
                    // Determine the length of the string. (if not specified using .*)
                    //
                    switch(cStrlenSet) {
c0d028c6:	2801      	cmp	r0, #1
c0d028c8:	d100      	bne.n	c0d028cc <snprintf+0xd4>
c0d028ca:	e0ce      	b.n	c0d02a6a <snprintf+0x272>
c0d028cc:	2802      	cmp	r0, #2
c0d028ce:	d100      	bne.n	c0d028d2 <snprintf+0xda>
c0d028d0:	e0d0      	b.n	c0d02a74 <snprintf+0x27c>
c0d028d2:	2803      	cmp	r0, #3
c0d028d4:	4633      	mov	r3, r6
c0d028d6:	4628      	mov	r0, r5
c0d028d8:	9d06      	ldr	r5, [sp, #24]
c0d028da:	d016      	beq.n	c0d0290a <snprintf+0x112>
c0d028dc:	e0e7      	b.n	c0d02aae <snprintf+0x2b6>
c0d028de:	2b2e      	cmp	r3, #46	; 0x2e
c0d028e0:	d000      	beq.n	c0d028e4 <snprintf+0xec>
c0d028e2:	e0ca      	b.n	c0d02a7a <snprintf+0x282>
                // special %.*H or %.*h format to print a given length of hex digits (case: H UPPER, h lower)
                //
                case '.':
                {
                  // ensure next char is '*' and next one is 's'/'h'/'H'
                  if (format[0] == '*' && (format[1] == 's' || format[1] == 'H' || format[1] == 'h')) {
c0d028e4:	7830      	ldrb	r0, [r6, #0]
c0d028e6:	282a      	cmp	r0, #42	; 0x2a
c0d028e8:	d000      	beq.n	c0d028ec <snprintf+0xf4>
c0d028ea:	e0c6      	b.n	c0d02a7a <snprintf+0x282>
c0d028ec:	7871      	ldrb	r1, [r6, #1]
c0d028ee:	1c73      	adds	r3, r6, #1
c0d028f0:	2001      	movs	r0, #1
c0d028f2:	2948      	cmp	r1, #72	; 0x48
c0d028f4:	d004      	beq.n	c0d02900 <snprintf+0x108>
c0d028f6:	2968      	cmp	r1, #104	; 0x68
c0d028f8:	d002      	beq.n	c0d02900 <snprintf+0x108>
c0d028fa:	2973      	cmp	r1, #115	; 0x73
c0d028fc:	d000      	beq.n	c0d02900 <snprintf+0x108>
c0d028fe:	e0bc      	b.n	c0d02a7a <snprintf+0x282>
c0d02900:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d02902:	1d0a      	adds	r2, r1, #4
c0d02904:	920b      	str	r2, [sp, #44]	; 0x2c
c0d02906:	6809      	ldr	r1, [r1, #0]
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
    char *pcStr, pcBuf[16], cFill;
    va_list vaArgP;
    char cStrlenSet;
c0d02908:	9100      	str	r1, [sp, #0]
c0d0290a:	2102      	movs	r1, #2
c0d0290c:	461e      	mov	r6, r3
again:

            //
            // Determine how to handle the next character.
            //
            switch(*format++)
c0d0290e:	7833      	ldrb	r3, [r6, #0]
c0d02910:	1c76      	adds	r6, r6, #1
c0d02912:	2200      	movs	r2, #0
c0d02914:	2b2d      	cmp	r3, #45	; 0x2d
c0d02916:	dca7      	bgt.n	c0d02868 <snprintf+0x70>
c0d02918:	4610      	mov	r0, r2
c0d0291a:	d0f8      	beq.n	c0d0290e <snprintf+0x116>
c0d0291c:	2b25      	cmp	r3, #37	; 0x25
c0d0291e:	d02a      	beq.n	c0d02976 <snprintf+0x17e>
c0d02920:	2b2a      	cmp	r3, #42	; 0x2a
c0d02922:	d000      	beq.n	c0d02926 <snprintf+0x12e>
c0d02924:	e0a9      	b.n	c0d02a7a <snprintf+0x282>
                  goto error;
                }
                
                case '*':
                {
                  if (*format == 's' ) {                    
c0d02926:	7830      	ldrb	r0, [r6, #0]
c0d02928:	2873      	cmp	r0, #115	; 0x73
c0d0292a:	d09a      	beq.n	c0d02862 <snprintf+0x6a>
c0d0292c:	e0a5      	b.n	c0d02a7a <snprintf+0x282>
c0d0292e:	2b75      	cmp	r3, #117	; 0x75
c0d02930:	d023      	beq.n	c0d0297a <snprintf+0x182>
c0d02932:	2b78      	cmp	r3, #120	; 0x78
c0d02934:	d018      	beq.n	c0d02968 <snprintf+0x170>
c0d02936:	e0a0      	b.n	c0d02a7a <snprintf+0x282>
c0d02938:	2b63      	cmp	r3, #99	; 0x63
c0d0293a:	d100      	bne.n	c0d0293e <snprintf+0x146>
c0d0293c:	e08b      	b.n	c0d02a56 <snprintf+0x25e>
c0d0293e:	2b64      	cmp	r3, #100	; 0x64
c0d02940:	d000      	beq.n	c0d02944 <snprintf+0x14c>
c0d02942:	e09a      	b.n	c0d02a7a <snprintf+0x282>
                case 'd':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d02944:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d02946:	1d01      	adds	r1, r0, #4
c0d02948:	910b      	str	r1, [sp, #44]	; 0x2c
c0d0294a:	6800      	ldr	r0, [r0, #0]
c0d0294c:	17c1      	asrs	r1, r0, #31
c0d0294e:	1842      	adds	r2, r0, r1
c0d02950:	404a      	eors	r2, r1

                    //
                    // If the value is negative, make it positive and indicate
                    // that a minus sign is needed.
                    //
                    if((long)ulValue < 0)
c0d02952:	0fc0      	lsrs	r0, r0, #31
c0d02954:	e016      	b.n	c0d02984 <snprintf+0x18c>
c0d02956:	2b58      	cmp	r3, #88	; 0x58
c0d02958:	d000      	beq.n	c0d0295c <snprintf+0x164>
c0d0295a:	e08e      	b.n	c0d02a7a <snprintf+0x282>
c0d0295c:	2001      	movs	r0, #1

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
    unsigned int ulIdx, ulValue, ulPos, ulCount, ulBase, ulNeg, ulStrlen, ulCap;
c0d0295e:	9004      	str	r0, [sp, #16]
c0d02960:	e002      	b.n	c0d02968 <snprintf+0x170>
c0d02962:	2b70      	cmp	r3, #112	; 0x70
c0d02964:	d000      	beq.n	c0d02968 <snprintf+0x170>
c0d02966:	e088      	b.n	c0d02a7a <snprintf+0x282>
                case 'p':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d02968:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d0296a:	1d01      	adds	r1, r0, #4
c0d0296c:	910b      	str	r1, [sp, #44]	; 0x2c
c0d0296e:	6802      	ldr	r2, [r0, #0]
c0d02970:	2000      	movs	r0, #0
c0d02972:	2510      	movs	r5, #16
c0d02974:	e007      	b.n	c0d02986 <snprintf+0x18e>
                case '%':
                {
                    //
                    // Simply write a single %.
                    //
                    str[0] = '%';
c0d02976:	2025      	movs	r0, #37	; 0x25
c0d02978:	e071      	b.n	c0d02a5e <snprintf+0x266>
                case 'u':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d0297a:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d0297c:	1d01      	adds	r1, r0, #4
c0d0297e:	910b      	str	r1, [sp, #44]	; 0x2c
c0d02980:	6802      	ldr	r2, [r0, #0]
c0d02982:	2000      	movs	r0, #0
c0d02984:	250a      	movs	r5, #10
c0d02986:	9006      	str	r0, [sp, #24]
c0d02988:	2701      	movs	r7, #1
c0d0298a:	920a      	str	r2, [sp, #40]	; 0x28
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d0298c:	4295      	cmp	r5, r2
c0d0298e:	d812      	bhi.n	c0d029b6 <snprintf+0x1be>
c0d02990:	2401      	movs	r4, #1
c0d02992:	4628      	mov	r0, r5
c0d02994:	4607      	mov	r7, r0
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
c0d02996:	4629      	mov	r1, r5
c0d02998:	f003 fb08 	bl	c0d05fac <__aeabi_uidiv>
                    //
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
c0d0299c:	42a0      	cmp	r0, r4
c0d0299e:	d109      	bne.n	c0d029b4 <snprintf+0x1bc>
                        (((ulIdx * ulBase) <= ulValue) &&
c0d029a0:	4628      	mov	r0, r5
c0d029a2:	4378      	muls	r0, r7
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
                        ulIdx *= ulBase, ulCount--)
c0d029a4:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d029a6:	1e49      	subs	r1, r1, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d029a8:	9109      	str	r1, [sp, #36]	; 0x24
c0d029aa:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d029ac:	4288      	cmp	r0, r1
c0d029ae:	463c      	mov	r4, r7
c0d029b0:	d9f0      	bls.n	c0d02994 <snprintf+0x19c>
c0d029b2:	e000      	b.n	c0d029b6 <snprintf+0x1be>
c0d029b4:	4627      	mov	r7, r4

                    //
                    // If the value is negative, reduce the count of padding
                    // characters needed.
                    //
                    if(ulNeg)
c0d029b6:	2400      	movs	r4, #0
c0d029b8:	43e1      	mvns	r1, r4
c0d029ba:	9b06      	ldr	r3, [sp, #24]
c0d029bc:	2b00      	cmp	r3, #0
c0d029be:	d100      	bne.n	c0d029c2 <snprintf+0x1ca>
c0d029c0:	4619      	mov	r1, r3
c0d029c2:	9809      	ldr	r0, [sp, #36]	; 0x24
c0d029c4:	9101      	str	r1, [sp, #4]
c0d029c6:	1840      	adds	r0, r0, r1

                    //
                    // If the value is negative and the value is padded with
                    // zeros, then place the minus sign before the padding.
                    //
                    if(ulNeg && (cFill == '0'))
c0d029c8:	9908      	ldr	r1, [sp, #32]
c0d029ca:	b2ca      	uxtb	r2, r1
c0d029cc:	2a30      	cmp	r2, #48	; 0x30
c0d029ce:	d106      	bne.n	c0d029de <snprintf+0x1e6>
c0d029d0:	2b00      	cmp	r3, #0
c0d029d2:	d004      	beq.n	c0d029de <snprintf+0x1e6>
c0d029d4:	a90c      	add	r1, sp, #48	; 0x30
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d029d6:	232d      	movs	r3, #45	; 0x2d
c0d029d8:	700b      	strb	r3, [r1, #0]
c0d029da:	2300      	movs	r3, #0
c0d029dc:	2401      	movs	r4, #1

                    //
                    // Provide additional padding at the beginning of the
                    // string conversion if needed.
                    //
                    if((ulCount > 1) && (ulCount < 16))
c0d029de:	1e81      	subs	r1, r0, #2
c0d029e0:	290d      	cmp	r1, #13
c0d029e2:	d80c      	bhi.n	c0d029fe <snprintf+0x206>
c0d029e4:	1e41      	subs	r1, r0, #1
c0d029e6:	d00a      	beq.n	c0d029fe <snprintf+0x206>
c0d029e8:	a80c      	add	r0, sp, #48	; 0x30
                    {
                        for(ulCount--; ulCount; ulCount--)
                        {
                            pcBuf[ulPos++] = cFill;
c0d029ea:	4320      	orrs	r0, r4
c0d029ec:	9306      	str	r3, [sp, #24]
c0d029ee:	f003 fc5d 	bl	c0d062ac <__aeabi_memset>
c0d029f2:	9b06      	ldr	r3, [sp, #24]
c0d029f4:	9809      	ldr	r0, [sp, #36]	; 0x24
c0d029f6:	1900      	adds	r0, r0, r4
c0d029f8:	9901      	ldr	r1, [sp, #4]
c0d029fa:	1840      	adds	r0, r0, r1
c0d029fc:	1e44      	subs	r4, r0, #1

                    //
                    // If the value is negative, then place the minus sign
                    // before the number.
                    //
                    if(ulNeg)
c0d029fe:	2b00      	cmp	r3, #0
c0d02a00:	d003      	beq.n	c0d02a0a <snprintf+0x212>
c0d02a02:	a80c      	add	r0, sp, #48	; 0x30
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d02a04:	212d      	movs	r1, #45	; 0x2d
c0d02a06:	5501      	strb	r1, [r0, r4]
c0d02a08:	1c64      	adds	r4, r4, #1
c0d02a0a:	9804      	ldr	r0, [sp, #16]
                    }

                    //
                    // Convert the value into a string.
                    //
                    for(; ulIdx; ulIdx /= ulBase)
c0d02a0c:	2f00      	cmp	r7, #0
c0d02a0e:	d018      	beq.n	c0d02a42 <snprintf+0x24a>
c0d02a10:	2800      	cmp	r0, #0
c0d02a12:	d001      	beq.n	c0d02a18 <snprintf+0x220>
c0d02a14:	a079      	add	r0, pc, #484	; (adr r0, c0d02bfc <g_pcHex_cap>)
c0d02a16:	e000      	b.n	c0d02a1a <snprintf+0x222>
c0d02a18:	a07c      	add	r0, pc, #496	; (adr r0, c0d02c0c <g_pcHex>)
c0d02a1a:	9009      	str	r0, [sp, #36]	; 0x24
c0d02a1c:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d02a1e:	4639      	mov	r1, r7
c0d02a20:	f003 fac4 	bl	c0d05fac <__aeabi_uidiv>
c0d02a24:	4629      	mov	r1, r5
c0d02a26:	f003 fb47 	bl	c0d060b8 <__aeabi_uidivmod>
c0d02a2a:	9809      	ldr	r0, [sp, #36]	; 0x24
c0d02a2c:	5c40      	ldrb	r0, [r0, r1]
c0d02a2e:	a90c      	add	r1, sp, #48	; 0x30
c0d02a30:	5508      	strb	r0, [r1, r4]
c0d02a32:	4638      	mov	r0, r7
c0d02a34:	4629      	mov	r1, r5
c0d02a36:	f003 fab9 	bl	c0d05fac <__aeabi_uidiv>
c0d02a3a:	1c64      	adds	r4, r4, #1
c0d02a3c:	42bd      	cmp	r5, r7
c0d02a3e:	4607      	mov	r7, r0
c0d02a40:	d9ec      	bls.n	c0d02a1c <snprintf+0x224>
c0d02a42:	9b03      	ldr	r3, [sp, #12]
                    }

                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
c0d02a44:	429c      	cmp	r4, r3
c0d02a46:	d300      	bcc.n	c0d02a4a <snprintf+0x252>
c0d02a48:	461c      	mov	r4, r3
c0d02a4a:	a90c      	add	r1, sp, #48	; 0x30
c0d02a4c:	9d02      	ldr	r5, [sp, #8]
                    os_memmove(str, pcBuf, ulPos);
c0d02a4e:	4628      	mov	r0, r5
c0d02a50:	4622      	mov	r2, r4
c0d02a52:	461f      	mov	r7, r3
c0d02a54:	e01b      	b.n	c0d02a8e <snprintf+0x296>
                case 'c':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d02a56:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d02a58:	1d01      	adds	r1, r0, #4
c0d02a5a:	910b      	str	r1, [sp, #44]	; 0x2c
c0d02a5c:	6800      	ldr	r0, [r0, #0]
c0d02a5e:	9902      	ldr	r1, [sp, #8]
c0d02a60:	7008      	strb	r0, [r1, #0]
c0d02a62:	9803      	ldr	r0, [sp, #12]
c0d02a64:	1e40      	subs	r0, r0, #1
c0d02a66:	1c49      	adds	r1, r1, #1
c0d02a68:	e015      	b.n	c0d02a96 <snprintf+0x29e>
c0d02a6a:	9c00      	ldr	r4, [sp, #0]
c0d02a6c:	9a05      	ldr	r2, [sp, #20]
c0d02a6e:	9b03      	ldr	r3, [sp, #12]
c0d02a70:	9d06      	ldr	r5, [sp, #24]
c0d02a72:	e024      	b.n	c0d02abe <snprintf+0x2c6>
                        break;
                        
                      // printout prepad
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
c0d02a74:	7808      	ldrb	r0, [r1, #0]
c0d02a76:	2800      	cmp	r0, #0
c0d02a78:	d075      	beq.n	c0d02b66 <snprintf+0x36e>
                default:
                {
                    //
                    // Indicate an error.
                    //
                    ulPos = MIN(strlen("ERROR"), str_size);
c0d02a7a:	2005      	movs	r0, #5
c0d02a7c:	9f03      	ldr	r7, [sp, #12]
c0d02a7e:	2f05      	cmp	r7, #5
c0d02a80:	463c      	mov	r4, r7
c0d02a82:	d300      	bcc.n	c0d02a86 <snprintf+0x28e>
c0d02a84:	4604      	mov	r4, r0
c0d02a86:	9d02      	ldr	r5, [sp, #8]
                    os_memmove(str, "ERROR", ulPos);
c0d02a88:	4628      	mov	r0, r5
c0d02a8a:	a164      	add	r1, pc, #400	; (adr r1, c0d02c1c <g_pcHex+0x10>)
c0d02a8c:	4622      	mov	r2, r4
c0d02a8e:	f7fe ff5e 	bl	c0d0194e <os_memmove>
c0d02a92:	1b38      	subs	r0, r7, r4
c0d02a94:	1929      	adds	r1, r5, r4
c0d02a96:	910a      	str	r1, [sp, #40]	; 0x28
c0d02a98:	4603      	mov	r3, r0
c0d02a9a:	2800      	cmp	r0, #0
c0d02a9c:	d100      	bne.n	c0d02aa0 <snprintf+0x2a8>
c0d02a9e:	e0a6      	b.n	c0d02bee <snprintf+0x3f6>
    va_start(vaArgP, format);

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d02aa0:	7830      	ldrb	r0, [r6, #0]
c0d02aa2:	2800      	cmp	r0, #0
c0d02aa4:	9905      	ldr	r1, [sp, #20]
c0d02aa6:	461d      	mov	r5, r3
c0d02aa8:	d000      	beq.n	c0d02aac <snprintf+0x2b4>
c0d02aaa:	e085      	b.n	c0d02bb8 <snprintf+0x3c0>
c0d02aac:	e09f      	b.n	c0d02bee <snprintf+0x3f6>
c0d02aae:	9a05      	ldr	r2, [sp, #20]
c0d02ab0:	4614      	mov	r4, r2
c0d02ab2:	9b03      	ldr	r3, [sp, #12]
                    // Determine the length of the string. (if not specified using .*)
                    //
                    switch(cStrlenSet) {
                      // compute length with strlen
                      case 0:
                        for(ulIdx = 0; pcStr[ulIdx] != '\0'; ulIdx++)
c0d02ab4:	1908      	adds	r0, r1, r4
c0d02ab6:	7840      	ldrb	r0, [r0, #1]
c0d02ab8:	1c64      	adds	r4, r4, #1
c0d02aba:	2800      	cmp	r0, #0
c0d02abc:	d1fa      	bne.n	c0d02ab4 <snprintf+0x2bc>
                    }

                    //
                    // Write the string.
                    //
                    switch(ulBase) {
c0d02abe:	9801      	ldr	r0, [sp, #4]
c0d02ac0:	2810      	cmp	r0, #16
c0d02ac2:	9802      	ldr	r0, [sp, #8]
c0d02ac4:	d144      	bne.n	c0d02b50 <snprintf+0x358>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d02ac6:	2c00      	cmp	r4, #0
c0d02ac8:	d074      	beq.n	c0d02bb4 <snprintf+0x3bc>
c0d02aca:	9108      	str	r1, [sp, #32]
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d02acc:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d02ace:	1883      	adds	r3, r0, r2
c0d02ad0:	1b50      	subs	r0, r2, r5
c0d02ad2:	4287      	cmp	r7, r0
c0d02ad4:	4639      	mov	r1, r7
c0d02ad6:	d800      	bhi.n	c0d02ada <snprintf+0x2e2>
c0d02ad8:	4601      	mov	r1, r0
c0d02ada:	9103      	str	r1, [sp, #12]
c0d02adc:	434a      	muls	r2, r1
c0d02ade:	9202      	str	r2, [sp, #8]
c0d02ae0:	1c50      	adds	r0, r2, #1
c0d02ae2:	9001      	str	r0, [sp, #4]
c0d02ae4:	2000      	movs	r0, #0
c0d02ae6:	462a      	mov	r2, r5
c0d02ae8:	930a      	str	r3, [sp, #40]	; 0x28
c0d02aea:	9902      	ldr	r1, [sp, #8]
c0d02aec:	185b      	adds	r3, r3, r1
c0d02aee:	9009      	str	r0, [sp, #36]	; 0x24
c0d02af0:	9908      	ldr	r1, [sp, #32]
c0d02af2:	5c08      	ldrb	r0, [r1, r0]
                          nibble2 = pcStr[ulCount]&0xF;
c0d02af4:	250f      	movs	r5, #15
c0d02af6:	4005      	ands	r5, r0
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d02af8:	0900      	lsrs	r0, r0, #4
c0d02afa:	9903      	ldr	r1, [sp, #12]
c0d02afc:	1889      	adds	r1, r1, r2
c0d02afe:	1c49      	adds	r1, r1, #1
                          nibble2 = pcStr[ulCount]&0xF;
                          if (str_size < 2) {
c0d02b00:	2902      	cmp	r1, #2
c0d02b02:	d374      	bcc.n	c0d02bee <snprintf+0x3f6>
c0d02b04:	9904      	ldr	r1, [sp, #16]
                              return 0;
                          }
                          switch(ulCap) {
c0d02b06:	2901      	cmp	r1, #1
c0d02b08:	d003      	beq.n	c0d02b12 <snprintf+0x31a>
c0d02b0a:	2900      	cmp	r1, #0
c0d02b0c:	d108      	bne.n	c0d02b20 <snprintf+0x328>
c0d02b0e:	a13f      	add	r1, pc, #252	; (adr r1, c0d02c0c <g_pcHex>)
c0d02b10:	e000      	b.n	c0d02b14 <snprintf+0x31c>
c0d02b12:	a13a      	add	r1, pc, #232	; (adr r1, c0d02bfc <g_pcHex_cap>)
c0d02b14:	b2c0      	uxtb	r0, r0
c0d02b16:	5c08      	ldrb	r0, [r1, r0]
c0d02b18:	7018      	strb	r0, [r3, #0]
c0d02b1a:	b2e8      	uxtb	r0, r5
c0d02b1c:	5c08      	ldrb	r0, [r1, r0]
c0d02b1e:	7058      	strb	r0, [r3, #1]
                                str[1] = g_pcHex_cap[nibble2];
                              break;
                          }
                          str+= 2;
                          str_size -= 2;
                          if (str_size == 0) {
c0d02b20:	9801      	ldr	r0, [sp, #4]
c0d02b22:	4290      	cmp	r0, r2
c0d02b24:	d063      	beq.n	c0d02bee <snprintf+0x3f6>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d02b26:	1e92      	subs	r2, r2, #2
c0d02b28:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d02b2a:	1c9b      	adds	r3, r3, #2
c0d02b2c:	9809      	ldr	r0, [sp, #36]	; 0x24
c0d02b2e:	1c40      	adds	r0, r0, #1
c0d02b30:	42a0      	cmp	r0, r4
c0d02b32:	d3d9      	bcc.n	c0d02ae8 <snprintf+0x2f0>
c0d02b34:	9009      	str	r0, [sp, #36]	; 0x24
c0d02b36:	9905      	ldr	r1, [sp, #20]
 
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
c0d02b38:	9806      	ldr	r0, [sp, #24]
c0d02b3a:	1a08      	subs	r0, r1, r0
c0d02b3c:	4287      	cmp	r7, r0
c0d02b3e:	d800      	bhi.n	c0d02b42 <snprintf+0x34a>
c0d02b40:	4607      	mov	r7, r0
c0d02b42:	4608      	mov	r0, r1
c0d02b44:	4378      	muls	r0, r7
c0d02b46:	1818      	adds	r0, r3, r0
c0d02b48:	900a      	str	r0, [sp, #40]	; 0x28
c0d02b4a:	18b8      	adds	r0, r7, r2
c0d02b4c:	1c43      	adds	r3, r0, #1
c0d02b4e:	e01c      	b.n	c0d02b8a <snprintf+0x392>
                    //
                    // Write the string.
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
c0d02b50:	429c      	cmp	r4, r3
c0d02b52:	d300      	bcc.n	c0d02b56 <snprintf+0x35e>
c0d02b54:	461c      	mov	r4, r3
                        os_memmove(str, pcStr, ulIdx);
c0d02b56:	4622      	mov	r2, r4
c0d02b58:	4605      	mov	r5, r0
c0d02b5a:	461f      	mov	r7, r3
c0d02b5c:	f7fe fef7 	bl	c0d0194e <os_memmove>
                        str+= ulIdx;
                        str_size -= ulIdx;
c0d02b60:	1b38      	subs	r0, r7, r4
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
                        os_memmove(str, pcStr, ulIdx);
                        str+= ulIdx;
c0d02b62:	1929      	adds	r1, r5, r4
c0d02b64:	e00d      	b.n	c0d02b82 <snprintf+0x38a>
c0d02b66:	9b03      	ldr	r3, [sp, #12]
c0d02b68:	9f00      	ldr	r7, [sp, #0]
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
c0d02b6a:	429f      	cmp	r7, r3
c0d02b6c:	d300      	bcc.n	c0d02b70 <snprintf+0x378>
c0d02b6e:	461f      	mov	r7, r3
                          os_memset(str, ' ', ulStrlen);
c0d02b70:	2120      	movs	r1, #32
c0d02b72:	9d02      	ldr	r5, [sp, #8]
c0d02b74:	4628      	mov	r0, r5
c0d02b76:	463a      	mov	r2, r7
c0d02b78:	f7fe fee0 	bl	c0d0193c <os_memset>
                          str+= ulStrlen;
                          str_size -= ulStrlen;
c0d02b7c:	9803      	ldr	r0, [sp, #12]
c0d02b7e:	1bc0      	subs	r0, r0, r7
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
                          os_memset(str, ' ', ulStrlen);
                          str+= ulStrlen;
c0d02b80:	19e9      	adds	r1, r5, r7
c0d02b82:	910a      	str	r1, [sp, #40]	; 0x28
c0d02b84:	4603      	mov	r3, r0
c0d02b86:	2800      	cmp	r0, #0
c0d02b88:	d031      	beq.n	c0d02bee <snprintf+0x3f6>
c0d02b8a:	9809      	ldr	r0, [sp, #36]	; 0x24

s_pad:
                    //
                    // Write any required padding spaces
                    //
                    if(ulCount > ulIdx)
c0d02b8c:	42a0      	cmp	r0, r4
c0d02b8e:	d987      	bls.n	c0d02aa0 <snprintf+0x2a8>
                    {
                        ulCount -= ulIdx;
c0d02b90:	1b04      	subs	r4, r0, r4
c0d02b92:	461d      	mov	r5, r3
                        ulCount = MIN(ulCount, str_size);
c0d02b94:	42ac      	cmp	r4, r5
c0d02b96:	d300      	bcc.n	c0d02b9a <snprintf+0x3a2>
c0d02b98:	462c      	mov	r4, r5
                        os_memset(str, ' ', ulCount);
c0d02b9a:	2120      	movs	r1, #32
c0d02b9c:	9f0a      	ldr	r7, [sp, #40]	; 0x28
c0d02b9e:	4638      	mov	r0, r7
c0d02ba0:	4622      	mov	r2, r4
c0d02ba2:	f7fe fecb 	bl	c0d0193c <os_memset>
                        str+= ulCount;
                        str_size -= ulCount;
c0d02ba6:	1b2d      	subs	r5, r5, r4
                    if(ulCount > ulIdx)
                    {
                        ulCount -= ulIdx;
                        ulCount = MIN(ulCount, str_size);
                        os_memset(str, ' ', ulCount);
                        str+= ulCount;
c0d02ba8:	193f      	adds	r7, r7, r4
c0d02baa:	970a      	str	r7, [sp, #40]	; 0x28
c0d02bac:	462b      	mov	r3, r5
                        str_size -= ulCount;
                        if (str_size == 0) {
c0d02bae:	2d00      	cmp	r5, #0
c0d02bb0:	d01d      	beq.n	c0d02bee <snprintf+0x3f6>
c0d02bb2:	e775      	b.n	c0d02aa0 <snprintf+0x2a8>
c0d02bb4:	900a      	str	r0, [sp, #40]	; 0x28
c0d02bb6:	e773      	b.n	c0d02aa0 <snprintf+0x2a8>
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d02bb8:	460f      	mov	r7, r1
c0d02bba:	9c07      	ldr	r4, [sp, #28]
c0d02bbc:	e003      	b.n	c0d02bc6 <snprintf+0x3ce>
c0d02bbe:	1930      	adds	r0, r6, r4
c0d02bc0:	7840      	ldrb	r0, [r0, #1]
c0d02bc2:	1e7f      	subs	r7, r7, #1
            ulIdx++)
c0d02bc4:	1c64      	adds	r4, r4, #1
c0d02bc6:	b2c0      	uxtb	r0, r0
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d02bc8:	2800      	cmp	r0, #0
c0d02bca:	d001      	beq.n	c0d02bd0 <snprintf+0x3d8>
c0d02bcc:	2825      	cmp	r0, #37	; 0x25
c0d02bce:	d1f6      	bne.n	c0d02bbe <snprintf+0x3c6>
        }

        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
c0d02bd0:	42ac      	cmp	r4, r5
c0d02bd2:	d300      	bcc.n	c0d02bd6 <snprintf+0x3de>
c0d02bd4:	462c      	mov	r4, r5
        os_memmove(str, format, ulIdx);
c0d02bd6:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d02bd8:	4631      	mov	r1, r6
c0d02bda:	4622      	mov	r2, r4
c0d02bdc:	f7fe feb7 	bl	c0d0194e <os_memmove>
c0d02be0:	9506      	str	r5, [sp, #24]
        str+= ulIdx;
        str_size -= ulIdx;
c0d02be2:	1b2b      	subs	r3, r5, r4
        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
        os_memmove(str, format, ulIdx);
        str+= ulIdx;
c0d02be4:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d02be6:	1902      	adds	r2, r0, r4
        str_size -= ulIdx;
        if (str_size == 0) {
c0d02be8:	2b00      	cmp	r3, #0
c0d02bea:	d000      	beq.n	c0d02bee <snprintf+0x3f6>
c0d02bec:	e626      	b.n	c0d0283c <snprintf+0x44>
    // End the varargs processing.
    //
    va_end(vaArgP);

    return 0;
}
c0d02bee:	2000      	movs	r0, #0
c0d02bf0:	b010      	add	sp, #64	; 0x40
c0d02bf2:	bcf0      	pop	{r4, r5, r6, r7}
c0d02bf4:	bc02      	pop	{r1}
c0d02bf6:	b001      	add	sp, #4
c0d02bf8:	4708      	bx	r1
c0d02bfa:	46c0      	nop			; (mov r8, r8)

c0d02bfc <g_pcHex_cap>:
c0d02bfc:	33323130 	.word	0x33323130
c0d02c00:	37363534 	.word	0x37363534
c0d02c04:	42413938 	.word	0x42413938
c0d02c08:	46454443 	.word	0x46454443

c0d02c0c <g_pcHex>:
c0d02c0c:	33323130 	.word	0x33323130
c0d02c10:	37363534 	.word	0x37363534
c0d02c14:	62613938 	.word	0x62613938
c0d02c18:	66656463 	.word	0x66656463
c0d02c1c:	4f525245 	.word	0x4f525245
c0d02c20:	00000052 	.word	0x00000052

c0d02c24 <pic>:

// only apply PIC conversion if link_address is in linked code (over 0xC0D00000 in our example)
// this way, PIC call are armless if the address is not meant to be converted
extern unsigned int _nvram;
extern unsigned int _envram;
unsigned int pic(unsigned int link_address) {
c0d02c24:	b580      	push	{r7, lr}
//  screen_printf(" %08X", link_address);
	if (link_address >= ((unsigned int)&_nvram) && link_address < ((unsigned int)&_envram)) {
c0d02c26:	4904      	ldr	r1, [pc, #16]	; (c0d02c38 <pic+0x14>)
c0d02c28:	4288      	cmp	r0, r1
c0d02c2a:	d304      	bcc.n	c0d02c36 <pic+0x12>
c0d02c2c:	4903      	ldr	r1, [pc, #12]	; (c0d02c3c <pic+0x18>)
c0d02c2e:	4288      	cmp	r0, r1
c0d02c30:	d201      	bcs.n	c0d02c36 <pic+0x12>
		link_address = pic_internal(link_address);
c0d02c32:	f000 f805 	bl	c0d02c40 <pic_internal>
//    screen_printf(" -> %08X\n", link_address);
  }
	return link_address;
c0d02c36:	bd80      	pop	{r7, pc}
c0d02c38:	c0d00000 	.word	0xc0d00000
c0d02c3c:	c0d09f80 	.word	0xc0d09f80

c0d02c40 <pic_internal>:

unsigned int pic_internal(unsigned int link_address) __attribute__((naked));
unsigned int pic_internal(unsigned int link_address) 
{
  // compute the delta offset between LinkMemAddr & ExecMemAddr
  __asm volatile ("mov r2, pc\n");          // r2 = 0x109004
c0d02c40:	467a      	mov	r2, pc
  __asm volatile ("ldr r1, =pic_internal\n");        // r1 = 0xC0D00001
c0d02c42:	4902      	ldr	r1, [pc, #8]	; (c0d02c4c <pic_internal+0xc>)
  __asm volatile ("adds r1, r1, #3\n");     // r1 = 0xC0D00004
c0d02c44:	1cc9      	adds	r1, r1, #3
  __asm volatile ("subs r1, r1, r2\n");     // r1 = 0xC0BF7000 (delta between load and exec address)
c0d02c46:	1a89      	subs	r1, r1, r2

  // adjust value of the given parameter
  __asm volatile ("subs r0, r0, r1\n");     // r0 = 0xC0D0C244 => r0 = 0x115244
c0d02c48:	1a40      	subs	r0, r0, r1
  __asm volatile ("bx lr\n");
c0d02c4a:	4770      	bx	lr
c0d02c4c:	c0d02c41 	.word	0xc0d02c41

c0d02c50 <bech32_polymod_step>:
#include <stdint.h>
#include <string.h>

#include "segwit_addr.h"

uint32_t bech32_polymod_step(uint32_t pre) {
c0d02c50:	b510      	push	{r4, lr}
    uint8_t b = pre >> 25;
    return ((pre & 0x1FFFFFF) << 5) ^
c0d02c52:	0141      	lsls	r1, r0, #5
c0d02c54:	4a10      	ldr	r2, [pc, #64]	; (c0d02c98 <bech32_polymod_step+0x48>)
c0d02c56:	400a      	ands	r2, r1
#include <string.h>

#include "segwit_addr.h"

uint32_t bech32_polymod_step(uint32_t pre) {
    uint8_t b = pre >> 25;
c0d02c58:	0e43      	lsrs	r3, r0, #25
    return ((pre & 0x1FFFFFF) << 5) ^
           (-((b >> 0) & 1) & 0x3b6a57b2UL) ^
c0d02c5a:	2101      	movs	r1, #1
c0d02c5c:	400b      	ands	r3, r1
c0d02c5e:	425b      	negs	r3, r3
c0d02c60:	4c0e      	ldr	r4, [pc, #56]	; (c0d02c9c <bech32_polymod_step+0x4c>)
c0d02c62:	401c      	ands	r4, r3

#include "segwit_addr.h"

uint32_t bech32_polymod_step(uint32_t pre) {
    uint8_t b = pre >> 25;
    return ((pre & 0x1FFFFFF) << 5) ^
c0d02c64:	4054      	eors	r4, r2
           (-((b >> 0) & 1) & 0x3b6a57b2UL) ^
           (-((b >> 1) & 1) & 0x26508e6dUL) ^
c0d02c66:	0e82      	lsrs	r2, r0, #26
c0d02c68:	400a      	ands	r2, r1
c0d02c6a:	4252      	negs	r2, r2
c0d02c6c:	4b0c      	ldr	r3, [pc, #48]	; (c0d02ca0 <bech32_polymod_step+0x50>)
c0d02c6e:	4013      	ands	r3, r2
#include "segwit_addr.h"

uint32_t bech32_polymod_step(uint32_t pre) {
    uint8_t b = pre >> 25;
    return ((pre & 0x1FFFFFF) << 5) ^
           (-((b >> 0) & 1) & 0x3b6a57b2UL) ^
c0d02c70:	4063      	eors	r3, r4
           (-((b >> 1) & 1) & 0x26508e6dUL) ^
           (-((b >> 2) & 1) & 0x1ea119faUL) ^
c0d02c72:	0ec2      	lsrs	r2, r0, #27
c0d02c74:	400a      	ands	r2, r1
c0d02c76:	4252      	negs	r2, r2
c0d02c78:	4c0a      	ldr	r4, [pc, #40]	; (c0d02ca4 <bech32_polymod_step+0x54>)
c0d02c7a:	4014      	ands	r4, r2

uint32_t bech32_polymod_step(uint32_t pre) {
    uint8_t b = pre >> 25;
    return ((pre & 0x1FFFFFF) << 5) ^
           (-((b >> 0) & 1) & 0x3b6a57b2UL) ^
           (-((b >> 1) & 1) & 0x26508e6dUL) ^
c0d02c7c:	405c      	eors	r4, r3
           (-((b >> 2) & 1) & 0x1ea119faUL) ^
           (-((b >> 3) & 1) & 0x3d4233ddUL) ^
c0d02c7e:	0f02      	lsrs	r2, r0, #28
c0d02c80:	400a      	ands	r2, r1
c0d02c82:	4252      	negs	r2, r2
c0d02c84:	4b08      	ldr	r3, [pc, #32]	; (c0d02ca8 <bech32_polymod_step+0x58>)
c0d02c86:	4013      	ands	r3, r2
uint32_t bech32_polymod_step(uint32_t pre) {
    uint8_t b = pre >> 25;
    return ((pre & 0x1FFFFFF) << 5) ^
           (-((b >> 0) & 1) & 0x3b6a57b2UL) ^
           (-((b >> 1) & 1) & 0x26508e6dUL) ^
           (-((b >> 2) & 1) & 0x1ea119faUL) ^
c0d02c88:	4063      	eors	r3, r4
           (-((b >> 3) & 1) & 0x3d4233ddUL) ^
           (-((b >> 4) & 1) & 0x2a1462b3UL);
c0d02c8a:	0f40      	lsrs	r0, r0, #29
c0d02c8c:	4008      	ands	r0, r1
c0d02c8e:	4241      	negs	r1, r0
c0d02c90:	4806      	ldr	r0, [pc, #24]	; (c0d02cac <bech32_polymod_step+0x5c>)
c0d02c92:	4008      	ands	r0, r1
    uint8_t b = pre >> 25;
    return ((pre & 0x1FFFFFF) << 5) ^
           (-((b >> 0) & 1) & 0x3b6a57b2UL) ^
           (-((b >> 1) & 1) & 0x26508e6dUL) ^
           (-((b >> 2) & 1) & 0x1ea119faUL) ^
           (-((b >> 3) & 1) & 0x3d4233ddUL) ^
c0d02c94:	4058      	eors	r0, r3

#include "segwit_addr.h"

uint32_t bech32_polymod_step(uint32_t pre) {
    uint8_t b = pre >> 25;
    return ((pre & 0x1FFFFFF) << 5) ^
c0d02c96:	bd10      	pop	{r4, pc}
c0d02c98:	3fffffe0 	.word	0x3fffffe0
c0d02c9c:	3b6a57b2 	.word	0x3b6a57b2
c0d02ca0:	26508e6d 	.word	0x26508e6d
c0d02ca4:	1ea119fa 	.word	0x1ea119fa
c0d02ca8:	3d4233dd 	.word	0x3d4233dd
c0d02cac:	2a1462b3 	.word	0x2a1462b3

c0d02cb0 <bech32_encode>:
        1,  0,  3, 16, 11, 28, 12, 14,  6,  4,  2, -1, -1, -1, -1, -1,
        -1, 29, -1, 24, 13, 25,  9,  8, 23, -1, 18, 22, 31, 27, 19, -1,
        1,  0,  3, 16, 11, 28, 12, 14,  6,  4,  2, -1, -1, -1, -1, -1
};

int bech32_encode(char *output, const char *hrp, const uint8_t *data, size_t data_len) {
c0d02cb0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02cb2:	b087      	sub	sp, #28
c0d02cb4:	9305      	str	r3, [sp, #20]
c0d02cb6:	9204      	str	r2, [sp, #16]
c0d02cb8:	4607      	mov	r7, r0
c0d02cba:	9102      	str	r1, [sp, #8]
    uint32_t chk = 1;
    size_t i = 0;
    while (hrp[i] != 0) {
c0d02cbc:	780e      	ldrb	r6, [r1, #0]
c0d02cbe:	2500      	movs	r5, #0
c0d02cc0:	2001      	movs	r0, #1
c0d02cc2:	2e00      	cmp	r6, #0
c0d02cc4:	9503      	str	r5, [sp, #12]
c0d02cc6:	d01b      	beq.n	c0d02d00 <bech32_encode+0x50>
        int ch = hrp[i];
c0d02cc8:	9802      	ldr	r0, [sp, #8]
c0d02cca:	1c40      	adds	r0, r0, #1
c0d02ccc:	9006      	str	r0, [sp, #24]
c0d02cce:	2001      	movs	r0, #1
c0d02cd0:	2500      	movs	r5, #0
c0d02cd2:	4634      	mov	r4, r6
c0d02cd4:	4632      	mov	r2, r6
c0d02cd6:	9501      	str	r5, [sp, #4]
        if (ch < 33 || ch > 126) {
            return 0;
        }

        if (ch >= 'A' && ch <= 'Z') return 0;
c0d02cd8:	4611      	mov	r1, r2
c0d02cda:	3941      	subs	r1, #65	; 0x41
int bech32_encode(char *output, const char *hrp, const uint8_t *data, size_t data_len) {
    uint32_t chk = 1;
    size_t i = 0;
    while (hrp[i] != 0) {
        int ch = hrp[i];
        if (ch < 33 || ch > 126) {
c0d02cdc:	3a21      	subs	r2, #33	; 0x21
c0d02cde:	b2d2      	uxtb	r2, r2
c0d02ce0:	2a5d      	cmp	r2, #93	; 0x5d
c0d02ce2:	d85d      	bhi.n	c0d02da0 <bech32_encode+0xf0>
c0d02ce4:	b2c9      	uxtb	r1, r1
c0d02ce6:	291a      	cmp	r1, #26
c0d02ce8:	d35a      	bcc.n	c0d02da0 <bech32_encode+0xf0>
            return 0;
        }

        if (ch >= 'A' && ch <= 'Z') return 0;
        chk = bech32_polymod_step(chk) ^ (ch >> 5);
c0d02cea:	f7ff ffb1 	bl	c0d02c50 <bech32_polymod_step>
c0d02cee:	4601      	mov	r1, r0
};

int bech32_encode(char *output, const char *hrp, const uint8_t *data, size_t data_len) {
    uint32_t chk = 1;
    size_t i = 0;
    while (hrp[i] != 0) {
c0d02cf0:	9806      	ldr	r0, [sp, #24]
c0d02cf2:	5d42      	ldrb	r2, [r0, r5]
        if (ch < 33 || ch > 126) {
            return 0;
        }

        if (ch >= 'A' && ch <= 'Z') return 0;
        chk = bech32_polymod_step(chk) ^ (ch >> 5);
c0d02cf4:	0960      	lsrs	r0, r4, #5
c0d02cf6:	4048      	eors	r0, r1
        ++i;
c0d02cf8:	1c6d      	adds	r5, r5, #1
};

int bech32_encode(char *output, const char *hrp, const uint8_t *data, size_t data_len) {
    uint32_t chk = 1;
    size_t i = 0;
    while (hrp[i] != 0) {
c0d02cfa:	2a00      	cmp	r2, #0
c0d02cfc:	4614      	mov	r4, r2
c0d02cfe:	d1eb      	bne.n	c0d02cd8 <bech32_encode+0x28>

        if (ch >= 'A' && ch <= 'Z') return 0;
        chk = bech32_polymod_step(chk) ^ (ch >> 5);
        ++i;
    }
    if (i + 7 + data_len > 90) return 0;
c0d02d00:	9905      	ldr	r1, [sp, #20]
c0d02d02:	1949      	adds	r1, r1, r5
c0d02d04:	1dc9      	adds	r1, r1, #7
c0d02d06:	295a      	cmp	r1, #90	; 0x5a
c0d02d08:	9903      	ldr	r1, [sp, #12]
c0d02d0a:	d84c      	bhi.n	c0d02da6 <bech32_encode+0xf6>
    chk = bech32_polymod_step(chk);
c0d02d0c:	f7ff ffa0 	bl	c0d02c50 <bech32_polymod_step>
    while (*hrp != 0) {
c0d02d10:	2e00      	cmp	r6, #0
c0d02d12:	d00e      	beq.n	c0d02d32 <bech32_encode+0x82>
        chk = bech32_polymod_step(chk) ^ (*hrp & 0x1f);
c0d02d14:	9902      	ldr	r1, [sp, #8]
c0d02d16:	1c4c      	adds	r4, r1, #1
c0d02d18:	f7ff ff9a 	bl	c0d02c50 <bech32_polymod_step>
c0d02d1c:	4601      	mov	r1, r0
        *(output++) = *(hrp++);
c0d02d1e:	703e      	strb	r6, [r7, #0]
        ++i;
    }
    if (i + 7 + data_len > 90) return 0;
    chk = bech32_polymod_step(chk);
    while (*hrp != 0) {
        chk = bech32_polymod_step(chk) ^ (*hrp & 0x1f);
c0d02d20:	201f      	movs	r0, #31
c0d02d22:	4030      	ands	r0, r6
c0d02d24:	4048      	eors	r0, r1
        chk = bech32_polymod_step(chk) ^ (ch >> 5);
        ++i;
    }
    if (i + 7 + data_len > 90) return 0;
    chk = bech32_polymod_step(chk);
    while (*hrp != 0) {
c0d02d26:	1c61      	adds	r1, r4, #1
        chk = bech32_polymod_step(chk) ^ (*hrp & 0x1f);
        *(output++) = *(hrp++);
c0d02d28:	1c7f      	adds	r7, r7, #1
        chk = bech32_polymod_step(chk) ^ (ch >> 5);
        ++i;
    }
    if (i + 7 + data_len > 90) return 0;
    chk = bech32_polymod_step(chk);
    while (*hrp != 0) {
c0d02d2a:	7826      	ldrb	r6, [r4, #0]
c0d02d2c:	2e00      	cmp	r6, #0
c0d02d2e:	460c      	mov	r4, r1
c0d02d30:	d1f2      	bne.n	c0d02d18 <bech32_encode+0x68>
        chk = bech32_polymod_step(chk) ^ (*hrp & 0x1f);
        *(output++) = *(hrp++);
    }
    *(output++) = '1';
c0d02d32:	2131      	movs	r1, #49	; 0x31
c0d02d34:	7039      	strb	r1, [r7, #0]
c0d02d36:	1c79      	adds	r1, r7, #1
    for (i = 0; i < data_len; ++i) {
c0d02d38:	9106      	str	r1, [sp, #24]
c0d02d3a:	9905      	ldr	r1, [sp, #20]
c0d02d3c:	2900      	cmp	r1, #0
c0d02d3e:	d014      	beq.n	c0d02d6a <bech32_encode+0xba>
c0d02d40:	2400      	movs	r4, #0
c0d02d42:	9403      	str	r4, [sp, #12]
        if (*data >> 5) return 0;
c0d02d44:	9904      	ldr	r1, [sp, #16]
c0d02d46:	5d0f      	ldrb	r7, [r1, r4]
c0d02d48:	9906      	ldr	r1, [sp, #24]
c0d02d4a:	190e      	adds	r6, r1, r4
c0d02d4c:	2f1f      	cmp	r7, #31
c0d02d4e:	d829      	bhi.n	c0d02da4 <bech32_encode+0xf4>
        chk = bech32_polymod_step(chk) ^ (*data);
        *(output++) = charset[*(data++)];
c0d02d50:	a116      	add	r1, pc, #88	; (adr r1, c0d02dac <bech32_encode+0xfc>)
c0d02d52:	5dcd      	ldrb	r5, [r1, r7]
        *(output++) = *(hrp++);
    }
    *(output++) = '1';
    for (i = 0; i < data_len; ++i) {
        if (*data >> 5) return 0;
        chk = bech32_polymod_step(chk) ^ (*data);
c0d02d54:	f7ff ff7c 	bl	c0d02c50 <bech32_polymod_step>
        *(output++) = charset[*(data++)];
c0d02d58:	7035      	strb	r5, [r6, #0]
        *(output++) = *(hrp++);
    }
    *(output++) = '1';
    for (i = 0; i < data_len; ++i) {
        if (*data >> 5) return 0;
        chk = bech32_polymod_step(chk) ^ (*data);
c0d02d5a:	4078      	eors	r0, r7
    while (*hrp != 0) {
        chk = bech32_polymod_step(chk) ^ (*hrp & 0x1f);
        *(output++) = *(hrp++);
    }
    *(output++) = '1';
    for (i = 0; i < data_len; ++i) {
c0d02d5c:	1c64      	adds	r4, r4, #1
c0d02d5e:	9905      	ldr	r1, [sp, #20]
c0d02d60:	428c      	cmp	r4, r1
c0d02d62:	d3ef      	bcc.n	c0d02d44 <bech32_encode+0x94>
        1,  0,  3, 16, 11, 28, 12, 14,  6,  4,  2, -1, -1, -1, -1, -1
};

int bech32_encode(char *output, const char *hrp, const uint8_t *data, size_t data_len) {
    uint32_t chk = 1;
    size_t i = 0;
c0d02d64:	9906      	ldr	r1, [sp, #24]
c0d02d66:	1909      	adds	r1, r1, r4
c0d02d68:	9106      	str	r1, [sp, #24]
c0d02d6a:	2406      	movs	r4, #6
        if (*data >> 5) return 0;
        chk = bech32_polymod_step(chk) ^ (*data);
        *(output++) = charset[*(data++)];
    }
    for (i = 0; i < 6; ++i) {
        chk = bech32_polymod_step(chk);
c0d02d6c:	f7ff ff70 	bl	c0d02c50 <bech32_polymod_step>
    for (i = 0; i < data_len; ++i) {
        if (*data >> 5) return 0;
        chk = bech32_polymod_step(chk) ^ (*data);
        *(output++) = charset[*(data++)];
    }
    for (i = 0; i < 6; ++i) {
c0d02d70:	1e64      	subs	r4, r4, #1
c0d02d72:	d1fb      	bne.n	c0d02d6c <bech32_encode+0xbc>
        chk = bech32_polymod_step(chk);
    }
    chk ^= 1;
c0d02d74:	2101      	movs	r1, #1
c0d02d76:	460e      	mov	r6, r1
c0d02d78:	4048      	eors	r0, r1
c0d02d7a:	2219      	movs	r2, #25
c0d02d7c:	a10b      	add	r1, pc, #44	; (adr r1, c0d02dac <bech32_encode+0xfc>)
c0d02d7e:	9b06      	ldr	r3, [sp, #24]
    for (i = 0; i < 6; ++i) {
        *(output++) = charset[(chk >> ((5 - i) * 5)) & 0x1f];
c0d02d80:	4604      	mov	r4, r0
c0d02d82:	40d4      	lsrs	r4, r2
c0d02d84:	251f      	movs	r5, #31
c0d02d86:	4025      	ands	r5, r4
c0d02d88:	5d4c      	ldrb	r4, [r1, r5]
c0d02d8a:	701c      	strb	r4, [r3, #0]
    }
    for (i = 0; i < 6; ++i) {
        chk = bech32_polymod_step(chk);
    }
    chk ^= 1;
    for (i = 0; i < 6; ++i) {
c0d02d8c:	1f54      	subs	r4, r2, #5
        *(output++) = charset[(chk >> ((5 - i) * 5)) & 0x1f];
c0d02d8e:	1c5b      	adds	r3, r3, #1
    }
    for (i = 0; i < 6; ++i) {
        chk = bech32_polymod_step(chk);
    }
    chk ^= 1;
    for (i = 0; i < 6; ++i) {
c0d02d90:	2a00      	cmp	r2, #0
c0d02d92:	4622      	mov	r2, r4
c0d02d94:	d1f4      	bne.n	c0d02d80 <bech32_encode+0xd0>
        *(output++) = charset[(chk >> ((5 - i) * 5)) & 0x1f];
    }
    *output = 0;
c0d02d96:	2000      	movs	r0, #0
c0d02d98:	9906      	ldr	r1, [sp, #24]
c0d02d9a:	7188      	strb	r0, [r1, #6]
c0d02d9c:	4631      	mov	r1, r6
c0d02d9e:	e002      	b.n	c0d02da6 <bech32_encode+0xf6>
c0d02da0:	9901      	ldr	r1, [sp, #4]
c0d02da2:	e000      	b.n	c0d02da6 <bech32_encode+0xf6>
c0d02da4:	9903      	ldr	r1, [sp, #12]
    return 1;
}
c0d02da6:	4608      	mov	r0, r1
c0d02da8:	b007      	add	sp, #28
c0d02daa:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02dac:	727a7071 	.word	0x727a7071
c0d02db0:	38783979 	.word	0x38783979
c0d02db4:	74326667 	.word	0x74326667
c0d02db8:	30776476 	.word	0x30776476
c0d02dbc:	6e6a3373 	.word	0x6e6a3373
c0d02dc0:	686b3435 	.word	0x686b3435
c0d02dc4:	6d366563 	.word	0x6d366563
c0d02dc8:	6c376175 	.word	0x6c376175
c0d02dcc:	00000000 	.word	0x00000000

c0d02dd0 <convert_bits>:
        return 0;
    }
    return chk == 1;
}

int convert_bits(uint8_t* out, size_t* outlen, int outbits, const uint8_t* in, size_t inlen, int inbits, int pad) {
c0d02dd0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02dd2:	b087      	sub	sp, #28
c0d02dd4:	461f      	mov	r7, r3
c0d02dd6:	4605      	mov	r5, r0
    uint32_t val = 0;
    int bits = 0;
    uint32_t maxv = (((uint32_t)1) << outbits) - 1;
c0d02dd8:	2301      	movs	r3, #1
c0d02dda:	9300      	str	r3, [sp, #0]
c0d02ddc:	4093      	lsls	r3, r2
c0d02dde:	1e58      	subs	r0, r3, #1
c0d02de0:	9006      	str	r0, [sp, #24]
c0d02de2:	2600      	movs	r6, #0
c0d02de4:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d02de6:	9001      	str	r0, [sp, #4]
c0d02de8:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d02dea:	9004      	str	r0, [sp, #16]
c0d02dec:	9b0c      	ldr	r3, [sp, #48]	; 0x30
    while (inlen--) {
c0d02dee:	2b00      	cmp	r3, #0
c0d02df0:	4630      	mov	r0, r6
c0d02df2:	d026      	beq.n	c0d02e42 <convert_bits+0x72>
c0d02df4:	4250      	negs	r0, r2
c0d02df6:	9005      	str	r0, [sp, #20]
c0d02df8:	2000      	movs	r0, #0
c0d02dfa:	4606      	mov	r6, r0
        val = (val << inbits) | *(in++);
        bits += inbits;
c0d02dfc:	9c04      	ldr	r4, [sp, #16]
c0d02dfe:	1900      	adds	r0, r0, r4
c0d02e00:	461c      	mov	r4, r3
int convert_bits(uint8_t* out, size_t* outlen, int outbits, const uint8_t* in, size_t inlen, int inbits, int pad) {
    uint32_t val = 0;
    int bits = 0;
    uint32_t maxv = (((uint32_t)1) << outbits) - 1;
    while (inlen--) {
        val = (val << inbits) | *(in++);
c0d02e02:	4633      	mov	r3, r6
c0d02e04:	9e04      	ldr	r6, [sp, #16]
c0d02e06:	40b3      	lsls	r3, r6
c0d02e08:	783e      	ldrb	r6, [r7, #0]
c0d02e0a:	431e      	orrs	r6, r3
c0d02e0c:	1c7f      	adds	r7, r7, #1
c0d02e0e:	9703      	str	r7, [sp, #12]

int convert_bits(uint8_t* out, size_t* outlen, int outbits, const uint8_t* in, size_t inlen, int inbits, int pad) {
    uint32_t val = 0;
    int bits = 0;
    uint32_t maxv = (((uint32_t)1) << outbits) - 1;
    while (inlen--) {
c0d02e10:	1e64      	subs	r4, r4, #1
c0d02e12:	9402      	str	r4, [sp, #8]
c0d02e14:	e00f      	b.n	c0d02e36 <convert_bits+0x66>
        val = (val << inbits) | *(in++);
        bits += inbits;
        while (bits >= outbits) {
            bits -= outbits;
            out[(*outlen)++] = (val >> bits) & maxv;
c0d02e16:	680b      	ldr	r3, [r1, #0]
c0d02e18:	462c      	mov	r4, r5
c0d02e1a:	1c5d      	adds	r5, r3, #1
c0d02e1c:	600d      	str	r5, [r1, #0]
c0d02e1e:	9d05      	ldr	r5, [sp, #20]
c0d02e20:	182d      	adds	r5, r5, r0
c0d02e22:	4637      	mov	r7, r6
c0d02e24:	40ee      	lsrs	r6, r5
c0d02e26:	460d      	mov	r5, r1
c0d02e28:	9906      	ldr	r1, [sp, #24]
c0d02e2a:	400e      	ands	r6, r1
c0d02e2c:	4629      	mov	r1, r5
c0d02e2e:	4625      	mov	r5, r4
c0d02e30:	54e6      	strb	r6, [r4, r3]
c0d02e32:	463e      	mov	r6, r7
    uint32_t maxv = (((uint32_t)1) << outbits) - 1;
    while (inlen--) {
        val = (val << inbits) | *(in++);
        bits += inbits;
        while (bits >= outbits) {
            bits -= outbits;
c0d02e34:	1a80      	subs	r0, r0, r2
c0d02e36:	4290      	cmp	r0, r2
c0d02e38:	daed      	bge.n	c0d02e16 <convert_bits+0x46>
c0d02e3a:	9b02      	ldr	r3, [sp, #8]

int convert_bits(uint8_t* out, size_t* outlen, int outbits, const uint8_t* in, size_t inlen, int inbits, int pad) {
    uint32_t val = 0;
    int bits = 0;
    uint32_t maxv = (((uint32_t)1) << outbits) - 1;
    while (inlen--) {
c0d02e3c:	2b00      	cmp	r3, #0
c0d02e3e:	9f03      	ldr	r7, [sp, #12]
c0d02e40:	d1dc      	bne.n	c0d02dfc <convert_bits+0x2c>
        while (bits >= outbits) {
            bits -= outbits;
            out[(*outlen)++] = (val >> bits) & maxv;
        }
    }
    if (pad) {
c0d02e42:	9b01      	ldr	r3, [sp, #4]
c0d02e44:	2b00      	cmp	r3, #0
c0d02e46:	d00a      	beq.n	c0d02e5e <convert_bits+0x8e>
        if (bits) {
c0d02e48:	2800      	cmp	r0, #0
c0d02e4a:	d012      	beq.n	c0d02e72 <convert_bits+0xa2>
            out[(*outlen)++] = (val << (outbits - bits)) & maxv;
c0d02e4c:	680b      	ldr	r3, [r1, #0]
c0d02e4e:	1c5c      	adds	r4, r3, #1
c0d02e50:	600c      	str	r4, [r1, #0]
c0d02e52:	1a11      	subs	r1, r2, r0
c0d02e54:	408e      	lsls	r6, r1
c0d02e56:	9806      	ldr	r0, [sp, #24]
c0d02e58:	4006      	ands	r6, r0
c0d02e5a:	54ee      	strb	r6, [r5, r3]
c0d02e5c:	e009      	b.n	c0d02e72 <convert_bits+0xa2>
        }
    } else if (((val << (outbits - bits)) & maxv) || bits >= inbits) {
c0d02e5e:	1a11      	subs	r1, r2, r0
c0d02e60:	408e      	lsls	r6, r1
c0d02e62:	9906      	ldr	r1, [sp, #24]
c0d02e64:	400e      	ands	r6, r1
c0d02e66:	2100      	movs	r1, #0
c0d02e68:	9a04      	ldr	r2, [sp, #16]
c0d02e6a:	4290      	cmp	r0, r2
c0d02e6c:	da02      	bge.n	c0d02e74 <convert_bits+0xa4>
c0d02e6e:	2e00      	cmp	r6, #0
c0d02e70:	d100      	bne.n	c0d02e74 <convert_bits+0xa4>
c0d02e72:	9900      	ldr	r1, [sp, #0]
        return 0;
    }
    return 1;
}
c0d02e74:	4608      	mov	r0, r1
c0d02e76:	b007      	add	sp, #28
c0d02e78:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02e7a <SVC_Call>:
  // avoid a separate asm file, but avoid any intrusion from the compiler
  unsigned int SVC_Call(unsigned int syscall_id, unsigned int * parameters) __attribute__ ((naked));
  //                    r0                       r1
  unsigned int SVC_Call(unsigned int syscall_id, unsigned int * parameters) {
    // delegate svc
    asm volatile("svc #1":::"r0","r1");
c0d02e7a:	df01      	svc	1
    // directly return R0 value
    asm volatile("bx  lr");
c0d02e7c:	4770      	bx	lr
	...

c0d02e80 <check_api_level>:
  }
  void check_api_level ( unsigned int apiLevel ) 
{
c0d02e80:	b580      	push	{r7, lr}
c0d02e82:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0+1];
  parameters[0] = (unsigned int)apiLevel;
c0d02e84:	9000      	str	r0, [sp, #0]
  retid = SVC_Call(SYSCALL_check_api_level_ID_IN, parameters);
c0d02e86:	4807      	ldr	r0, [pc, #28]	; (c0d02ea4 <check_api_level+0x24>)
c0d02e88:	4669      	mov	r1, sp
c0d02e8a:	f7ff fff6 	bl	c0d02e7a <SVC_Call>
c0d02e8e:	aa01      	add	r2, sp, #4
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d02e90:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_check_api_level_ID_OUT) {
c0d02e92:	4905      	ldr	r1, [pc, #20]	; (c0d02ea8 <check_api_level+0x28>)
c0d02e94:	4288      	cmp	r0, r1
c0d02e96:	d101      	bne.n	c0d02e9c <check_api_level+0x1c>
    THROW(EXCEPTION_SECURITY);
  }
}
c0d02e98:	b002      	add	sp, #8
c0d02e9a:	bd80      	pop	{r7, pc}
  unsigned int parameters [0+1];
  parameters[0] = (unsigned int)apiLevel;
  retid = SVC_Call(SYSCALL_check_api_level_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_check_api_level_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d02e9c:	2004      	movs	r0, #4
c0d02e9e:	f7fe fe0a 	bl	c0d01ab6 <os_longjmp>
c0d02ea2:	46c0      	nop			; (mov r8, r8)
c0d02ea4:	60000137 	.word	0x60000137
c0d02ea8:	900001c6 	.word	0x900001c6

c0d02eac <reset>:
  }
}

void reset ( void ) 
{
c0d02eac:	b580      	push	{r7, lr}
c0d02eae:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0];
  retid = SVC_Call(SYSCALL_reset_ID_IN, parameters);
c0d02eb0:	4806      	ldr	r0, [pc, #24]	; (c0d02ecc <reset+0x20>)
c0d02eb2:	a901      	add	r1, sp, #4
c0d02eb4:	f7ff ffe1 	bl	c0d02e7a <SVC_Call>
c0d02eb8:	466a      	mov	r2, sp
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d02eba:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_reset_ID_OUT) {
c0d02ebc:	4904      	ldr	r1, [pc, #16]	; (c0d02ed0 <reset+0x24>)
c0d02ebe:	4288      	cmp	r0, r1
c0d02ec0:	d101      	bne.n	c0d02ec6 <reset+0x1a>
    THROW(EXCEPTION_SECURITY);
  }
}
c0d02ec2:	b002      	add	sp, #8
c0d02ec4:	bd80      	pop	{r7, pc}
  unsigned int retid;
  unsigned int parameters [0];
  retid = SVC_Call(SYSCALL_reset_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_reset_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d02ec6:	2004      	movs	r0, #4
c0d02ec8:	f7fe fdf5 	bl	c0d01ab6 <os_longjmp>
c0d02ecc:	60000200 	.word	0x60000200
c0d02ed0:	900002f1 	.word	0x900002f1

c0d02ed4 <nvm_write>:
  }
}

void nvm_write ( void * dst_adr, void * src_adr, unsigned int src_len ) 
{
c0d02ed4:	b580      	push	{r7, lr}
c0d02ed6:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0+3];
  parameters[0] = (unsigned int)dst_adr;
c0d02ed8:	ab00      	add	r3, sp, #0
c0d02eda:	c307      	stmia	r3!, {r0, r1, r2}
  parameters[1] = (unsigned int)src_adr;
  parameters[2] = (unsigned int)src_len;
  retid = SVC_Call(SYSCALL_nvm_write_ID_IN, parameters);
c0d02edc:	4806      	ldr	r0, [pc, #24]	; (c0d02ef8 <nvm_write+0x24>)
c0d02ede:	4669      	mov	r1, sp
c0d02ee0:	f7ff ffcb 	bl	c0d02e7a <SVC_Call>
c0d02ee4:	aa03      	add	r2, sp, #12
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d02ee6:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_nvm_write_ID_OUT) {
c0d02ee8:	4904      	ldr	r1, [pc, #16]	; (c0d02efc <nvm_write+0x28>)
c0d02eea:	4288      	cmp	r0, r1
c0d02eec:	d101      	bne.n	c0d02ef2 <nvm_write+0x1e>
    THROW(EXCEPTION_SECURITY);
  }
}
c0d02eee:	b004      	add	sp, #16
c0d02ef0:	bd80      	pop	{r7, pc}
  parameters[1] = (unsigned int)src_adr;
  parameters[2] = (unsigned int)src_len;
  retid = SVC_Call(SYSCALL_nvm_write_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_nvm_write_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d02ef2:	2004      	movs	r0, #4
c0d02ef4:	f7fe fddf 	bl	c0d01ab6 <os_longjmp>
c0d02ef8:	6000037f 	.word	0x6000037f
c0d02efc:	900003bc 	.word	0x900003bc

c0d02f00 <cx_rng>:
  }
  return (unsigned char)ret;
}

unsigned char * cx_rng ( unsigned char * buffer, unsigned int len ) 
{
c0d02f00:	b580      	push	{r7, lr}
c0d02f02:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0+2];
  parameters[0] = (unsigned int)buffer;
c0d02f04:	9001      	str	r0, [sp, #4]
  parameters[1] = (unsigned int)len;
c0d02f06:	9102      	str	r1, [sp, #8]
  retid = SVC_Call(SYSCALL_cx_rng_ID_IN, parameters);
c0d02f08:	4807      	ldr	r0, [pc, #28]	; (c0d02f28 <cx_rng+0x28>)
c0d02f0a:	a901      	add	r1, sp, #4
c0d02f0c:	f7ff ffb5 	bl	c0d02e7a <SVC_Call>
c0d02f10:	aa03      	add	r2, sp, #12
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d02f12:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_cx_rng_ID_OUT) {
c0d02f14:	4905      	ldr	r1, [pc, #20]	; (c0d02f2c <cx_rng+0x2c>)
c0d02f16:	4288      	cmp	r0, r1
c0d02f18:	d102      	bne.n	c0d02f20 <cx_rng+0x20>
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned char *)ret;
c0d02f1a:	9803      	ldr	r0, [sp, #12]
c0d02f1c:	b004      	add	sp, #16
c0d02f1e:	bd80      	pop	{r7, pc}
  parameters[0] = (unsigned int)buffer;
  parameters[1] = (unsigned int)len;
  retid = SVC_Call(SYSCALL_cx_rng_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_cx_rng_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d02f20:	2004      	movs	r0, #4
c0d02f22:	f7fe fdc8 	bl	c0d01ab6 <os_longjmp>
c0d02f26:	46c0      	nop			; (mov r8, r8)
c0d02f28:	6000052c 	.word	0x6000052c
c0d02f2c:	90000567 	.word	0x90000567

c0d02f30 <cx_hash>:
  }
  return (int)ret;
}

int cx_hash ( cx_hash_t * hash, int mode, const unsigned char * in, unsigned int len, unsigned char * out, unsigned int out_len ) 
{
c0d02f30:	b580      	push	{r7, lr}
c0d02f32:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0+6];
  parameters[0] = (unsigned int)hash;
c0d02f34:	af01      	add	r7, sp, #4
c0d02f36:	c70f      	stmia	r7!, {r0, r1, r2, r3}
c0d02f38:	980a      	ldr	r0, [sp, #40]	; 0x28
  parameters[1] = (unsigned int)mode;
  parameters[2] = (unsigned int)in;
  parameters[3] = (unsigned int)len;
  parameters[4] = (unsigned int)out;
c0d02f3a:	9005      	str	r0, [sp, #20]
c0d02f3c:	980b      	ldr	r0, [sp, #44]	; 0x2c
  parameters[5] = (unsigned int)out_len;
c0d02f3e:	9006      	str	r0, [sp, #24]
  retid = SVC_Call(SYSCALL_cx_hash_ID_IN, parameters);
c0d02f40:	4807      	ldr	r0, [pc, #28]	; (c0d02f60 <cx_hash+0x30>)
c0d02f42:	a901      	add	r1, sp, #4
c0d02f44:	f7ff ff99 	bl	c0d02e7a <SVC_Call>
c0d02f48:	aa07      	add	r2, sp, #28
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d02f4a:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_cx_hash_ID_OUT) {
c0d02f4c:	4905      	ldr	r1, [pc, #20]	; (c0d02f64 <cx_hash+0x34>)
c0d02f4e:	4288      	cmp	r0, r1
c0d02f50:	d102      	bne.n	c0d02f58 <cx_hash+0x28>
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d02f52:	9807      	ldr	r0, [sp, #28]
c0d02f54:	b008      	add	sp, #32
c0d02f56:	bd80      	pop	{r7, pc}
  parameters[4] = (unsigned int)out;
  parameters[5] = (unsigned int)out_len;
  retid = SVC_Call(SYSCALL_cx_hash_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_cx_hash_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d02f58:	2004      	movs	r0, #4
c0d02f5a:	f7fe fdac 	bl	c0d01ab6 <os_longjmp>
c0d02f5e:	46c0      	nop			; (mov r8, r8)
c0d02f60:	6000073b 	.word	0x6000073b
c0d02f64:	900007ad 	.word	0x900007ad

c0d02f68 <cx_ripemd160_init>:
  }
  return (int)ret;
}

int cx_ripemd160_init ( cx_ripemd160_t * hash ) 
{
c0d02f68:	b580      	push	{r7, lr}
c0d02f6a:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0+1];
  parameters[0] = (unsigned int)hash;
c0d02f6c:	9000      	str	r0, [sp, #0]
  retid = SVC_Call(SYSCALL_cx_ripemd160_init_ID_IN, parameters);
c0d02f6e:	4807      	ldr	r0, [pc, #28]	; (c0d02f8c <cx_ripemd160_init+0x24>)
c0d02f70:	4669      	mov	r1, sp
c0d02f72:	f7ff ff82 	bl	c0d02e7a <SVC_Call>
c0d02f76:	aa01      	add	r2, sp, #4
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d02f78:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_cx_ripemd160_init_ID_OUT) {
c0d02f7a:	4905      	ldr	r1, [pc, #20]	; (c0d02f90 <cx_ripemd160_init+0x28>)
c0d02f7c:	4288      	cmp	r0, r1
c0d02f7e:	d102      	bne.n	c0d02f86 <cx_ripemd160_init+0x1e>
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d02f80:	9801      	ldr	r0, [sp, #4]
c0d02f82:	b002      	add	sp, #8
c0d02f84:	bd80      	pop	{r7, pc}
  unsigned int parameters [0+1];
  parameters[0] = (unsigned int)hash;
  retid = SVC_Call(SYSCALL_cx_ripemd160_init_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_cx_ripemd160_init_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d02f86:	2004      	movs	r0, #4
c0d02f88:	f7fe fd95 	bl	c0d01ab6 <os_longjmp>
c0d02f8c:	6000087f 	.word	0x6000087f
c0d02f90:	900008f8 	.word	0x900008f8

c0d02f94 <cx_hash_sha256>:
  }
  return (int)ret;
}

int cx_hash_sha256 ( const unsigned char * in, unsigned int len, unsigned char * out, unsigned int out_len ) 
{
c0d02f94:	b580      	push	{r7, lr}
c0d02f96:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0+4];
  parameters[0] = (unsigned int)in;
c0d02f98:	af01      	add	r7, sp, #4
c0d02f9a:	c70f      	stmia	r7!, {r0, r1, r2, r3}
  parameters[1] = (unsigned int)len;
  parameters[2] = (unsigned int)out;
  parameters[3] = (unsigned int)out_len;
  retid = SVC_Call(SYSCALL_cx_hash_sha256_ID_IN, parameters);
c0d02f9c:	4807      	ldr	r0, [pc, #28]	; (c0d02fbc <cx_hash_sha256+0x28>)
c0d02f9e:	a901      	add	r1, sp, #4
c0d02fa0:	f7ff ff6b 	bl	c0d02e7a <SVC_Call>
c0d02fa4:	aa05      	add	r2, sp, #20
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d02fa6:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_cx_hash_sha256_ID_OUT) {
c0d02fa8:	4905      	ldr	r1, [pc, #20]	; (c0d02fc0 <cx_hash_sha256+0x2c>)
c0d02faa:	4288      	cmp	r0, r1
c0d02fac:	d102      	bne.n	c0d02fb4 <cx_hash_sha256+0x20>
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d02fae:	9805      	ldr	r0, [sp, #20]
c0d02fb0:	b006      	add	sp, #24
c0d02fb2:	bd80      	pop	{r7, pc}
  parameters[2] = (unsigned int)out;
  parameters[3] = (unsigned int)out_len;
  retid = SVC_Call(SYSCALL_cx_hash_sha256_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_cx_hash_sha256_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d02fb4:	2004      	movs	r0, #4
c0d02fb6:	f7fe fd7e 	bl	c0d01ab6 <os_longjmp>
c0d02fba:	46c0      	nop			; (mov r8, r8)
c0d02fbc:	60000b2c 	.word	0x60000b2c
c0d02fc0:	90000ba0 	.word	0x90000ba0

c0d02fc4 <cx_ecfp_init_public_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_public_key ( cx_curve_t curve, const unsigned char * rawkey, unsigned int key_len, cx_ecfp_public_key_t * key ) 
{
c0d02fc4:	b580      	push	{r7, lr}
c0d02fc6:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0+4];
  parameters[0] = (unsigned int)curve;
c0d02fc8:	af01      	add	r7, sp, #4
c0d02fca:	c70f      	stmia	r7!, {r0, r1, r2, r3}
  parameters[1] = (unsigned int)rawkey;
  parameters[2] = (unsigned int)key_len;
  parameters[3] = (unsigned int)key;
  retid = SVC_Call(SYSCALL_cx_ecfp_init_public_key_ID_IN, parameters);
c0d02fcc:	4807      	ldr	r0, [pc, #28]	; (c0d02fec <cx_ecfp_init_public_key+0x28>)
c0d02fce:	a901      	add	r1, sp, #4
c0d02fd0:	f7ff ff53 	bl	c0d02e7a <SVC_Call>
c0d02fd4:	aa05      	add	r2, sp, #20
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d02fd6:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_cx_ecfp_init_public_key_ID_OUT) {
c0d02fd8:	4905      	ldr	r1, [pc, #20]	; (c0d02ff0 <cx_ecfp_init_public_key+0x2c>)
c0d02fda:	4288      	cmp	r0, r1
c0d02fdc:	d102      	bne.n	c0d02fe4 <cx_ecfp_init_public_key+0x20>
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d02fde:	9805      	ldr	r0, [sp, #20]
c0d02fe0:	b006      	add	sp, #24
c0d02fe2:	bd80      	pop	{r7, pc}
  parameters[2] = (unsigned int)key_len;
  parameters[3] = (unsigned int)key;
  retid = SVC_Call(SYSCALL_cx_ecfp_init_public_key_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_cx_ecfp_init_public_key_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d02fe4:	2004      	movs	r0, #4
c0d02fe6:	f7fe fd66 	bl	c0d01ab6 <os_longjmp>
c0d02fea:	46c0      	nop			; (mov r8, r8)
c0d02fec:	60002ded 	.word	0x60002ded
c0d02ff0:	90002d49 	.word	0x90002d49

c0d02ff4 <cx_ecfp_init_private_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_private_key ( cx_curve_t curve, const unsigned char * rawkey, unsigned int key_len, cx_ecfp_private_key_t * pvkey ) 
{
c0d02ff4:	b580      	push	{r7, lr}
c0d02ff6:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0+4];
  parameters[0] = (unsigned int)curve;
c0d02ff8:	af01      	add	r7, sp, #4
c0d02ffa:	c70f      	stmia	r7!, {r0, r1, r2, r3}
  parameters[1] = (unsigned int)rawkey;
  parameters[2] = (unsigned int)key_len;
  parameters[3] = (unsigned int)pvkey;
  retid = SVC_Call(SYSCALL_cx_ecfp_init_private_key_ID_IN, parameters);
c0d02ffc:	4807      	ldr	r0, [pc, #28]	; (c0d0301c <cx_ecfp_init_private_key+0x28>)
c0d02ffe:	a901      	add	r1, sp, #4
c0d03000:	f7ff ff3b 	bl	c0d02e7a <SVC_Call>
c0d03004:	aa05      	add	r2, sp, #20
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d03006:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_cx_ecfp_init_private_key_ID_OUT) {
c0d03008:	4905      	ldr	r1, [pc, #20]	; (c0d03020 <cx_ecfp_init_private_key+0x2c>)
c0d0300a:	4288      	cmp	r0, r1
c0d0300c:	d102      	bne.n	c0d03014 <cx_ecfp_init_private_key+0x20>
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d0300e:	9805      	ldr	r0, [sp, #20]
c0d03010:	b006      	add	sp, #24
c0d03012:	bd80      	pop	{r7, pc}
  parameters[2] = (unsigned int)key_len;
  parameters[3] = (unsigned int)pvkey;
  retid = SVC_Call(SYSCALL_cx_ecfp_init_private_key_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_cx_ecfp_init_private_key_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d03014:	2004      	movs	r0, #4
c0d03016:	f7fe fd4e 	bl	c0d01ab6 <os_longjmp>
c0d0301a:	46c0      	nop			; (mov r8, r8)
c0d0301c:	60002eea 	.word	0x60002eea
c0d03020:	90002e63 	.word	0x90002e63

c0d03024 <cx_ecfp_generate_pair>:
  }
  return (int)ret;
}

int cx_ecfp_generate_pair ( cx_curve_t curve, cx_ecfp_public_key_t * pubkey, cx_ecfp_private_key_t * privkey, int keepprivate ) 
{
c0d03024:	b580      	push	{r7, lr}
c0d03026:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0+4];
  parameters[0] = (unsigned int)curve;
c0d03028:	af01      	add	r7, sp, #4
c0d0302a:	c70f      	stmia	r7!, {r0, r1, r2, r3}
  parameters[1] = (unsigned int)pubkey;
  parameters[2] = (unsigned int)privkey;
  parameters[3] = (unsigned int)keepprivate;
  retid = SVC_Call(SYSCALL_cx_ecfp_generate_pair_ID_IN, parameters);
c0d0302c:	4807      	ldr	r0, [pc, #28]	; (c0d0304c <cx_ecfp_generate_pair+0x28>)
c0d0302e:	a901      	add	r1, sp, #4
c0d03030:	f7ff ff23 	bl	c0d02e7a <SVC_Call>
c0d03034:	aa05      	add	r2, sp, #20
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d03036:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_cx_ecfp_generate_pair_ID_OUT) {
c0d03038:	4905      	ldr	r1, [pc, #20]	; (c0d03050 <cx_ecfp_generate_pair+0x2c>)
c0d0303a:	4288      	cmp	r0, r1
c0d0303c:	d102      	bne.n	c0d03044 <cx_ecfp_generate_pair+0x20>
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d0303e:	9805      	ldr	r0, [sp, #20]
c0d03040:	b006      	add	sp, #24
c0d03042:	bd80      	pop	{r7, pc}
  parameters[2] = (unsigned int)privkey;
  parameters[3] = (unsigned int)keepprivate;
  retid = SVC_Call(SYSCALL_cx_ecfp_generate_pair_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_cx_ecfp_generate_pair_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d03044:	2004      	movs	r0, #4
c0d03046:	f7fe fd36 	bl	c0d01ab6 <os_longjmp>
c0d0304a:	46c0      	nop			; (mov r8, r8)
c0d0304c:	60002f2e 	.word	0x60002f2e
c0d03050:	90002f74 	.word	0x90002f74

c0d03054 <cx_ecdsa_sign>:
  }
  return (int)ret;
}

int cx_ecdsa_sign ( const cx_ecfp_private_key_t * pvkey, int mode, cx_md_t hashID, const unsigned char * hash, unsigned int hash_len, unsigned char * sig, unsigned int sig_len, unsigned int * info ) 
{
c0d03054:	b580      	push	{r7, lr}
c0d03056:	b08a      	sub	sp, #40	; 0x28
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0+8];
  parameters[0] = (unsigned int)pvkey;
c0d03058:	af01      	add	r7, sp, #4
c0d0305a:	c70f      	stmia	r7!, {r0, r1, r2, r3}
c0d0305c:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[1] = (unsigned int)mode;
  parameters[2] = (unsigned int)hashID;
  parameters[3] = (unsigned int)hash;
  parameters[4] = (unsigned int)hash_len;
c0d0305e:	9005      	str	r0, [sp, #20]
c0d03060:	980d      	ldr	r0, [sp, #52]	; 0x34
  parameters[5] = (unsigned int)sig;
c0d03062:	9006      	str	r0, [sp, #24]
c0d03064:	980e      	ldr	r0, [sp, #56]	; 0x38
  parameters[6] = (unsigned int)sig_len;
c0d03066:	9007      	str	r0, [sp, #28]
c0d03068:	980f      	ldr	r0, [sp, #60]	; 0x3c
  parameters[7] = (unsigned int)info;
c0d0306a:	9008      	str	r0, [sp, #32]
  retid = SVC_Call(SYSCALL_cx_ecdsa_sign_ID_IN, parameters);
c0d0306c:	4807      	ldr	r0, [pc, #28]	; (c0d0308c <cx_ecdsa_sign+0x38>)
c0d0306e:	a901      	add	r1, sp, #4
c0d03070:	f7ff ff03 	bl	c0d02e7a <SVC_Call>
c0d03074:	aa09      	add	r2, sp, #36	; 0x24
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d03076:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_cx_ecdsa_sign_ID_OUT) {
c0d03078:	4905      	ldr	r1, [pc, #20]	; (c0d03090 <cx_ecdsa_sign+0x3c>)
c0d0307a:	4288      	cmp	r0, r1
c0d0307c:	d102      	bne.n	c0d03084 <cx_ecdsa_sign+0x30>
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d0307e:	9809      	ldr	r0, [sp, #36]	; 0x24
c0d03080:	b00a      	add	sp, #40	; 0x28
c0d03082:	bd80      	pop	{r7, pc}
  parameters[6] = (unsigned int)sig_len;
  parameters[7] = (unsigned int)info;
  retid = SVC_Call(SYSCALL_cx_ecdsa_sign_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_cx_ecdsa_sign_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d03084:	2004      	movs	r0, #4
c0d03086:	f7fe fd16 	bl	c0d01ab6 <os_longjmp>
c0d0308a:	46c0      	nop			; (mov r8, r8)
c0d0308c:	600038f3 	.word	0x600038f3
c0d03090:	90003876 	.word	0x90003876

c0d03094 <cx_crc16_update>:
  }
  return (unsigned short)ret;
}

unsigned short cx_crc16_update ( unsigned short crc, const void * buffer, unsigned int len ) 
{
c0d03094:	b580      	push	{r7, lr}
c0d03096:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0+3];
  parameters[0] = (unsigned int)crc;
c0d03098:	ab00      	add	r3, sp, #0
c0d0309a:	c307      	stmia	r3!, {r0, r1, r2}
  parameters[1] = (unsigned int)buffer;
  parameters[2] = (unsigned int)len;
  retid = SVC_Call(SYSCALL_cx_crc16_update_ID_IN, parameters);
c0d0309c:	4807      	ldr	r0, [pc, #28]	; (c0d030bc <cx_crc16_update+0x28>)
c0d0309e:	4669      	mov	r1, sp
c0d030a0:	f7ff feeb 	bl	c0d02e7a <SVC_Call>
c0d030a4:	aa03      	add	r2, sp, #12
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d030a6:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_cx_crc16_update_ID_OUT) {
c0d030a8:	4905      	ldr	r1, [pc, #20]	; (c0d030c0 <cx_crc16_update+0x2c>)
c0d030aa:	4288      	cmp	r0, r1
c0d030ac:	d103      	bne.n	c0d030b6 <cx_crc16_update+0x22>
c0d030ae:	a803      	add	r0, sp, #12
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned short)ret;
c0d030b0:	8800      	ldrh	r0, [r0, #0]
c0d030b2:	b004      	add	sp, #16
c0d030b4:	bd80      	pop	{r7, pc}
  parameters[1] = (unsigned int)buffer;
  parameters[2] = (unsigned int)len;
  retid = SVC_Call(SYSCALL_cx_crc16_update_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_cx_crc16_update_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d030b6:	2004      	movs	r0, #4
c0d030b8:	f7fe fcfd 	bl	c0d01ab6 <os_longjmp>
c0d030bc:	60003c9e 	.word	0x60003c9e
c0d030c0:	90003cb9 	.word	0x90003cb9

c0d030c4 <os_perso_derive_node_bip32>:
  }
  return (unsigned int)ret;
}

void os_perso_derive_node_bip32 ( cx_curve_t curve, const unsigned int * path, unsigned int pathLength, unsigned char * privateKey, unsigned char * chain ) 
{
c0d030c4:	b580      	push	{r7, lr}
c0d030c6:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0+5];
  parameters[0] = (unsigned int)curve;
c0d030c8:	af00      	add	r7, sp, #0
c0d030ca:	c70f      	stmia	r7!, {r0, r1, r2, r3}
c0d030cc:	9808      	ldr	r0, [sp, #32]
  parameters[1] = (unsigned int)path;
  parameters[2] = (unsigned int)pathLength;
  parameters[3] = (unsigned int)privateKey;
  parameters[4] = (unsigned int)chain;
c0d030ce:	9004      	str	r0, [sp, #16]
  retid = SVC_Call(SYSCALL_os_perso_derive_node_bip32_ID_IN, parameters);
c0d030d0:	4806      	ldr	r0, [pc, #24]	; (c0d030ec <os_perso_derive_node_bip32+0x28>)
c0d030d2:	4669      	mov	r1, sp
c0d030d4:	f7ff fed1 	bl	c0d02e7a <SVC_Call>
c0d030d8:	aa05      	add	r2, sp, #20
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d030da:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_os_perso_derive_node_bip32_ID_OUT) {
c0d030dc:	4904      	ldr	r1, [pc, #16]	; (c0d030f0 <os_perso_derive_node_bip32+0x2c>)
c0d030de:	4288      	cmp	r0, r1
c0d030e0:	d101      	bne.n	c0d030e6 <os_perso_derive_node_bip32+0x22>
    THROW(EXCEPTION_SECURITY);
  }
}
c0d030e2:	b006      	add	sp, #24
c0d030e4:	bd80      	pop	{r7, pc}
  parameters[3] = (unsigned int)privateKey;
  parameters[4] = (unsigned int)chain;
  retid = SVC_Call(SYSCALL_os_perso_derive_node_bip32_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_os_perso_derive_node_bip32_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d030e6:	2004      	movs	r0, #4
c0d030e8:	f7fe fce5 	bl	c0d01ab6 <os_longjmp>
c0d030ec:	600053ba 	.word	0x600053ba
c0d030f0:	9000531e 	.word	0x9000531e

c0d030f4 <os_sched_exit>:
  }
  return (unsigned int)ret;
}

void os_sched_exit ( unsigned int exit_code ) 
{
c0d030f4:	b580      	push	{r7, lr}
c0d030f6:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0+1];
  parameters[0] = (unsigned int)exit_code;
c0d030f8:	9000      	str	r0, [sp, #0]
  retid = SVC_Call(SYSCALL_os_sched_exit_ID_IN, parameters);
c0d030fa:	4807      	ldr	r0, [pc, #28]	; (c0d03118 <os_sched_exit+0x24>)
c0d030fc:	4669      	mov	r1, sp
c0d030fe:	f7ff febc 	bl	c0d02e7a <SVC_Call>
c0d03102:	aa01      	add	r2, sp, #4
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d03104:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_os_sched_exit_ID_OUT) {
c0d03106:	4905      	ldr	r1, [pc, #20]	; (c0d0311c <os_sched_exit+0x28>)
c0d03108:	4288      	cmp	r0, r1
c0d0310a:	d101      	bne.n	c0d03110 <os_sched_exit+0x1c>
    THROW(EXCEPTION_SECURITY);
  }
}
c0d0310c:	b002      	add	sp, #8
c0d0310e:	bd80      	pop	{r7, pc}
  unsigned int parameters [0+1];
  parameters[0] = (unsigned int)exit_code;
  retid = SVC_Call(SYSCALL_os_sched_exit_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_os_sched_exit_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d03110:	2004      	movs	r0, #4
c0d03112:	f7fe fcd0 	bl	c0d01ab6 <os_longjmp>
c0d03116:	46c0      	nop			; (mov r8, r8)
c0d03118:	600062e1 	.word	0x600062e1
c0d0311c:	9000626f 	.word	0x9000626f

c0d03120 <os_ux>:
    THROW(EXCEPTION_SECURITY);
  }
}

unsigned int os_ux ( bolos_ux_params_t * params ) 
{
c0d03120:	b580      	push	{r7, lr}
c0d03122:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0+1];
  parameters[0] = (unsigned int)params;
c0d03124:	9000      	str	r0, [sp, #0]
  retid = SVC_Call(SYSCALL_os_ux_ID_IN, parameters);
c0d03126:	4807      	ldr	r0, [pc, #28]	; (c0d03144 <os_ux+0x24>)
c0d03128:	4669      	mov	r1, sp
c0d0312a:	f7ff fea6 	bl	c0d02e7a <SVC_Call>
c0d0312e:	aa01      	add	r2, sp, #4
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d03130:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_os_ux_ID_OUT) {
c0d03132:	4905      	ldr	r1, [pc, #20]	; (c0d03148 <os_ux+0x28>)
c0d03134:	4288      	cmp	r0, r1
c0d03136:	d102      	bne.n	c0d0313e <os_ux+0x1e>
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d03138:	9801      	ldr	r0, [sp, #4]
c0d0313a:	b002      	add	sp, #8
c0d0313c:	bd80      	pop	{r7, pc}
  unsigned int parameters [0+1];
  parameters[0] = (unsigned int)params;
  retid = SVC_Call(SYSCALL_os_ux_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_os_ux_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d0313e:	2004      	movs	r0, #4
c0d03140:	f7fe fcb9 	bl	c0d01ab6 <os_longjmp>
c0d03144:	60006458 	.word	0x60006458
c0d03148:	9000641f 	.word	0x9000641f

c0d0314c <os_flags>:
    THROW(EXCEPTION_SECURITY);
  }
}

unsigned int os_flags ( void ) 
{
c0d0314c:	b580      	push	{r7, lr}
c0d0314e:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0];
  retid = SVC_Call(SYSCALL_os_flags_ID_IN, parameters);
c0d03150:	4807      	ldr	r0, [pc, #28]	; (c0d03170 <os_flags+0x24>)
c0d03152:	a901      	add	r1, sp, #4
c0d03154:	f7ff fe91 	bl	c0d02e7a <SVC_Call>
c0d03158:	466a      	mov	r2, sp
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d0315a:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_os_flags_ID_OUT) {
c0d0315c:	4905      	ldr	r1, [pc, #20]	; (c0d03174 <os_flags+0x28>)
c0d0315e:	4288      	cmp	r0, r1
c0d03160:	d102      	bne.n	c0d03168 <os_flags+0x1c>
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d03162:	9800      	ldr	r0, [sp, #0]
c0d03164:	b002      	add	sp, #8
c0d03166:	bd80      	pop	{r7, pc}
  unsigned int retid;
  unsigned int parameters [0];
  retid = SVC_Call(SYSCALL_os_flags_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_os_flags_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d03168:	2004      	movs	r0, #4
c0d0316a:	f7fe fca4 	bl	c0d01ab6 <os_longjmp>
c0d0316e:	46c0      	nop			; (mov r8, r8)
c0d03170:	6000686e 	.word	0x6000686e
c0d03174:	9000687f 	.word	0x9000687f

c0d03178 <os_version>:
  }
  return (unsigned int)ret;
}

unsigned int os_version ( unsigned char * version, unsigned int maxlength ) 
{
c0d03178:	b580      	push	{r7, lr}
c0d0317a:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0+2];
  parameters[0] = (unsigned int)version;
c0d0317c:	9001      	str	r0, [sp, #4]
  parameters[1] = (unsigned int)maxlength;
c0d0317e:	9102      	str	r1, [sp, #8]
  retid = SVC_Call(SYSCALL_os_version_ID_IN, parameters);
c0d03180:	4807      	ldr	r0, [pc, #28]	; (c0d031a0 <os_version+0x28>)
c0d03182:	a901      	add	r1, sp, #4
c0d03184:	f7ff fe79 	bl	c0d02e7a <SVC_Call>
c0d03188:	aa03      	add	r2, sp, #12
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d0318a:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_os_version_ID_OUT) {
c0d0318c:	4905      	ldr	r1, [pc, #20]	; (c0d031a4 <os_version+0x2c>)
c0d0318e:	4288      	cmp	r0, r1
c0d03190:	d102      	bne.n	c0d03198 <os_version+0x20>
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d03192:	9803      	ldr	r0, [sp, #12]
c0d03194:	b004      	add	sp, #16
c0d03196:	bd80      	pop	{r7, pc}
  parameters[0] = (unsigned int)version;
  parameters[1] = (unsigned int)maxlength;
  retid = SVC_Call(SYSCALL_os_version_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_os_version_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d03198:	2004      	movs	r0, #4
c0d0319a:	f7fe fc8c 	bl	c0d01ab6 <os_longjmp>
c0d0319e:	46c0      	nop			; (mov r8, r8)
c0d031a0:	600069b8 	.word	0x600069b8
c0d031a4:	900069c4 	.word	0x900069c4

c0d031a8 <os_seph_version>:
  }
  return (unsigned int)ret;
}

unsigned int os_seph_version ( unsigned char * version, unsigned int maxlength ) 
{
c0d031a8:	b580      	push	{r7, lr}
c0d031aa:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0+2];
  parameters[0] = (unsigned int)version;
c0d031ac:	9001      	str	r0, [sp, #4]
  parameters[1] = (unsigned int)maxlength;
c0d031ae:	9102      	str	r1, [sp, #8]
  retid = SVC_Call(SYSCALL_os_seph_version_ID_IN, parameters);
c0d031b0:	4807      	ldr	r0, [pc, #28]	; (c0d031d0 <os_seph_version+0x28>)
c0d031b2:	a901      	add	r1, sp, #4
c0d031b4:	f7ff fe61 	bl	c0d02e7a <SVC_Call>
c0d031b8:	aa03      	add	r2, sp, #12
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d031ba:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_os_seph_version_ID_OUT) {
c0d031bc:	4905      	ldr	r1, [pc, #20]	; (c0d031d4 <os_seph_version+0x2c>)
c0d031be:	4288      	cmp	r0, r1
c0d031c0:	d102      	bne.n	c0d031c8 <os_seph_version+0x20>
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d031c2:	9803      	ldr	r0, [sp, #12]
c0d031c4:	b004      	add	sp, #16
c0d031c6:	bd80      	pop	{r7, pc}
  parameters[0] = (unsigned int)version;
  parameters[1] = (unsigned int)maxlength;
  retid = SVC_Call(SYSCALL_os_seph_version_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_os_seph_version_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d031c8:	2004      	movs	r0, #4
c0d031ca:	f7fe fc74 	bl	c0d01ab6 <os_longjmp>
c0d031ce:	46c0      	nop			; (mov r8, r8)
c0d031d0:	60006bac 	.word	0x60006bac
c0d031d4:	90006b5d 	.word	0x90006b5d

c0d031d8 <os_registry_get_current_app_tag>:
  }
  return (unsigned int)ret;
}

unsigned int os_registry_get_current_app_tag ( unsigned int tag, unsigned char * buffer, unsigned int maxlen ) 
{
c0d031d8:	b580      	push	{r7, lr}
c0d031da:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0+3];
  parameters[0] = (unsigned int)tag;
c0d031dc:	ab00      	add	r3, sp, #0
c0d031de:	c307      	stmia	r3!, {r0, r1, r2}
  parameters[1] = (unsigned int)buffer;
  parameters[2] = (unsigned int)maxlen;
  retid = SVC_Call(SYSCALL_os_registry_get_current_app_tag_ID_IN, parameters);
c0d031e0:	4807      	ldr	r0, [pc, #28]	; (c0d03200 <os_registry_get_current_app_tag+0x28>)
c0d031e2:	4669      	mov	r1, sp
c0d031e4:	f7ff fe49 	bl	c0d02e7a <SVC_Call>
c0d031e8:	aa03      	add	r2, sp, #12
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d031ea:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_os_registry_get_current_app_tag_ID_OUT) {
c0d031ec:	4905      	ldr	r1, [pc, #20]	; (c0d03204 <os_registry_get_current_app_tag+0x2c>)
c0d031ee:	4288      	cmp	r0, r1
c0d031f0:	d102      	bne.n	c0d031f8 <os_registry_get_current_app_tag+0x20>
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d031f2:	9803      	ldr	r0, [sp, #12]
c0d031f4:	b004      	add	sp, #16
c0d031f6:	bd80      	pop	{r7, pc}
  parameters[1] = (unsigned int)buffer;
  parameters[2] = (unsigned int)maxlen;
  retid = SVC_Call(SYSCALL_os_registry_get_current_app_tag_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_os_registry_get_current_app_tag_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d031f8:	2004      	movs	r0, #4
c0d031fa:	f7fe fc5c 	bl	c0d01ab6 <os_longjmp>
c0d031fe:	46c0      	nop			; (mov r8, r8)
c0d03200:	600070d4 	.word	0x600070d4
c0d03204:	90007087 	.word	0x90007087

c0d03208 <io_seproxyhal_spi_send>:
  }
  return (unsigned int)ret;
}

void io_seproxyhal_spi_send ( const unsigned char * buffer, unsigned short length ) 
{
c0d03208:	b580      	push	{r7, lr}
c0d0320a:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0+2];
  parameters[0] = (unsigned int)buffer;
c0d0320c:	9001      	str	r0, [sp, #4]
  parameters[1] = (unsigned int)length;
c0d0320e:	9102      	str	r1, [sp, #8]
  retid = SVC_Call(SYSCALL_io_seproxyhal_spi_send_ID_IN, parameters);
c0d03210:	4806      	ldr	r0, [pc, #24]	; (c0d0322c <io_seproxyhal_spi_send+0x24>)
c0d03212:	a901      	add	r1, sp, #4
c0d03214:	f7ff fe31 	bl	c0d02e7a <SVC_Call>
c0d03218:	aa03      	add	r2, sp, #12
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d0321a:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_io_seproxyhal_spi_send_ID_OUT) {
c0d0321c:	4904      	ldr	r1, [pc, #16]	; (c0d03230 <io_seproxyhal_spi_send+0x28>)
c0d0321e:	4288      	cmp	r0, r1
c0d03220:	d101      	bne.n	c0d03226 <io_seproxyhal_spi_send+0x1e>
    THROW(EXCEPTION_SECURITY);
  }
}
c0d03222:	b004      	add	sp, #16
c0d03224:	bd80      	pop	{r7, pc}
  parameters[0] = (unsigned int)buffer;
  parameters[1] = (unsigned int)length;
  retid = SVC_Call(SYSCALL_io_seproxyhal_spi_send_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_io_seproxyhal_spi_send_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d03226:	2004      	movs	r0, #4
c0d03228:	f7fe fc45 	bl	c0d01ab6 <os_longjmp>
c0d0322c:	6000721c 	.word	0x6000721c
c0d03230:	900072f3 	.word	0x900072f3

c0d03234 <io_seproxyhal_spi_is_status_sent>:
  }
}

unsigned int io_seproxyhal_spi_is_status_sent ( void ) 
{
c0d03234:	b580      	push	{r7, lr}
c0d03236:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0];
  retid = SVC_Call(SYSCALL_io_seproxyhal_spi_is_status_sent_ID_IN, parameters);
c0d03238:	4807      	ldr	r0, [pc, #28]	; (c0d03258 <io_seproxyhal_spi_is_status_sent+0x24>)
c0d0323a:	a901      	add	r1, sp, #4
c0d0323c:	f7ff fe1d 	bl	c0d02e7a <SVC_Call>
c0d03240:	466a      	mov	r2, sp
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d03242:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT) {
c0d03244:	4905      	ldr	r1, [pc, #20]	; (c0d0325c <io_seproxyhal_spi_is_status_sent+0x28>)
c0d03246:	4288      	cmp	r0, r1
c0d03248:	d102      	bne.n	c0d03250 <io_seproxyhal_spi_is_status_sent+0x1c>
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d0324a:	9800      	ldr	r0, [sp, #0]
c0d0324c:	b002      	add	sp, #8
c0d0324e:	bd80      	pop	{r7, pc}
  unsigned int retid;
  unsigned int parameters [0];
  retid = SVC_Call(SYSCALL_io_seproxyhal_spi_is_status_sent_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d03250:	2004      	movs	r0, #4
c0d03252:	f7fe fc30 	bl	c0d01ab6 <os_longjmp>
c0d03256:	46c0      	nop			; (mov r8, r8)
c0d03258:	600073cf 	.word	0x600073cf
c0d0325c:	9000737f 	.word	0x9000737f

c0d03260 <io_seproxyhal_spi_recv>:
  }
  return (unsigned int)ret;
}

unsigned short io_seproxyhal_spi_recv ( unsigned char * buffer, unsigned short maxlength, unsigned int flags ) 
{
c0d03260:	b580      	push	{r7, lr}
c0d03262:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int retid;
  unsigned int parameters [0+3];
  parameters[0] = (unsigned int)buffer;
c0d03264:	ab00      	add	r3, sp, #0
c0d03266:	c307      	stmia	r3!, {r0, r1, r2}
  parameters[1] = (unsigned int)maxlength;
  parameters[2] = (unsigned int)flags;
  retid = SVC_Call(SYSCALL_io_seproxyhal_spi_recv_ID_IN, parameters);
c0d03268:	4807      	ldr	r0, [pc, #28]	; (c0d03288 <io_seproxyhal_spi_recv+0x28>)
c0d0326a:	4669      	mov	r1, sp
c0d0326c:	f7ff fe05 	bl	c0d02e7a <SVC_Call>
c0d03270:	aa03      	add	r2, sp, #12
  asm volatile("str r1, %0":"=m"(ret)::"r1");
c0d03272:	6011      	str	r1, [r2, #0]
  if (retid != SYSCALL_io_seproxyhal_spi_recv_ID_OUT) {
c0d03274:	4905      	ldr	r1, [pc, #20]	; (c0d0328c <io_seproxyhal_spi_recv+0x2c>)
c0d03276:	4288      	cmp	r0, r1
c0d03278:	d103      	bne.n	c0d03282 <io_seproxyhal_spi_recv+0x22>
c0d0327a:	a803      	add	r0, sp, #12
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned short)ret;
c0d0327c:	8800      	ldrh	r0, [r0, #0]
c0d0327e:	b004      	add	sp, #16
c0d03280:	bd80      	pop	{r7, pc}
  parameters[1] = (unsigned int)maxlength;
  parameters[2] = (unsigned int)flags;
  retid = SVC_Call(SYSCALL_io_seproxyhal_spi_recv_ID_IN, parameters);
  asm volatile("str r1, %0":"=m"(ret)::"r1");
  if (retid != SYSCALL_io_seproxyhal_spi_recv_ID_OUT) {
    THROW(EXCEPTION_SECURITY);
c0d03282:	2004      	movs	r0, #4
c0d03284:	f7fe fc17 	bl	c0d01ab6 <os_longjmp>
c0d03288:	600074d1 	.word	0x600074d1
c0d0328c:	9000742b 	.word	0x9000742b

c0d03290 <transaction_initialize>:
#define N_appdata (*(volatile storage_t *)PIC(&N_appdata_impl))
#endif

parsed_json_t parsed_transaction;

void transaction_initialize() {
c0d03290:	b580      	push	{r7, lr}
    buffering_init(
        ram_buffer,
        sizeof(ram_buffer),
        N_appdata.buffer,
c0d03292:	4806      	ldr	r0, [pc, #24]	; (c0d032ac <transaction_initialize+0x1c>)
c0d03294:	f7ff fcc6 	bl	c0d02c24 <pic>
c0d03298:	4602      	mov	r2, r0
#endif

parsed_json_t parsed_transaction;

void transaction_initialize() {
    buffering_init(
c0d0329a:	200d      	movs	r0, #13
c0d0329c:	0141      	lsls	r1, r0, #5
c0d0329e:	2001      	movs	r0, #1
c0d032a0:	0343      	lsls	r3, r0, #13
c0d032a2:	4803      	ldr	r0, [pc, #12]	; (c0d032b0 <transaction_initialize+0x20>)
c0d032a4:	f7fd fdbc 	bl	c0d00e20 <buffering_init>
        ram_buffer,
        sizeof(ram_buffer),
        N_appdata.buffer,
        sizeof(N_appdata.buffer)
    );
}
c0d032a8:	bd80      	pop	{r7, pc}
c0d032aa:	46c0      	nop			; (mov r8, r8)
c0d032ac:	c0d07f80 	.word	0xc0d07f80
c0d032b0:	20001b78 	.word	0x20001b78

c0d032b4 <transaction_reset>:

void transaction_reset() {
c0d032b4:	b580      	push	{r7, lr}
    buffering_reset();
c0d032b6:	f7fd fdcb 	bl	c0d00e50 <buffering_reset>
}
c0d032ba:	bd80      	pop	{r7, pc}

c0d032bc <transaction_append>:

uint32_t transaction_append(unsigned char *buffer, uint32_t length) {
c0d032bc:	b580      	push	{r7, lr}
    return buffering_append(buffer, length);
c0d032be:	f7fd fdd9 	bl	c0d00e74 <buffering_append>
c0d032c2:	bd80      	pop	{r7, pc}

c0d032c4 <transaction_get_buffer_length>:
}

uint32_t transaction_get_buffer_length() {
c0d032c4:	b580      	push	{r7, lr}
    return buffering_get_buffer()->pos;
c0d032c6:	f7fd fe13 	bl	c0d00ef0 <buffering_get_buffer>
c0d032ca:	88c0      	ldrh	r0, [r0, #6]
c0d032cc:	bd80      	pop	{r7, pc}

c0d032ce <transaction_get_buffer>:
}

uint8_t *transaction_get_buffer() {
c0d032ce:	b580      	push	{r7, lr}
    return buffering_get_buffer()->data;
c0d032d0:	f7fd fe0e 	bl	c0d00ef0 <buffering_get_buffer>
c0d032d4:	6800      	ldr	r0, [r0, #0]
c0d032d6:	bd80      	pop	{r7, pc}

c0d032d8 <transaction_parse>:
}

const char* transaction_parse() {
c0d032d8:	b510      	push	{r4, lr}
uint32_t transaction_get_buffer_length() {
    return buffering_get_buffer()->pos;
}

uint8_t *transaction_get_buffer() {
    return buffering_get_buffer()->data;
c0d032da:	f7fd fe09 	bl	c0d00ef0 <buffering_get_buffer>
c0d032de:	6804      	ldr	r4, [r0, #0]
uint32_t transaction_append(unsigned char *buffer, uint32_t length) {
    return buffering_append(buffer, length);
}

uint32_t transaction_get_buffer_length() {
    return buffering_get_buffer()->pos;
c0d032e0:	f7fd fe06 	bl	c0d00ef0 <buffering_get_buffer>
    return buffering_get_buffer()->data;
}

const char* transaction_parse() {
    const char *transaction_buffer = (const char *) transaction_get_buffer();
    const char* error_msg = json_parse_s(&parsed_transaction, transaction_buffer, transaction_get_buffer_length());
c0d032e4:	88c2      	ldrh	r2, [r0, #6]
c0d032e6:	4809      	ldr	r0, [pc, #36]	; (c0d0330c <transaction_parse+0x34>)
c0d032e8:	4621      	mov	r1, r4
c0d032ea:	f7fe f90d 	bl	c0d01508 <json_parse_s>
    if (error_msg != NULL) {
c0d032ee:	2800      	cmp	r0, #0
c0d032f0:	d10b      	bne.n	c0d0330a <transaction_parse+0x32>
        return error_msg;
    }
    error_msg = json_validate(&parsed_transaction, transaction_buffer);
c0d032f2:	4806      	ldr	r0, [pc, #24]	; (c0d0330c <transaction_parse+0x34>)
c0d032f4:	4621      	mov	r1, r4
c0d032f6:	f000 fb93 	bl	c0d03a20 <json_validate>
    if (error_msg != NULL) {
c0d032fa:	2800      	cmp	r0, #0
c0d032fc:	d105      	bne.n	c0d0330a <transaction_parse+0x32>
    context.tx = transaction_buffer;
    context.max_chars_per_key_line = MAX_CHARS_PER_KEY_LINE;
    context.max_chars_per_value_line = MAX_CHARS_PER_VALUE_LINE;
    context.parsed_tx = &parsed_transaction;

    set_parsing_context(context);
c0d032fe:	4803      	ldr	r0, [pc, #12]	; (c0d0330c <transaction_parse+0x34>)
c0d03300:	4903      	ldr	r1, [pc, #12]	; (c0d03310 <transaction_parse+0x38>)
c0d03302:	4622      	mov	r2, r4
c0d03304:	f000 f9b4 	bl	c0d03670 <set_parsing_context>
c0d03308:	2000      	movs	r0, #0
    return NULL;
}
c0d0330a:	bd10      	pop	{r4, pc}
c0d0330c:	20001d18 	.word	0x20001d18
c0d03310:	00c00040 	.word	0x00c00040

c0d03314 <tx_display_index_root>:

display_cache_t *tx_display_cache() {
    return &display_cache;
}

void tx_display_index_root() {
c0d03314:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03316:	b089      	sub	sp, #36	; 0x24
    if (parsing_context.cache_valid) {
c0d03318:	4859      	ldr	r0, [pc, #356]	; (c0d03480 <tx_display_index_root+0x16c>)
c0d0331a:	7b00      	ldrb	r0, [r0, #12]
c0d0331c:	2800      	cmp	r0, #0
c0d0331e:	d000      	beq.n	c0d03322 <tx_display_index_root+0xe>
c0d03320:	e0ac      	b.n	c0d0347c <tx_display_index_root+0x168>
        return;
    }

    // Clear values
    display_cache.num_pages = 0;
c0d03322:	4958      	ldr	r1, [pc, #352]	; (c0d03484 <tx_display_index_root+0x170>)
c0d03324:	2200      	movs	r2, #0
c0d03326:	800a      	strh	r2, [r1, #0]
    memset(display_cache.num_subpages, 0, NUM_REQUIRED_ROOT_PAGES);
c0d03328:	820a      	strh	r2, [r1, #16]
c0d0332a:	81ca      	strh	r2, [r1, #14]
c0d0332c:	824a      	strh	r2, [r1, #18]
    memset(display_cache.subroot_start_token, TX_TOKEN_NOT_FOUND, NUM_REQUIRED_ROOT_PAGES);
c0d0332e:	4856      	ldr	r0, [pc, #344]	; (c0d03488 <tx_display_index_root+0x174>)
c0d03330:	8088      	strh	r0, [r1, #4]
c0d03332:	8048      	strh	r0, [r1, #2]
c0d03334:	80c8      	strh	r0, [r1, #6]
c0d03336:	4858      	ldr	r0, [pc, #352]	; (c0d03498 <tx_display_index_root+0x184>)
c0d03338:	4478      	add	r0, pc
c0d0333a:	9002      	str	r0, [sp, #8]
c0d0333c:	4857      	ldr	r0, [pc, #348]	; (c0d0349c <tx_display_index_root+0x188>)
c0d0333e:	4478      	add	r0, pc
c0d03340:	9001      	str	r0, [sp, #4]
c0d03342:	4857      	ldr	r0, [pc, #348]	; (c0d034a0 <tx_display_index_root+0x18c>)
c0d03344:	4478      	add	r0, pc
c0d03346:	9000      	str	r0, [sp, #0]
c0d03348:	4f52      	ldr	r7, [pc, #328]	; (c0d03494 <tx_display_index_root+0x180>)
c0d0334a:	4856      	ldr	r0, [pc, #344]	; (c0d034a4 <tx_display_index_root+0x190>)
c0d0334c:	4478      	add	r0, pc
c0d0334e:	9003      	str	r0, [sp, #12]
c0d03350:	b2d6      	uxtb	r6, r2
#endif

// Required pages
// FIXME: the required root items have been moved to a function due to PIC issues. Refactor and fix
const char *get_required_root_item(uint8_t i) {
    switch (i) {
c0d03352:	2e02      	cmp	r6, #2
c0d03354:	dc08      	bgt.n	c0d03368 <tx_display_index_root+0x54>
c0d03356:	2e00      	cmp	r6, #0
c0d03358:	9902      	ldr	r1, [sp, #8]
c0d0335a:	d016      	beq.n	c0d0338a <tx_display_index_root+0x76>
c0d0335c:	2e01      	cmp	r6, #1
c0d0335e:	d00c      	beq.n	c0d0337a <tx_display_index_root+0x66>
c0d03360:	2e02      	cmp	r6, #2
c0d03362:	d111      	bne.n	c0d03388 <tx_display_index_root+0x74>
c0d03364:	9900      	ldr	r1, [sp, #0]
c0d03366:	e010      	b.n	c0d0338a <tx_display_index_root+0x76>
c0d03368:	2e03      	cmp	r6, #3
c0d0336a:	d008      	beq.n	c0d0337e <tx_display_index_root+0x6a>
c0d0336c:	2e04      	cmp	r6, #4
c0d0336e:	d008      	beq.n	c0d03382 <tx_display_index_root+0x6e>
c0d03370:	2e05      	cmp	r6, #5
c0d03372:	d109      	bne.n	c0d03388 <tx_display_index_root+0x74>
c0d03374:	494c      	ldr	r1, [pc, #304]	; (c0d034a8 <tx_display_index_root+0x194>)
c0d03376:	4479      	add	r1, pc
c0d03378:	e007      	b.n	c0d0338a <tx_display_index_root+0x76>
c0d0337a:	9901      	ldr	r1, [sp, #4]
c0d0337c:	e005      	b.n	c0d0338a <tx_display_index_root+0x76>
c0d0337e:	a143      	add	r1, pc, #268	; (adr r1, c0d0348c <tx_display_index_root+0x178>)
c0d03380:	e003      	b.n	c0d0338a <tx_display_index_root+0x76>
c0d03382:	494a      	ldr	r1, [pc, #296]	; (c0d034ac <tx_display_index_root+0x198>)
c0d03384:	4479      	add	r1, pc
c0d03386:	e000      	b.n	c0d0338a <tx_display_index_root+0x76>
c0d03388:	a141      	add	r1, pc, #260	; (adr r1, c0d03490 <tx_display_index_root+0x17c>)
c0d0338a:	483d      	ldr	r0, [pc, #244]	; (c0d03480 <tx_display_index_root+0x16c>)
    int8_t found = 0;
    for (int8_t idx = 0; idx < NUM_REQUIRED_ROOT_PAGES; idx++) {
        const int16_t subroot_token_idx = object_get_value(ROOT_TOKEN_INDEX,
                                                           get_required_root_item(idx),
                                                           parsing_context.parsed_tx,
                                                           parsing_context.tx);
c0d0338c:	6883      	ldr	r3, [r0, #8]
c0d0338e:	9206      	str	r2, [sp, #24]
    // Calculate pages
    int8_t found = 0;
    for (int8_t idx = 0; idx < NUM_REQUIRED_ROOT_PAGES; idx++) {
        const int16_t subroot_token_idx = object_get_value(ROOT_TOKEN_INDEX,
                                                           get_required_root_item(idx),
                                                           parsing_context.parsed_tx,
c0d03390:	6802      	ldr	r2, [r0, #0]
c0d03392:	2500      	movs	r5, #0
    memset(display_cache.subroot_start_token, TX_TOKEN_NOT_FOUND, NUM_REQUIRED_ROOT_PAGES);

    // Calculate pages
    int8_t found = 0;
    for (int8_t idx = 0; idx < NUM_REQUIRED_ROOT_PAGES; idx++) {
        const int16_t subroot_token_idx = object_get_value(ROOT_TOKEN_INDEX,
c0d03394:	4628      	mov	r0, r5
c0d03396:	f7fe f9d5 	bl	c0d01744 <object_get_value>
c0d0339a:	9a06      	ldr	r2, [sp, #24]
c0d0339c:	4604      	mov	r4, r0
                                                           get_required_root_item(idx),
                                                           parsing_context.parsed_tx,
                                                           parsing_context.tx);
        if (subroot_token_idx < 0) {
c0d0339e:	2c00      	cmp	r4, #0
c0d033a0:	db69      	blt.n	c0d03476 <tx_display_index_root+0x162>
c0d033a2:	4838      	ldr	r0, [pc, #224]	; (c0d03484 <tx_display_index_root+0x170>)
c0d033a4:	4601      	mov	r1, r0
            break;
        }

        display_cache.num_subpages[idx] = 0;
c0d033a6:	188b      	adds	r3, r1, r2
c0d033a8:	739d      	strb	r5, [r3, #14]
        display_cache.subroot_start_token[idx] = subroot_token_idx;
c0d033aa:	0050      	lsls	r0, r2, #1
c0d033ac:	1809      	adds	r1, r1, r0
c0d033ae:	804c      	strh	r4, [r1, #2]
c0d033b0:	a908      	add	r1, sp, #32

        char tmp_key[2];
        char tmp_val[2];
        INIT_QUERY_CONTEXT(tmp_key, sizeof(tmp_key), tmp_val, sizeof(tmp_val), 0, root_max_level[idx])
c0d033b2:	700d      	strb	r5, [r1, #0]
c0d033b4:	aa07      	add	r2, sp, #28
c0d033b6:	7015      	strb	r5, [r2, #0]
c0d033b8:	6079      	str	r1, [r7, #4]
c0d033ba:	60fa      	str	r2, [r7, #12]
c0d033bc:	2102      	movs	r1, #2
c0d033be:	8139      	strh	r1, [r7, #8]
c0d033c0:	8239      	strh	r1, [r7, #16]
c0d033c2:	803d      	strh	r5, [r7, #0]
c0d033c4:	807d      	strh	r5, [r7, #2]
c0d033c6:	82bd      	strh	r5, [r7, #20]
c0d033c8:	2206      	movs	r2, #6
c0d033ca:	75fa      	strb	r2, [r7, #23]
c0d033cc:	9903      	ldr	r1, [sp, #12]
c0d033ce:	5c08      	ldrb	r0, [r1, r0]
c0d033d0:	75b8      	strb	r0, [r7, #22]
                                                           parsing_context.tx);
        if (subroot_token_idx < 0) {
            break;
        }

        display_cache.num_subpages[idx] = 0;
c0d033d2:	330e      	adds	r3, #14
c0d033d4:	9305      	str	r3, [sp, #20]
#endif

// Required pages
// FIXME: the required root items have been moved to a function due to PIC issues. Refactor and fix
const char *get_required_root_item(uint8_t i) {
    switch (i) {
c0d033d6:	2e02      	cmp	r6, #2
c0d033d8:	9204      	str	r2, [sp, #16]
c0d033da:	dc08      	bgt.n	c0d033ee <tx_display_index_root+0xda>
c0d033dc:	2e00      	cmp	r6, #0
c0d033de:	d00f      	beq.n	c0d03400 <tx_display_index_root+0xec>
c0d033e0:	2e01      	cmp	r6, #1
c0d033e2:	d010      	beq.n	c0d03406 <tx_display_index_root+0xf2>
c0d033e4:	2e02      	cmp	r6, #2
c0d033e6:	d116      	bne.n	c0d03416 <tx_display_index_root+0x102>
c0d033e8:	4932      	ldr	r1, [pc, #200]	; (c0d034b4 <tx_display_index_root+0x1a0>)
c0d033ea:	4479      	add	r1, pc
c0d033ec:	e014      	b.n	c0d03418 <tx_display_index_root+0x104>
c0d033ee:	2e03      	cmp	r6, #3
c0d033f0:	d00c      	beq.n	c0d0340c <tx_display_index_root+0xf8>
c0d033f2:	2e04      	cmp	r6, #4
c0d033f4:	d00c      	beq.n	c0d03410 <tx_display_index_root+0xfc>
c0d033f6:	2e05      	cmp	r6, #5
c0d033f8:	d10d      	bne.n	c0d03416 <tx_display_index_root+0x102>
c0d033fa:	492f      	ldr	r1, [pc, #188]	; (c0d034b8 <tx_display_index_root+0x1a4>)
c0d033fc:	4479      	add	r1, pc
c0d033fe:	e00b      	b.n	c0d03418 <tx_display_index_root+0x104>
c0d03400:	492b      	ldr	r1, [pc, #172]	; (c0d034b0 <tx_display_index_root+0x19c>)
c0d03402:	4479      	add	r1, pc
c0d03404:	e008      	b.n	c0d03418 <tx_display_index_root+0x104>
c0d03406:	492d      	ldr	r1, [pc, #180]	; (c0d034bc <tx_display_index_root+0x1a8>)
c0d03408:	4479      	add	r1, pc
c0d0340a:	e005      	b.n	c0d03418 <tx_display_index_root+0x104>
c0d0340c:	a11f      	add	r1, pc, #124	; (adr r1, c0d0348c <tx_display_index_root+0x178>)
c0d0340e:	e003      	b.n	c0d03418 <tx_display_index_root+0x104>
c0d03410:	492b      	ldr	r1, [pc, #172]	; (c0d034c0 <tx_display_index_root+0x1ac>)
c0d03412:	4479      	add	r1, pc
c0d03414:	e000      	b.n	c0d03418 <tx_display_index_root+0x104>
c0d03416:	a11e      	add	r1, pc, #120	; (adr r1, c0d03490 <tx_display_index_root+0x17c>)
c0d03418:	a808      	add	r0, sp, #32
        display_cache.subroot_start_token[idx] = subroot_token_idx;

        char tmp_key[2];
        char tmp_val[2];
        INIT_QUERY_CONTEXT(tmp_key, sizeof(tmp_key), tmp_val, sizeof(tmp_val), 0, root_max_level[idx])
        STRNCPY_S(tx_ctx.query.out_key, get_required_root_item(idx), tx_ctx.query.out_key_len);
c0d0341a:	2201      	movs	r2, #1
c0d0341c:	f003 f864 	bl	c0d064e8 <strncpy>
c0d03420:	2008      	movs	r0, #8
c0d03422:	5e38      	ldrsh	r0, [r7, r0]
c0d03424:	6879      	ldr	r1, [r7, #4]
c0d03426:	1808      	adds	r0, r1, r0
c0d03428:	43ee      	mvns	r6, r5
c0d0342a:	5585      	strb	r5, [r0, r6]
        tx_ctx.max_depth = MAX_RECURSION_DEPTH;
c0d0342c:	9804      	ldr	r0, [sp, #16]
c0d0342e:	75f8      	strb	r0, [r7, #23]
c0d03430:	4629      	mov	r1, r5
c0d03432:	803d      	strh	r5, [r7, #0]
        tx_ctx.query.item_index = 0;

        found = 0;
        while (found >= 0) {
c0d03434:	b248      	sxtb	r0, r1
c0d03436:	42b0      	cmp	r0, r6
c0d03438:	dd0f      	ble.n	c0d0345a <tx_display_index_root+0x146>
            tx_ctx.item_index_current = 0;
c0d0343a:	2000      	movs	r0, #0
c0d0343c:	82b8      	strh	r0, [r7, #20]
            found = tx_traverse(subroot_token_idx);
c0d0343e:	4620      	mov	r0, r4
c0d03440:	f000 f920 	bl	c0d03684 <tx_traverse>
c0d03444:	b241      	sxtb	r1, r0

            if (found >= 0) {
c0d03446:	42b1      	cmp	r1, r6
c0d03448:	ddf4      	ble.n	c0d03434 <tx_display_index_root+0x120>
c0d0344a:	9a05      	ldr	r2, [sp, #20]
                display_cache.num_subpages[idx]++;
c0d0344c:	7811      	ldrb	r1, [r2, #0]
c0d0344e:	1c49      	adds	r1, r1, #1
c0d03450:	7011      	strb	r1, [r2, #0]
                tx_ctx.query.item_index++;
c0d03452:	8839      	ldrh	r1, [r7, #0]
c0d03454:	1c4d      	adds	r5, r1, #1
c0d03456:	4601      	mov	r1, r0
c0d03458:	e7eb      	b.n	c0d03432 <tx_display_index_root+0x11e>
            }
        };
        display_cache.num_pages += display_cache.num_subpages[idx];
c0d0345a:	9805      	ldr	r0, [sp, #20]
c0d0345c:	7800      	ldrb	r0, [r0, #0]
c0d0345e:	4909      	ldr	r1, [pc, #36]	; (c0d03484 <tx_display_index_root+0x170>)
c0d03460:	460a      	mov	r2, r1
c0d03462:	8811      	ldrh	r1, [r2, #0]
c0d03464:	1809      	adds	r1, r1, r0
c0d03466:	8011      	strh	r1, [r2, #0]
c0d03468:	9a06      	ldr	r2, [sp, #24]
    memset(display_cache.num_subpages, 0, NUM_REQUIRED_ROOT_PAGES);
    memset(display_cache.subroot_start_token, TX_TOKEN_NOT_FOUND, NUM_REQUIRED_ROOT_PAGES);

    // Calculate pages
    int8_t found = 0;
    for (int8_t idx = 0; idx < NUM_REQUIRED_ROOT_PAGES; idx++) {
c0d0346a:	1c52      	adds	r2, r2, #1
c0d0346c:	2800      	cmp	r0, #0
c0d0346e:	d002      	beq.n	c0d03476 <tx_display_index_root+0x162>
c0d03470:	2a06      	cmp	r2, #6
c0d03472:	da00      	bge.n	c0d03476 <tx_display_index_root+0x162>
c0d03474:	e76c      	b.n	c0d03350 <tx_display_index_root+0x3c>
        if (display_cache.num_subpages[idx] == 0) {
            break;
        }
    }

    parsing_context.cache_valid = 1;
c0d03476:	2001      	movs	r0, #1
c0d03478:	4901      	ldr	r1, [pc, #4]	; (c0d03480 <tx_display_index_root+0x16c>)
c0d0347a:	7308      	strb	r0, [r1, #12]
}
c0d0347c:	b009      	add	sp, #36	; 0x24
c0d0347e:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03480:	20002130 	.word	0x20002130
c0d03484:	2000211c 	.word	0x2000211c
c0d03488:	0000ffff 	.word	0x0000ffff
c0d0348c:	00656566 	.word	0x00656566
c0d03490:	0000003f 	.word	0x0000003f
c0d03494:	20002140 	.word	0x20002140
c0d03498:	0000350c 	.word	0x0000350c
c0d0349c:	000043ce 	.word	0x000043ce
c0d034a0:	00003509 	.word	0x00003509
c0d034a4:	0000350a 	.word	0x0000350a
c0d034a8:	00004384 	.word	0x00004384
c0d034ac:	000043a4 	.word	0x000043a4
c0d034b0:	00003442 	.word	0x00003442
c0d034b4:	00003463 	.word	0x00003463
c0d034b8:	000042fe 	.word	0x000042fe
c0d034bc:	00004304 	.word	0x00004304
c0d034c0:	00004316 	.word	0x00004316

c0d034c4 <tx_display_num_pages>:

int16_t tx_display_num_pages() {
c0d034c4:	b580      	push	{r7, lr}
    tx_display_index_root();
c0d034c6:	f7ff ff25 	bl	c0d03314 <tx_display_index_root>
    return display_cache.num_pages;
c0d034ca:	4802      	ldr	r0, [pc, #8]	; (c0d034d4 <tx_display_num_pages+0x10>)
c0d034cc:	8800      	ldrh	r0, [r0, #0]
c0d034ce:	b200      	sxth	r0, r0
c0d034d0:	bd80      	pop	{r7, pc}
c0d034d2:	46c0      	nop			; (mov r8, r8)
c0d034d4:	2000211c 	.word	0x2000211c

c0d034d8 <tx_display_get_item>:
}

// This function assumes that the tx_ctx has been set properly
int16_t tx_display_get_item(uint16_t page_index) {
c0d034d8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d034da:	b081      	sub	sp, #4
    if (!parsing_context.cache_valid) {
c0d034dc:	4935      	ldr	r1, [pc, #212]	; (c0d035b4 <tx_display_get_item+0xdc>)
c0d034de:	7b0a      	ldrb	r2, [r1, #12]
c0d034e0:	4935      	ldr	r1, [pc, #212]	; (c0d035b8 <tx_display_get_item+0xe0>)
c0d034e2:	2a00      	cmp	r2, #0
c0d034e4:	d063      	beq.n	c0d035ae <tx_display_get_item+0xd6>
        return ERR_MUST_INDEX_FIRST;
    }

    // TODO: Verify it has been properly set?
    tx_ctx.query.out_key[0] = 0;
c0d034e6:	4f35      	ldr	r7, [pc, #212]	; (c0d035bc <tx_display_get_item+0xe4>)
c0d034e8:	687b      	ldr	r3, [r7, #4]
c0d034ea:	2200      	movs	r2, #0
c0d034ec:	701a      	strb	r2, [r3, #0]
    tx_ctx.query.out_val[0] = 0;
c0d034ee:	68fb      	ldr	r3, [r7, #12]
c0d034f0:	701a      	strb	r2, [r3, #0]
c0d034f2:	1c49      	adds	r1, r1, #1
    if (page_index < 0 || page_index >= display_cache.num_pages) {
c0d034f4:	4b32      	ldr	r3, [pc, #200]	; (c0d035c0 <tx_display_get_item+0xe8>)
c0d034f6:	881b      	ldrh	r3, [r3, #0]
c0d034f8:	b21b      	sxth	r3, r3
c0d034fa:	4298      	cmp	r0, r3
c0d034fc:	da57      	bge.n	c0d035ae <tx_display_get_item+0xd6>
        return -1;
    }

    tx_ctx.query.item_index = 0;
c0d034fe:	803a      	strh	r2, [r7, #0]
    uint16_t root_index = 0;
    for (uint16_t i = 0; i < page_index; i++) {
c0d03500:	2800      	cmp	r0, #0
c0d03502:	4615      	mov	r5, r2
c0d03504:	d016      	beq.n	c0d03534 <tx_display_get_item+0x5c>
c0d03506:	2300      	movs	r3, #0
c0d03508:	461e      	mov	r6, r3
c0d0350a:	461d      	mov	r5, r3
        tx_ctx.query.item_index++;
        if (tx_ctx.query.item_index >= display_cache.num_subpages[root_index]) {
c0d0350c:	b2a9      	uxth	r1, r5
c0d0350e:	4c2c      	ldr	r4, [pc, #176]	; (c0d035c0 <tx_display_get_item+0xe8>)
c0d03510:	1861      	adds	r1, r4, r1
c0d03512:	7b8f      	ldrb	r7, [r1, #14]
c0d03514:	1c69      	adds	r1, r5, #1
    }

    tx_ctx.query.item_index = 0;
    uint16_t root_index = 0;
    for (uint16_t i = 0; i < page_index; i++) {
        tx_ctx.query.item_index++;
c0d03516:	1c5b      	adds	r3, r3, #1
        if (tx_ctx.query.item_index >= display_cache.num_subpages[root_index]) {
c0d03518:	b21c      	sxth	r4, r3
c0d0351a:	42bc      	cmp	r4, r7
c0d0351c:	db00      	blt.n	c0d03520 <tx_display_get_item+0x48>
c0d0351e:	460d      	mov	r5, r1
c0d03520:	2100      	movs	r1, #0
c0d03522:	42bc      	cmp	r4, r7
c0d03524:	db00      	blt.n	c0d03528 <tx_display_get_item+0x50>
c0d03526:	460b      	mov	r3, r1
        return -1;
    }

    tx_ctx.query.item_index = 0;
    uint16_t root_index = 0;
    for (uint16_t i = 0; i < page_index; i++) {
c0d03528:	1c76      	adds	r6, r6, #1
c0d0352a:	b2b1      	uxth	r1, r6
c0d0352c:	4281      	cmp	r1, r0
c0d0352e:	d3ed      	bcc.n	c0d0350c <tx_display_get_item+0x34>
c0d03530:	4f22      	ldr	r7, [pc, #136]	; (c0d035bc <tx_display_get_item+0xe4>)
        tx_ctx.query.item_index++;
        if (tx_ctx.query.item_index >= display_cache.num_subpages[root_index]) {
            tx_ctx.query.item_index = 0;
c0d03532:	803b      	strh	r3, [r7, #0]
            root_index++;
        }
    }

    tx_ctx.item_index_current = 0;
c0d03534:	82ba      	strh	r2, [r7, #20]
    tx_ctx.max_level = root_max_level[root_index];
c0d03536:	b2a8      	uxth	r0, r5
c0d03538:	0046      	lsls	r6, r0, #1
c0d0353a:	4824      	ldr	r0, [pc, #144]	; (c0d035cc <tx_display_get_item+0xf4>)
c0d0353c:	4478      	add	r0, pc
c0d0353e:	5d80      	ldrb	r0, [r0, r6]
c0d03540:	75b8      	strb	r0, [r7, #22]
    tx_ctx.max_depth = MAX_RECURSION_DEPTH;
c0d03542:	2006      	movs	r0, #6
c0d03544:	75f8      	strb	r0, [r7, #23]
c0d03546:	b2e9      	uxtb	r1, r5

    STRNCPY_S(tx_ctx.query.out_key, get_required_root_item(root_index), tx_ctx.query.out_key_len);
c0d03548:	6878      	ldr	r0, [r7, #4]
#endif

// Required pages
// FIXME: the required root items have been moved to a function due to PIC issues. Refactor and fix
const char *get_required_root_item(uint8_t i) {
    switch (i) {
c0d0354a:	2902      	cmp	r1, #2
c0d0354c:	dc08      	bgt.n	c0d03560 <tx_display_get_item+0x88>
c0d0354e:	2900      	cmp	r1, #0
c0d03550:	d00f      	beq.n	c0d03572 <tx_display_get_item+0x9a>
c0d03552:	2901      	cmp	r1, #1
c0d03554:	d010      	beq.n	c0d03578 <tx_display_get_item+0xa0>
c0d03556:	2902      	cmp	r1, #2
c0d03558:	d116      	bne.n	c0d03588 <tx_display_get_item+0xb0>
c0d0355a:	491e      	ldr	r1, [pc, #120]	; (c0d035d4 <tx_display_get_item+0xfc>)
c0d0355c:	4479      	add	r1, pc
c0d0355e:	e014      	b.n	c0d0358a <tx_display_get_item+0xb2>
c0d03560:	2903      	cmp	r1, #3
c0d03562:	d00c      	beq.n	c0d0357e <tx_display_get_item+0xa6>
c0d03564:	2904      	cmp	r1, #4
c0d03566:	d00c      	beq.n	c0d03582 <tx_display_get_item+0xaa>
c0d03568:	2905      	cmp	r1, #5
c0d0356a:	d10d      	bne.n	c0d03588 <tx_display_get_item+0xb0>
c0d0356c:	491a      	ldr	r1, [pc, #104]	; (c0d035d8 <tx_display_get_item+0x100>)
c0d0356e:	4479      	add	r1, pc
c0d03570:	e00b      	b.n	c0d0358a <tx_display_get_item+0xb2>
c0d03572:	4917      	ldr	r1, [pc, #92]	; (c0d035d0 <tx_display_get_item+0xf8>)
c0d03574:	4479      	add	r1, pc
c0d03576:	e008      	b.n	c0d0358a <tx_display_get_item+0xb2>
c0d03578:	4918      	ldr	r1, [pc, #96]	; (c0d035dc <tx_display_get_item+0x104>)
c0d0357a:	4479      	add	r1, pc
c0d0357c:	e005      	b.n	c0d0358a <tx_display_get_item+0xb2>
c0d0357e:	a111      	add	r1, pc, #68	; (adr r1, c0d035c4 <tx_display_get_item+0xec>)
c0d03580:	e003      	b.n	c0d0358a <tx_display_get_item+0xb2>
c0d03582:	4917      	ldr	r1, [pc, #92]	; (c0d035e0 <tx_display_get_item+0x108>)
c0d03584:	4479      	add	r1, pc
c0d03586:	e000      	b.n	c0d0358a <tx_display_get_item+0xb2>
c0d03588:	a10f      	add	r1, pc, #60	; (adr r1, c0d035c8 <tx_display_get_item+0xf0>)

    tx_ctx.item_index_current = 0;
    tx_ctx.max_level = root_max_level[root_index];
    tx_ctx.max_depth = MAX_RECURSION_DEPTH;

    STRNCPY_S(tx_ctx.query.out_key, get_required_root_item(root_index), tx_ctx.query.out_key_len);
c0d0358a:	2408      	movs	r4, #8
c0d0358c:	5f3a      	ldrsh	r2, [r7, r4]
c0d0358e:	1e52      	subs	r2, r2, #1
c0d03590:	f002 ffaa 	bl	c0d064e8 <strncpy>
c0d03594:	5f38      	ldrsh	r0, [r7, r4]
c0d03596:	6879      	ldr	r1, [r7, #4]
c0d03598:	1808      	adds	r0, r1, r0
c0d0359a:	2100      	movs	r1, #0
c0d0359c:	43ca      	mvns	r2, r1
c0d0359e:	5481      	strb	r1, [r0, r2]

    int16_t ret = tx_traverse(display_cache.subroot_start_token[root_index]);
c0d035a0:	4807      	ldr	r0, [pc, #28]	; (c0d035c0 <tx_display_get_item+0xe8>)
c0d035a2:	1980      	adds	r0, r0, r6
c0d035a4:	2102      	movs	r1, #2
c0d035a6:	5e40      	ldrsh	r0, [r0, r1]
c0d035a8:	f000 f86c 	bl	c0d03684 <tx_traverse>
c0d035ac:	4601      	mov	r1, r0

    return ret;
}
c0d035ae:	b208      	sxth	r0, r1
c0d035b0:	b001      	add	sp, #4
c0d035b2:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d035b4:	20002130 	.word	0x20002130
c0d035b8:	0000fffe 	.word	0x0000fffe
c0d035bc:	20002140 	.word	0x20002140
c0d035c0:	2000211c 	.word	0x2000211c
c0d035c4:	00656566 	.word	0x00656566
c0d035c8:	0000003f 	.word	0x0000003f
c0d035cc:	0000331a 	.word	0x0000331a
c0d035d0:	000032d0 	.word	0x000032d0
c0d035d4:	000032f1 	.word	0x000032f1
c0d035d8:	0000418c 	.word	0x0000418c
c0d035dc:	00004192 	.word	0x00004192
c0d035e0:	000041a4 	.word	0x000041a4

c0d035e4 <tx_display_make_friendly>:

void tx_display_make_friendly() {
c0d035e4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d035e6:	b081      	sub	sp, #4
c0d035e8:	4e1e      	ldr	r6, [pc, #120]	; (c0d03664 <tx_display_make_friendly+0x80>)
c0d035ea:	6874      	ldr	r4, [r6, #4]
c0d035ec:	2700      	movs	r7, #0
c0d035ee:	4d1e      	ldr	r5, [pc, #120]	; (c0d03668 <tx_display_make_friendly+0x84>)
c0d035f0:	447d      	add	r5, pc
    // post process keys
    for (int8_t i = 0; i < NUM_KEY_SUBSTITUTIONS; i++) {
        if (!strcmp(tx_ctx.query.out_key, key_substitutions[i].str1)) {
c0d035f2:	4620      	mov	r0, r4
c0d035f4:	4629      	mov	r1, r5
c0d035f6:	f002 feff 	bl	c0d063f8 <strcmp>
    return ret;
}

void tx_display_make_friendly() {
    // post process keys
    for (int8_t i = 0; i < NUM_KEY_SUBSTITUTIONS; i++) {
c0d035fa:	1c7f      	adds	r7, r7, #1
        if (!strcmp(tx_ctx.query.out_key, key_substitutions[i].str1)) {
c0d035fc:	2800      	cmp	r0, #0
c0d035fe:	d003      	beq.n	c0d03608 <tx_display_make_friendly+0x24>
    return ret;
}

void tx_display_make_friendly() {
    // post process keys
    for (int8_t i = 0; i < NUM_KEY_SUBSTITUTIONS; i++) {
c0d03600:	3564      	adds	r5, #100	; 0x64
c0d03602:	2f1c      	cmp	r7, #28
c0d03604:	ddf5      	ble.n	c0d035f2 <tx_display_make_friendly+0xe>
c0d03606:	e00d      	b.n	c0d03624 <tx_display_make_friendly+0x40>
        if (!strcmp(tx_ctx.query.out_key, key_substitutions[i].str1)) {
            STRNCPY_S(tx_ctx.query.out_key,
c0d03608:	2708      	movs	r7, #8
c0d0360a:	5ff0      	ldrsh	r0, [r6, r7]
c0d0360c:	1e42      	subs	r2, r0, #1
c0d0360e:	3532      	adds	r5, #50	; 0x32
c0d03610:	4620      	mov	r0, r4
c0d03612:	4629      	mov	r1, r5
c0d03614:	f002 ff68 	bl	c0d064e8 <strncpy>
c0d03618:	5ff0      	ldrsh	r0, [r6, r7]
c0d0361a:	6871      	ldr	r1, [r6, #4]
c0d0361c:	1808      	adds	r0, r1, r0
c0d0361e:	2100      	movs	r1, #0
c0d03620:	43ca      	mvns	r2, r1
c0d03622:	5481      	strb	r1, [r0, r2]
c0d03624:	68f4      	ldr	r4, [r6, #12]
c0d03626:	2700      	movs	r7, #0
c0d03628:	4d10      	ldr	r5, [pc, #64]	; (c0d0366c <tx_display_make_friendly+0x88>)
c0d0362a:	447d      	add	r5, pc
            break;
        }
    }

    for (int8_t i = 0; i < NUM_VALUE_SUBSTITUTIONS; i++) {
        if (!strcmp(tx_ctx.query.out_val, value_substitutions[i].str1)) {
c0d0362c:	4620      	mov	r0, r4
c0d0362e:	4629      	mov	r1, r5
c0d03630:	f002 fee2 	bl	c0d063f8 <strcmp>
                      tx_ctx.query.out_key_len);
            break;
        }
    }

    for (int8_t i = 0; i < NUM_VALUE_SUBSTITUTIONS; i++) {
c0d03634:	1c7f      	adds	r7, r7, #1
        if (!strcmp(tx_ctx.query.out_val, value_substitutions[i].str1)) {
c0d03636:	2800      	cmp	r0, #0
c0d03638:	d003      	beq.n	c0d03642 <tx_display_make_friendly+0x5e>
                      tx_ctx.query.out_key_len);
            break;
        }
    }

    for (int8_t i = 0; i < NUM_VALUE_SUBSTITUTIONS; i++) {
c0d0363a:	3564      	adds	r5, #100	; 0x64
c0d0363c:	2f07      	cmp	r7, #7
c0d0363e:	ddf5      	ble.n	c0d0362c <tx_display_make_friendly+0x48>
c0d03640:	e00d      	b.n	c0d0365e <tx_display_make_friendly+0x7a>
        if (!strcmp(tx_ctx.query.out_val, value_substitutions[i].str1)) {
            STRNCPY_S(tx_ctx.query.out_val,
c0d03642:	2710      	movs	r7, #16
c0d03644:	5ff0      	ldrsh	r0, [r6, r7]
c0d03646:	1e42      	subs	r2, r0, #1
c0d03648:	3532      	adds	r5, #50	; 0x32
c0d0364a:	4620      	mov	r0, r4
c0d0364c:	4629      	mov	r1, r5
c0d0364e:	f002 ff4b 	bl	c0d064e8 <strncpy>
c0d03652:	5ff0      	ldrsh	r0, [r6, r7]
c0d03654:	68f1      	ldr	r1, [r6, #12]
c0d03656:	1808      	adds	r0, r1, r0
c0d03658:	2100      	movs	r1, #0
c0d0365a:	43ca      	mvns	r2, r1
c0d0365c:	5481      	strb	r1, [r0, r2]
                      tx_ctx.query.out_val_len);
            break;
        }
    }

}
c0d0365e:	b001      	add	sp, #4
c0d03660:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03662:	46c0      	nop			; (mov r8, r8)
c0d03664:	20002140 	.word	0x20002140
c0d03668:	00003272 	.word	0x00003272
c0d0366c:	00003d8c 	.word	0x00003d8c

c0d03670 <set_parsing_context>:

// Global context to save memory / stack space in recursive calls
parsing_context_t parsing_context;
tx_context_t tx_ctx;

void set_parsing_context(parsing_context_t context) {
c0d03670:	b510      	push	{r4, lr}
    parsing_context = context;
c0d03672:	4c03      	ldr	r4, [pc, #12]	; (c0d03680 <set_parsing_context+0x10>)
c0d03674:	c40f      	stmia	r4!, {r0, r1, r2, r3}
    // reset cached values
    parsing_context.cache_valid = false;
c0d03676:	2000      	movs	r0, #0
// Global context to save memory / stack space in recursive calls
parsing_context_t parsing_context;
tx_context_t tx_ctx;

void set_parsing_context(parsing_context_t context) {
    parsing_context = context;
c0d03678:	3c10      	subs	r4, #16
    // reset cached values
    parsing_context.cache_valid = false;
c0d0367a:	7320      	strb	r0, [r4, #12]
}
c0d0367c:	bd10      	pop	{r4, pc}
c0d0367e:	46c0      	nop			; (mov r8, r8)
c0d03680:	20002130 	.word	0x20002130

c0d03684 <tx_traverse>:
    const int16_t new_item_size = token_end - token_start;

    strcat_chunk_s(tx_ctx.query.out_key, tx_ctx.query.out_key_len, address_ptr, new_item_size);
}

int16_t tx_traverse(int16_t root_token_index) {
c0d03684:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03686:	b08b      	sub	sp, #44	; 0x2c
    const jsmntype_t token_type = parsing_context.parsed_tx->Tokens[root_token_index].type;
c0d03688:	00c2      	lsls	r2, r0, #3
c0d0368a:	4993      	ldr	r1, [pc, #588]	; (c0d038d8 <tx_traverse+0x254>)
c0d0368c:	6809      	ldr	r1, [r1, #0]
c0d0368e:	188a      	adds	r2, r1, r2
c0d03690:	7914      	ldrb	r4, [r2, #4]

    if (tx_ctx.max_level <= 0 || tx_ctx.max_depth <= 0 ||
c0d03692:	1ee3      	subs	r3, r4, #3
c0d03694:	b2df      	uxtb	r7, r3
c0d03696:	4d91      	ldr	r5, [pc, #580]	; (c0d038dc <tx_traverse+0x258>)
c0d03698:	7deb      	ldrb	r3, [r5, #23]
c0d0369a:	9308      	str	r3, [sp, #32]
c0d0369c:	7dae      	ldrb	r6, [r5, #22]
c0d0369e:	4b90      	ldr	r3, [pc, #576]	; (c0d038e0 <tx_traverse+0x25c>)
c0d036a0:	930a      	str	r3, [sp, #40]	; 0x28
c0d036a2:	2f02      	cmp	r7, #2
c0d036a4:	9309      	str	r3, [sp, #36]	; 0x24
c0d036a6:	d32b      	bcc.n	c0d03700 <tx_traverse+0x7c>
c0d036a8:	2e00      	cmp	r6, #0
c0d036aa:	d029      	beq.n	c0d03700 <tx_traverse+0x7c>
c0d036ac:	9e08      	ldr	r6, [sp, #32]
c0d036ae:	2e00      	cmp	r6, #0
c0d036b0:	d026      	beq.n	c0d03700 <tx_traverse+0x7c>
        }
        tx_ctx.item_index_current++;
        return TX_TOKEN_NOT_FOUND;
    }

    const int16_t el_count = object_get_element_count(root_token_index, parsing_context.parsed_tx);
c0d036b2:	b286      	uxth	r6, r0
c0d036b4:	4630      	mov	r0, r6
c0d036b6:	f7fd ffd3 	bl	c0d01660 <object_get_element_count>
c0d036ba:	b207      	sxth	r7, r0
    int16_t num_chunks = TX_TOKEN_NOT_FOUND;

    switch (token_type) {
c0d036bc:	2c01      	cmp	r4, #1
c0d036be:	d047      	beq.n	c0d03750 <tx_traverse+0xcc>
c0d036c0:	2c02      	cmp	r4, #2
c0d036c2:	d000      	beq.n	c0d036c6 <tx_traverse+0x42>
c0d036c4:	e103      	b.n	c0d038ce <tx_traverse+0x24a>
                *(tx_ctx.query.out_key + key_len) = 0;
            }
            break;
        }
        case JSMN_ARRAY: {
            for (int16_t i = 0; i < el_count; ++i) {
c0d036c6:	2f01      	cmp	r7, #1
c0d036c8:	da00      	bge.n	c0d036cc <tx_traverse+0x48>
c0d036ca:	e100      	b.n	c0d038ce <tx_traverse+0x24a>
c0d036cc:	2400      	movs	r4, #0
                const int16_t element_index = array_get_nth_element(root_token_index, i, parsing_context.parsed_tx);
c0d036ce:	4882      	ldr	r0, [pc, #520]	; (c0d038d8 <tx_traverse+0x254>)
c0d036d0:	6802      	ldr	r2, [r0, #0]
c0d036d2:	b2a1      	uxth	r1, r4
c0d036d4:	4630      	mov	r0, r6
c0d036d6:	f7fd ff93 	bl	c0d01600 <array_get_nth_element>

                // When iterating along an array, the level does not change but we need to count the recursion
                tx_ctx.max_depth--;
c0d036da:	7de9      	ldrb	r1, [r5, #23]
c0d036dc:	1e49      	subs	r1, r1, #1
c0d036de:	75e9      	strb	r1, [r5, #23]
                num_chunks = tx_traverse(element_index);
c0d036e0:	f7ff ffd0 	bl	c0d03684 <tx_traverse>
                tx_ctx.max_depth++;
c0d036e4:	7de9      	ldrb	r1, [r5, #23]
c0d036e6:	1c49      	adds	r1, r1, #1
c0d036e8:	75e9      	strb	r1, [r5, #23]
c0d036ea:	9009      	str	r0, [sp, #36]	; 0x24
            for (int16_t i = 0; i < el_count; ++i) {
                const int16_t element_index = array_get_nth_element(root_token_index, i, parsing_context.parsed_tx);

                // When iterating along an array, the level does not change but we need to count the recursion
                tx_ctx.max_depth--;
                num_chunks = tx_traverse(element_index);
c0d036ec:	b281      	uxth	r1, r0
                *(tx_ctx.query.out_key + key_len) = 0;
            }
            break;
        }
        case JSMN_ARRAY: {
            for (int16_t i = 0; i < el_count; ++i) {
c0d036ee:	1c60      	adds	r0, r4, #1
c0d036f0:	9a0a      	ldr	r2, [sp, #40]	; 0x28
c0d036f2:	4291      	cmp	r1, r2
c0d036f4:	d000      	beq.n	c0d036f8 <tx_traverse+0x74>
c0d036f6:	e0ea      	b.n	c0d038ce <tx_traverse+0x24a>
c0d036f8:	b204      	sxth	r4, r0
c0d036fa:	42bc      	cmp	r4, r7
c0d036fc:	dbe7      	blt.n	c0d036ce <tx_traverse+0x4a>
c0d036fe:	e0e6      	b.n	c0d038ce <tx_traverse+0x24a>
    if (tx_ctx.max_level <= 0 || tx_ctx.max_depth <= 0 ||
        token_type == JSMN_STRING ||
        token_type == JSMN_PRIMITIVE) {

        // Early bail out
        if (tx_ctx.item_index_current == tx_ctx.query.item_index) {
c0d03700:	8aa8      	ldrh	r0, [r5, #20]
c0d03702:	8829      	ldrh	r1, [r5, #0]
c0d03704:	4288      	cmp	r0, r1
c0d03706:	d120      	bne.n	c0d0374a <tx_traverse+0xc6>
    }
}

__always_inline int16_t tx_get_value(const int16_t token_index) {

    const int16_t token_start = parsing_context.parsed_tx->Tokens[token_index].start;
c0d03708:	2006      	movs	r0, #6
    const int16_t token_end = parsing_context.parsed_tx->Tokens[token_index].end;
    const int16_t token_len = token_end - token_start;
c0d0370a:	5e11      	ldrsh	r1, [r2, r0]
}

__always_inline int16_t tx_get_value(const int16_t token_index) {

    const int16_t token_start = parsing_context.parsed_tx->Tokens[token_index].start;
    const int16_t token_end = parsing_context.parsed_tx->Tokens[token_index].end;
c0d0370c:	2008      	movs	r0, #8
    const int16_t token_len = token_end - token_start;
c0d0370e:	5e10      	ldrsh	r0, [r2, r0]
c0d03710:	9008      	str	r0, [sp, #32]
c0d03712:	9107      	str	r1, [sp, #28]
c0d03714:	1a44      	subs	r4, r0, r1

    int16_t num_chunks = (token_len / (tx_ctx.query.out_val_len - 1)) + 1;
c0d03716:	b227      	sxth	r7, r4
c0d03718:	2010      	movs	r0, #16
c0d0371a:	9006      	str	r0, [sp, #24]
c0d0371c:	5e28      	ldrsh	r0, [r5, r0]
c0d0371e:	1e46      	subs	r6, r0, #1
c0d03720:	4638      	mov	r0, r7
c0d03722:	4631      	mov	r1, r6
c0d03724:	f002 fccc 	bl	c0d060c0 <__aeabi_idiv>
c0d03728:	1c42      	adds	r2, r0, #1
c0d0372a:	0420      	lsls	r0, r4, #16
    if (token_len > 0 && (token_len % (tx_ctx.query.out_val_len - 1) == 0))
c0d0372c:	2801      	cmp	r0, #1
c0d0372e:	da00      	bge.n	c0d03732 <tx_traverse+0xae>
c0d03730:	e0a5      	b.n	c0d0387e <tx_traverse+0x1fa>
c0d03732:	4638      	mov	r0, r7
c0d03734:	4631      	mov	r1, r6
c0d03736:	4614      	mov	r4, r2
c0d03738:	f002 fda8 	bl	c0d0628c <__aeabi_idivmod>
c0d0373c:	4620      	mov	r0, r4
c0d0373e:	1e46      	subs	r6, r0, #1
c0d03740:	2900      	cmp	r1, #0
c0d03742:	d100      	bne.n	c0d03746 <tx_traverse+0xc2>
c0d03744:	e09c      	b.n	c0d03880 <tx_traverse+0x1fc>
c0d03746:	4606      	mov	r6, r0
c0d03748:	e09a      	b.n	c0d03880 <tx_traverse+0x1fc>

        // Early bail out
        if (tx_ctx.item_index_current == tx_ctx.query.item_index) {
            return tx_get_value(root_token_index);
        }
        tx_ctx.item_index_current++;
c0d0374a:	1c40      	adds	r0, r0, #1
c0d0374c:	82a8      	strh	r0, [r5, #20]
c0d0374e:	e0be      	b.n	c0d038ce <tx_traverse+0x24a>
    int16_t num_chunks = TX_TOKEN_NOT_FOUND;

    switch (token_type) {
        case JSMN_OBJECT: {
            const int16_t key_len = strlen(tx_ctx.query.out_key);
            for (int16_t i = 0; i < el_count; ++i) {
c0d03750:	2f01      	cmp	r7, #1
c0d03752:	da00      	bge.n	c0d03756 <tx_traverse+0xd2>
c0d03754:	e0bb      	b.n	c0d038ce <tx_traverse+0x24a>
c0d03756:	9603      	str	r6, [sp, #12]
    const int16_t el_count = object_get_element_count(root_token_index, parsing_context.parsed_tx);
    int16_t num_chunks = TX_TOKEN_NOT_FOUND;

    switch (token_type) {
        case JSMN_OBJECT: {
            const int16_t key_len = strlen(tx_ctx.query.out_key);
c0d03758:	6868      	ldr	r0, [r5, #4]
c0d0375a:	f002 fe91 	bl	c0d06480 <strlen>
c0d0375e:	b200      	sxth	r0, r0
c0d03760:	9001      	str	r0, [sp, #4]
c0d03762:	2100      	movs	r1, #0
c0d03764:	9702      	str	r7, [sp, #8]
c0d03766:	485c      	ldr	r0, [pc, #368]	; (c0d038d8 <tx_traverse+0x254>)
c0d03768:	4607      	mov	r7, r0
            for (int16_t i = 0; i < el_count; ++i) {
                const int16_t key_index = object_get_nth_key(root_token_index, i, parsing_context.parsed_tx);
c0d0376a:	683a      	ldr	r2, [r7, #0]
c0d0376c:	9108      	str	r1, [sp, #32]
c0d0376e:	b28e      	uxth	r6, r1
c0d03770:	9c03      	ldr	r4, [sp, #12]
c0d03772:	4620      	mov	r0, r4
c0d03774:	4631      	mov	r1, r6
c0d03776:	f7fd ffa5 	bl	c0d016c4 <object_get_nth_key>
c0d0377a:	9007      	str	r0, [sp, #28]
                const int16_t value_index = object_get_nth_value(root_token_index, i, parsing_context.parsed_tx);
c0d0377c:	683a      	ldr	r2, [r7, #0]
c0d0377e:	4620      	mov	r0, r4
c0d03780:	4631      	mov	r1, r6
c0d03782:	f7fd ffcf 	bl	c0d01724 <object_get_nth_value>
c0d03786:	4601      	mov	r1, r0

                // Skip writing keys if we are actually exploring to count
                if (tx_ctx.query.item_index != TX_TOKEN_NOT_FOUND) {
c0d03788:	8828      	ldrh	r0, [r5, #0]
c0d0378a:	9e0a      	ldr	r6, [sp, #40]	; 0x28
c0d0378c:	42b0      	cmp	r0, r6
c0d0378e:	d059      	beq.n	c0d03844 <tx_traverse+0x1c0>
c0d03790:	9104      	str	r1, [sp, #16]
c0d03792:	2300      	movs	r3, #0
c0d03794:	43d8      	mvns	r0, r3
    return num_chunks;
}

///// Update key characters from json transaction read from the token_index element.
__always_inline void append_key_item(int16_t token_index) {
    if (*tx_ctx.query.out_key > 0) {
c0d03796:	9005      	str	r0, [sp, #20]
c0d03798:	686f      	ldr	r7, [r5, #4]
c0d0379a:	7838      	ldrb	r0, [r7, #0]
c0d0379c:	2800      	cmp	r0, #0
c0d0379e:	9306      	str	r3, [sp, #24]
c0d037a0:	d01b      	beq.n	c0d037da <tx_traverse+0x156>

// strcat but source does not need to be terminated (a chunk from a bigger string is concatenated)
// dst_max is measured in bytes including the space for NULL termination
// src_size does not include NULL termination
__always_inline void strcat_chunk_s(char *dst, uint16_t dst_max, const char *src_chunk, uint16_t src_chunk_size) {
    *(dst + dst_max - 1) = 0;                 // last character terminates with zero in case we go beyond bounds
c0d037a2:	892e      	ldrh	r6, [r5, #8]
c0d037a4:	19b8      	adds	r0, r7, r6
c0d037a6:	9905      	ldr	r1, [sp, #20]
c0d037a8:	5443      	strb	r3, [r0, r1]
    const uint16_t prev_size = strlen(dst);
c0d037aa:	4638      	mov	r0, r7
c0d037ac:	f002 fe68 	bl	c0d06480 <strlen>

    uint16_t space_left = dst_max - prev_size - 1;  // -1 because requires termination
c0d037b0:	1a31      	subs	r1, r6, r0
c0d037b2:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d037b4:	18c9      	adds	r1, r1, r3

    if (src_chunk_size > space_left) {
c0d037b6:	2201      	movs	r2, #1
c0d037b8:	4219      	tst	r1, r3
c0d037ba:	d000      	beq.n	c0d037be <tx_traverse+0x13a>
c0d037bc:	4611      	mov	r1, r2
c0d037be:	b28e      	uxth	r6, r1
        src_chunk_size = space_left;
    }

    if (src_chunk_size > 0) {
c0d037c0:	2e00      	cmp	r6, #0
c0d037c2:	9b06      	ldr	r3, [sp, #24]
c0d037c4:	d009      	beq.n	c0d037da <tx_traverse+0x156>
// src_size does not include NULL termination
__always_inline void strcat_chunk_s(char *dst, uint16_t dst_max, const char *src_chunk, uint16_t src_chunk_size) {
    *(dst + dst_max - 1) = 0;                 // last character terminates with zero in case we go beyond bounds
    const uint16_t prev_size = strlen(dst);

    uint16_t space_left = dst_max - prev_size - 1;  // -1 because requires termination
c0d037c6:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d037c8:	4008      	ands	r0, r1
        src_chunk_size = space_left;
    }

    if (src_chunk_size > 0) {
        // Check bounds
        COPYFUNC(dst + prev_size, src_chunk, src_chunk_size);
c0d037ca:	183f      	adds	r7, r7, r0
c0d037cc:	4638      	mov	r0, r7
c0d037ce:	a145      	add	r1, pc, #276	; (adr r1, c0d038e4 <tx_traverse+0x260>)
c0d037d0:	4632      	mov	r2, r6
c0d037d2:	f7fe f8bc 	bl	c0d0194e <os_memmove>
c0d037d6:	9b06      	ldr	r3, [sp, #24]
        // terminate
        *(dst + prev_size + src_chunk_size) = 0;
c0d037d8:	55bb      	strb	r3, [r7, r6]
    if (*tx_ctx.query.out_key > 0) {
        // There is already something there, add separator
        strcat_chunk_s(tx_ctx.query.out_key, tx_ctx.query.out_key_len, "/", 1);
    }

    const int16_t token_start = parsing_context.parsed_tx->Tokens[token_index].start;
c0d037da:	9807      	ldr	r0, [sp, #28]
c0d037dc:	00c0      	lsls	r0, r0, #3
c0d037de:	493e      	ldr	r1, [pc, #248]	; (c0d038d8 <tx_traverse+0x254>)
c0d037e0:	460a      	mov	r2, r1
c0d037e2:	6811      	ldr	r1, [r2, #0]
c0d037e4:	1808      	adds	r0, r1, r0
c0d037e6:	2106      	movs	r1, #6
    const int16_t token_end = parsing_context.parsed_tx->Tokens[token_index].end;
    const char *address_ptr = parsing_context.tx + token_start;
c0d037e8:	5e46      	ldrsh	r6, [r0, r1]
    const int16_t new_item_size = token_end - token_start;
c0d037ea:	8904      	ldrh	r4, [r0, #8]

// strcat but source does not need to be terminated (a chunk from a bigger string is concatenated)
// dst_max is measured in bytes including the space for NULL termination
// src_size does not include NULL termination
__always_inline void strcat_chunk_s(char *dst, uint16_t dst_max, const char *src_chunk, uint16_t src_chunk_size) {
    *(dst + dst_max - 1) = 0;                 // last character terminates with zero in case we go beyond bounds
c0d037ec:	892f      	ldrh	r7, [r5, #8]
    const int16_t token_start = parsing_context.parsed_tx->Tokens[token_index].start;
    const int16_t token_end = parsing_context.parsed_tx->Tokens[token_index].end;
    const char *address_ptr = parsing_context.tx + token_start;
    const int16_t new_item_size = token_end - token_start;

    strcat_chunk_s(tx_ctx.query.out_key, tx_ctx.query.out_key_len, address_ptr, new_item_size);
c0d037ee:	6868      	ldr	r0, [r5, #4]

// strcat but source does not need to be terminated (a chunk from a bigger string is concatenated)
// dst_max is measured in bytes including the space for NULL termination
// src_size does not include NULL termination
__always_inline void strcat_chunk_s(char *dst, uint16_t dst_max, const char *src_chunk, uint16_t src_chunk_size) {
    *(dst + dst_max - 1) = 0;                 // last character terminates with zero in case we go beyond bounds
c0d037f0:	19c1      	adds	r1, r0, r7
        strcat_chunk_s(tx_ctx.query.out_key, tx_ctx.query.out_key_len, "/", 1);
    }

    const int16_t token_start = parsing_context.parsed_tx->Tokens[token_index].start;
    const int16_t token_end = parsing_context.parsed_tx->Tokens[token_index].end;
    const char *address_ptr = parsing_context.tx + token_start;
c0d037f2:	6892      	ldr	r2, [r2, #8]

// strcat but source does not need to be terminated (a chunk from a bigger string is concatenated)
// dst_max is measured in bytes including the space for NULL termination
// src_size does not include NULL termination
__always_inline void strcat_chunk_s(char *dst, uint16_t dst_max, const char *src_chunk, uint16_t src_chunk_size) {
    *(dst + dst_max - 1) = 0;                 // last character terminates with zero in case we go beyond bounds
c0d037f4:	9200      	str	r2, [sp, #0]
c0d037f6:	9a05      	ldr	r2, [sp, #20]
c0d037f8:	548b      	strb	r3, [r1, r2]
c0d037fa:	9607      	str	r6, [sp, #28]
    }

    const int16_t token_start = parsing_context.parsed_tx->Tokens[token_index].start;
    const int16_t token_end = parsing_context.parsed_tx->Tokens[token_index].end;
    const char *address_ptr = parsing_context.tx + token_start;
    const int16_t new_item_size = token_end - token_start;
c0d037fc:	1ba6      	subs	r6, r4, r6
c0d037fe:	4634      	mov	r4, r6
c0d03800:	9d0a      	ldr	r5, [sp, #40]	; 0x28
    *(dst + dst_max - 1) = 0;                 // last character terminates with zero in case we go beyond bounds
    const uint16_t prev_size = strlen(dst);

    uint16_t space_left = dst_max - prev_size - 1;  // -1 because requires termination

    if (src_chunk_size > space_left) {
c0d03802:	402e      	ands	r6, r5
c0d03804:	9005      	str	r0, [sp, #20]
// strcat but source does not need to be terminated (a chunk from a bigger string is concatenated)
// dst_max is measured in bytes including the space for NULL termination
// src_size does not include NULL termination
__always_inline void strcat_chunk_s(char *dst, uint16_t dst_max, const char *src_chunk, uint16_t src_chunk_size) {
    *(dst + dst_max - 1) = 0;                 // last character terminates with zero in case we go beyond bounds
    const uint16_t prev_size = strlen(dst);
c0d03806:	f002 fe3b 	bl	c0d06480 <strlen>

    uint16_t space_left = dst_max - prev_size - 1;  // -1 because requires termination
c0d0380a:	1a39      	subs	r1, r7, r0
c0d0380c:	1949      	adds	r1, r1, r5

    if (src_chunk_size > space_left) {
c0d0380e:	460a      	mov	r2, r1
c0d03810:	402a      	ands	r2, r5
c0d03812:	4296      	cmp	r6, r2
c0d03814:	d800      	bhi.n	c0d03818 <tx_traverse+0x194>
c0d03816:	4621      	mov	r1, r4
        src_chunk_size = space_left;
    }

    if (src_chunk_size > 0) {
c0d03818:	460f      	mov	r7, r1
c0d0381a:	9e0a      	ldr	r6, [sp, #40]	; 0x28
c0d0381c:	4037      	ands	r7, r6
c0d0381e:	4a30      	ldr	r2, [pc, #192]	; (c0d038e0 <tx_traverse+0x25c>)
c0d03820:	4211      	tst	r1, r2
c0d03822:	4d2e      	ldr	r5, [pc, #184]	; (c0d038dc <tx_traverse+0x258>)
c0d03824:	9904      	ldr	r1, [sp, #16]
c0d03826:	d00d      	beq.n	c0d03844 <tx_traverse+0x1c0>
        strcat_chunk_s(tx_ctx.query.out_key, tx_ctx.query.out_key_len, "/", 1);
    }

    const int16_t token_start = parsing_context.parsed_tx->Tokens[token_index].start;
    const int16_t token_end = parsing_context.parsed_tx->Tokens[token_index].end;
    const char *address_ptr = parsing_context.tx + token_start;
c0d03828:	9907      	ldr	r1, [sp, #28]
c0d0382a:	9a00      	ldr	r2, [sp, #0]
c0d0382c:	1851      	adds	r1, r2, r1
// src_size does not include NULL termination
__always_inline void strcat_chunk_s(char *dst, uint16_t dst_max, const char *src_chunk, uint16_t src_chunk_size) {
    *(dst + dst_max - 1) = 0;                 // last character terminates with zero in case we go beyond bounds
    const uint16_t prev_size = strlen(dst);

    uint16_t space_left = dst_max - prev_size - 1;  // -1 because requires termination
c0d0382e:	4030      	ands	r0, r6
        src_chunk_size = space_left;
    }

    if (src_chunk_size > 0) {
        // Check bounds
        COPYFUNC(dst + prev_size, src_chunk, src_chunk_size);
c0d03830:	9a05      	ldr	r2, [sp, #20]
c0d03832:	1816      	adds	r6, r2, r0
c0d03834:	4630      	mov	r0, r6
c0d03836:	463a      	mov	r2, r7
c0d03838:	f7fe f889 	bl	c0d0194e <os_memmove>
c0d0383c:	9904      	ldr	r1, [sp, #16]
        // terminate
        *(dst + prev_size + src_chunk_size) = 0;
c0d0383e:	9806      	ldr	r0, [sp, #24]
c0d03840:	55f0      	strb	r0, [r6, r7]
c0d03842:	9e0a      	ldr	r6, [sp, #40]	; 0x28
                if (tx_ctx.query.item_index != TX_TOKEN_NOT_FOUND) {
                    append_key_item(key_index);
                }

                // When traversing objects both level and depth should be considered
                tx_ctx.max_level--;
c0d03844:	7da8      	ldrb	r0, [r5, #22]
c0d03846:	1e40      	subs	r0, r0, #1
c0d03848:	75a8      	strb	r0, [r5, #22]
                tx_ctx.max_depth--;
c0d0384a:	7de8      	ldrb	r0, [r5, #23]
c0d0384c:	1e40      	subs	r0, r0, #1
c0d0384e:	75e8      	strb	r0, [r5, #23]
                num_chunks = tx_traverse(value_index);       // Traverse the value, extracting subkeys
c0d03850:	4608      	mov	r0, r1
c0d03852:	f7ff ff17 	bl	c0d03684 <tx_traverse>
                tx_ctx.max_level++;
c0d03856:	7da9      	ldrb	r1, [r5, #22]
c0d03858:	1c49      	adds	r1, r1, #1
c0d0385a:	75a9      	strb	r1, [r5, #22]
                tx_ctx.max_depth++;
c0d0385c:	7de9      	ldrb	r1, [r5, #23]
c0d0385e:	1c49      	adds	r1, r1, #1
c0d03860:	75e9      	strb	r1, [r5, #23]
                }

                // When traversing objects both level and depth should be considered
                tx_ctx.max_level--;
                tx_ctx.max_depth--;
                num_chunks = tx_traverse(value_index);       // Traverse the value, extracting subkeys
c0d03862:	b281      	uxth	r1, r0
                tx_ctx.max_level++;
                tx_ctx.max_depth++;

                if (num_chunks != TX_TOKEN_NOT_FOUND) {
c0d03864:	42b1      	cmp	r1, r6
c0d03866:	9f02      	ldr	r7, [sp, #8]
c0d03868:	d130      	bne.n	c0d038cc <tx_traverse+0x248>
                    break;
                }

                *(tx_ctx.query.out_key + key_len) = 0;
c0d0386a:	6868      	ldr	r0, [r5, #4]
c0d0386c:	2100      	movs	r1, #0
c0d0386e:	9a01      	ldr	r2, [sp, #4]
c0d03870:	5481      	strb	r1, [r0, r2]
    int16_t num_chunks = TX_TOKEN_NOT_FOUND;

    switch (token_type) {
        case JSMN_OBJECT: {
            const int16_t key_len = strlen(tx_ctx.query.out_key);
            for (int16_t i = 0; i < el_count; ++i) {
c0d03872:	9808      	ldr	r0, [sp, #32]
c0d03874:	1c40      	adds	r0, r0, #1
c0d03876:	b201      	sxth	r1, r0
c0d03878:	42b9      	cmp	r1, r7
c0d0387a:	da28      	bge.n	c0d038ce <tx_traverse+0x24a>
c0d0387c:	e773      	b.n	c0d03766 <tx_traverse+0xe2>
c0d0387e:	4616      	mov	r6, r2

    int16_t num_chunks = (token_len / (tx_ctx.query.out_val_len - 1)) + 1;
    if (token_len > 0 && (token_len % (tx_ctx.query.out_val_len - 1) == 0))
        num_chunks--;

    tx_ctx.query.out_val[0] = '\0';  // flush
c0d03880:	68e8      	ldr	r0, [r5, #12]
c0d03882:	2700      	movs	r7, #0
c0d03884:	7007      	strb	r7, [r0, #0]
    if (tx_ctx.query.chunk_index >= num_chunks) {
c0d03886:	2002      	movs	r0, #2
c0d03888:	5e29      	ldrsh	r1, [r5, r0]
c0d0388a:	b230      	sxth	r0, r6
c0d0388c:	4281      	cmp	r1, r0
c0d0388e:	da1e      	bge.n	c0d038ce <tx_traverse+0x24a>
        return TX_TOKEN_NOT_FOUND;
    }

    const int16_t chunk_start = token_start + tx_ctx.query.chunk_index * (tx_ctx.query.out_val_len - 1);
c0d03890:	9806      	ldr	r0, [sp, #24]
c0d03892:	5e2a      	ldrsh	r2, [r5, r0]
c0d03894:	1e50      	subs	r0, r2, #1
c0d03896:	4341      	muls	r1, r0
c0d03898:	9b07      	ldr	r3, [sp, #28]
c0d0389a:	18c9      	adds	r1, r1, r3
    int16_t chunk_len = token_end - chunk_start;
c0d0389c:	b209      	sxth	r1, r1
c0d0389e:	9b08      	ldr	r3, [sp, #32]
c0d038a0:	1a5b      	subs	r3, r3, r1

    if (chunk_len < 0) {
c0d038a2:	2401      	movs	r4, #1
c0d038a4:	03e4      	lsls	r4, r4, #15
c0d038a6:	4223      	tst	r3, r4
c0d038a8:	d111      	bne.n	c0d038ce <tx_traverse+0x24a>
    }

    if (chunk_len > tx_ctx.query.out_val_len - 1) {
        chunk_len = tx_ctx.query.out_val_len - 1;
    }
    COPYFUNC(tx_ctx.query.out_val, parsing_context.tx + chunk_start, chunk_len);
c0d038aa:	4c0b      	ldr	r4, [pc, #44]	; (c0d038d8 <tx_traverse+0x254>)
c0d038ac:	68a4      	ldr	r4, [r4, #8]
c0d038ae:	1861      	adds	r1, r4, r1
c0d038b0:	9c0a      	ldr	r4, [sp, #40]	; 0x28
c0d038b2:	401c      	ands	r4, r3

    if (chunk_len < 0) {
        return TX_TOKEN_NOT_FOUND;
    }

    if (chunk_len > tx_ctx.query.out_val_len - 1) {
c0d038b4:	4294      	cmp	r4, r2
c0d038b6:	db00      	blt.n	c0d038ba <tx_traverse+0x236>
c0d038b8:	4603      	mov	r3, r0
        chunk_len = tx_ctx.query.out_val_len - 1;
    }
    COPYFUNC(tx_ctx.query.out_val, parsing_context.tx + chunk_start, chunk_len);
c0d038ba:	b21c      	sxth	r4, r3
c0d038bc:	68e8      	ldr	r0, [r5, #12]
c0d038be:	4622      	mov	r2, r4
c0d038c0:	f7fe f845 	bl	c0d0194e <os_memmove>
    tx_ctx.query.out_val[chunk_len] = 0;
c0d038c4:	68e8      	ldr	r0, [r5, #12]
c0d038c6:	5507      	strb	r7, [r0, r4]
c0d038c8:	9609      	str	r6, [sp, #36]	; 0x24
c0d038ca:	e000      	b.n	c0d038ce <tx_traverse+0x24a>
c0d038cc:	9009      	str	r0, [sp, #36]	; 0x24
        default:
            break;
    }

    return num_chunks;
}
c0d038ce:	9809      	ldr	r0, [sp, #36]	; 0x24
c0d038d0:	b200      	sxth	r0, r0
c0d038d2:	b00b      	add	sp, #44	; 0x2c
c0d038d4:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d038d6:	46c0      	nop			; (mov r8, r8)
c0d038d8:	20002130 	.word	0x20002130
c0d038dc:	20002140 	.word	0x20002140
c0d038e0:	0000ffff 	.word	0x0000ffff
c0d038e4:	0000002f 	.word	0x0000002f

c0d038e8 <contains_whitespace>:
        }
    }
    return 0;
}

int8_t contains_whitespace(parsed_json_t *parsed_transaction, const char *transaction) {
c0d038e8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d038ea:	b087      	sub	sp, #28
c0d038ec:	9106      	str	r1, [sp, #24]
    int start = 0;
    const int last_element_index = parsed_transaction->Tokens[0].end;
c0d038ee:	2608      	movs	r6, #8
c0d038f0:	5f82      	ldrsh	r2, [r0, r6]

    // Starting at token 1 because token 0 contains full tx
    for (int i = 1; i < parsed_transaction->NumberOfTokens; i++) {
c0d038f2:	8847      	ldrh	r7, [r0, #2]
c0d038f4:	2500      	movs	r5, #0
c0d038f6:	2f02      	cmp	r7, #2
c0d038f8:	9505      	str	r5, [sp, #20]
c0d038fa:	d327      	bcc.n	c0d0394c <contains_whitespace+0x64>
c0d038fc:	2500      	movs	r5, #0
c0d038fe:	2401      	movs	r4, #1
c0d03900:	9500      	str	r5, [sp, #0]
        if (parsed_transaction->Tokens[i].type != JSMN_UNDEFINED) {
c0d03902:	00e1      	lsls	r1, r4, #3
c0d03904:	1843      	adds	r3, r0, r1
c0d03906:	7919      	ldrb	r1, [r3, #4]
c0d03908:	2900      	cmp	r1, #0
c0d0390a:	d038      	beq.n	c0d0397e <contains_whitespace+0x96>
            const int end = parsed_transaction->Tokens[i].start;
c0d0390c:	2106      	movs	r1, #6
c0d0390e:	5e59      	ldrsh	r1, [r3, r1]
            for (int j = start; j < end; j++) {
c0d03910:	428d      	cmp	r5, r1
c0d03912:	da16      	bge.n	c0d03942 <contains_whitespace+0x5a>
c0d03914:	9204      	str	r2, [sp, #16]
c0d03916:	9603      	str	r6, [sp, #12]
c0d03918:	9702      	str	r7, [sp, #8]
c0d0391a:	9101      	str	r1, [sp, #4]
                if (is_space(transaction[j]) == 1) {
c0d0391c:	9906      	ldr	r1, [sp, #24]
c0d0391e:	5d49      	ldrb	r1, [r1, r5]
c0d03920:	2700      	movs	r7, #0
        0x0b // vertical_tab, '\v'
};

int8_t is_space(char c) {
    for (uint16_t i = 0; i < sizeof(whitespaces); i++) {
        if (whitespaces[i] == c) {
c0d03922:	4a19      	ldr	r2, [pc, #100]	; (c0d03988 <contains_whitespace+0xa0>)
c0d03924:	447a      	add	r2, pc
c0d03926:	5dd6      	ldrb	r6, [r2, r7]
        0x09, // horizontal_tab, '\t'
        0x0b // vertical_tab, '\v'
};

int8_t is_space(char c) {
    for (uint16_t i = 0; i < sizeof(whitespaces); i++) {
c0d03928:	1c7f      	adds	r7, r7, #1
c0d0392a:	2201      	movs	r2, #1
        if (whitespaces[i] == c) {
c0d0392c:	428e      	cmp	r6, r1
c0d0392e:	d027      	beq.n	c0d03980 <contains_whitespace+0x98>
        0x09, // horizontal_tab, '\t'
        0x0b // vertical_tab, '\v'
};

int8_t is_space(char c) {
    for (uint16_t i = 0; i < sizeof(whitespaces); i++) {
c0d03930:	2f05      	cmp	r7, #5
c0d03932:	d9f6      	bls.n	c0d03922 <contains_whitespace+0x3a>

    // Starting at token 1 because token 0 contains full tx
    for (int i = 1; i < parsed_transaction->NumberOfTokens; i++) {
        if (parsed_transaction->Tokens[i].type != JSMN_UNDEFINED) {
            const int end = parsed_transaction->Tokens[i].start;
            for (int j = start; j < end; j++) {
c0d03934:	1c6d      	adds	r5, r5, #1
c0d03936:	9901      	ldr	r1, [sp, #4]
c0d03938:	428d      	cmp	r5, r1
c0d0393a:	9a04      	ldr	r2, [sp, #16]
c0d0393c:	9e03      	ldr	r6, [sp, #12]
c0d0393e:	9f02      	ldr	r7, [sp, #8]
c0d03940:	dbec      	blt.n	c0d0391c <contains_whitespace+0x34>
                if (is_space(transaction[j]) == 1) {
                    return 1;
                }
            }
            start = parsed_transaction->Tokens[i].end + 1;
c0d03942:	5f99      	ldrsh	r1, [r3, r6]
c0d03944:	1c4d      	adds	r5, r1, #1
int8_t contains_whitespace(parsed_json_t *parsed_transaction, const char *transaction) {
    int start = 0;
    const int last_element_index = parsed_transaction->Tokens[0].end;

    // Starting at token 1 because token 0 contains full tx
    for (int i = 1; i < parsed_transaction->NumberOfTokens; i++) {
c0d03946:	1c64      	adds	r4, r4, #1
c0d03948:	42bc      	cmp	r4, r7
c0d0394a:	dbda      	blt.n	c0d03902 <contains_whitespace+0x1a>
            start = parsed_transaction->Tokens[i].end + 1;
        } else {
            return 0;
        }
    }
    while (start <= last_element_index && transaction[start] != '\0') {
c0d0394c:	4295      	cmp	r5, r2
c0d0394e:	dd01      	ble.n	c0d03954 <contains_whitespace+0x6c>
c0d03950:	9a05      	ldr	r2, [sp, #20]
c0d03952:	e015      	b.n	c0d03980 <contains_whitespace+0x98>
c0d03954:	4616      	mov	r6, r2
c0d03956:	480d      	ldr	r0, [pc, #52]	; (c0d0398c <contains_whitespace+0xa4>)
c0d03958:	4478      	add	r0, pc
c0d0395a:	9906      	ldr	r1, [sp, #24]
c0d0395c:	5d49      	ldrb	r1, [r1, r5]
c0d0395e:	2900      	cmp	r1, #0
c0d03960:	d0f6      	beq.n	c0d03950 <contains_whitespace+0x68>
c0d03962:	2300      	movs	r3, #0
        0x0b // vertical_tab, '\v'
};

int8_t is_space(char c) {
    for (uint16_t i = 0; i < sizeof(whitespaces); i++) {
        if (whitespaces[i] == c) {
c0d03964:	5cc4      	ldrb	r4, [r0, r3]
        0x09, // horizontal_tab, '\t'
        0x0b // vertical_tab, '\v'
};

int8_t is_space(char c) {
    for (uint16_t i = 0; i < sizeof(whitespaces); i++) {
c0d03966:	1c5b      	adds	r3, r3, #1
c0d03968:	2201      	movs	r2, #1
        if (whitespaces[i] == c) {
c0d0396a:	428c      	cmp	r4, r1
c0d0396c:	d008      	beq.n	c0d03980 <contains_whitespace+0x98>
        0x09, // horizontal_tab, '\t'
        0x0b // vertical_tab, '\v'
};

int8_t is_space(char c) {
    for (uint16_t i = 0; i < sizeof(whitespaces); i++) {
c0d0396e:	2b05      	cmp	r3, #5
c0d03970:	d9f8      	bls.n	c0d03964 <contains_whitespace+0x7c>
    }
    while (start <= last_element_index && transaction[start] != '\0') {
        if (is_space(transaction[start])) {
            return 1;
        }
        start++;
c0d03972:	1c69      	adds	r1, r5, #1
c0d03974:	2200      	movs	r2, #0
            start = parsed_transaction->Tokens[i].end + 1;
        } else {
            return 0;
        }
    }
    while (start <= last_element_index && transaction[start] != '\0') {
c0d03976:	42b5      	cmp	r5, r6
c0d03978:	460d      	mov	r5, r1
c0d0397a:	dbee      	blt.n	c0d0395a <contains_whitespace+0x72>
c0d0397c:	e000      	b.n	c0d03980 <contains_whitespace+0x98>
c0d0397e:	9a00      	ldr	r2, [sp, #0]
            return 1;
        }
        start++;
    }
    return 0;
}
c0d03980:	4610      	mov	r0, r2
c0d03982:	b007      	add	sp, #28
c0d03984:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03986:	46c0      	nop			; (mov r8, r8)
c0d03988:	00003db2 	.word	0x00003db2
c0d0398c:	00003d7e 	.word	0x00003d7e

c0d03990 <dictionaries_sorted>:
    }
    return 0;
}

int8_t dictionaries_sorted(parsed_json_t *parsed_transaction,
                           const char *transaction) {
c0d03990:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03992:	b087      	sub	sp, #28
c0d03994:	9103      	str	r1, [sp, #12]
c0d03996:	4606      	mov	r6, r0
    for (int i = 0; i < parsed_transaction->NumberOfTokens; i++) {
c0d03998:	8871      	ldrh	r1, [r6, #2]
c0d0399a:	2001      	movs	r0, #1
c0d0399c:	2900      	cmp	r1, #0
c0d0399e:	d03d      	beq.n	c0d03a1c <dictionaries_sorted+0x8c>
c0d039a0:	9000      	str	r0, [sp, #0]
c0d039a2:	2100      	movs	r1, #0
c0d039a4:	9102      	str	r1, [sp, #8]
        if (parsed_transaction->Tokens[i].type == JSMN_OBJECT) {
c0d039a6:	00c8      	lsls	r0, r1, #3
c0d039a8:	1830      	adds	r0, r6, r0
c0d039aa:	7900      	ldrb	r0, [r0, #4]
c0d039ac:	2801      	cmp	r0, #1
c0d039ae:	d12d      	bne.n	c0d03a0c <dictionaries_sorted+0x7c>

            const int count = object_get_element_count(i, parsed_transaction);
c0d039b0:	9802      	ldr	r0, [sp, #8]
c0d039b2:	b280      	uxth	r0, r0
c0d039b4:	9005      	str	r0, [sp, #20]
c0d039b6:	4631      	mov	r1, r6
c0d039b8:	f7fd fe52 	bl	c0d01660 <object_get_element_count>
c0d039bc:	9004      	str	r0, [sp, #16]
            if (count > 1) {
c0d039be:	2802      	cmp	r0, #2
c0d039c0:	d324      	bcc.n	c0d03a0c <dictionaries_sorted+0x7c>
                int prev_token_index = object_get_nth_key(i, 0, parsed_transaction);
c0d039c2:	2100      	movs	r1, #0
c0d039c4:	9805      	ldr	r0, [sp, #20]
c0d039c6:	9101      	str	r1, [sp, #4]
c0d039c8:	4632      	mov	r2, r6
c0d039ca:	f7fd fe7b 	bl	c0d016c4 <object_get_nth_key>
c0d039ce:	4607      	mov	r7, r0
c0d039d0:	2501      	movs	r5, #1
                for (int j = 1; j < count; j++) {
                    int next_token_index = object_get_nth_key(i, j, parsed_transaction);
c0d039d2:	9706      	str	r7, [sp, #24]
c0d039d4:	b2a9      	uxth	r1, r5
c0d039d6:	9805      	ldr	r0, [sp, #20]
c0d039d8:	4632      	mov	r2, r6
c0d039da:	f7fd fe73 	bl	c0d016c4 <object_get_nth_key>
c0d039de:	4607      	mov	r7, r0
    strncpy(second, tx + parsed_tx->Tokens[second_index].start, size);
    second[size] = '\0';
#endif

    if (strcmp(transaction + parsed_transaction->Tokens[first_index].start,
               transaction + parsed_transaction->Tokens[second_index].start) <= 0) {
c0d039e0:	00f8      	lsls	r0, r7, #3
c0d039e2:	4634      	mov	r4, r6
    size =  parsed_tx->Tokens[second_index].end - parsed_tx->Tokens[second_index].start;
    strncpy(second, tx + parsed_tx->Tokens[second_index].start, size);
    second[size] = '\0';
#endif

    if (strcmp(transaction + parsed_transaction->Tokens[first_index].start,
c0d039e4:	1d32      	adds	r2, r6, #4
               transaction + parsed_transaction->Tokens[second_index].start) <= 0) {
c0d039e6:	1810      	adds	r0, r2, r0
c0d039e8:	2302      	movs	r3, #2
c0d039ea:	5ec0      	ldrsh	r0, [r0, r3]
c0d039ec:	9e03      	ldr	r6, [sp, #12]
c0d039ee:	1831      	adds	r1, r6, r0
    size =  parsed_tx->Tokens[second_index].end - parsed_tx->Tokens[second_index].start;
    strncpy(second, tx + parsed_tx->Tokens[second_index].start, size);
    second[size] = '\0';
#endif

    if (strcmp(transaction + parsed_transaction->Tokens[first_index].start,
c0d039f0:	9806      	ldr	r0, [sp, #24]
c0d039f2:	00c0      	lsls	r0, r0, #3
c0d039f4:	1810      	adds	r0, r2, r0
c0d039f6:	5ec0      	ldrsh	r0, [r0, r3]
c0d039f8:	1830      	adds	r0, r6, r0
c0d039fa:	f002 fcfd 	bl	c0d063f8 <strcmp>
        if (parsed_transaction->Tokens[i].type == JSMN_OBJECT) {

            const int count = object_get_element_count(i, parsed_transaction);
            if (count > 1) {
                int prev_token_index = object_get_nth_key(i, 0, parsed_transaction);
                for (int j = 1; j < count; j++) {
c0d039fe:	1c6d      	adds	r5, r5, #1
c0d03a00:	2800      	cmp	r0, #0
c0d03a02:	dc0a      	bgt.n	c0d03a1a <dictionaries_sorted+0x8a>
c0d03a04:	9804      	ldr	r0, [sp, #16]
c0d03a06:	4285      	cmp	r5, r0
c0d03a08:	4626      	mov	r6, r4
c0d03a0a:	dbe2      	blt.n	c0d039d2 <dictionaries_sorted+0x42>
c0d03a0c:	9902      	ldr	r1, [sp, #8]
    return 0;
}

int8_t dictionaries_sorted(parsed_json_t *parsed_transaction,
                           const char *transaction) {
    for (int i = 0; i < parsed_transaction->NumberOfTokens; i++) {
c0d03a0e:	1c49      	adds	r1, r1, #1
c0d03a10:	8870      	ldrh	r0, [r6, #2]
c0d03a12:	4281      	cmp	r1, r0
c0d03a14:	dbc6      	blt.n	c0d039a4 <dictionaries_sorted+0x14>
c0d03a16:	9800      	ldr	r0, [sp, #0]
c0d03a18:	e000      	b.n	c0d03a1c <dictionaries_sorted+0x8c>
c0d03a1a:	9801      	ldr	r0, [sp, #4]
                }
            }
        }
    }
    return 1;
}
c0d03a1c:	b007      	add	sp, #28
c0d03a1e:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d03a20 <json_validate>:

const char *json_validate(parsed_json_t *parsed_transaction, const char *transaction) {
c0d03a20:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03a22:	b081      	sub	sp, #4
c0d03a24:	460c      	mov	r4, r1
c0d03a26:	4605      	mov	r5, r0
    if (contains_whitespace(parsed_transaction, transaction) == 1) {
c0d03a28:	f7ff ff5e 	bl	c0d038e8 <contains_whitespace>
c0d03a2c:	2801      	cmp	r0, #1
c0d03a2e:	d101      	bne.n	c0d03a34 <json_validate+0x14>
c0d03a30:	a62a      	add	r6, pc, #168	; (adr r6, c0d03adc <json_validate+0xbc>)
c0d03a32:	e011      	b.n	c0d03a58 <json_validate+0x38>
        return "JSON Contains whitespace in the corpus";
    }

    if (dictionaries_sorted(parsed_transaction, transaction) != 1) {
c0d03a34:	4628      	mov	r0, r5
c0d03a36:	4621      	mov	r1, r4
c0d03a38:	f7ff ffaa 	bl	c0d03990 <dictionaries_sorted>
c0d03a3c:	2801      	cmp	r0, #1
c0d03a3e:	d10a      	bne.n	c0d03a56 <json_validate+0x36>
c0d03a40:	2000      	movs	r0, #0
        return "JSON Dictionaries are not sorted";
    }

    if (object_get_value(0,
c0d03a42:	a139      	add	r1, pc, #228	; (adr r1, c0d03b28 <json_validate+0x108>)
c0d03a44:	462a      	mov	r2, r5
c0d03a46:	4623      	mov	r3, r4
c0d03a48:	f7fd fe7c 	bl	c0d01744 <object_get_value>
c0d03a4c:	3001      	adds	r0, #1
    }

    if (object_get_value(0,
                         "memo",
                         parsed_transaction,
                         transaction) == -1) {
c0d03a4e:	4f3f      	ldr	r7, [pc, #252]	; (c0d03b4c <json_validate+0x12c>)
c0d03a50:	d105      	bne.n	c0d03a5e <json_validate+0x3e>
c0d03a52:	a638      	add	r6, pc, #224	; (adr r6, c0d03b34 <json_validate+0x114>)
c0d03a54:	e000      	b.n	c0d03a58 <json_validate+0x38>
c0d03a56:	a62b      	add	r6, pc, #172	; (adr r6, c0d03b04 <json_validate+0xe4>)
        return "JSON Missing memo";
    }

    return NULL;
}
c0d03a58:	4630      	mov	r0, r6
c0d03a5a:	b001      	add	sp, #4
c0d03a5c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03a5e:	2000      	movs	r0, #0
                         parsed_transaction,
                         transaction) == -1) {
        return "JSON Missing chain_id";
    }

    if (object_get_value(0,
c0d03a60:	a13b      	add	r1, pc, #236	; (adr r1, c0d03b50 <json_validate+0x130>)
c0d03a62:	462a      	mov	r2, r5
c0d03a64:	4623      	mov	r3, r4
c0d03a66:	f7fd fe6d 	bl	c0d01744 <object_get_value>
c0d03a6a:	b280      	uxth	r0, r0
c0d03a6c:	42b8      	cmp	r0, r7
c0d03a6e:	d101      	bne.n	c0d03a74 <json_validate+0x54>
c0d03a70:	a63a      	add	r6, pc, #232	; (adr r6, c0d03b5c <json_validate+0x13c>)
c0d03a72:	e7f1      	b.n	c0d03a58 <json_validate+0x38>
c0d03a74:	2000      	movs	r0, #0
                         parsed_transaction,
                         transaction) == -1) {
        return "JSON Missing sequence";
    }

    if (object_get_value(0,
c0d03a76:	a13f      	add	r1, pc, #252	; (adr r1, c0d03b74 <json_validate+0x154>)
c0d03a78:	462a      	mov	r2, r5
c0d03a7a:	4623      	mov	r3, r4
c0d03a7c:	f7fd fe62 	bl	c0d01744 <object_get_value>
c0d03a80:	b280      	uxth	r0, r0
c0d03a82:	42b8      	cmp	r0, r7
c0d03a84:	d102      	bne.n	c0d03a8c <json_validate+0x6c>
c0d03a86:	4e3c      	ldr	r6, [pc, #240]	; (c0d03b78 <json_validate+0x158>)
c0d03a88:	447e      	add	r6, pc
c0d03a8a:	e7e5      	b.n	c0d03a58 <json_validate+0x38>
c0d03a8c:	2000      	movs	r0, #0
                         parsed_transaction,
                         transaction) == -1) {
        return "JSON Missing fee";
    }

    if (object_get_value(0,
c0d03a8e:	493b      	ldr	r1, [pc, #236]	; (c0d03b7c <json_validate+0x15c>)
c0d03a90:	4479      	add	r1, pc
c0d03a92:	462a      	mov	r2, r5
c0d03a94:	4623      	mov	r3, r4
c0d03a96:	f7fd fe55 	bl	c0d01744 <object_get_value>
c0d03a9a:	b280      	uxth	r0, r0
c0d03a9c:	42b8      	cmp	r0, r7
c0d03a9e:	d102      	bne.n	c0d03aa6 <json_validate+0x86>
c0d03aa0:	4e37      	ldr	r6, [pc, #220]	; (c0d03b80 <json_validate+0x160>)
c0d03aa2:	447e      	add	r6, pc
c0d03aa4:	e7d8      	b.n	c0d03a58 <json_validate+0x38>
c0d03aa6:	2000      	movs	r0, #0
                         parsed_transaction,
                         transaction) == -1) {
        return "JSON Missing msgs";
    }

    if (object_get_value(0,
c0d03aa8:	4936      	ldr	r1, [pc, #216]	; (c0d03b84 <json_validate+0x164>)
c0d03aaa:	4479      	add	r1, pc
c0d03aac:	462a      	mov	r2, r5
c0d03aae:	4623      	mov	r3, r4
c0d03ab0:	f7fd fe48 	bl	c0d01744 <object_get_value>
c0d03ab4:	b280      	uxth	r0, r0
c0d03ab6:	42b8      	cmp	r0, r7
c0d03ab8:	d102      	bne.n	c0d03ac0 <json_validate+0xa0>
c0d03aba:	4e33      	ldr	r6, [pc, #204]	; (c0d03b88 <json_validate+0x168>)
c0d03abc:	447e      	add	r6, pc
c0d03abe:	e7cb      	b.n	c0d03a58 <json_validate+0x38>
c0d03ac0:	2600      	movs	r6, #0
                         parsed_transaction,
                         transaction) == -1) {
        return "JSON Missing account_number";
    }

    if (object_get_value(0,
c0d03ac2:	4932      	ldr	r1, [pc, #200]	; (c0d03b8c <json_validate+0x16c>)
c0d03ac4:	4479      	add	r1, pc
c0d03ac6:	4630      	mov	r0, r6
c0d03ac8:	462a      	mov	r2, r5
c0d03aca:	4623      	mov	r3, r4
c0d03acc:	f7fd fe3a 	bl	c0d01744 <object_get_value>
c0d03ad0:	b280      	uxth	r0, r0
                         "memo",
                         parsed_transaction,
                         transaction) == -1) {
        return "JSON Missing memo";
c0d03ad2:	42b8      	cmp	r0, r7
c0d03ad4:	d1c0      	bne.n	c0d03a58 <json_validate+0x38>
c0d03ad6:	4e2e      	ldr	r6, [pc, #184]	; (c0d03b90 <json_validate+0x170>)
c0d03ad8:	447e      	add	r6, pc
c0d03ada:	e7bd      	b.n	c0d03a58 <json_validate+0x38>
c0d03adc:	4e4f534a 	.word	0x4e4f534a
c0d03ae0:	6e6f4320 	.word	0x6e6f4320
c0d03ae4:	6e696174 	.word	0x6e696174
c0d03ae8:	68772073 	.word	0x68772073
c0d03aec:	73657469 	.word	0x73657469
c0d03af0:	65636170 	.word	0x65636170
c0d03af4:	206e6920 	.word	0x206e6920
c0d03af8:	20656874 	.word	0x20656874
c0d03afc:	70726f63 	.word	0x70726f63
c0d03b00:	00007375 	.word	0x00007375
c0d03b04:	4e4f534a 	.word	0x4e4f534a
c0d03b08:	63694420 	.word	0x63694420
c0d03b0c:	6e6f6974 	.word	0x6e6f6974
c0d03b10:	65697261 	.word	0x65697261
c0d03b14:	72612073 	.word	0x72612073
c0d03b18:	6f6e2065 	.word	0x6f6e2065
c0d03b1c:	6f732074 	.word	0x6f732074
c0d03b20:	64657472 	.word	0x64657472
c0d03b24:	00000000 	.word	0x00000000
c0d03b28:	69616863 	.word	0x69616863
c0d03b2c:	64695f6e 	.word	0x64695f6e
c0d03b30:	00000000 	.word	0x00000000
c0d03b34:	4e4f534a 	.word	0x4e4f534a
c0d03b38:	73694d20 	.word	0x73694d20
c0d03b3c:	676e6973 	.word	0x676e6973
c0d03b40:	61686320 	.word	0x61686320
c0d03b44:	695f6e69 	.word	0x695f6e69
c0d03b48:	00000064 	.word	0x00000064
c0d03b4c:	0000ffff 	.word	0x0000ffff
c0d03b50:	75716573 	.word	0x75716573
c0d03b54:	65636e65 	.word	0x65636e65
c0d03b58:	00000000 	.word	0x00000000
c0d03b5c:	4e4f534a 	.word	0x4e4f534a
c0d03b60:	73694d20 	.word	0x73694d20
c0d03b64:	676e6973 	.word	0x676e6973
c0d03b68:	71657320 	.word	0x71657320
c0d03b6c:	636e6575 	.word	0x636e6575
c0d03b70:	00000065 	.word	0x00000065
c0d03b74:	00656566 	.word	0x00656566
c0d03b78:	00003c54 	.word	0x00003c54
c0d03b7c:	00003c6a 	.word	0x00003c6a
c0d03b80:	00003c4b 	.word	0x00003c4b
c0d03b84:	00003c62 	.word	0x00003c62
c0d03b88:	00003c43 	.word	0x00003c43
c0d03b8c:	00003c64 	.word	0x00003c64
c0d03b90:	00003c43 	.word	0x00003c43

c0d03b94 <u2f_apdu_sign>:

    u2f_message_reply(service, U2F_CMD_MSG, (uint8_t *)SW_INTERNAL, sizeof(SW_INTERNAL));
}

void u2f_apdu_sign(u2f_service_t *service, uint8_t p1, uint8_t p2,
                     uint8_t *buffer, uint16_t length) {
c0d03b94:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03b96:	b085      	sub	sp, #20
    UNUSED(p2);
    uint8_t keyHandleLength;
    uint8_t i;

    // can't process the apdu if another one is already scheduled in
    if (G_io_apdu_state != APDU_IDLE) {
c0d03b98:	4a34      	ldr	r2, [pc, #208]	; (c0d03c6c <u2f_apdu_sign+0xd8>)
c0d03b9a:	7812      	ldrb	r2, [r2, #0]
    for (i = 0; i < keyHandleLength; i++) {
        buffer[U2F_HANDLE_SIGN_HEADER_SIZE + i] ^= U2F_PROXY_MAGIC[i % (sizeof(U2F_PROXY_MAGIC)-1)];
    }
    // Check that it looks like an APDU
    if (length != U2F_HANDLE_SIGN_HEADER_SIZE + 5 + buffer[U2F_HANDLE_SIGN_HEADER_SIZE + 4]) {
        u2f_message_reply(service, U2F_CMD_MSG,
c0d03b9c:	2483      	movs	r4, #131	; 0x83
    UNUSED(p2);
    uint8_t keyHandleLength;
    uint8_t i;

    // can't process the apdu if another one is already scheduled in
    if (G_io_apdu_state != APDU_IDLE) {
c0d03b9e:	2a00      	cmp	r2, #0
c0d03ba0:	d002      	beq.n	c0d03ba8 <u2f_apdu_sign+0x14>
        u2f_message_reply(service, U2F_CMD_MSG,
c0d03ba2:	4a3b      	ldr	r2, [pc, #236]	; (c0d03c90 <u2f_apdu_sign+0xfc>)
c0d03ba4:	447a      	add	r2, pc
c0d03ba6:	e009      	b.n	c0d03bbc <u2f_apdu_sign+0x28>
c0d03ba8:	9a0a      	ldr	r2, [sp, #40]	; 0x28
                  (uint8_t *)SW_BUSY,
                  sizeof(SW_BUSY));
        return;        
    }

    if (length < U2F_HANDLE_SIGN_HEADER_SIZE + 5 /*at least an apdu header*/) {
c0d03baa:	2a45      	cmp	r2, #69	; 0x45
c0d03bac:	d802      	bhi.n	c0d03bb4 <u2f_apdu_sign+0x20>
        u2f_message_reply(service, U2F_CMD_MSG,
c0d03bae:	4a39      	ldr	r2, [pc, #228]	; (c0d03c94 <u2f_apdu_sign+0x100>)
c0d03bb0:	447a      	add	r2, pc
c0d03bb2:	e003      	b.n	c0d03bbc <u2f_apdu_sign+0x28>
                  sizeof(SW_WRONG_LENGTH));
        return;
    }
    
    // Confirm immediately if it's just a validation call
    if (p1 == P1_SIGN_CHECK_ONLY) {
c0d03bb4:	2907      	cmp	r1, #7
c0d03bb6:	d107      	bne.n	c0d03bc8 <u2f_apdu_sign+0x34>
        u2f_message_reply(service, U2F_CMD_MSG,
c0d03bb8:	4a37      	ldr	r2, [pc, #220]	; (c0d03c98 <u2f_apdu_sign+0x104>)
c0d03bba:	447a      	add	r2, pc
c0d03bbc:	2302      	movs	r3, #2
c0d03bbe:	4621      	mov	r1, r4
c0d03bc0:	f000 fcb3 	bl	c0d0452a <u2f_message_reply>
    app_dispatch();
    if ((btchip_context_D.io_flags & IO_ASYNCH_REPLY) == 0) {
        u2f_proxy_response(service, btchip_context_D.outLength);
    }
    */
}
c0d03bc4:	b005      	add	sp, #20
c0d03bc6:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03bc8:	9202      	str	r2, [sp, #8]
c0d03bca:	9401      	str	r4, [sp, #4]
c0d03bcc:	9003      	str	r0, [sp, #12]
                  sizeof(SW_PROOF_OF_PRESENCE_REQUIRED));
        return;
    }

    // Unwrap magic
    keyHandleLength = buffer[U2F_HANDLE_SIGN_HEADER_SIZE-1];
c0d03bce:	2040      	movs	r0, #64	; 0x40
c0d03bd0:	9304      	str	r3, [sp, #16]
c0d03bd2:	5c1f      	ldrb	r7, [r3, r0]
    
    // reply to the "get magic" question of the host
    if (keyHandleLength == 5) {
c0d03bd4:	2f00      	cmp	r7, #0
c0d03bd6:	d018      	beq.n	c0d03c0a <u2f_apdu_sign+0x76>
c0d03bd8:	2f05      	cmp	r7, #5
c0d03bda:	9e04      	ldr	r6, [sp, #16]
c0d03bdc:	d107      	bne.n	c0d03bee <u2f_apdu_sign+0x5a>
        // GET U2F PROXY PARAMETERS
        // this apdu is not subject to proxy magic masking
        // APDU is F1 D0 00 00 00 to get the magic proxy
        // RAPDU: <>
        if (os_memcmp(buffer+U2F_HANDLE_SIGN_HEADER_SIZE, "\xF1\xD0\x00\x00\x00", 5) == 0 ) {
c0d03bde:	4630      	mov	r0, r6
c0d03be0:	3041      	adds	r0, #65	; 0x41
c0d03be2:	a123      	add	r1, pc, #140	; (adr r1, c0d03c70 <u2f_apdu_sign+0xdc>)
c0d03be4:	2205      	movs	r2, #5
c0d03be6:	f7fd ff4f 	bl	c0d01a88 <os_memcmp>
c0d03bea:	2800      	cmp	r0, #0
c0d03bec:	d02c      	beq.n	c0d03c48 <u2f_apdu_sign+0xb4>
        }
    }
    

    for (i = 0; i < keyHandleLength; i++) {
        buffer[U2F_HANDLE_SIGN_HEADER_SIZE + i] ^= U2F_PROXY_MAGIC[i % (sizeof(U2F_PROXY_MAGIC)-1)];
c0d03bee:	3641      	adds	r6, #65	; 0x41
c0d03bf0:	2400      	movs	r4, #0
c0d03bf2:	a522      	add	r5, pc, #136	; (adr r5, c0d03c7c <u2f_apdu_sign+0xe8>)
c0d03bf4:	b2e0      	uxtb	r0, r4
c0d03bf6:	2103      	movs	r1, #3
c0d03bf8:	f002 fa5e 	bl	c0d060b8 <__aeabi_uidivmod>
c0d03bfc:	5d30      	ldrb	r0, [r6, r4]
c0d03bfe:	5c69      	ldrb	r1, [r5, r1]
c0d03c00:	4041      	eors	r1, r0
c0d03c02:	5531      	strb	r1, [r6, r4]
            return;
        }
    }
    

    for (i = 0; i < keyHandleLength; i++) {
c0d03c04:	1c64      	adds	r4, r4, #1
c0d03c06:	42a7      	cmp	r7, r4
c0d03c08:	d1f4      	bne.n	c0d03bf4 <u2f_apdu_sign+0x60>
        buffer[U2F_HANDLE_SIGN_HEADER_SIZE + i] ^= U2F_PROXY_MAGIC[i % (sizeof(U2F_PROXY_MAGIC)-1)];
    }
    // Check that it looks like an APDU
    if (length != U2F_HANDLE_SIGN_HEADER_SIZE + 5 + buffer[U2F_HANDLE_SIGN_HEADER_SIZE + 4]) {
c0d03c0a:	2045      	movs	r0, #69	; 0x45
c0d03c0c:	9904      	ldr	r1, [sp, #16]
c0d03c0e:	5c08      	ldrb	r0, [r1, r0]
c0d03c10:	3046      	adds	r0, #70	; 0x46
c0d03c12:	9a02      	ldr	r2, [sp, #8]
c0d03c14:	4282      	cmp	r2, r0
c0d03c16:	d111      	bne.n	c0d03c3c <u2f_apdu_sign+0xa8>
                  sizeof(SW_BAD_KEY_HANDLE));
        return;
    }

    // make the apdu available to higher layers
    os_memmove(G_io_apdu_buffer, buffer + U2F_HANDLE_SIGN_HEADER_SIZE, keyHandleLength);
c0d03c18:	3141      	adds	r1, #65	; 0x41
c0d03c1a:	4817      	ldr	r0, [pc, #92]	; (c0d03c78 <u2f_apdu_sign+0xe4>)
c0d03c1c:	463a      	mov	r2, r7
c0d03c1e:	f7fd fe96 	bl	c0d0194e <os_memmove>
    G_io_apdu_length = keyHandleLength;
c0d03c22:	4819      	ldr	r0, [pc, #100]	; (c0d03c88 <u2f_apdu_sign+0xf4>)
c0d03c24:	8007      	strh	r7, [r0, #0]
    G_io_apdu_media = IO_APDU_MEDIA_U2F; // the effective transport is managed by the U2F layer
c0d03c26:	4819      	ldr	r0, [pc, #100]	; (c0d03c8c <u2f_apdu_sign+0xf8>)
c0d03c28:	2107      	movs	r1, #7
c0d03c2a:	7001      	strb	r1, [r0, #0]
    G_io_apdu_state = APDU_U2F;
c0d03c2c:	2009      	movs	r0, #9
c0d03c2e:	490f      	ldr	r1, [pc, #60]	; (c0d03c6c <u2f_apdu_sign+0xd8>)
c0d03c30:	7008      	strb	r0, [r1, #0]

    // prepare for asynch reply
    u2f_message_set_autoreply_wait_user_presence(service, true);
c0d03c32:	2101      	movs	r1, #1
c0d03c34:	9803      	ldr	r0, [sp, #12]
c0d03c36:	f000 fc4d 	bl	c0d044d4 <u2f_message_set_autoreply_wait_user_presence>
c0d03c3a:	e7c3      	b.n	c0d03bc4 <u2f_apdu_sign+0x30>
    for (i = 0; i < keyHandleLength; i++) {
        buffer[U2F_HANDLE_SIGN_HEADER_SIZE + i] ^= U2F_PROXY_MAGIC[i % (sizeof(U2F_PROXY_MAGIC)-1)];
    }
    // Check that it looks like an APDU
    if (length != U2F_HANDLE_SIGN_HEADER_SIZE + 5 + buffer[U2F_HANDLE_SIGN_HEADER_SIZE + 4]) {
        u2f_message_reply(service, U2F_CMD_MSG,
c0d03c3c:	4a17      	ldr	r2, [pc, #92]	; (c0d03c9c <u2f_apdu_sign+0x108>)
c0d03c3e:	447a      	add	r2, pc
c0d03c40:	2302      	movs	r3, #2
c0d03c42:	9803      	ldr	r0, [sp, #12]
c0d03c44:	9901      	ldr	r1, [sp, #4]
c0d03c46:	e7bb      	b.n	c0d03bc0 <u2f_apdu_sign+0x2c>
        // this apdu is not subject to proxy magic masking
        // APDU is F1 D0 00 00 00 to get the magic proxy
        // RAPDU: <>
        if (os_memcmp(buffer+U2F_HANDLE_SIGN_HEADER_SIZE, "\xF1\xD0\x00\x00\x00", 5) == 0 ) {
            // U2F_PROXY_MAGIC is given as a 0 terminated string
            G_io_apdu_buffer[0] = sizeof(U2F_PROXY_MAGIC)-1;
c0d03c48:	4e0b      	ldr	r6, [pc, #44]	; (c0d03c78 <u2f_apdu_sign+0xe4>)
c0d03c4a:	2203      	movs	r2, #3
c0d03c4c:	7032      	strb	r2, [r6, #0]
            os_memmove(G_io_apdu_buffer+1, U2F_PROXY_MAGIC, sizeof(U2F_PROXY_MAGIC)-1);
c0d03c4e:	1c70      	adds	r0, r6, #1
c0d03c50:	a10a      	add	r1, pc, #40	; (adr r1, c0d03c7c <u2f_apdu_sign+0xe8>)
c0d03c52:	f7fd fe7c 	bl	c0d0194e <os_memmove>
            os_memmove(G_io_apdu_buffer+1+sizeof(U2F_PROXY_MAGIC)-1, "\x90\x00\x90\x00", 4);
c0d03c56:	1d30      	adds	r0, r6, #4
c0d03c58:	a109      	add	r1, pc, #36	; (adr r1, c0d03c80 <u2f_apdu_sign+0xec>)
c0d03c5a:	2204      	movs	r2, #4
c0d03c5c:	f7fd fe77 	bl	c0d0194e <os_memmove>
            u2f_message_reply(service, U2F_CMD_MSG,
                              (uint8_t *)G_io_apdu_buffer,
                              G_io_apdu_buffer[0]+1+2+2);
c0d03c60:	7830      	ldrb	r0, [r6, #0]
c0d03c62:	1d43      	adds	r3, r0, #5
        if (os_memcmp(buffer+U2F_HANDLE_SIGN_HEADER_SIZE, "\xF1\xD0\x00\x00\x00", 5) == 0 ) {
            // U2F_PROXY_MAGIC is given as a 0 terminated string
            G_io_apdu_buffer[0] = sizeof(U2F_PROXY_MAGIC)-1;
            os_memmove(G_io_apdu_buffer+1, U2F_PROXY_MAGIC, sizeof(U2F_PROXY_MAGIC)-1);
            os_memmove(G_io_apdu_buffer+1+sizeof(U2F_PROXY_MAGIC)-1, "\x90\x00\x90\x00", 4);
            u2f_message_reply(service, U2F_CMD_MSG,
c0d03c64:	9803      	ldr	r0, [sp, #12]
c0d03c66:	9901      	ldr	r1, [sp, #4]
c0d03c68:	4632      	mov	r2, r6
c0d03c6a:	e7a9      	b.n	c0d03bc0 <u2f_apdu_sign+0x2c>
c0d03c6c:	20001a96 	.word	0x20001a96
c0d03c70:	0000d0f1 	.word	0x0000d0f1
c0d03c74:	00000000 	.word	0x00000000
c0d03c78:	20001924 	.word	0x20001924
c0d03c7c:	004d5343 	.word	0x004d5343
c0d03c80:	00900090 	.word	0x00900090
c0d03c84:	00000000 	.word	0x00000000
c0d03c88:	20001a98 	.word	0x20001a98
c0d03c8c:	20001a80 	.word	0x20001a80
c0d03c90:	00003b8b 	.word	0x00003b8b
c0d03c94:	00003b81 	.word	0x00003b81
c0d03c98:	00003b79 	.word	0x00003b79
c0d03c9c:	00003af7 	.word	0x00003af7

c0d03ca0 <u2f_handle_cmd_init>:
    UNUSED(length);
    u2f_message_reply(service, U2F_CMD_MSG, (uint8_t *)INFO, sizeof(INFO));
}

void u2f_handle_cmd_init(u2f_service_t *service, uint8_t *buffer,
                         uint16_t length, uint8_t *channelInit) {
c0d03ca0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03ca2:	b081      	sub	sp, #4
c0d03ca4:	461d      	mov	r5, r3
c0d03ca6:	460e      	mov	r6, r1
c0d03ca8:	4604      	mov	r4, r0
    // screen_printf("U2F init\n");
    uint8_t channel[4];
    (void)length;
    if (u2f_is_channel_broadcast(channelInit)) {
c0d03caa:	4628      	mov	r0, r5
c0d03cac:	f000 fc02 	bl	c0d044b4 <u2f_is_channel_broadcast>
c0d03cb0:	2801      	cmp	r0, #1
c0d03cb2:	d104      	bne.n	c0d03cbe <u2f_handle_cmd_init+0x1e>
c0d03cb4:	4668      	mov	r0, sp
        cx_rng(channel, 4);
c0d03cb6:	2104      	movs	r1, #4
c0d03cb8:	f7ff f922 	bl	c0d02f00 <cx_rng>
c0d03cbc:	e004      	b.n	c0d03cc8 <u2f_handle_cmd_init+0x28>
c0d03cbe:	4668      	mov	r0, sp
    } else {
        os_memmove(channel, channelInit, 4);
c0d03cc0:	2204      	movs	r2, #4
c0d03cc2:	4629      	mov	r1, r5
c0d03cc4:	f7fd fe43 	bl	c0d0194e <os_memmove>
    }
    os_memmove(G_io_apdu_buffer, buffer, 8);
c0d03cc8:	4f17      	ldr	r7, [pc, #92]	; (c0d03d28 <u2f_handle_cmd_init+0x88>)
c0d03cca:	2208      	movs	r2, #8
c0d03ccc:	4638      	mov	r0, r7
c0d03cce:	4631      	mov	r1, r6
c0d03cd0:	f7fd fe3d 	bl	c0d0194e <os_memmove>
    os_memmove(G_io_apdu_buffer + 8, channel, 4);
c0d03cd4:	4638      	mov	r0, r7
c0d03cd6:	3008      	adds	r0, #8
c0d03cd8:	4669      	mov	r1, sp
c0d03cda:	2204      	movs	r2, #4
c0d03cdc:	f7fd fe37 	bl	c0d0194e <os_memmove>
    G_io_apdu_buffer[12] = INIT_U2F_VERSION;
c0d03ce0:	2002      	movs	r0, #2
c0d03ce2:	7338      	strb	r0, [r7, #12]
    G_io_apdu_buffer[13] = INIT_DEVICE_VERSION_MAJOR;
c0d03ce4:	2000      	movs	r0, #0
c0d03ce6:	7378      	strb	r0, [r7, #13]
c0d03ce8:	2101      	movs	r1, #1
    G_io_apdu_buffer[14] = INIT_DEVICE_VERSION_MINOR;
c0d03cea:	73b9      	strb	r1, [r7, #14]
    G_io_apdu_buffer[15] = INIT_BUILD_VERSION;
c0d03cec:	73f8      	strb	r0, [r7, #15]
    G_io_apdu_buffer[16] = INIT_CAPABILITIES;
c0d03cee:	7438      	strb	r0, [r7, #16]

    if (u2f_is_channel_broadcast(channelInit)) {
c0d03cf0:	4628      	mov	r0, r5
c0d03cf2:	f000 fbdf 	bl	c0d044b4 <u2f_is_channel_broadcast>
c0d03cf6:	4601      	mov	r1, r0
c0d03cf8:	1d20      	adds	r0, r4, #4
        os_memset(service->channel, 0xff, 4);
c0d03cfa:	2586      	movs	r5, #134	; 0x86
    G_io_apdu_buffer[13] = INIT_DEVICE_VERSION_MAJOR;
    G_io_apdu_buffer[14] = INIT_DEVICE_VERSION_MINOR;
    G_io_apdu_buffer[15] = INIT_BUILD_VERSION;
    G_io_apdu_buffer[16] = INIT_CAPABILITIES;

    if (u2f_is_channel_broadcast(channelInit)) {
c0d03cfc:	2901      	cmp	r1, #1
c0d03cfe:	d106      	bne.n	c0d03d0e <u2f_handle_cmd_init+0x6e>
        os_memset(service->channel, 0xff, 4);
c0d03d00:	4629      	mov	r1, r5
c0d03d02:	3179      	adds	r1, #121	; 0x79
c0d03d04:	b2c9      	uxtb	r1, r1
c0d03d06:	2204      	movs	r2, #4
c0d03d08:	f7fd fe18 	bl	c0d0193c <os_memset>
c0d03d0c:	e003      	b.n	c0d03d16 <u2f_handle_cmd_init+0x76>
c0d03d0e:	4669      	mov	r1, sp
    } else {
        os_memmove(service->channel, channel, 4);
c0d03d10:	2204      	movs	r2, #4
c0d03d12:	f7fd fe1c 	bl	c0d0194e <os_memmove>
    }
    u2f_message_reply(service, U2F_CMD_INIT, G_io_apdu_buffer, 17);
c0d03d16:	4a04      	ldr	r2, [pc, #16]	; (c0d03d28 <u2f_handle_cmd_init+0x88>)
c0d03d18:	2311      	movs	r3, #17
c0d03d1a:	4620      	mov	r0, r4
c0d03d1c:	4629      	mov	r1, r5
c0d03d1e:	f000 fc04 	bl	c0d0452a <u2f_message_reply>
}
c0d03d22:	b001      	add	sp, #4
c0d03d24:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03d26:	46c0      	nop			; (mov r8, r8)
c0d03d28:	20001924 	.word	0x20001924

c0d03d2c <u2f_handle_cmd_msg>:
    // screen_printf("U2F ping\n");
    u2f_message_reply(service, U2F_CMD_PING, buffer, length);
}

void u2f_handle_cmd_msg(u2f_service_t *service, uint8_t *buffer,
                        uint16_t length) {
c0d03d2c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03d2e:	b085      	sub	sp, #20
c0d03d30:	4615      	mov	r5, r2
c0d03d32:	460c      	mov	r4, r1
c0d03d34:	9004      	str	r0, [sp, #16]
    uint8_t cla = buffer[0];
    uint8_t ins = buffer[1];
    uint8_t p1 = buffer[2];
    uint8_t p2 = buffer[3];
    // in extended length buffer[4] must be 0
    uint32_t dataLength = /*(buffer[4] << 16) |*/ (buffer[5] << 8) | (buffer[6]);
c0d03d36:	79a0      	ldrb	r0, [r4, #6]
c0d03d38:	7961      	ldrb	r1, [r4, #5]
c0d03d3a:	020e      	lsls	r6, r1, #8
c0d03d3c:	4306      	orrs	r6, r0
void u2f_handle_cmd_msg(u2f_service_t *service, uint8_t *buffer,
                        uint16_t length) {
    // screen_printf("U2F msg\n");
    uint8_t cla = buffer[0];
    uint8_t ins = buffer[1];
    uint8_t p1 = buffer[2];
c0d03d3e:	78a0      	ldrb	r0, [r4, #2]

void u2f_handle_cmd_msg(u2f_service_t *service, uint8_t *buffer,
                        uint16_t length) {
    // screen_printf("U2F msg\n");
    uint8_t cla = buffer[0];
    uint8_t ins = buffer[1];
c0d03d40:	9002      	str	r0, [sp, #8]
c0d03d42:	7861      	ldrb	r1, [r4, #1]
}

void u2f_handle_cmd_msg(u2f_service_t *service, uint8_t *buffer,
                        uint16_t length) {
    // screen_printf("U2F msg\n");
    uint8_t cla = buffer[0];
c0d03d44:	7827      	ldrb	r7, [r4, #0]
    uint8_t ins = buffer[1];
    uint8_t p1 = buffer[2];
    uint8_t p2 = buffer[3];
    // in extended length buffer[4] must be 0
    uint32_t dataLength = /*(buffer[4] << 16) |*/ (buffer[5] << 8) | (buffer[6]);
    if (dataLength == (uint16_t)(length - 9) || dataLength == (uint16_t)(length - 7)) {
c0d03d46:	3a09      	subs	r2, #9
c0d03d48:	b290      	uxth	r0, r2
        u2f_apdu_get_info(service, p1, p2, buffer + 7, dataLength);
        break;

    default:
        // screen_printf("unsupported\n");
        u2f_message_reply(service, U2F_CMD_MSG,
c0d03d4a:	2383      	movs	r3, #131	; 0x83
c0d03d4c:	9303      	str	r3, [sp, #12]
c0d03d4e:	4b1f      	ldr	r3, [pc, #124]	; (c0d03dcc <u2f_handle_cmd_msg+0xa0>)
    uint8_t ins = buffer[1];
    uint8_t p1 = buffer[2];
    uint8_t p2 = buffer[3];
    // in extended length buffer[4] must be 0
    uint32_t dataLength = /*(buffer[4] << 16) |*/ (buffer[5] << 8) | (buffer[6]);
    if (dataLength == (uint16_t)(length - 9) || dataLength == (uint16_t)(length - 7)) {
c0d03d50:	4286      	cmp	r6, r0
c0d03d52:	d003      	beq.n	c0d03d5c <u2f_handle_cmd_msg+0x30>
c0d03d54:	1fed      	subs	r5, r5, #7
c0d03d56:	402b      	ands	r3, r5
c0d03d58:	429e      	cmp	r6, r3
c0d03d5a:	d11b      	bne.n	c0d03d94 <u2f_handle_cmd_msg+0x68>
c0d03d5c:	4632      	mov	r2, r6
                  (uint8_t *)SW_WRONG_LENGTH,
                  sizeof(SW_WRONG_LENGTH));
        return;
    }

    if (cla != FIDO_CLA) {
c0d03d5e:	2f00      	cmp	r7, #0
c0d03d60:	d008      	beq.n	c0d03d74 <u2f_handle_cmd_msg+0x48>
        u2f_message_reply(service, U2F_CMD_MSG,
c0d03d62:	4a1b      	ldr	r2, [pc, #108]	; (c0d03dd0 <u2f_handle_cmd_msg+0xa4>)
c0d03d64:	447a      	add	r2, pc
c0d03d66:	2302      	movs	r3, #2
c0d03d68:	9804      	ldr	r0, [sp, #16]
c0d03d6a:	9903      	ldr	r1, [sp, #12]
c0d03d6c:	f000 fbdd 	bl	c0d0452a <u2f_message_reply>
        u2f_message_reply(service, U2F_CMD_MSG,
                 (uint8_t *)SW_UNKNOWN_INSTRUCTION,
                 sizeof(SW_UNKNOWN_INSTRUCTION));
        return;
    }
}
c0d03d70:	b005      	add	sp, #20
c0d03d72:	bdf0      	pop	{r4, r5, r6, r7, pc}
        u2f_message_reply(service, U2F_CMD_MSG,
                  (uint8_t *)SW_UNKNOWN_CLASS,
                  sizeof(SW_UNKNOWN_CLASS));
        return;
    }
    switch (ins) {
c0d03d74:	2902      	cmp	r1, #2
c0d03d76:	dc17      	bgt.n	c0d03da8 <u2f_handle_cmd_msg+0x7c>
c0d03d78:	2901      	cmp	r1, #1
c0d03d7a:	d020      	beq.n	c0d03dbe <u2f_handle_cmd_msg+0x92>
c0d03d7c:	2902      	cmp	r1, #2
c0d03d7e:	d11b      	bne.n	c0d03db8 <u2f_handle_cmd_msg+0x8c>
        // screen_printf("enroll\n");
        u2f_apdu_enroll(service, p1, p2, buffer + 7, dataLength);
        break;
    case FIDO_INS_SIGN:
        // screen_printf("sign\n");
        u2f_apdu_sign(service, p1, p2, buffer + 7, dataLength);
c0d03d80:	b290      	uxth	r0, r2
c0d03d82:	4669      	mov	r1, sp
c0d03d84:	6008      	str	r0, [r1, #0]
c0d03d86:	1de3      	adds	r3, r4, #7
c0d03d88:	2200      	movs	r2, #0
c0d03d8a:	9804      	ldr	r0, [sp, #16]
c0d03d8c:	9902      	ldr	r1, [sp, #8]
c0d03d8e:	f7ff ff01 	bl	c0d03b94 <u2f_apdu_sign>
c0d03d92:	e7ed      	b.n	c0d03d70 <u2f_handle_cmd_msg+0x44>
    if (dataLength == (uint16_t)(length - 9) || dataLength == (uint16_t)(length - 7)) {
        // Le is optional
        // nominal case from the specification
    }
    // circumvent google chrome extended length encoding done on the last byte only (module 256) but all data being transferred
    else if (dataLength == (uint16_t)(length - 9)%256) {
c0d03d94:	b2d0      	uxtb	r0, r2
c0d03d96:	4286      	cmp	r6, r0
c0d03d98:	d0e1      	beq.n	c0d03d5e <u2f_handle_cmd_msg+0x32>
        dataLength = length - 9;
    }
    else if (dataLength == (uint16_t)(length - 7)%256) {
c0d03d9a:	b2e8      	uxtb	r0, r5
c0d03d9c:	4286      	cmp	r6, r0
c0d03d9e:	462a      	mov	r2, r5
c0d03da0:	d0dd      	beq.n	c0d03d5e <u2f_handle_cmd_msg+0x32>
        dataLength = length - 7;
    }    
    else { 
        // invalid size
        u2f_message_reply(service, U2F_CMD_MSG,
c0d03da2:	4a0c      	ldr	r2, [pc, #48]	; (c0d03dd4 <u2f_handle_cmd_msg+0xa8>)
c0d03da4:	447a      	add	r2, pc
c0d03da6:	e7de      	b.n	c0d03d66 <u2f_handle_cmd_msg+0x3a>
c0d03da8:	2903      	cmp	r1, #3
c0d03daa:	d00b      	beq.n	c0d03dc4 <u2f_handle_cmd_msg+0x98>
c0d03dac:	29c1      	cmp	r1, #193	; 0xc1
c0d03dae:	d103      	bne.n	c0d03db8 <u2f_handle_cmd_msg+0x8c>
                            uint8_t *buffer, uint16_t length) {
    UNUSED(p1);
    UNUSED(p2);
    UNUSED(buffer);
    UNUSED(length);
    u2f_message_reply(service, U2F_CMD_MSG, (uint8_t *)INFO, sizeof(INFO));
c0d03db0:	4a09      	ldr	r2, [pc, #36]	; (c0d03dd8 <u2f_handle_cmd_msg+0xac>)
c0d03db2:	447a      	add	r2, pc
c0d03db4:	2304      	movs	r3, #4
c0d03db6:	e7d7      	b.n	c0d03d68 <u2f_handle_cmd_msg+0x3c>
        u2f_apdu_get_info(service, p1, p2, buffer + 7, dataLength);
        break;

    default:
        // screen_printf("unsupported\n");
        u2f_message_reply(service, U2F_CMD_MSG,
c0d03db8:	4a0a      	ldr	r2, [pc, #40]	; (c0d03de4 <u2f_handle_cmd_msg+0xb8>)
c0d03dba:	447a      	add	r2, pc
c0d03dbc:	e7d3      	b.n	c0d03d66 <u2f_handle_cmd_msg+0x3a>
    UNUSED(p1);
    UNUSED(p2);
    UNUSED(buffer);
    UNUSED(length);

    u2f_message_reply(service, U2F_CMD_MSG, (uint8_t *)SW_INTERNAL, sizeof(SW_INTERNAL));
c0d03dbe:	4a07      	ldr	r2, [pc, #28]	; (c0d03ddc <u2f_handle_cmd_msg+0xb0>)
c0d03dc0:	447a      	add	r2, pc
c0d03dc2:	e7d0      	b.n	c0d03d66 <u2f_handle_cmd_msg+0x3a>
    // screen_printf("U2F version\n");
    UNUSED(p1);
    UNUSED(p2);
    UNUSED(buffer);
    UNUSED(length);
    u2f_message_reply(service, U2F_CMD_MSG, (uint8_t *)U2F_VERSION, sizeof(U2F_VERSION));
c0d03dc4:	4a06      	ldr	r2, [pc, #24]	; (c0d03de0 <u2f_handle_cmd_msg+0xb4>)
c0d03dc6:	447a      	add	r2, pc
c0d03dc8:	2308      	movs	r3, #8
c0d03dca:	e7cd      	b.n	c0d03d68 <u2f_handle_cmd_msg+0x3c>
c0d03dcc:	0000ffff 	.word	0x0000ffff
c0d03dd0:	000039df 	.word	0x000039df
c0d03dd4:	0000398d 	.word	0x0000398d
c0d03dd8:	0000398d 	.word	0x0000398d
c0d03ddc:	0000396d 	.word	0x0000396d
c0d03de0:	00003971 	.word	0x00003971
c0d03de4:	0000398b 	.word	0x0000398b

c0d03de8 <u2f_message_complete>:
                 sizeof(SW_UNKNOWN_INSTRUCTION));
        return;
    }
}

void u2f_message_complete(u2f_service_t *service) {
c0d03de8:	b580      	push	{r7, lr}
    uint8_t cmd = service->transportBuffer[0];
c0d03dea:	69c1      	ldr	r1, [r0, #28]
    uint16_t length = (service->transportBuffer[1] << 8) | (service->transportBuffer[2]);
c0d03dec:	788a      	ldrb	r2, [r1, #2]
c0d03dee:	784b      	ldrb	r3, [r1, #1]
c0d03df0:	021b      	lsls	r3, r3, #8
c0d03df2:	4313      	orrs	r3, r2
        return;
    }
}

void u2f_message_complete(u2f_service_t *service) {
    uint8_t cmd = service->transportBuffer[0];
c0d03df4:	780a      	ldrb	r2, [r1, #0]
    uint16_t length = (service->transportBuffer[1] << 8) | (service->transportBuffer[2]);
    switch (cmd) {
c0d03df6:	2a81      	cmp	r2, #129	; 0x81
c0d03df8:	d009      	beq.n	c0d03e0e <u2f_message_complete+0x26>
c0d03dfa:	2a83      	cmp	r2, #131	; 0x83
c0d03dfc:	d00c      	beq.n	c0d03e18 <u2f_message_complete+0x30>
c0d03dfe:	2a86      	cmp	r2, #134	; 0x86
c0d03e00:	d10e      	bne.n	c0d03e20 <u2f_message_complete+0x38>
    case U2F_CMD_INIT:
        u2f_handle_cmd_init(service, service->transportBuffer + 3, length, service->channel);
c0d03e02:	1cc9      	adds	r1, r1, #3
c0d03e04:	1d03      	adds	r3, r0, #4
c0d03e06:	2200      	movs	r2, #0
c0d03e08:	f7ff ff4a 	bl	c0d03ca0 <u2f_handle_cmd_init>
        break;
    case U2F_CMD_MSG:
        u2f_handle_cmd_msg(service, service->transportBuffer + 3, length);
        break;
    }
}
c0d03e0c:	bd80      	pop	{r7, pc}
    switch (cmd) {
    case U2F_CMD_INIT:
        u2f_handle_cmd_init(service, service->transportBuffer + 3, length, service->channel);
        break;
    case U2F_CMD_PING:
        u2f_handle_cmd_ping(service, service->transportBuffer + 3, length);
c0d03e0e:	1cca      	adds	r2, r1, #3
}

void u2f_handle_cmd_ping(u2f_service_t *service, uint8_t *buffer,
                         uint16_t length) {
    // screen_printf("U2F ping\n");
    u2f_message_reply(service, U2F_CMD_PING, buffer, length);
c0d03e10:	2181      	movs	r1, #129	; 0x81
c0d03e12:	f000 fb8a 	bl	c0d0452a <u2f_message_reply>
        break;
    case U2F_CMD_MSG:
        u2f_handle_cmd_msg(service, service->transportBuffer + 3, length);
        break;
    }
}
c0d03e16:	bd80      	pop	{r7, pc}
        break;
    case U2F_CMD_PING:
        u2f_handle_cmd_ping(service, service->transportBuffer + 3, length);
        break;
    case U2F_CMD_MSG:
        u2f_handle_cmd_msg(service, service->transportBuffer + 3, length);
c0d03e18:	1cc9      	adds	r1, r1, #3
c0d03e1a:	461a      	mov	r2, r3
c0d03e1c:	f7ff ff86 	bl	c0d03d2c <u2f_handle_cmd_msg>
        break;
    }
}
c0d03e20:	bd80      	pop	{r7, pc}
	...

c0d03e24 <u2f_io_send>:
#include "u2f_processing.h"
#include "u2f_impl.h"

#include "os_io_seproxyhal.h"

void u2f_io_send(uint8_t *buffer, uint16_t length, u2f_transport_media_t media) {
c0d03e24:	b570      	push	{r4, r5, r6, lr}
c0d03e26:	460d      	mov	r5, r1
c0d03e28:	4601      	mov	r1, r0
    if (media == U2F_MEDIA_USB) {
c0d03e2a:	2a01      	cmp	r2, #1
c0d03e2c:	d111      	bne.n	c0d03e52 <u2f_io_send+0x2e>
        os_memmove(G_io_usb_ep_buffer, buffer, length);
c0d03e2e:	4c09      	ldr	r4, [pc, #36]	; (c0d03e54 <u2f_io_send+0x30>)
c0d03e30:	4620      	mov	r0, r4
c0d03e32:	462a      	mov	r2, r5
c0d03e34:	f7fd fd8b 	bl	c0d0194e <os_memmove>
        // wipe the remaining to avoid :
        // 1/ data leaks
        // 2/ invalid junk
        os_memset(G_io_usb_ep_buffer+length, 0, sizeof(G_io_usb_ep_buffer)-length);
c0d03e38:	1960      	adds	r0, r4, r5
c0d03e3a:	2640      	movs	r6, #64	; 0x40
c0d03e3c:	1b72      	subs	r2, r6, r5
c0d03e3e:	2500      	movs	r5, #0
c0d03e40:	4629      	mov	r1, r5
c0d03e42:	f7fd fd7b 	bl	c0d0193c <os_memset>
    }
    switch (media) {
    case U2F_MEDIA_USB:
        io_usb_send_ep(U2F_EPIN_ADDR, G_io_usb_ep_buffer, USB_SEGMENT_SIZE, 0);
c0d03e46:	2081      	movs	r0, #129	; 0x81
c0d03e48:	4621      	mov	r1, r4
c0d03e4a:	4632      	mov	r2, r6
c0d03e4c:	462b      	mov	r3, r5
c0d03e4e:	f7fd fecd 	bl	c0d01bec <io_usb_send_ep>
#endif
    default:
        PRINTF("Request to send on unsupported media %d\n", media);
        break;
    }
}
c0d03e52:	bd70      	pop	{r4, r5, r6, pc}
c0d03e54:	20001b38 	.word	0x20001b38

c0d03e58 <u2f_transport_init>:

/**
 * Initialize the u2f transport and provide the buffer into which to store incoming message
 */
void u2f_transport_init(u2f_service_t *service, uint8_t* message_buffer, uint16_t message_buffer_length) {
    service->transportReceiveBuffer = message_buffer;
c0d03e58:	60c1      	str	r1, [r0, #12]
    service->transportReceiveBufferLength = message_buffer_length;
c0d03e5a:	8202      	strh	r2, [r0, #16]
c0d03e5c:	2200      	movs	r2, #0
#warning TODO take into account the INIT during SEGMENTED message correctly (avoid erasing the first part of the apdu buffer when doing so)

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
c0d03e5e:	82c2      	strh	r2, [r0, #22]
    service->transportMedia = 0;
    service->transportPacketIndex = 0;
c0d03e60:	7682      	strb	r2, [r0, #26]
    service->fakeChannelTransportState = U2F_IDLE;
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
c0d03e62:	232b      	movs	r3, #43	; 0x2b
c0d03e64:	54c2      	strb	r2, [r0, r3]
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
c0d03e66:	232a      	movs	r3, #42	; 0x2a
c0d03e68:	54c2      	strb	r2, [r0, r3]

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
    service->transportMedia = 0;
c0d03e6a:	8482      	strh	r2, [r0, #36]	; 0x24
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
    // reset the receive buffer to allow for a new message to be received again (in case transmission of a CODE buffer the previous reply)
    service->transportBuffer = service->transportReceiveBuffer;
c0d03e6c:	61c1      	str	r1, [r0, #28]

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
    service->transportMedia = 0;
c0d03e6e:	6202      	str	r2, [r0, #32]
 */
void u2f_transport_init(u2f_service_t *service, uint8_t* message_buffer, uint16_t message_buffer_length) {
    service->transportReceiveBuffer = message_buffer;
    service->transportReceiveBufferLength = message_buffer_length;
    u2f_transport_reset(service);
}
c0d03e70:	4770      	bx	lr
	...

c0d03e74 <u2f_transport_sent>:

/**
 * Function called when the previously scheduled message to be sent on the media is effectively sent.
 * And a new message can be scheduled.
 */
void u2f_transport_sent(u2f_service_t* service, u2f_transport_media_t media) {
c0d03e74:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03e76:	b083      	sub	sp, #12
c0d03e78:	460d      	mov	r5, r1
c0d03e7a:	4604      	mov	r4, r0

    // previous mark packet as sent
    if (service->sending) {
c0d03e7c:	202b      	movs	r0, #43	; 0x2b
c0d03e7e:	5c21      	ldrb	r1, [r4, r0]
c0d03e80:	4620      	mov	r0, r4
c0d03e82:	302b      	adds	r0, #43	; 0x2b
c0d03e84:	2900      	cmp	r1, #0
c0d03e86:	d002      	beq.n	c0d03e8e <u2f_transport_sent+0x1a>
        service->sending = false;
c0d03e88:	2100      	movs	r1, #0
c0d03e8a:	7001      	strb	r1, [r0, #0]
c0d03e8c:	e061      	b.n	c0d03f52 <u2f_transport_sent+0xde>
        return;
    }

    // if idle (possibly after an error), then only await for a transmission 
    if (service->transportState != U2F_SENDING_RESPONSE 
c0d03e8e:	2120      	movs	r1, #32
c0d03e90:	5c61      	ldrb	r1, [r4, r1]
        && service->transportState != U2F_SENDING_ERROR) {
c0d03e92:	1ec9      	subs	r1, r1, #3
c0d03e94:	b2c9      	uxtb	r1, r1
        service->sending = false;
        return;
    }

    // if idle (possibly after an error), then only await for a transmission 
    if (service->transportState != U2F_SENDING_RESPONSE 
c0d03e96:	4623      	mov	r3, r4
c0d03e98:	3320      	adds	r3, #32
        && service->transportState != U2F_SENDING_ERROR) {
c0d03e9a:	2901      	cmp	r1, #1
c0d03e9c:	d859      	bhi.n	c0d03f52 <u2f_transport_sent+0xde>
        // absorb the error, transport is erroneous but that won't hurt in the end.
        // also absorb the fake channel user presence check reply ack
        //THROW(INVALID_STATE);
        return;
    }
    if (service->transportOffset < service->transportLength) {
c0d03e9e:	8b21      	ldrh	r1, [r4, #24]
c0d03ea0:	8ae2      	ldrh	r2, [r4, #22]
c0d03ea2:	4291      	cmp	r1, r2
c0d03ea4:	d924      	bls.n	c0d03ef0 <u2f_transport_sent+0x7c>
        uint16_t mtu = (media == U2F_MEDIA_USB) ? USB_SEGMENT_SIZE : BLE_SEGMENT_SIZE;
        uint16_t channelHeader =
            (media == U2F_MEDIA_USB ? 4 : 0);
c0d03ea6:	2304      	movs	r3, #4
c0d03ea8:	2000      	movs	r0, #0
c0d03eaa:	2d01      	cmp	r5, #1
c0d03eac:	d000      	beq.n	c0d03eb0 <u2f_transport_sent+0x3c>
c0d03eae:	4603      	mov	r3, r0
c0d03eb0:	9002      	str	r0, [sp, #8]
        uint8_t headerSize =
            (service->transportPacketIndex == 0 ? (channelHeader + 3)
c0d03eb2:	7ea0      	ldrb	r0, [r4, #26]
c0d03eb4:	2703      	movs	r7, #3
c0d03eb6:	2601      	movs	r6, #1
c0d03eb8:	2800      	cmp	r0, #0
c0d03eba:	d000      	beq.n	c0d03ebe <u2f_transport_sent+0x4a>
c0d03ebc:	4637      	mov	r7, r6
c0d03ebe:	431f      	orrs	r7, r3
                                                : (channelHeader + 1));
        uint16_t blockSize = ((service->transportLength - service->transportOffset) >
                                      (mtu - headerSize)
c0d03ec0:	2340      	movs	r3, #64	; 0x40
c0d03ec2:	1bde      	subs	r6, r3, r7
        uint16_t channelHeader =
            (media == U2F_MEDIA_USB ? 4 : 0);
        uint8_t headerSize =
            (service->transportPacketIndex == 0 ? (channelHeader + 3)
                                                : (channelHeader + 1));
        uint16_t blockSize = ((service->transportLength - service->transportOffset) >
c0d03ec4:	1a89      	subs	r1, r1, r2
c0d03ec6:	42b1      	cmp	r1, r6
c0d03ec8:	dc00      	bgt.n	c0d03ecc <u2f_transport_sent+0x58>
c0d03eca:	460e      	mov	r6, r1
                                      (mtu - headerSize)
                                  ? (mtu - headerSize)
                                  : service->transportLength - service->transportOffset);
        uint16_t dataSize = blockSize + headerSize;
c0d03ecc:	19f1      	adds	r1, r6, r7
        uint16_t offset = 0;
        // Fragment
        if (media == U2F_MEDIA_USB) {
c0d03ece:	9101      	str	r1, [sp, #4]
c0d03ed0:	2d01      	cmp	r5, #1
c0d03ed2:	d108      	bne.n	c0d03ee6 <u2f_transport_sent+0x72>
            os_memmove(G_io_usb_ep_buffer, service->channel, 4);
c0d03ed4:	1d21      	adds	r1, r4, #4
c0d03ed6:	4821      	ldr	r0, [pc, #132]	; (c0d03f5c <u2f_transport_sent+0xe8>)
c0d03ed8:	2204      	movs	r2, #4
c0d03eda:	9202      	str	r2, [sp, #8]
c0d03edc:	9300      	str	r3, [sp, #0]
c0d03ede:	f7fd fd36 	bl	c0d0194e <os_memmove>
c0d03ee2:	9b00      	ldr	r3, [sp, #0]
c0d03ee4:	7ea0      	ldrb	r0, [r4, #26]
            offset += 4;
        }
        if (service->transportPacketIndex == 0) {
c0d03ee6:	2800      	cmp	r0, #0
c0d03ee8:	d00f      	beq.n	c0d03f0a <u2f_transport_sent+0x96>
            G_io_usb_ep_buffer[offset++] = service->sendCmd;
            G_io_usb_ep_buffer[offset++] = (service->transportLength >> 8);
            G_io_usb_ep_buffer[offset++] = (service->transportLength & 0xff);
        } else {
            G_io_usb_ep_buffer[offset++] = (service->transportPacketIndex - 1);
c0d03eea:	30ff      	adds	r0, #255	; 0xff
c0d03eec:	9902      	ldr	r1, [sp, #8]
c0d03eee:	e018      	b.n	c0d03f22 <u2f_transport_sent+0xae>
c0d03ef0:	d12f      	bne.n	c0d03f52 <u2f_transport_sent+0xde>
c0d03ef2:	2100      	movs	r1, #0
#warning TODO take into account the INIT during SEGMENTED message correctly (avoid erasing the first part of the apdu buffer when doing so)

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
c0d03ef4:	82e1      	strh	r1, [r4, #22]
    service->transportMedia = 0;
    service->transportPacketIndex = 0;
c0d03ef6:	76a1      	strb	r1, [r4, #26]
    service->fakeChannelTransportState = U2F_IDLE;
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
c0d03ef8:	7001      	strb	r1, [r0, #0]
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
c0d03efa:	202a      	movs	r0, #42	; 0x2a
c0d03efc:	5421      	strb	r1, [r4, r0]

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
    service->transportMedia = 0;
c0d03efe:	8099      	strh	r1, [r3, #4]
c0d03f00:	6019      	str	r1, [r3, #0]
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
    // reset the receive buffer to allow for a new message to be received again (in case transmission of a CODE buffer the previous reply)
    service->transportBuffer = service->transportReceiveBuffer;
c0d03f02:	68e0      	ldr	r0, [r4, #12]
c0d03f04:	61e0      	str	r0, [r4, #28]
    }
    // last part sent
    else if (service->transportOffset == service->transportLength) {
        u2f_transport_reset(service);
        // we sent the whole response (even if we haven't yet received the ack for the last sent usb in packet)
        G_io_apdu_state = APDU_IDLE;
c0d03f06:	4814      	ldr	r0, [pc, #80]	; (c0d03f58 <u2f_transport_sent+0xe4>)
c0d03f08:	e7bf      	b.n	c0d03e8a <u2f_transport_sent+0x16>
        if (media == U2F_MEDIA_USB) {
            os_memmove(G_io_usb_ep_buffer, service->channel, 4);
            offset += 4;
        }
        if (service->transportPacketIndex == 0) {
            G_io_usb_ep_buffer[offset++] = service->sendCmd;
c0d03f0a:	5ce0      	ldrb	r0, [r4, r3]
c0d03f0c:	9b02      	ldr	r3, [sp, #8]
c0d03f0e:	b299      	uxth	r1, r3
c0d03f10:	4a12      	ldr	r2, [pc, #72]	; (c0d03f5c <u2f_transport_sent+0xe8>)
c0d03f12:	5450      	strb	r0, [r2, r1]
c0d03f14:	2001      	movs	r0, #1
c0d03f16:	4318      	orrs	r0, r3
            G_io_usb_ep_buffer[offset++] = (service->transportLength >> 8);
c0d03f18:	b281      	uxth	r1, r0
c0d03f1a:	7e63      	ldrb	r3, [r4, #25]
c0d03f1c:	5453      	strb	r3, [r2, r1]
c0d03f1e:	1c41      	adds	r1, r0, #1
            G_io_usb_ep_buffer[offset++] = (service->transportLength & 0xff);
c0d03f20:	7e20      	ldrb	r0, [r4, #24]
c0d03f22:	b289      	uxth	r1, r1
c0d03f24:	4b0d      	ldr	r3, [pc, #52]	; (c0d03f5c <u2f_transport_sent+0xe8>)
c0d03f26:	5458      	strb	r0, [r3, r1]
        } else {
            G_io_usb_ep_buffer[offset++] = (service->transportPacketIndex - 1);
        }
        if (service->transportBuffer != NULL) {
c0d03f28:	69e1      	ldr	r1, [r4, #28]
c0d03f2a:	2900      	cmp	r1, #0
c0d03f2c:	d005      	beq.n	c0d03f3a <u2f_transport_sent+0xc6>
                                                : (channelHeader + 1));
        uint16_t blockSize = ((service->transportLength - service->transportOffset) >
                                      (mtu - headerSize)
                                  ? (mtu - headerSize)
                                  : service->transportLength - service->transportOffset);
        uint16_t dataSize = blockSize + headerSize;
c0d03f2e:	b2b2      	uxth	r2, r6
            G_io_usb_ep_buffer[offset++] = (service->transportLength & 0xff);
        } else {
            G_io_usb_ep_buffer[offset++] = (service->transportPacketIndex - 1);
        }
        if (service->transportBuffer != NULL) {
            os_memmove(G_io_usb_ep_buffer + headerSize,
c0d03f30:	19d8      	adds	r0, r3, r7
                       service->transportBuffer + service->transportOffset, blockSize);
c0d03f32:	8ae3      	ldrh	r3, [r4, #22]
c0d03f34:	18c9      	adds	r1, r1, r3
            G_io_usb_ep_buffer[offset++] = (service->transportLength & 0xff);
        } else {
            G_io_usb_ep_buffer[offset++] = (service->transportPacketIndex - 1);
        }
        if (service->transportBuffer != NULL) {
            os_memmove(G_io_usb_ep_buffer + headerSize,
c0d03f36:	f7fd fd0a 	bl	c0d0194e <os_memmove>
                       service->transportBuffer + service->transportOffset, blockSize);
        }
        service->transportOffset += blockSize;
c0d03f3a:	8ae0      	ldrh	r0, [r4, #22]
c0d03f3c:	1980      	adds	r0, r0, r6
c0d03f3e:	82e0      	strh	r0, [r4, #22]
        service->transportPacketIndex++;
c0d03f40:	7ea0      	ldrb	r0, [r4, #26]
c0d03f42:	1c40      	adds	r0, r0, #1
c0d03f44:	76a0      	strb	r0, [r4, #26]
        u2f_io_send(G_io_usb_ep_buffer, dataSize, media);
c0d03f46:	9801      	ldr	r0, [sp, #4]
c0d03f48:	b281      	uxth	r1, r0
c0d03f4a:	4804      	ldr	r0, [pc, #16]	; (c0d03f5c <u2f_transport_sent+0xe8>)
c0d03f4c:	462a      	mov	r2, r5
c0d03f4e:	f7ff ff69 	bl	c0d03e24 <u2f_io_send>
    else if (service->transportOffset == service->transportLength) {
        u2f_transport_reset(service);
        // we sent the whole response (even if we haven't yet received the ack for the last sent usb in packet)
        G_io_apdu_state = APDU_IDLE;
    }
}
c0d03f52:	b003      	add	sp, #12
c0d03f54:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03f56:	46c0      	nop			; (mov r8, r8)
c0d03f58:	20001a96 	.word	0x20001a96
c0d03f5c:	20001b38 	.word	0x20001b38

c0d03f60 <u2f_transport_send_usb_user_presence_required>:

void u2f_transport_send_usb_user_presence_required(u2f_service_t *service) {
c0d03f60:	b5b0      	push	{r4, r5, r7, lr}
    uint16_t offset = 0;
    service->sending = true;
c0d03f62:	212b      	movs	r1, #43	; 0x2b
c0d03f64:	2401      	movs	r4, #1
c0d03f66:	5444      	strb	r4, [r0, r1]
    os_memmove(G_io_usb_ep_buffer, service->channel, 4);
c0d03f68:	1d01      	adds	r1, r0, #4
c0d03f6a:	4d0b      	ldr	r5, [pc, #44]	; (c0d03f98 <u2f_transport_send_usb_user_presence_required+0x38>)
c0d03f6c:	2204      	movs	r2, #4
c0d03f6e:	4628      	mov	r0, r5
c0d03f70:	f7fd fced 	bl	c0d0194e <os_memmove>
    offset += 4;
    G_io_usb_ep_buffer[offset++] = U2F_CMD_MSG;
    G_io_usb_ep_buffer[offset++] = 0;
    G_io_usb_ep_buffer[offset++] = 2;
    G_io_usb_ep_buffer[offset++] = 0x69;
    G_io_usb_ep_buffer[offset++] = 0x85;
c0d03f74:	2083      	movs	r0, #131	; 0x83
void u2f_transport_send_usb_user_presence_required(u2f_service_t *service) {
    uint16_t offset = 0;
    service->sending = true;
    os_memmove(G_io_usb_ep_buffer, service->channel, 4);
    offset += 4;
    G_io_usb_ep_buffer[offset++] = U2F_CMD_MSG;
c0d03f76:	7128      	strb	r0, [r5, #4]
    G_io_usb_ep_buffer[offset++] = 0;
c0d03f78:	2000      	movs	r0, #0
c0d03f7a:	7168      	strb	r0, [r5, #5]
    G_io_usb_ep_buffer[offset++] = 2;
c0d03f7c:	2002      	movs	r0, #2
c0d03f7e:	71a8      	strb	r0, [r5, #6]
    G_io_usb_ep_buffer[offset++] = 0x69;
c0d03f80:	2069      	movs	r0, #105	; 0x69
c0d03f82:	71e8      	strb	r0, [r5, #7]
    G_io_usb_ep_buffer[offset++] = 0x85;
c0d03f84:	207c      	movs	r0, #124	; 0x7c
c0d03f86:	43c0      	mvns	r0, r0
c0d03f88:	1c80      	adds	r0, r0, #2
c0d03f8a:	7228      	strb	r0, [r5, #8]
    u2f_io_send(G_io_usb_ep_buffer, offset, U2F_MEDIA_USB);
c0d03f8c:	2109      	movs	r1, #9
c0d03f8e:	4628      	mov	r0, r5
c0d03f90:	4622      	mov	r2, r4
c0d03f92:	f7ff ff47 	bl	c0d03e24 <u2f_io_send>
}
c0d03f96:	bdb0      	pop	{r4, r5, r7, pc}
c0d03f98:	20001b38 	.word	0x20001b38

c0d03f9c <u2f_transport_send_wink>:

void u2f_transport_send_wink(u2f_service_t *service) {
c0d03f9c:	b5b0      	push	{r4, r5, r7, lr}
    uint16_t offset = 0;
    service->sending = true;
c0d03f9e:	212b      	movs	r1, #43	; 0x2b
c0d03fa0:	2401      	movs	r4, #1
c0d03fa2:	5444      	strb	r4, [r0, r1]
    os_memmove(G_io_usb_ep_buffer, service->channel, 4);
c0d03fa4:	1d01      	adds	r1, r0, #4
c0d03fa6:	4d08      	ldr	r5, [pc, #32]	; (c0d03fc8 <u2f_transport_send_wink+0x2c>)
c0d03fa8:	2204      	movs	r2, #4
c0d03faa:	4628      	mov	r0, r5
c0d03fac:	f7fd fccf 	bl	c0d0194e <os_memmove>
    offset += 4;
    G_io_usb_ep_buffer[offset++] = U2F_CMD_WINK;
c0d03fb0:	2088      	movs	r0, #136	; 0x88
c0d03fb2:	7128      	strb	r0, [r5, #4]
    G_io_usb_ep_buffer[offset++] = 0;
c0d03fb4:	2000      	movs	r0, #0
c0d03fb6:	7168      	strb	r0, [r5, #5]
    G_io_usb_ep_buffer[offset++] = 0;
c0d03fb8:	71a8      	strb	r0, [r5, #6]
    u2f_io_send(G_io_usb_ep_buffer, offset, U2F_MEDIA_USB);
c0d03fba:	2107      	movs	r1, #7
c0d03fbc:	4628      	mov	r0, r5
c0d03fbe:	4622      	mov	r2, r4
c0d03fc0:	f7ff ff30 	bl	c0d03e24 <u2f_io_send>
}
c0d03fc4:	bdb0      	pop	{r4, r5, r7, pc}
c0d03fc6:	46c0      	nop			; (mov r8, r8)
c0d03fc8:	20001b38 	.word	0x20001b38

c0d03fcc <u2f_transport_receive_fakeChannel>:

bool u2f_transport_receive_fakeChannel(u2f_service_t *service, uint8_t *buffer, uint16_t size) {
c0d03fcc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03fce:	b085      	sub	sp, #20
c0d03fd0:	4604      	mov	r4, r0
    if (service->fakeChannelTransportState == U2F_INTERNAL_ERROR) {
c0d03fd2:	2025      	movs	r0, #37	; 0x25
c0d03fd4:	5c23      	ldrb	r3, [r4, r0]
c0d03fd6:	4627      	mov	r7, r4
c0d03fd8:	3725      	adds	r7, #37	; 0x25
c0d03fda:	2000      	movs	r0, #0
c0d03fdc:	2b05      	cmp	r3, #5
c0d03fde:	d019      	beq.n	c0d04014 <u2f_transport_receive_fakeChannel+0x48>
c0d03fe0:	9004      	str	r0, [sp, #16]
        return false;
    }
    if (memcmp(service->channel, buffer, 4) != 0) {
c0d03fe2:	7808      	ldrb	r0, [r1, #0]
c0d03fe4:	784b      	ldrb	r3, [r1, #1]
c0d03fe6:	021b      	lsls	r3, r3, #8
c0d03fe8:	4303      	orrs	r3, r0
c0d03fea:	7888      	ldrb	r0, [r1, #2]
c0d03fec:	78ce      	ldrb	r6, [r1, #3]
c0d03fee:	0236      	lsls	r6, r6, #8
c0d03ff0:	4306      	orrs	r6, r0
c0d03ff2:	0430      	lsls	r0, r6, #16
c0d03ff4:	4318      	orrs	r0, r3
c0d03ff6:	7923      	ldrb	r3, [r4, #4]
c0d03ff8:	7966      	ldrb	r6, [r4, #5]
c0d03ffa:	0236      	lsls	r6, r6, #8
c0d03ffc:	431e      	orrs	r6, r3
c0d03ffe:	79a3      	ldrb	r3, [r4, #6]
c0d04000:	79e5      	ldrb	r5, [r4, #7]
c0d04002:	022d      	lsls	r5, r5, #8
c0d04004:	431d      	orrs	r5, r3
c0d04006:	042b      	lsls	r3, r5, #16
c0d04008:	4333      	orrs	r3, r6
c0d0400a:	4283      	cmp	r3, r0
c0d0400c:	d004      	beq.n	c0d04018 <u2f_transport_receive_fakeChannel+0x4c>
            service->fakeChannelTransportState = U2F_IDLE;
        }
    }
    return true;
error:
    service->fakeChannelTransportState = U2F_INTERNAL_ERROR;
c0d0400e:	2005      	movs	r0, #5
c0d04010:	7038      	strb	r0, [r7, #0]
c0d04012:	9804      	ldr	r0, [sp, #16]
    return false;    
}
c0d04014:	b005      	add	sp, #20
c0d04016:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d04018:	790e      	ldrb	r6, [r1, #4]
c0d0401a:	1d0d      	adds	r5, r1, #4
        return false;
    }
    if (memcmp(service->channel, buffer, 4) != 0) {
        goto error;
    }
    if (service->fakeChannelTransportOffset == 0) {        
c0d0401c:	8c60      	ldrh	r0, [r4, #34]	; 0x22
c0d0401e:	2301      	movs	r3, #1
c0d04020:	9303      	str	r3, [sp, #12]
c0d04022:	4b30      	ldr	r3, [pc, #192]	; (c0d040e4 <u2f_transport_receive_fakeChannel+0x118>)
c0d04024:	2800      	cmp	r0, #0
c0d04026:	d01e      	beq.n	c0d04066 <u2f_transport_receive_fakeChannel+0x9a>
c0d04028:	9302      	str	r3, [sp, #8]
        service->fakeChannelTransportOffset = MIN(size - 4, service->transportLength);
        service->fakeChannelTransportPacketIndex = 0;
        service->fakeChannelCrc = cx_crc16_update(0, buffer + 4, service->fakeChannelTransportOffset);
    }
    else {
        if (buffer[4] != service->fakeChannelTransportPacketIndex) {
c0d0402a:	2324      	movs	r3, #36	; 0x24
c0d0402c:	5ce5      	ldrb	r5, [r4, r3]
c0d0402e:	4623      	mov	r3, r4
c0d04030:	3324      	adds	r3, #36	; 0x24
c0d04032:	42ae      	cmp	r6, r5
c0d04034:	d1eb      	bne.n	c0d0400e <u2f_transport_receive_fakeChannel+0x42>
            goto error;
        }
        uint16_t xfer_len = MIN(size - 5, service->transportLength - service->fakeChannelTransportOffset);
c0d04036:	8b25      	ldrh	r5, [r4, #24]
        service->fakeChannelTransportPacketIndex++;
c0d04038:	9500      	str	r5, [sp, #0]
c0d0403a:	1c75      	adds	r5, r6, #1
c0d0403c:	701d      	strb	r5, [r3, #0]
    }
    else {
        if (buffer[4] != service->fakeChannelTransportPacketIndex) {
            goto error;
        }
        uint16_t xfer_len = MIN(size - 5, service->transportLength - service->fakeChannelTransportOffset);
c0d0403e:	9b00      	ldr	r3, [sp, #0]
c0d04040:	1a1e      	subs	r6, r3, r0
c0d04042:	1f53      	subs	r3, r2, #5
c0d04044:	2505      	movs	r5, #5
c0d04046:	9501      	str	r5, [sp, #4]
c0d04048:	42b3      	cmp	r3, r6
c0d0404a:	db00      	blt.n	c0d0404e <u2f_transport_receive_fakeChannel+0x82>
c0d0404c:	9001      	str	r0, [sp, #4]
c0d0404e:	42b3      	cmp	r3, r6
c0d04050:	db00      	blt.n	c0d04054 <u2f_transport_receive_fakeChannel+0x88>
c0d04052:	9a00      	ldr	r2, [sp, #0]
c0d04054:	9b01      	ldr	r3, [sp, #4]
c0d04056:	1ad3      	subs	r3, r2, r3
        service->fakeChannelTransportPacketIndex++;
        service->fakeChannelTransportOffset += xfer_len;
c0d04058:	1818      	adds	r0, r3, r0
c0d0405a:	8460      	strh	r0, [r4, #34]	; 0x22
c0d0405c:	9a02      	ldr	r2, [sp, #8]
c0d0405e:	401a      	ands	r2, r3
        service->fakeChannelCrc = cx_crc16_update(service->fakeChannelCrc, buffer + 5, xfer_len);   
c0d04060:	8d20      	ldrh	r0, [r4, #40]	; 0x28
c0d04062:	1d49      	adds	r1, r1, #5
c0d04064:	e025      	b.n	c0d040b2 <u2f_transport_receive_fakeChannel+0xe6>
c0d04066:	207c      	movs	r0, #124	; 0x7c
c0d04068:	43c0      	mvns	r0, r0
    }
    if (service->fakeChannelTransportOffset == 0) {        
        uint16_t commandLength =
            (buffer[4 + 1] << 8) | (buffer[4 + 2]) + U2F_COMMAND_HEADER_SIZE;
        // Some buggy implementations can send a WINK here, reply it gently
        if (buffer[4] == U2F_CMD_WINK) {
c0d0406a:	1d40      	adds	r0, r0, #5
c0d0406c:	b2c0      	uxtb	r0, r0
c0d0406e:	9002      	str	r0, [sp, #8]
c0d04070:	2083      	movs	r0, #131	; 0x83
c0d04072:	9001      	str	r0, [sp, #4]
c0d04074:	9802      	ldr	r0, [sp, #8]
c0d04076:	4286      	cmp	r6, r0
c0d04078:	d103      	bne.n	c0d04082 <u2f_transport_receive_fakeChannel+0xb6>
            u2f_transport_send_wink(service);
c0d0407a:	4620      	mov	r0, r4
c0d0407c:	f7ff ff8e 	bl	c0d03f9c <u2f_transport_send_wink>
c0d04080:	e02d      	b.n	c0d040de <u2f_transport_receive_fakeChannel+0x112>
c0d04082:	9502      	str	r5, [sp, #8]
c0d04084:	461d      	mov	r5, r3
    if (memcmp(service->channel, buffer, 4) != 0) {
        goto error;
    }
    if (service->fakeChannelTransportOffset == 0) {        
        uint16_t commandLength =
            (buffer[4 + 1] << 8) | (buffer[4 + 2]) + U2F_COMMAND_HEADER_SIZE;
c0d04086:	7948      	ldrb	r0, [r1, #5]
c0d04088:	0203      	lsls	r3, r0, #8
c0d0408a:	7988      	ldrb	r0, [r1, #6]
c0d0408c:	1cc0      	adds	r0, r0, #3
c0d0408e:	4318      	orrs	r0, r3
        if (buffer[4] == U2F_CMD_WINK) {
            u2f_transport_send_wink(service);
            return true;
        }

        if (commandLength != service->transportLength) {
c0d04090:	9901      	ldr	r1, [sp, #4]
c0d04092:	428e      	cmp	r6, r1
c0d04094:	d1bb      	bne.n	c0d0400e <u2f_transport_receive_fakeChannel+0x42>
c0d04096:	8b21      	ldrh	r1, [r4, #24]
c0d04098:	4288      	cmp	r0, r1
c0d0409a:	d1b8      	bne.n	c0d0400e <u2f_transport_receive_fakeChannel+0x42>
            goto error;
        }
        if (buffer[4] != U2F_CMD_MSG) {
            goto error;
        }
        service->fakeChannelTransportOffset = MIN(size - 4, service->transportLength);
c0d0409c:	1f11      	subs	r1, r2, #4
c0d0409e:	4281      	cmp	r1, r0
c0d040a0:	db00      	blt.n	c0d040a4 <u2f_transport_receive_fakeChannel+0xd8>
c0d040a2:	4601      	mov	r1, r0
c0d040a4:	8461      	strh	r1, [r4, #34]	; 0x22
        service->fakeChannelTransportPacketIndex = 0;
c0d040a6:	2224      	movs	r2, #36	; 0x24
c0d040a8:	2000      	movs	r0, #0
c0d040aa:	54a0      	strb	r0, [r4, r2]
c0d040ac:	462a      	mov	r2, r5
        service->fakeChannelCrc = cx_crc16_update(0, buffer + 4, service->fakeChannelTransportOffset);
c0d040ae:	400a      	ands	r2, r1
c0d040b0:	9902      	ldr	r1, [sp, #8]
c0d040b2:	f7fe ffef 	bl	c0d03094 <cx_crc16_update>
c0d040b6:	8520      	strh	r0, [r4, #40]	; 0x28
        uint16_t xfer_len = MIN(size - 5, service->transportLength - service->fakeChannelTransportOffset);
        service->fakeChannelTransportPacketIndex++;
        service->fakeChannelTransportOffset += xfer_len;
        service->fakeChannelCrc = cx_crc16_update(service->fakeChannelCrc, buffer + 5, xfer_len);   
    }
    if (service->fakeChannelTransportOffset >= service->transportLength) {
c0d040b8:	8b21      	ldrh	r1, [r4, #24]
c0d040ba:	8c62      	ldrh	r2, [r4, #34]	; 0x22
c0d040bc:	428a      	cmp	r2, r1
c0d040be:	d30e      	bcc.n	c0d040de <u2f_transport_receive_fakeChannel+0x112>
        if (service->fakeChannelCrc != service->commandCrc) {
c0d040c0:	8ce1      	ldrh	r1, [r4, #38]	; 0x26
c0d040c2:	4288      	cmp	r0, r1
c0d040c4:	d1a3      	bne.n	c0d0400e <u2f_transport_receive_fakeChannel+0x42>
            goto error;
        }
        service->fakeChannelTransportState = U2F_FAKE_RECEIVED;
c0d040c6:	2006      	movs	r0, #6
c0d040c8:	7038      	strb	r0, [r7, #0]
        service->fakeChannelTransportOffset = 0;
c0d040ca:	2500      	movs	r5, #0
c0d040cc:	8465      	strh	r5, [r4, #34]	; 0x22
        // reply immediately when the asynch response is not yet ready
        if (service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_ON) {
c0d040ce:	202a      	movs	r0, #42	; 0x2a
c0d040d0:	5c20      	ldrb	r0, [r4, r0]
c0d040d2:	2801      	cmp	r0, #1
c0d040d4:	d103      	bne.n	c0d040de <u2f_transport_receive_fakeChannel+0x112>
            u2f_transport_send_usb_user_presence_required(service);
c0d040d6:	4620      	mov	r0, r4
c0d040d8:	f7ff ff42 	bl	c0d03f60 <u2f_transport_send_usb_user_presence_required>
            // response sent
            service->fakeChannelTransportState = U2F_IDLE;
c0d040dc:	703d      	strb	r5, [r7, #0]
c0d040de:	9803      	ldr	r0, [sp, #12]
c0d040e0:	e798      	b.n	c0d04014 <u2f_transport_receive_fakeChannel+0x48>
c0d040e2:	46c0      	nop			; (mov r8, r8)
c0d040e4:	0000ffff 	.word	0x0000ffff

c0d040e8 <u2f_transport_received>:
/** 
 * Function that process every message received on a media.
 * Performs message concatenation when message is splitted.
 */
void u2f_transport_received(u2f_service_t *service, uint8_t *buffer,
                          uint16_t size, u2f_transport_media_t media) {
c0d040e8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d040ea:	b08b      	sub	sp, #44	; 0x2c
c0d040ec:	4604      	mov	r4, r0
    uint16_t channelHeader = (media == U2F_MEDIA_USB ? 4 : 0);
    uint16_t xfer_len;
    service->media = media;
c0d040ee:	7223      	strb	r3, [r4, #8]

    // Handle a busy channel and avoid reentry
    if (service->transportState == U2F_SENDING_RESPONSE) {
c0d040f0:	2020      	movs	r0, #32
c0d040f2:	5c20      	ldrb	r0, [r4, r0]
c0d040f4:	4627      	mov	r7, r4
c0d040f6:	3720      	adds	r7, #32
            // Message to short, abort
            u2f_transport_error(service, ERROR_PROP_MESSAGE_TOO_SHORT);
            goto error;
        }
        // check this is a command, cannot accept continuation without previous command
        if ((buffer[channelHeader+0]&U2F_MASK_COMMAND) == 0) {
c0d040f8:	2585      	movs	r5, #133	; 0x85
    uint16_t channelHeader = (media == U2F_MEDIA_USB ? 4 : 0);
    uint16_t xfer_len;
    service->media = media;

    // Handle a busy channel and avoid reentry
    if (service->transportState == U2F_SENDING_RESPONSE) {
c0d040fa:	2803      	cmp	r0, #3
c0d040fc:	d00e      	beq.n	c0d0411c <u2f_transport_received+0x34>
c0d040fe:	9109      	str	r1, [sp, #36]	; 0x24
c0d04100:	920a      	str	r2, [sp, #40]	; 0x28
        u2f_transport_error(service, ERROR_CHANNEL_BUSY);
        goto error;
    }
    if (service->waitAsynchronousResponse != U2F_WAIT_ASYNCH_IDLE) {
c0d04102:	212a      	movs	r1, #42	; 0x2a
c0d04104:	5c61      	ldrb	r1, [r4, r1]
c0d04106:	4626      	mov	r6, r4
c0d04108:	362a      	adds	r6, #42	; 0x2a
c0d0410a:	2900      	cmp	r1, #0
c0d0410c:	d013      	beq.n	c0d04136 <u2f_transport_received+0x4e>
        if (!u2f_transport_receive_fakeChannel(service, buffer, size)) {
c0d0410e:	4620      	mov	r0, r4
c0d04110:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d04112:	9a0a      	ldr	r2, [sp, #40]	; 0x28
c0d04114:	f7ff ff5a 	bl	c0d03fcc <u2f_transport_receive_fakeChannel>
c0d04118:	2800      	cmp	r0, #0
c0d0411a:	d173      	bne.n	c0d04204 <u2f_transport_received+0x11c>
c0d0411c:	48e0      	ldr	r0, [pc, #896]	; (c0d044a0 <u2f_transport_received+0x3b8>)
c0d0411e:	2106      	movs	r1, #6
c0d04120:	7201      	strb	r1, [r0, #8]
c0d04122:	2104      	movs	r1, #4
c0d04124:	7039      	strb	r1, [r7, #0]
c0d04126:	2100      	movs	r1, #0
c0d04128:	76a1      	strb	r1, [r4, #26]
c0d0412a:	3008      	adds	r0, #8
c0d0412c:	61e0      	str	r0, [r4, #28]
c0d0412e:	82e1      	strh	r1, [r4, #22]
c0d04130:	2001      	movs	r0, #1
c0d04132:	8320      	strh	r0, [r4, #24]
c0d04134:	e05f      	b.n	c0d041f6 <u2f_transport_received+0x10e>
        }
        return;
    }
    
    // SENDING_ERROR is accepted, and triggers a reset => means the host hasn't consumed the error.
    if (service->transportState == U2F_SENDING_ERROR) {
c0d04136:	2804      	cmp	r0, #4
c0d04138:	d109      	bne.n	c0d0414e <u2f_transport_received+0x66>
c0d0413a:	2000      	movs	r0, #0
#warning TODO take into account the INIT during SEGMENTED message correctly (avoid erasing the first part of the apdu buffer when doing so)

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
c0d0413c:	82e0      	strh	r0, [r4, #22]
    service->transportMedia = 0;
    service->transportPacketIndex = 0;
c0d0413e:	76a0      	strb	r0, [r4, #26]
    service->fakeChannelTransportState = U2F_IDLE;
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
c0d04140:	212b      	movs	r1, #43	; 0x2b
c0d04142:	5460      	strb	r0, [r4, r1]
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
c0d04144:	7030      	strb	r0, [r6, #0]

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
    service->transportMedia = 0;
c0d04146:	80b8      	strh	r0, [r7, #4]
c0d04148:	6038      	str	r0, [r7, #0]
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
    // reset the receive buffer to allow for a new message to be received again (in case transmission of a CODE buffer the previous reply)
    service->transportBuffer = service->transportReceiveBuffer;
c0d0414a:	68e0      	ldr	r0, [r4, #12]
c0d0414c:	61e0      	str	r0, [r4, #28]
    // SENDING_ERROR is accepted, and triggers a reset => means the host hasn't consumed the error.
    if (service->transportState == U2F_SENDING_ERROR) {
        u2f_transport_reset(service);
    }

    if (size < (1 + channelHeader)) {
c0d0414e:	2104      	movs	r1, #4
c0d04150:	2000      	movs	r0, #0
c0d04152:	9308      	str	r3, [sp, #32]
c0d04154:	2b01      	cmp	r3, #1
c0d04156:	d000      	beq.n	c0d0415a <u2f_transport_received+0x72>
c0d04158:	4601      	mov	r1, r0
c0d0415a:	2301      	movs	r3, #1
c0d0415c:	460a      	mov	r2, r1
c0d0415e:	431a      	orrs	r2, r3
c0d04160:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d04162:	4290      	cmp	r0, r2
c0d04164:	d33d      	bcc.n	c0d041e2 <u2f_transport_received+0xfa>
c0d04166:	9204      	str	r2, [sp, #16]
        // Message to short, abort
        u2f_transport_error(service, ERROR_PROP_MESSAGE_TOO_SHORT);
        goto error;
    }
    if (media == U2F_MEDIA_USB) {
c0d04168:	9808      	ldr	r0, [sp, #32]
c0d0416a:	2801      	cmp	r0, #1
c0d0416c:	9106      	str	r1, [sp, #24]
c0d0416e:	9505      	str	r5, [sp, #20]
c0d04170:	9307      	str	r3, [sp, #28]
c0d04172:	d107      	bne.n	c0d04184 <u2f_transport_received+0x9c>
        // hold the current channel value to reply to, for example, INIT commands within flow of segments.
        os_memmove(service->channel, buffer, 4);
c0d04174:	1d20      	adds	r0, r4, #4
c0d04176:	2204      	movs	r2, #4
c0d04178:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d0417a:	f7fd fbe8 	bl	c0d0194e <os_memmove>
c0d0417e:	9906      	ldr	r1, [sp, #24]
c0d04180:	9b07      	ldr	r3, [sp, #28]
c0d04182:	9d05      	ldr	r5, [sp, #20]
    }

    // no previous chunk processed for the current message
    if (service->transportOffset == 0
c0d04184:	8ae0      	ldrh	r0, [r4, #22]
c0d04186:	4ac7      	ldr	r2, [pc, #796]	; (c0d044a4 <u2f_transport_received+0x3bc>)
        // on USB we could get an INIT within a flow of segments.
        || (media == U2F_MEDIA_USB && os_memcmp(service->transportChannel, service->channel, 4) != 0) ) {
c0d04188:	2800      	cmp	r0, #0
c0d0418a:	d00f      	beq.n	c0d041ac <u2f_transport_received+0xc4>
c0d0418c:	9808      	ldr	r0, [sp, #32]
c0d0418e:	2801      	cmp	r0, #1
c0d04190:	d122      	bne.n	c0d041d8 <u2f_transport_received+0xf0>
c0d04192:	4620      	mov	r0, r4
c0d04194:	3012      	adds	r0, #18
c0d04196:	1d21      	adds	r1, r4, #4
c0d04198:	4615      	mov	r5, r2
c0d0419a:	2204      	movs	r2, #4
c0d0419c:	f7fd fc74 	bl	c0d01a88 <os_memcmp>
c0d041a0:	9906      	ldr	r1, [sp, #24]
c0d041a2:	462a      	mov	r2, r5
c0d041a4:	9b07      	ldr	r3, [sp, #28]
c0d041a6:	9d05      	ldr	r5, [sp, #20]
        // hold the current channel value to reply to, for example, INIT commands within flow of segments.
        os_memmove(service->channel, buffer, 4);
    }

    // no previous chunk processed for the current message
    if (service->transportOffset == 0
c0d041a8:	2800      	cmp	r0, #0
c0d041aa:	d015      	beq.n	c0d041d8 <u2f_transport_received+0xf0>
        // on USB we could get an INIT within a flow of segments.
        || (media == U2F_MEDIA_USB && os_memcmp(service->transportChannel, service->channel, 4) != 0) ) {
        if (size < (channelHeader + 3)) {
c0d041ac:	2603      	movs	r6, #3
c0d041ae:	4608      	mov	r0, r1
c0d041b0:	9603      	str	r6, [sp, #12]
c0d041b2:	4330      	orrs	r0, r6
c0d041b4:	460e      	mov	r6, r1
c0d041b6:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d041b8:	4281      	cmp	r1, r0
c0d041ba:	d312      	bcc.n	c0d041e2 <u2f_transport_received+0xfa>
c0d041bc:	9909      	ldr	r1, [sp, #36]	; 0x24
            // Message to short, abort
            u2f_transport_error(service, ERROR_PROP_MESSAGE_TOO_SHORT);
            goto error;
        }
        // check this is a command, cannot accept continuation without previous command
        if ((buffer[channelHeader+0]&U2F_MASK_COMMAND) == 0) {
c0d041be:	1988      	adds	r0, r1, r6
c0d041c0:	9002      	str	r0, [sp, #8]
c0d041c2:	5788      	ldrsb	r0, [r1, r6]
c0d041c4:	460e      	mov	r6, r1
c0d041c6:	4629      	mov	r1, r5
c0d041c8:	317a      	adds	r1, #122	; 0x7a
c0d041ca:	b249      	sxtb	r1, r1
c0d041cc:	4288      	cmp	r0, r1
c0d041ce:	dd37      	ble.n	c0d04240 <u2f_transport_received+0x158>
c0d041d0:	48b3      	ldr	r0, [pc, #716]	; (c0d044a0 <u2f_transport_received+0x3b8>)
c0d041d2:	2104      	movs	r1, #4
c0d041d4:	7201      	strb	r1, [r0, #8]
c0d041d6:	e007      	b.n	c0d041e8 <u2f_transport_received+0x100>
c0d041d8:	2002      	movs	r0, #2
            service->transportPacketIndex = 0;
            os_memmove(service->transportChannel, service->channel, 4);
        }
    } else {
        // Continuation
        if (size < (channelHeader + 2)) {
c0d041da:	4308      	orrs	r0, r1
c0d041dc:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d041de:	4281      	cmp	r1, r0
c0d041e0:	d212      	bcs.n	c0d04208 <u2f_transport_received+0x120>
c0d041e2:	48af      	ldr	r0, [pc, #700]	; (c0d044a0 <u2f_transport_received+0x3b8>)
c0d041e4:	7205      	strb	r5, [r0, #8]
c0d041e6:	2104      	movs	r1, #4
c0d041e8:	7039      	strb	r1, [r7, #0]
c0d041ea:	2100      	movs	r1, #0
c0d041ec:	76a1      	strb	r1, [r4, #26]
c0d041ee:	3008      	adds	r0, #8
c0d041f0:	61e0      	str	r0, [r4, #28]
c0d041f2:	82e1      	strh	r1, [r4, #22]
c0d041f4:	8323      	strh	r3, [r4, #24]
c0d041f6:	353a      	adds	r5, #58	; 0x3a
c0d041f8:	2040      	movs	r0, #64	; 0x40
c0d041fa:	5425      	strb	r5, [r4, r0]
c0d041fc:	7a21      	ldrb	r1, [r4, #8]
c0d041fe:	4620      	mov	r0, r4
c0d04200:	f7ff fe38 	bl	c0d03e74 <u2f_transport_sent>
        service->seqTimeout = 0;
        service->transportState = U2F_HANDLE_SEGMENTED;
    }
error:
    return;
}
c0d04204:	b00b      	add	sp, #44	; 0x2c
c0d04206:	bdf0      	pop	{r4, r5, r6, r7, pc}
        if (size < (channelHeader + 2)) {
            // Message to short, abort
            u2f_transport_error(service, ERROR_PROP_MESSAGE_TOO_SHORT);
            goto error;
        }
        if (media != service->transportMedia) {
c0d04208:	2021      	movs	r0, #33	; 0x21
c0d0420a:	5c20      	ldrb	r0, [r4, r0]
c0d0420c:	9908      	ldr	r1, [sp, #32]
c0d0420e:	4288      	cmp	r0, r1
c0d04210:	d14d      	bne.n	c0d042ae <u2f_transport_received+0x1c6>
            // Mixed medias
            u2f_transport_error(service, ERROR_PROP_MEDIA_MIXED);
            goto error;
        }
        if (service->transportState != U2F_HANDLE_SEGMENTED) {
c0d04212:	7838      	ldrb	r0, [r7, #0]
c0d04214:	2801      	cmp	r0, #1
c0d04216:	d156      	bne.n	c0d042c6 <u2f_transport_received+0x1de>
c0d04218:	9203      	str	r2, [sp, #12]
            } else {
                u2f_transport_error(service, ERROR_INVALID_SEQ);
                goto error;
            }
        }
        if (media == U2F_MEDIA_USB) {
c0d0421a:	9808      	ldr	r0, [sp, #32]
c0d0421c:	2801      	cmp	r0, #1
c0d0421e:	d000      	beq.n	c0d04222 <u2f_transport_received+0x13a>
c0d04220:	e085      	b.n	c0d0432e <u2f_transport_received+0x246>
            // Check the channel
            if (os_memcmp(buffer, service->channel, 4) != 0) {
c0d04222:	1d21      	adds	r1, r4, #4
c0d04224:	2504      	movs	r5, #4
c0d04226:	9809      	ldr	r0, [sp, #36]	; 0x24
c0d04228:	462a      	mov	r2, r5
c0d0422a:	461e      	mov	r6, r3
c0d0422c:	f7fd fc2c 	bl	c0d01a88 <os_memcmp>
c0d04230:	4633      	mov	r3, r6
c0d04232:	2800      	cmp	r0, #0
c0d04234:	d07b      	beq.n	c0d0432e <u2f_transport_received+0x246>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d04236:	489a      	ldr	r0, [pc, #616]	; (c0d044a0 <u2f_transport_received+0x3b8>)
c0d04238:	2106      	movs	r1, #6
c0d0423a:	7201      	strb	r1, [r0, #8]

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
c0d0423c:	703d      	strb	r5, [r7, #0]
c0d0423e:	e0f6      	b.n	c0d0442e <u2f_transport_received+0x346>
c0d04240:	9b08      	ldr	r3, [sp, #32]
            goto error;
        }

        // If waiting for a continuation on a different channel, reply BUSY
        // immediately
        if (media == U2F_MEDIA_USB) {
c0d04242:	2b01      	cmp	r3, #1
c0d04244:	d116      	bne.n	c0d04274 <u2f_transport_received+0x18c>
            if ((service->transportState == U2F_HANDLE_SEGMENTED) &&
c0d04246:	7838      	ldrb	r0, [r7, #0]
c0d04248:	2801      	cmp	r0, #1
c0d0424a:	d11f      	bne.n	c0d0428c <u2f_transport_received+0x1a4>
                (os_memcmp(service->channel, service->transportChannel, 4) !=
c0d0424c:	1d20      	adds	r0, r4, #4
c0d0424e:	4621      	mov	r1, r4
c0d04250:	3112      	adds	r1, #18
c0d04252:	4615      	mov	r5, r2
c0d04254:	2204      	movs	r2, #4
c0d04256:	9001      	str	r0, [sp, #4]
c0d04258:	f7fd fc16 	bl	c0d01a88 <os_memcmp>
c0d0425c:	462a      	mov	r2, r5
c0d0425e:	9b08      	ldr	r3, [sp, #32]
c0d04260:	9d05      	ldr	r5, [sp, #20]
                 0) &&
c0d04262:	2800      	cmp	r0, #0
c0d04264:	d006      	beq.n	c0d04274 <u2f_transport_received+0x18c>
                (buffer[channelHeader] != U2F_CMD_INIT)) {
c0d04266:	9802      	ldr	r0, [sp, #8]
c0d04268:	7800      	ldrb	r0, [r0, #0]
c0d0426a:	1c69      	adds	r1, r5, #1
c0d0426c:	b2c9      	uxtb	r1, r1
        }

        // If waiting for a continuation on a different channel, reply BUSY
        // immediately
        if (media == U2F_MEDIA_USB) {
            if ((service->transportState == U2F_HANDLE_SEGMENTED) &&
c0d0426e:	4288      	cmp	r0, r1
c0d04270:	d000      	beq.n	c0d04274 <u2f_transport_received+0x18c>
c0d04272:	e0f6      	b.n	c0d04462 <u2f_transport_received+0x37a>
                goto error;
            }
        }
        // If a command was already sent, and we are not processing a INIT
        // command, abort
        if ((service->transportState == U2F_HANDLE_SEGMENTED) &&
c0d04274:	7838      	ldrb	r0, [r7, #0]
c0d04276:	2801      	cmp	r0, #1
c0d04278:	d108      	bne.n	c0d0428c <u2f_transport_received+0x1a4>
            !((media == U2F_MEDIA_USB) &&
c0d0427a:	2b01      	cmp	r3, #1
c0d0427c:	d000      	beq.n	c0d04280 <u2f_transport_received+0x198>
c0d0427e:	e082      	b.n	c0d04386 <u2f_transport_received+0x29e>
              (buffer[channelHeader] == U2F_CMD_INIT))) {
c0d04280:	9802      	ldr	r0, [sp, #8]
c0d04282:	7800      	ldrb	r0, [r0, #0]
c0d04284:	1c69      	adds	r1, r5, #1
c0d04286:	b2c9      	uxtb	r1, r1
                goto error;
            }
        }
        // If a command was already sent, and we are not processing a INIT
        // command, abort
        if ((service->transportState == U2F_HANDLE_SEGMENTED) &&
c0d04288:	4288      	cmp	r0, r1
c0d0428a:	d17c      	bne.n	c0d04386 <u2f_transport_received+0x29e>
            u2f_transport_error(service, ERROR_INVALID_SEQ);
            goto error;
        }
        // Check the length
        uint16_t commandLength =
            (buffer[channelHeader + 1] << 8) | (buffer[channelHeader + 2]);
c0d0428c:	2002      	movs	r0, #2
c0d0428e:	9906      	ldr	r1, [sp, #24]
c0d04290:	4308      	orrs	r0, r1
c0d04292:	5c30      	ldrb	r0, [r6, r0]
c0d04294:	9904      	ldr	r1, [sp, #16]
c0d04296:	5c71      	ldrb	r1, [r6, r1]
c0d04298:	0209      	lsls	r1, r1, #8
c0d0429a:	4301      	orrs	r1, r0
        if (commandLength > (service->transportReceiveBufferLength - 3)) {
c0d0429c:	8a20      	ldrh	r0, [r4, #16]
c0d0429e:	1ec0      	subs	r0, r0, #3
c0d042a0:	4281      	cmp	r1, r0
c0d042a2:	dd1e      	ble.n	c0d042e2 <u2f_transport_received+0x1fa>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d042a4:	487e      	ldr	r0, [pc, #504]	; (c0d044a0 <u2f_transport_received+0x3b8>)
c0d042a6:	9903      	ldr	r1, [sp, #12]
c0d042a8:	7201      	strb	r1, [r0, #8]

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
c0d042aa:	2104      	movs	r1, #4
c0d042ac:	e06e      	b.n	c0d0438c <u2f_transport_received+0x2a4>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d042ae:	4628      	mov	r0, r5
c0d042b0:	3008      	adds	r0, #8
c0d042b2:	497b      	ldr	r1, [pc, #492]	; (c0d044a0 <u2f_transport_received+0x3b8>)
c0d042b4:	7208      	strb	r0, [r1, #8]

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
c0d042b6:	2004      	movs	r0, #4
c0d042b8:	7038      	strb	r0, [r7, #0]
c0d042ba:	2000      	movs	r0, #0
    service->transportPacketIndex = 0;
c0d042bc:	76a0      	strb	r0, [r4, #26]
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d042be:	3108      	adds	r1, #8

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
    service->transportPacketIndex = 0;
    service->transportBuffer = G_io_usb_ep_buffer + 8;
c0d042c0:	61e1      	str	r1, [r4, #28]
    service->transportOffset = 0;
c0d042c2:	82e0      	strh	r0, [r4, #22]
c0d042c4:	e796      	b.n	c0d041f4 <u2f_transport_received+0x10c>
            goto error;
        }
        if (service->transportState != U2F_HANDLE_SEGMENTED) {
            // Unexpected continuation at this stage, abort
            // TODO : review the behavior is HID only
            if (media == U2F_MEDIA_USB) {
c0d042c6:	9808      	ldr	r0, [sp, #32]
c0d042c8:	2801      	cmp	r0, #1
c0d042ca:	d181      	bne.n	c0d041d0 <u2f_transport_received+0xe8>
c0d042cc:	2000      	movs	r0, #0
#warning TODO take into account the INIT during SEGMENTED message correctly (avoid erasing the first part of the apdu buffer when doing so)

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
c0d042ce:	82e0      	strh	r0, [r4, #22]
    service->transportMedia = 0;
    service->transportPacketIndex = 0;
c0d042d0:	76a0      	strb	r0, [r4, #26]
    service->fakeChannelTransportState = U2F_IDLE;
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
c0d042d2:	212b      	movs	r1, #43	; 0x2b
c0d042d4:	5460      	strb	r0, [r4, r1]
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
c0d042d6:	7030      	strb	r0, [r6, #0]

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
    service->transportMedia = 0;
c0d042d8:	80b8      	strh	r0, [r7, #4]
c0d042da:	6038      	str	r0, [r7, #0]
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
    // reset the receive buffer to allow for a new message to be received again (in case transmission of a CODE buffer the previous reply)
    service->transportBuffer = service->transportReceiveBuffer;
c0d042dc:	68e0      	ldr	r0, [r4, #12]
c0d042de:	61e0      	str	r0, [r4, #28]
c0d042e0:	e790      	b.n	c0d04204 <u2f_transport_received+0x11c>
            // Overflow in message size, abort
            u2f_transport_error(service, ERROR_INVALID_LEN);
            goto error;
        }
        // Check if the command is supported
        switch (buffer[channelHeader]) {
c0d042e2:	9802      	ldr	r0, [sp, #8]
c0d042e4:	7800      	ldrb	r0, [r0, #0]
c0d042e6:	2881      	cmp	r0, #129	; 0x81
c0d042e8:	9b07      	ldr	r3, [sp, #28]
c0d042ea:	d004      	beq.n	c0d042f6 <u2f_transport_received+0x20e>
c0d042ec:	2886      	cmp	r0, #134	; 0x86
c0d042ee:	d059      	beq.n	c0d043a4 <u2f_transport_received+0x2bc>
c0d042f0:	2883      	cmp	r0, #131	; 0x83
c0d042f2:	d000      	beq.n	c0d042f6 <u2f_transport_received+0x20e>
c0d042f4:	e0ac      	b.n	c0d04450 <u2f_transport_received+0x368>
c0d042f6:	9109      	str	r1, [sp, #36]	; 0x24
c0d042f8:	9203      	str	r2, [sp, #12]
        case U2F_CMD_PING:
        case U2F_CMD_MSG:
            if (media == U2F_MEDIA_USB) {
c0d042fa:	9808      	ldr	r0, [sp, #32]
c0d042fc:	2801      	cmp	r0, #1
c0d042fe:	d15f      	bne.n	c0d043c0 <u2f_transport_received+0x2d8>
                if (u2f_is_channel_broadcast(service->channel) ||
c0d04300:	1d26      	adds	r6, r4, #4
error:
    return;
}

bool u2f_is_channel_broadcast(uint8_t *channel) {
    return (os_memcmp(channel, BROADCAST_CHANNEL, 4) == 0);
c0d04302:	4969      	ldr	r1, [pc, #420]	; (c0d044a8 <u2f_transport_received+0x3c0>)
c0d04304:	4479      	add	r1, pc
c0d04306:	2504      	movs	r5, #4
c0d04308:	4630      	mov	r0, r6
c0d0430a:	462a      	mov	r2, r5
c0d0430c:	f7fd fbbc 	bl	c0d01a88 <os_memcmp>
        // Check if the command is supported
        switch (buffer[channelHeader]) {
        case U2F_CMD_PING:
        case U2F_CMD_MSG:
            if (media == U2F_MEDIA_USB) {
                if (u2f_is_channel_broadcast(service->channel) ||
c0d04310:	2800      	cmp	r0, #0
c0d04312:	d007      	beq.n	c0d04324 <u2f_transport_received+0x23c>
bool u2f_is_channel_broadcast(uint8_t *channel) {
    return (os_memcmp(channel, BROADCAST_CHANNEL, 4) == 0);
}

bool u2f_is_channel_forbidden(uint8_t *channel) {
    return (os_memcmp(channel, FORBIDDEN_CHANNEL, 4) == 0);
c0d04314:	4965      	ldr	r1, [pc, #404]	; (c0d044ac <u2f_transport_received+0x3c4>)
c0d04316:	4479      	add	r1, pc
c0d04318:	2204      	movs	r2, #4
c0d0431a:	4630      	mov	r0, r6
c0d0431c:	f7fd fbb4 	bl	c0d01a88 <os_memcmp>
        // Check if the command is supported
        switch (buffer[channelHeader]) {
        case U2F_CMD_PING:
        case U2F_CMD_MSG:
            if (media == U2F_MEDIA_USB) {
                if (u2f_is_channel_broadcast(service->channel) ||
c0d04320:	2800      	cmp	r0, #0
c0d04322:	d14d      	bne.n	c0d043c0 <u2f_transport_received+0x2d8>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d04324:	485e      	ldr	r0, [pc, #376]	; (c0d044a0 <u2f_transport_received+0x3b8>)
c0d04326:	210b      	movs	r1, #11
c0d04328:	7201      	strb	r1, [r0, #8]

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
c0d0432a:	703d      	strb	r5, [r7, #0]
c0d0432c:	e0b0      	b.n	c0d04490 <u2f_transport_received+0x3a8>
c0d0432e:	9806      	ldr	r0, [sp, #24]
c0d04330:	9a09      	ldr	r2, [sp, #36]	; 0x24
                u2f_transport_error(service, ERROR_CHANNEL_BUSY);
                goto error;
            }
        }
        // also discriminate invalid command sent instead of a continuation
        if (buffer[channelHeader] != service->transportPacketIndex) {
c0d04332:	1811      	adds	r1, r2, r0
c0d04334:	5c10      	ldrb	r0, [r2, r0]
c0d04336:	7ea2      	ldrb	r2, [r4, #26]
c0d04338:	4290      	cmp	r0, r2
c0d0433a:	d12f      	bne.n	c0d0439c <u2f_transport_received+0x2b4>
            // Bad continuation packet, abort
            u2f_transport_error(service, ERROR_INVALID_SEQ);
            goto error;
        }
        xfer_len = MIN(size - (channelHeader + 1), service->transportLength - service->transportOffset);
c0d0433c:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d0433e:	9a04      	ldr	r2, [sp, #16]
c0d04340:	1a85      	subs	r5, r0, r2
c0d04342:	8ae0      	ldrh	r0, [r4, #22]
c0d04344:	8b22      	ldrh	r2, [r4, #24]
c0d04346:	1a12      	subs	r2, r2, r0
c0d04348:	4295      	cmp	r5, r2
c0d0434a:	db00      	blt.n	c0d0434e <u2f_transport_received+0x266>
c0d0434c:	4615      	mov	r5, r2
c0d0434e:	9e03      	ldr	r6, [sp, #12]
        os_memmove(service->transportBuffer + service->transportOffset, buffer + channelHeader + 1, xfer_len);
c0d04350:	402e      	ands	r6, r5
c0d04352:	69e2      	ldr	r2, [r4, #28]
c0d04354:	1810      	adds	r0, r2, r0
c0d04356:	1c49      	adds	r1, r1, #1
c0d04358:	4632      	mov	r2, r6
c0d0435a:	f7fd faf8 	bl	c0d0194e <os_memmove>
        if (media == U2F_MEDIA_USB) {
c0d0435e:	9808      	ldr	r0, [sp, #32]
c0d04360:	2801      	cmp	r0, #1
c0d04362:	d107      	bne.n	c0d04374 <u2f_transport_received+0x28c>
            service->commandCrc = cx_crc16_update(service->commandCrc, service->transportBuffer + service->transportOffset, xfer_len);
c0d04364:	8ae0      	ldrh	r0, [r4, #22]
c0d04366:	69e1      	ldr	r1, [r4, #28]
c0d04368:	1809      	adds	r1, r1, r0
c0d0436a:	8ce0      	ldrh	r0, [r4, #38]	; 0x26
c0d0436c:	4632      	mov	r2, r6
c0d0436e:	f7fe fe91 	bl	c0d03094 <cx_crc16_update>
c0d04372:	84e0      	strh	r0, [r4, #38]	; 0x26
        }        
        service->transportOffset += xfer_len;
c0d04374:	8ae0      	ldrh	r0, [r4, #22]
c0d04376:	1940      	adds	r0, r0, r5
c0d04378:	82e0      	strh	r0, [r4, #22]
        service->transportPacketIndex++;
c0d0437a:	7ea0      	ldrb	r0, [r4, #26]
c0d0437c:	1c40      	adds	r0, r0, #1
c0d0437e:	76a0      	strb	r0, [r4, #26]
c0d04380:	9b07      	ldr	r3, [sp, #28]
c0d04382:	9d08      	ldr	r5, [sp, #32]
c0d04384:	e045      	b.n	c0d04412 <u2f_transport_received+0x32a>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d04386:	4846      	ldr	r0, [pc, #280]	; (c0d044a0 <u2f_transport_received+0x3b8>)
c0d04388:	2104      	movs	r1, #4
c0d0438a:	7201      	strb	r1, [r0, #8]
c0d0438c:	7039      	strb	r1, [r7, #0]
c0d0438e:	2100      	movs	r1, #0
c0d04390:	76a1      	strb	r1, [r4, #26]
c0d04392:	3008      	adds	r0, #8
c0d04394:	61e0      	str	r0, [r4, #28]
c0d04396:	82e1      	strh	r1, [r4, #22]
c0d04398:	9807      	ldr	r0, [sp, #28]
c0d0439a:	e6ca      	b.n	c0d04132 <u2f_transport_received+0x4a>
c0d0439c:	4840      	ldr	r0, [pc, #256]	; (c0d044a0 <u2f_transport_received+0x3b8>)
c0d0439e:	2104      	movs	r1, #4
c0d043a0:	7201      	strb	r1, [r0, #8]
c0d043a2:	e043      	b.n	c0d0442c <u2f_transport_received+0x344>
                }
            }
            // no channel for BLE
            break;
        case U2F_CMD_INIT:
            if (media != U2F_MEDIA_USB) {
c0d043a4:	9808      	ldr	r0, [sp, #32]
c0d043a6:	2801      	cmp	r0, #1
c0d043a8:	d152      	bne.n	c0d04450 <u2f_transport_received+0x368>
c0d043aa:	9109      	str	r1, [sp, #36]	; 0x24
c0d043ac:	9203      	str	r2, [sp, #12]
                // Unknown command, abort
                u2f_transport_error(service, ERROR_INVALID_CMD);
                goto error;
            }

            if (u2f_is_channel_forbidden(service->channel)) {
c0d043ae:	1d20      	adds	r0, r4, #4
bool u2f_is_channel_broadcast(uint8_t *channel) {
    return (os_memcmp(channel, BROADCAST_CHANNEL, 4) == 0);
}

bool u2f_is_channel_forbidden(uint8_t *channel) {
    return (os_memcmp(channel, FORBIDDEN_CHANNEL, 4) == 0);
c0d043b0:	493f      	ldr	r1, [pc, #252]	; (c0d044b0 <u2f_transport_received+0x3c8>)
c0d043b2:	4479      	add	r1, pc
c0d043b4:	2604      	movs	r6, #4
c0d043b6:	4632      	mov	r2, r6
c0d043b8:	f7fd fb66 	bl	c0d01a88 <os_memcmp>
                // Unknown command, abort
                u2f_transport_error(service, ERROR_INVALID_CMD);
                goto error;
            }

            if (u2f_is_channel_forbidden(service->channel)) {
c0d043bc:	2800      	cmp	r0, #0
c0d043be:	d063      	beq.n	c0d04488 <u2f_transport_received+0x3a0>
        }

        // Ok, initialize the buffer
        //if (buffer[channelHeader] != U2F_CMD_INIT) 
        {
            xfer_len = MIN(size - (channelHeader), U2F_COMMAND_HEADER_SIZE+commandLength);
c0d043c0:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d043c2:	9906      	ldr	r1, [sp, #24]
c0d043c4:	1a46      	subs	r6, r0, r1
c0d043c6:	9809      	ldr	r0, [sp, #36]	; 0x24
c0d043c8:	1cc0      	adds	r0, r0, #3
c0d043ca:	4286      	cmp	r6, r0
c0d043cc:	9d03      	ldr	r5, [sp, #12]
c0d043ce:	db00      	blt.n	c0d043d2 <u2f_transport_received+0x2ea>
c0d043d0:	4606      	mov	r6, r0
c0d043d2:	900a      	str	r0, [sp, #40]	; 0x28
            os_memmove(service->transportBuffer, buffer + channelHeader, xfer_len);
c0d043d4:	4035      	ands	r5, r6
c0d043d6:	69e0      	ldr	r0, [r4, #28]
c0d043d8:	9902      	ldr	r1, [sp, #8]
c0d043da:	462a      	mov	r2, r5
c0d043dc:	f7fd fab7 	bl	c0d0194e <os_memmove>
c0d043e0:	9b08      	ldr	r3, [sp, #32]
            if (media == U2F_MEDIA_USB) {
c0d043e2:	2b01      	cmp	r3, #1
c0d043e4:	d106      	bne.n	c0d043f4 <u2f_transport_received+0x30c>
                service->commandCrc = cx_crc16_update(0, service->transportBuffer, xfer_len);
c0d043e6:	69e1      	ldr	r1, [r4, #28]
c0d043e8:	2000      	movs	r0, #0
c0d043ea:	462a      	mov	r2, r5
c0d043ec:	f7fe fe52 	bl	c0d03094 <cx_crc16_update>
c0d043f0:	9b08      	ldr	r3, [sp, #32]
c0d043f2:	84e0      	strh	r0, [r4, #38]	; 0x26
            }
            service->transportOffset = xfer_len;
c0d043f4:	82e6      	strh	r6, [r4, #22]
            service->transportLength = U2F_COMMAND_HEADER_SIZE+commandLength;
c0d043f6:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d043f8:	8320      	strh	r0, [r4, #24]
            service->transportMedia = media;
c0d043fa:	2021      	movs	r0, #33	; 0x21
c0d043fc:	5423      	strb	r3, [r4, r0]
            // initialize the response
            service->transportPacketIndex = 0;
c0d043fe:	2000      	movs	r0, #0
c0d04400:	76a0      	strb	r0, [r4, #26]
            os_memmove(service->transportChannel, service->channel, 4);
c0d04402:	4620      	mov	r0, r4
c0d04404:	3012      	adds	r0, #18
c0d04406:	1d21      	adds	r1, r4, #4
c0d04408:	2204      	movs	r2, #4
c0d0440a:	461d      	mov	r5, r3
c0d0440c:	f7fd fa9f 	bl	c0d0194e <os_memmove>
c0d04410:	9b07      	ldr	r3, [sp, #28]
c0d04412:	8ae0      	ldrh	r0, [r4, #22]
        }        
        service->transportOffset += xfer_len;
        service->transportPacketIndex++;
    }
    // See if we can process the command
    if ((media != U2F_MEDIA_USB) &&
c0d04414:	2d01      	cmp	r5, #1
c0d04416:	d101      	bne.n	c0d0441c <u2f_transport_received+0x334>
c0d04418:	8b21      	ldrh	r1, [r4, #24]
c0d0441a:	e013      	b.n	c0d04444 <u2f_transport_received+0x35c>
        (service->transportOffset >
         (service->transportLength + U2F_COMMAND_HEADER_SIZE))) {
c0d0441c:	8b21      	ldrh	r1, [r4, #24]
c0d0441e:	1cca      	adds	r2, r1, #3
        }        
        service->transportOffset += xfer_len;
        service->transportPacketIndex++;
    }
    // See if we can process the command
    if ((media != U2F_MEDIA_USB) &&
c0d04420:	4290      	cmp	r0, r2
c0d04422:	d90f      	bls.n	c0d04444 <u2f_transport_received+0x35c>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d04424:	481e      	ldr	r0, [pc, #120]	; (c0d044a0 <u2f_transport_received+0x3b8>)
c0d04426:	2103      	movs	r1, #3
c0d04428:	7201      	strb	r1, [r0, #8]

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
c0d0442a:	2104      	movs	r1, #4
c0d0442c:	7039      	strb	r1, [r7, #0]
c0d0442e:	2100      	movs	r1, #0
c0d04430:	76a1      	strb	r1, [r4, #26]
c0d04432:	3008      	adds	r0, #8
c0d04434:	61e0      	str	r0, [r4, #28]
c0d04436:	82e1      	strh	r1, [r4, #22]
c0d04438:	8323      	strh	r3, [r4, #24]
c0d0443a:	9905      	ldr	r1, [sp, #20]
c0d0443c:	313a      	adds	r1, #58	; 0x3a
c0d0443e:	2040      	movs	r0, #64	; 0x40
c0d04440:	5421      	strb	r1, [r4, r0]
c0d04442:	e6db      	b.n	c0d041fc <u2f_transport_received+0x114>
        (service->transportOffset >
         (service->transportLength + U2F_COMMAND_HEADER_SIZE))) {
        // Overflow, abort
        u2f_transport_error(service, ERROR_INVALID_LEN);
        goto error;
    } else if (service->transportOffset >= service->transportLength) {
c0d04444:	4288      	cmp	r0, r1
c0d04446:	d206      	bcs.n	c0d04456 <u2f_transport_received+0x36e>
c0d04448:	2000      	movs	r0, #0
        service->transportState = U2F_PROCESSING_COMMAND;
        // internal notification of a complete message received
        u2f_message_complete(service);
    } else {
        // new segment received, reset the timeout for the current piece
        service->seqTimeout = 0;
c0d0444a:	6360      	str	r0, [r4, #52]	; 0x34
        service->transportState = U2F_HANDLE_SEGMENTED;
c0d0444c:	703b      	strb	r3, [r7, #0]
c0d0444e:	e6d9      	b.n	c0d04204 <u2f_transport_received+0x11c>
c0d04450:	4813      	ldr	r0, [pc, #76]	; (c0d044a0 <u2f_transport_received+0x3b8>)
c0d04452:	7203      	strb	r3, [r0, #8]
c0d04454:	e6c7      	b.n	c0d041e6 <u2f_transport_received+0xfe>
        // Overflow, abort
        u2f_transport_error(service, ERROR_INVALID_LEN);
        goto error;
    } else if (service->transportOffset >= service->transportLength) {
        // switch before the handler gets the opportunity to change it again
        service->transportState = U2F_PROCESSING_COMMAND;
c0d04456:	2002      	movs	r0, #2
c0d04458:	7038      	strb	r0, [r7, #0]
        // internal notification of a complete message received
        u2f_message_complete(service);
c0d0445a:	4620      	mov	r0, r4
c0d0445c:	f7ff fcc4 	bl	c0d03de8 <u2f_message_complete>
c0d04460:	e6d0      	b.n	c0d04204 <u2f_transport_received+0x11c>
                // special error case, we reply but don't change the current state of the transport (ongoing message for example)
                //u2f_transport_error_no_reset(service, ERROR_CHANNEL_BUSY);
                uint16_t offset = 0;
                // Fragment
                if (media == U2F_MEDIA_USB) {
                    os_memmove(G_io_usb_ep_buffer, service->channel, 4);
c0d04462:	4c0f      	ldr	r4, [pc, #60]	; (c0d044a0 <u2f_transport_received+0x3b8>)
c0d04464:	2204      	movs	r2, #4
c0d04466:	4620      	mov	r0, r4
c0d04468:	9901      	ldr	r1, [sp, #4]
c0d0446a:	f7fd fa70 	bl	c0d0194e <os_memmove>
                    offset += 4;
                }
                G_io_usb_ep_buffer[offset++] = U2F_STATUS_ERROR;
c0d0446e:	353a      	adds	r5, #58	; 0x3a
c0d04470:	7125      	strb	r5, [r4, #4]
                G_io_usb_ep_buffer[offset++] = 0;
c0d04472:	2000      	movs	r0, #0
c0d04474:	7160      	strb	r0, [r4, #5]
c0d04476:	9a07      	ldr	r2, [sp, #28]
                G_io_usb_ep_buffer[offset++] = 1;
c0d04478:	71a2      	strb	r2, [r4, #6]
c0d0447a:	2006      	movs	r0, #6
                G_io_usb_ep_buffer[offset++] = ERROR_CHANNEL_BUSY;
c0d0447c:	71e0      	strb	r0, [r4, #7]
                u2f_io_send(G_io_usb_ep_buffer, offset, media);
c0d0447e:	2108      	movs	r1, #8
c0d04480:	4620      	mov	r0, r4
c0d04482:	f7ff fccf 	bl	c0d03e24 <u2f_io_send>
c0d04486:	e6bd      	b.n	c0d04204 <u2f_transport_received+0x11c>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d04488:	4805      	ldr	r0, [pc, #20]	; (c0d044a0 <u2f_transport_received+0x3b8>)
c0d0448a:	210b      	movs	r1, #11
c0d0448c:	7201      	strb	r1, [r0, #8]

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
c0d0448e:	703e      	strb	r6, [r7, #0]
c0d04490:	2100      	movs	r1, #0
c0d04492:	76a1      	strb	r1, [r4, #26]
c0d04494:	3008      	adds	r0, #8
c0d04496:	61e0      	str	r0, [r4, #28]
c0d04498:	82e1      	strh	r1, [r4, #22]
c0d0449a:	9807      	ldr	r0, [sp, #28]
c0d0449c:	8320      	strh	r0, [r4, #24]
c0d0449e:	e7cc      	b.n	c0d0443a <u2f_transport_received+0x352>
c0d044a0:	20001b38 	.word	0x20001b38
c0d044a4:	0000ffff 	.word	0x0000ffff
c0d044a8:	00003443 	.word	0x00003443
c0d044ac:	00003435 	.word	0x00003435
c0d044b0:	00003399 	.word	0x00003399

c0d044b4 <u2f_is_channel_broadcast>:
    }
error:
    return;
}

bool u2f_is_channel_broadcast(uint8_t *channel) {
c0d044b4:	b580      	push	{r7, lr}
    return (os_memcmp(channel, BROADCAST_CHANNEL, 4) == 0);
c0d044b6:	4906      	ldr	r1, [pc, #24]	; (c0d044d0 <u2f_is_channel_broadcast+0x1c>)
c0d044b8:	4479      	add	r1, pc
c0d044ba:	2204      	movs	r2, #4
c0d044bc:	f7fd fae4 	bl	c0d01a88 <os_memcmp>
c0d044c0:	4601      	mov	r1, r0
c0d044c2:	2001      	movs	r0, #1
c0d044c4:	2200      	movs	r2, #0
c0d044c6:	2900      	cmp	r1, #0
c0d044c8:	d000      	beq.n	c0d044cc <u2f_is_channel_broadcast+0x18>
c0d044ca:	4610      	mov	r0, r2
c0d044cc:	bd80      	pop	{r7, pc}
c0d044ce:	46c0      	nop			; (mov r8, r8)
c0d044d0:	0000328f 	.word	0x0000328f

c0d044d4 <u2f_message_set_autoreply_wait_user_presence>:
}

/**
 * Auto reply hodl until the real reply is prepared and sent
 */
void u2f_message_set_autoreply_wait_user_presence(u2f_service_t* service, bool enabled) {
c0d044d4:	b580      	push	{r7, lr}
c0d044d6:	222a      	movs	r2, #42	; 0x2a
c0d044d8:	5c83      	ldrb	r3, [r0, r2]
c0d044da:	4602      	mov	r2, r0
c0d044dc:	322a      	adds	r2, #42	; 0x2a

    if (enabled) {
c0d044de:	2901      	cmp	r1, #1
c0d044e0:	d106      	bne.n	c0d044f0 <u2f_message_set_autoreply_wait_user_presence+0x1c>
        // start replying placeholder until user presence validated
        if (service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_IDLE) {
c0d044e2:	2b00      	cmp	r3, #0
c0d044e4:	d108      	bne.n	c0d044f8 <u2f_message_set_autoreply_wait_user_presence+0x24>
            service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_ON;
c0d044e6:	2101      	movs	r1, #1
c0d044e8:	7011      	strb	r1, [r2, #0]
            u2f_transport_send_usb_user_presence_required(service);
c0d044ea:	f7ff fd39 	bl	c0d03f60 <u2f_transport_send_usb_user_presence_required>
    }
    // don't set to REPLY_READY when it has not been enabled beforehand
    else if (service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_ON) {
        service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_REPLY_READY;
    }
}
c0d044ee:	bd80      	pop	{r7, pc}
            service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_ON;
            u2f_transport_send_usb_user_presence_required(service);
        }
    }
    // don't set to REPLY_READY when it has not been enabled beforehand
    else if (service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_ON) {
c0d044f0:	2b01      	cmp	r3, #1
c0d044f2:	d101      	bne.n	c0d044f8 <u2f_message_set_autoreply_wait_user_presence+0x24>
        service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_REPLY_READY;
c0d044f4:	2002      	movs	r0, #2
c0d044f6:	7010      	strb	r0, [r2, #0]
    }
}
c0d044f8:	bd80      	pop	{r7, pc}

c0d044fa <u2f_message_repliable>:

bool u2f_message_repliable(u2f_service_t* service) {
c0d044fa:	4601      	mov	r1, r0
    // no more asynch replies
    // finished receiving the command
    // and not sending a user presence required status
    return service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_IDLE
c0d044fc:	202a      	movs	r0, #42	; 0x2a
c0d044fe:	5c0a      	ldrb	r2, [r1, r0]
c0d04500:	2001      	movs	r0, #1
        || (service->waitAsynchronousResponse != U2F_WAIT_ASYNCH_ON 
c0d04502:	2a00      	cmp	r2, #0
c0d04504:	d010      	beq.n	c0d04528 <u2f_message_repliable+0x2e>
c0d04506:	2a01      	cmp	r2, #1
c0d04508:	d101      	bne.n	c0d0450e <u2f_message_repliable+0x14>
c0d0450a:	2000      	movs	r0, #0

bool u2f_message_repliable(u2f_service_t* service) {
    // no more asynch replies
    // finished receiving the command
    // and not sending a user presence required status
    return service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_IDLE
c0d0450c:	4770      	bx	lr
        || (service->waitAsynchronousResponse != U2F_WAIT_ASYNCH_ON 
            && service->fakeChannelTransportState == U2F_FAKE_RECEIVED 
c0d0450e:	2025      	movs	r0, #37	; 0x25
c0d04510:	5c0a      	ldrb	r2, [r1, r0]
c0d04512:	2000      	movs	r0, #0
            && service->sending == false)
c0d04514:	2a06      	cmp	r2, #6
c0d04516:	d107      	bne.n	c0d04528 <u2f_message_repliable+0x2e>
c0d04518:	202b      	movs	r0, #43	; 0x2b
c0d0451a:	5c0a      	ldrb	r2, [r1, r0]
c0d0451c:	2001      	movs	r0, #1
c0d0451e:	2100      	movs	r1, #0
c0d04520:	2a00      	cmp	r2, #0
c0d04522:	d001      	beq.n	c0d04528 <u2f_message_repliable+0x2e>
c0d04524:	4608      	mov	r0, r1

bool u2f_message_repliable(u2f_service_t* service) {
    // no more asynch replies
    // finished receiving the command
    // and not sending a user presence required status
    return service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_IDLE
c0d04526:	4770      	bx	lr
c0d04528:	4770      	bx	lr

c0d0452a <u2f_message_reply>:
            && service->fakeChannelTransportState == U2F_FAKE_RECEIVED 
            && service->sending == false)
        ;
}

void u2f_message_reply(u2f_service_t *service, uint8_t cmd, uint8_t *buffer, uint16_t len) {
c0d0452a:	b5b0      	push	{r4, r5, r7, lr}

bool u2f_message_repliable(u2f_service_t* service) {
    // no more asynch replies
    // finished receiving the command
    // and not sending a user presence required status
    return service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_IDLE
c0d0452c:	242a      	movs	r4, #42	; 0x2a
c0d0452e:	5d04      	ldrb	r4, [r0, r4]
        || (service->waitAsynchronousResponse != U2F_WAIT_ASYNCH_ON 
c0d04530:	2c00      	cmp	r4, #0
c0d04532:	d009      	beq.n	c0d04548 <u2f_message_reply+0x1e>
c0d04534:	2c01      	cmp	r4, #1
c0d04536:	d015      	beq.n	c0d04564 <u2f_message_reply+0x3a>
            && service->fakeChannelTransportState == U2F_FAKE_RECEIVED 
c0d04538:	2425      	movs	r4, #37	; 0x25
c0d0453a:	5d04      	ldrb	r4, [r0, r4]
            && service->sending == false)
c0d0453c:	2c06      	cmp	r4, #6
c0d0453e:	d111      	bne.n	c0d04564 <u2f_message_reply+0x3a>
c0d04540:	242b      	movs	r4, #43	; 0x2b
c0d04542:	5d04      	ldrb	r4, [r0, r4]
}

void u2f_message_reply(u2f_service_t *service, uint8_t cmd, uint8_t *buffer, uint16_t len) {

    // if U2F is not ready to reply, then gently avoid replying
    if (u2f_message_repliable(service)) 
c0d04544:	2c00      	cmp	r4, #0
c0d04546:	d10d      	bne.n	c0d04564 <u2f_message_reply+0x3a>
    {
        service->transportState = U2F_SENDING_RESPONSE;
c0d04548:	2420      	movs	r4, #32
c0d0454a:	2503      	movs	r5, #3
c0d0454c:	5505      	strb	r5, [r0, r4]
c0d0454e:	2400      	movs	r4, #0
        service->transportPacketIndex = 0;
c0d04550:	7684      	strb	r4, [r0, #26]
        service->transportBuffer = buffer;
c0d04552:	61c2      	str	r2, [r0, #28]
        service->transportOffset = 0;
c0d04554:	82c4      	strh	r4, [r0, #22]
        service->transportLength = len;
c0d04556:	8303      	strh	r3, [r0, #24]
        service->sendCmd = cmd;
c0d04558:	2240      	movs	r2, #64	; 0x40
c0d0455a:	5481      	strb	r1, [r0, r2]
        // pump the first message
        u2f_transport_sent(service, service->transportMedia);
c0d0455c:	2121      	movs	r1, #33	; 0x21
c0d0455e:	5c41      	ldrb	r1, [r0, r1]
c0d04560:	f7ff fc88 	bl	c0d03e74 <u2f_transport_sent>
    }
}
c0d04564:	bdb0      	pop	{r4, r5, r7, pc}
	...

c0d04568 <USBD_LL_Init>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Init (USBD_HandleTypeDef *pdev)
{ 
  UNUSED(pdev);
  ep_in_stall = 0;
c0d04568:	4902      	ldr	r1, [pc, #8]	; (c0d04574 <USBD_LL_Init+0xc>)
c0d0456a:	2000      	movs	r0, #0
c0d0456c:	6008      	str	r0, [r1, #0]
  ep_out_stall = 0;
c0d0456e:	4902      	ldr	r1, [pc, #8]	; (c0d04578 <USBD_LL_Init+0x10>)
c0d04570:	6008      	str	r0, [r1, #0]
  return USBD_OK;
c0d04572:	4770      	bx	lr
c0d04574:	20002158 	.word	0x20002158
c0d04578:	2000215c 	.word	0x2000215c

c0d0457c <USBD_LL_DeInit>:
  * @brief  De-Initializes the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_DeInit (USBD_HandleTypeDef *pdev)
{
c0d0457c:	b510      	push	{r4, lr}
  UNUSED(pdev);
  // usb off
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0457e:	4807      	ldr	r0, [pc, #28]	; (c0d0459c <USBD_LL_DeInit+0x20>)
c0d04580:	214f      	movs	r1, #79	; 0x4f
c0d04582:	7001      	strb	r1, [r0, #0]
c0d04584:	2400      	movs	r4, #0
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d04586:	7044      	strb	r4, [r0, #1]
c0d04588:	2101      	movs	r1, #1
  G_io_seproxyhal_spi_buffer[2] = 1;
c0d0458a:	7081      	strb	r1, [r0, #2]
c0d0458c:	2102      	movs	r1, #2
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d0458e:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 4);
c0d04590:	2104      	movs	r1, #4
c0d04592:	f7fe fe39 	bl	c0d03208 <io_seproxyhal_spi_send>

  return USBD_OK; 
c0d04596:	4620      	mov	r0, r4
c0d04598:	bd10      	pop	{r4, pc}
c0d0459a:	46c0      	nop			; (mov r8, r8)
c0d0459c:	20001800 	.word	0x20001800

c0d045a0 <USBD_LL_Start>:
  * @brief  Starts the Low Level portion of the Device driver. 
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Start(USBD_HandleTypeDef *pdev)
{
c0d045a0:	b570      	push	{r4, r5, r6, lr}
c0d045a2:	b082      	sub	sp, #8
c0d045a4:	466d      	mov	r5, sp
  uint8_t buffer[5];
  UNUSED(pdev);

  // reset address
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d045a6:	264f      	movs	r6, #79	; 0x4f
c0d045a8:	702e      	strb	r6, [r5, #0]
c0d045aa:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d045ac:	706c      	strb	r4, [r5, #1]
c0d045ae:	2002      	movs	r0, #2
  buffer[2] = 2;
c0d045b0:	70a8      	strb	r0, [r5, #2]
c0d045b2:	2003      	movs	r0, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d045b4:	70e8      	strb	r0, [r5, #3]
  buffer[4] = 0;
c0d045b6:	712c      	strb	r4, [r5, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d045b8:	2105      	movs	r1, #5
c0d045ba:	4628      	mov	r0, r5
c0d045bc:	f7fe fe24 	bl	c0d03208 <io_seproxyhal_spi_send>
  
  // start usb operation
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d045c0:	702e      	strb	r6, [r5, #0]
  buffer[1] = 0;
c0d045c2:	706c      	strb	r4, [r5, #1]
c0d045c4:	2001      	movs	r0, #1
  buffer[2] = 1;
c0d045c6:	70a8      	strb	r0, [r5, #2]
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_CONNECT;
c0d045c8:	70e8      	strb	r0, [r5, #3]
c0d045ca:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(buffer, 4);
c0d045cc:	4628      	mov	r0, r5
c0d045ce:	f7fe fe1b 	bl	c0d03208 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d045d2:	4620      	mov	r0, r4
c0d045d4:	b002      	add	sp, #8
c0d045d6:	bd70      	pop	{r4, r5, r6, pc}

c0d045d8 <USBD_LL_Stop>:
  * @brief  Stops the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Stop (USBD_HandleTypeDef *pdev)
{
c0d045d8:	b510      	push	{r4, lr}
c0d045da:	b082      	sub	sp, #8
c0d045dc:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[4];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d045de:	214f      	movs	r1, #79	; 0x4f
c0d045e0:	7001      	strb	r1, [r0, #0]
c0d045e2:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d045e4:	7044      	strb	r4, [r0, #1]
c0d045e6:	2101      	movs	r1, #1
  buffer[2] = 1;
c0d045e8:	7081      	strb	r1, [r0, #2]
c0d045ea:	2102      	movs	r1, #2
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d045ec:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(buffer, 4);
c0d045ee:	2104      	movs	r1, #4
c0d045f0:	f7fe fe0a 	bl	c0d03208 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d045f4:	4620      	mov	r0, r4
c0d045f6:	b002      	add	sp, #8
c0d045f8:	bd10      	pop	{r4, pc}
	...

c0d045fc <USBD_LL_OpenEP>:
  */
USBD_StatusTypeDef  USBD_LL_OpenEP  (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  ep_type,
                                      uint16_t ep_mps)
{
c0d045fc:	b5b0      	push	{r4, r5, r7, lr}
c0d045fe:	b082      	sub	sp, #8
  uint8_t buffer[8];
  UNUSED(pdev);

  ep_in_stall = 0;
c0d04600:	480e      	ldr	r0, [pc, #56]	; (c0d0463c <USBD_LL_OpenEP+0x40>)
c0d04602:	2400      	movs	r4, #0
c0d04604:	6004      	str	r4, [r0, #0]
  ep_out_stall = 0;
c0d04606:	480e      	ldr	r0, [pc, #56]	; (c0d04640 <USBD_LL_OpenEP+0x44>)
c0d04608:	6004      	str	r4, [r0, #0]
c0d0460a:	4668      	mov	r0, sp

  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0460c:	254f      	movs	r5, #79	; 0x4f
c0d0460e:	7005      	strb	r5, [r0, #0]
  buffer[1] = 0;
c0d04610:	7044      	strb	r4, [r0, #1]
c0d04612:	2505      	movs	r5, #5
  buffer[2] = 5;
c0d04614:	7085      	strb	r5, [r0, #2]
c0d04616:	2504      	movs	r5, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d04618:	70c5      	strb	r5, [r0, #3]
c0d0461a:	2501      	movs	r5, #1
  buffer[4] = 1;
c0d0461c:	7105      	strb	r5, [r0, #4]
  buffer[5] = ep_addr;
c0d0461e:	7141      	strb	r1, [r0, #5]
  buffer[6] = 0;
  switch(ep_type) {
c0d04620:	2a03      	cmp	r2, #3
c0d04622:	d802      	bhi.n	c0d0462a <USBD_LL_OpenEP+0x2e>
c0d04624:	00d0      	lsls	r0, r2, #3
c0d04626:	4c07      	ldr	r4, [pc, #28]	; (c0d04644 <USBD_LL_OpenEP+0x48>)
c0d04628:	40c4      	lsrs	r4, r0
c0d0462a:	4668      	mov	r0, sp
  buffer[1] = 0;
  buffer[2] = 5;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
  buffer[4] = 1;
  buffer[5] = ep_addr;
  buffer[6] = 0;
c0d0462c:	7184      	strb	r4, [r0, #6]
      break;
    case USBD_EP_TYPE_INTR:
      buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_INTERRUPT;
      break;
  }
  buffer[7] = ep_mps;
c0d0462e:	71c3      	strb	r3, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d04630:	2108      	movs	r1, #8
c0d04632:	f7fe fde9 	bl	c0d03208 <io_seproxyhal_spi_send>
c0d04636:	2000      	movs	r0, #0
  return USBD_OK; 
c0d04638:	b002      	add	sp, #8
c0d0463a:	bdb0      	pop	{r4, r5, r7, pc}
c0d0463c:	20002158 	.word	0x20002158
c0d04640:	2000215c 	.word	0x2000215c
c0d04644:	02030401 	.word	0x02030401

c0d04648 <USBD_LL_CloseEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_CloseEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d04648:	b510      	push	{r4, lr}
c0d0464a:	b082      	sub	sp, #8
c0d0464c:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[8];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0464e:	224f      	movs	r2, #79	; 0x4f
c0d04650:	7002      	strb	r2, [r0, #0]
c0d04652:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d04654:	7044      	strb	r4, [r0, #1]
c0d04656:	2205      	movs	r2, #5
  buffer[2] = 5;
c0d04658:	7082      	strb	r2, [r0, #2]
c0d0465a:	2204      	movs	r2, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d0465c:	70c2      	strb	r2, [r0, #3]
c0d0465e:	2201      	movs	r2, #1
  buffer[4] = 1;
c0d04660:	7102      	strb	r2, [r0, #4]
  buffer[5] = ep_addr;
c0d04662:	7141      	strb	r1, [r0, #5]
  buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_DISABLED;
c0d04664:	7184      	strb	r4, [r0, #6]
  buffer[7] = 0;
c0d04666:	71c4      	strb	r4, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d04668:	2108      	movs	r1, #8
c0d0466a:	f7fe fdcd 	bl	c0d03208 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d0466e:	4620      	mov	r0, r4
c0d04670:	b002      	add	sp, #8
c0d04672:	bd10      	pop	{r4, pc}

c0d04674 <USBD_LL_StallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_StallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{ 
c0d04674:	b5b0      	push	{r4, r5, r7, lr}
c0d04676:	b082      	sub	sp, #8
c0d04678:	460d      	mov	r5, r1
c0d0467a:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d0467c:	2150      	movs	r1, #80	; 0x50
c0d0467e:	7001      	strb	r1, [r0, #0]
c0d04680:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d04682:	7044      	strb	r4, [r0, #1]
c0d04684:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d04686:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d04688:	70c5      	strb	r5, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_STALL;
c0d0468a:	2140      	movs	r1, #64	; 0x40
c0d0468c:	7101      	strb	r1, [r0, #4]
  buffer[5] = 0;
c0d0468e:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d04690:	2106      	movs	r1, #6
c0d04692:	f7fe fdb9 	bl	c0d03208 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d04696:	2080      	movs	r0, #128	; 0x80
c0d04698:	4205      	tst	r5, r0
c0d0469a:	d101      	bne.n	c0d046a0 <USBD_LL_StallEP+0x2c>
c0d0469c:	4807      	ldr	r0, [pc, #28]	; (c0d046bc <USBD_LL_StallEP+0x48>)
c0d0469e:	e000      	b.n	c0d046a2 <USBD_LL_StallEP+0x2e>
c0d046a0:	4805      	ldr	r0, [pc, #20]	; (c0d046b8 <USBD_LL_StallEP+0x44>)
c0d046a2:	6801      	ldr	r1, [r0, #0]
c0d046a4:	227f      	movs	r2, #127	; 0x7f
c0d046a6:	4015      	ands	r5, r2
c0d046a8:	2201      	movs	r2, #1
c0d046aa:	40aa      	lsls	r2, r5
c0d046ac:	430a      	orrs	r2, r1
c0d046ae:	6002      	str	r2, [r0, #0]
    ep_in_stall |= (1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall |= (1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d046b0:	4620      	mov	r0, r4
c0d046b2:	b002      	add	sp, #8
c0d046b4:	bdb0      	pop	{r4, r5, r7, pc}
c0d046b6:	46c0      	nop			; (mov r8, r8)
c0d046b8:	20002158 	.word	0x20002158
c0d046bc:	2000215c 	.word	0x2000215c

c0d046c0 <USBD_LL_ClearStallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_ClearStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d046c0:	b570      	push	{r4, r5, r6, lr}
c0d046c2:	b082      	sub	sp, #8
c0d046c4:	460d      	mov	r5, r1
c0d046c6:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d046c8:	2150      	movs	r1, #80	; 0x50
c0d046ca:	7001      	strb	r1, [r0, #0]
c0d046cc:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d046ce:	7044      	strb	r4, [r0, #1]
c0d046d0:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d046d2:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d046d4:	70c5      	strb	r5, [r0, #3]
c0d046d6:	2680      	movs	r6, #128	; 0x80
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_UNSTALL;
c0d046d8:	7106      	strb	r6, [r0, #4]
  buffer[5] = 0;
c0d046da:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d046dc:	2106      	movs	r1, #6
c0d046de:	f7fe fd93 	bl	c0d03208 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d046e2:	4235      	tst	r5, r6
c0d046e4:	d101      	bne.n	c0d046ea <USBD_LL_ClearStallEP+0x2a>
c0d046e6:	4807      	ldr	r0, [pc, #28]	; (c0d04704 <USBD_LL_ClearStallEP+0x44>)
c0d046e8:	e000      	b.n	c0d046ec <USBD_LL_ClearStallEP+0x2c>
c0d046ea:	4805      	ldr	r0, [pc, #20]	; (c0d04700 <USBD_LL_ClearStallEP+0x40>)
c0d046ec:	6801      	ldr	r1, [r0, #0]
c0d046ee:	227f      	movs	r2, #127	; 0x7f
c0d046f0:	4015      	ands	r5, r2
c0d046f2:	2201      	movs	r2, #1
c0d046f4:	40aa      	lsls	r2, r5
c0d046f6:	4391      	bics	r1, r2
c0d046f8:	6001      	str	r1, [r0, #0]
    ep_in_stall &= ~(1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall &= ~(1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d046fa:	4620      	mov	r0, r4
c0d046fc:	b002      	add	sp, #8
c0d046fe:	bd70      	pop	{r4, r5, r6, pc}
c0d04700:	20002158 	.word	0x20002158
c0d04704:	2000215c 	.word	0x2000215c

c0d04708 <USBD_LL_IsStallEP>:
  * @retval Stall (1: Yes, 0: No)
  */
uint8_t USBD_LL_IsStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  UNUSED(pdev);
  if((ep_addr & 0x80) == 0x80)
c0d04708:	2080      	movs	r0, #128	; 0x80
c0d0470a:	4201      	tst	r1, r0
c0d0470c:	d001      	beq.n	c0d04712 <USBD_LL_IsStallEP+0xa>
c0d0470e:	4806      	ldr	r0, [pc, #24]	; (c0d04728 <USBD_LL_IsStallEP+0x20>)
c0d04710:	e000      	b.n	c0d04714 <USBD_LL_IsStallEP+0xc>
c0d04712:	4804      	ldr	r0, [pc, #16]	; (c0d04724 <USBD_LL_IsStallEP+0x1c>)
c0d04714:	6800      	ldr	r0, [r0, #0]
c0d04716:	227f      	movs	r2, #127	; 0x7f
c0d04718:	4011      	ands	r1, r2
c0d0471a:	2201      	movs	r2, #1
c0d0471c:	408a      	lsls	r2, r1
c0d0471e:	4002      	ands	r2, r0
  }
  else
  {
    return ep_out_stall & (1<<(ep_addr&0x7F));
  }
}
c0d04720:	b2d0      	uxtb	r0, r2
c0d04722:	4770      	bx	lr
c0d04724:	2000215c 	.word	0x2000215c
c0d04728:	20002158 	.word	0x20002158

c0d0472c <USBD_LL_SetUSBAddress>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_SetUSBAddress (USBD_HandleTypeDef *pdev, uint8_t dev_addr)   
{
c0d0472c:	b510      	push	{r4, lr}
c0d0472e:	b082      	sub	sp, #8
c0d04730:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[5];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d04732:	224f      	movs	r2, #79	; 0x4f
c0d04734:	7002      	strb	r2, [r0, #0]
c0d04736:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d04738:	7044      	strb	r4, [r0, #1]
c0d0473a:	2202      	movs	r2, #2
  buffer[2] = 2;
c0d0473c:	7082      	strb	r2, [r0, #2]
c0d0473e:	2203      	movs	r2, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d04740:	70c2      	strb	r2, [r0, #3]
  buffer[4] = dev_addr;
c0d04742:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d04744:	2105      	movs	r1, #5
c0d04746:	f7fe fd5f 	bl	c0d03208 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d0474a:	4620      	mov	r0, r4
c0d0474c:	b002      	add	sp, #8
c0d0474e:	bd10      	pop	{r4, pc}

c0d04750 <USBD_LL_Transmit>:
  */
USBD_StatusTypeDef  USBD_LL_Transmit (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  *pbuf,
                                      uint16_t  size)
{
c0d04750:	b5b0      	push	{r4, r5, r7, lr}
c0d04752:	b082      	sub	sp, #8
c0d04754:	461c      	mov	r4, r3
c0d04756:	4615      	mov	r5, r2
c0d04758:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d0475a:	2250      	movs	r2, #80	; 0x50
c0d0475c:	7002      	strb	r2, [r0, #0]
  buffer[1] = (3+size)>>8;
c0d0475e:	1ce2      	adds	r2, r4, #3
c0d04760:	0a13      	lsrs	r3, r2, #8
c0d04762:	7043      	strb	r3, [r0, #1]
  buffer[2] = (3+size);
c0d04764:	7082      	strb	r2, [r0, #2]
  buffer[3] = ep_addr;
c0d04766:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d04768:	2120      	movs	r1, #32
c0d0476a:	7101      	strb	r1, [r0, #4]
  buffer[5] = size;
c0d0476c:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d0476e:	2106      	movs	r1, #6
c0d04770:	f7fe fd4a 	bl	c0d03208 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(pbuf, size);
c0d04774:	4628      	mov	r0, r5
c0d04776:	4621      	mov	r1, r4
c0d04778:	f7fe fd46 	bl	c0d03208 <io_seproxyhal_spi_send>
c0d0477c:	2000      	movs	r0, #0
  return USBD_OK;   
c0d0477e:	b002      	add	sp, #8
c0d04780:	bdb0      	pop	{r4, r5, r7, pc}

c0d04782 <USBD_LL_PrepareReceive>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_PrepareReceive(USBD_HandleTypeDef *pdev, 
                                           uint8_t  ep_addr,
                                           uint16_t  size)
{
c0d04782:	b510      	push	{r4, lr}
c0d04784:	b082      	sub	sp, #8
c0d04786:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d04788:	2350      	movs	r3, #80	; 0x50
c0d0478a:	7003      	strb	r3, [r0, #0]
c0d0478c:	2400      	movs	r4, #0
  buffer[1] = (3/*+size*/)>>8;
c0d0478e:	7044      	strb	r4, [r0, #1]
c0d04790:	2303      	movs	r3, #3
  buffer[2] = (3/*+size*/);
c0d04792:	7083      	strb	r3, [r0, #2]
  buffer[3] = ep_addr;
c0d04794:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_OUT;
c0d04796:	2130      	movs	r1, #48	; 0x30
c0d04798:	7101      	strb	r1, [r0, #4]
  buffer[5] = size; // expected size, not transmitted here !
c0d0479a:	7142      	strb	r2, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d0479c:	2106      	movs	r1, #6
c0d0479e:	f7fe fd33 	bl	c0d03208 <io_seproxyhal_spi_send>
  return USBD_OK;   
c0d047a2:	4620      	mov	r0, r4
c0d047a4:	b002      	add	sp, #8
c0d047a6:	bd10      	pop	{r4, pc}

c0d047a8 <USBD_Init>:
* @param  pdesc: Descriptor structure address
* @param  id: Low level core index
* @retval None
*/
USBD_StatusTypeDef USBD_Init(USBD_HandleTypeDef *pdev, USBD_DescriptorsTypeDef *pdesc, uint8_t id)
{
c0d047a8:	b570      	push	{r4, r5, r6, lr}
c0d047aa:	4615      	mov	r5, r2
c0d047ac:	460e      	mov	r6, r1
c0d047ae:	4604      	mov	r4, r0
c0d047b0:	2002      	movs	r0, #2
  /* Check whether the USB Host handle is valid */
  if(pdev == NULL)
c0d047b2:	2c00      	cmp	r4, #0
c0d047b4:	d011      	beq.n	c0d047da <USBD_Init+0x32>
  {
    USBD_ErrLog("Invalid Device handle");
    return USBD_FAIL; 
  }

  memset(pdev, 0, sizeof(USBD_HandleTypeDef));
c0d047b6:	204d      	movs	r0, #77	; 0x4d
c0d047b8:	0081      	lsls	r1, r0, #2
c0d047ba:	4620      	mov	r0, r4
c0d047bc:	f001 fd6c 	bl	c0d06298 <__aeabi_memclr>
  
  /* Assign USBD Descriptors */
  if(pdesc != NULL)
c0d047c0:	2e00      	cmp	r6, #0
c0d047c2:	d002      	beq.n	c0d047ca <USBD_Init+0x22>
  {
    pdev->pDesc = pdesc;
c0d047c4:	2011      	movs	r0, #17
c0d047c6:	0100      	lsls	r0, r0, #4
c0d047c8:	5026      	str	r6, [r4, r0]
  }
  
  /* Set Device initial State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d047ca:	20fc      	movs	r0, #252	; 0xfc
c0d047cc:	2101      	movs	r1, #1
c0d047ce:	5421      	strb	r1, [r4, r0]
  pdev->id = id;
c0d047d0:	7025      	strb	r5, [r4, #0]
  /* Initialize low level driver */
  USBD_LL_Init(pdev);
c0d047d2:	4620      	mov	r0, r4
c0d047d4:	f7ff fec8 	bl	c0d04568 <USBD_LL_Init>
c0d047d8:	2000      	movs	r0, #0
  
  return USBD_OK; 
}
c0d047da:	b2c0      	uxtb	r0, r0
c0d047dc:	bd70      	pop	{r4, r5, r6, pc}

c0d047de <USBD_DeInit>:
*         Re-Initialize th device library
* @param  pdev: device instance
* @retval status: status
*/
USBD_StatusTypeDef USBD_DeInit(USBD_HandleTypeDef *pdev)
{
c0d047de:	b570      	push	{r4, r5, r6, lr}
c0d047e0:	4604      	mov	r4, r0
  /* Set Default State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d047e2:	20fc      	movs	r0, #252	; 0xfc
c0d047e4:	2101      	movs	r1, #1
c0d047e6:	5421      	strb	r1, [r4, r0]
  
  /* Free Class Resources */
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d047e8:	2045      	movs	r0, #69	; 0x45
c0d047ea:	0080      	lsls	r0, r0, #2
c0d047ec:	1825      	adds	r5, r4, r0
c0d047ee:	2600      	movs	r6, #0
    if(pdev->interfacesClass[intf].pClass != NULL) {
c0d047f0:	00f0      	lsls	r0, r6, #3
c0d047f2:	5828      	ldr	r0, [r5, r0]
c0d047f4:	2800      	cmp	r0, #0
c0d047f6:	d006      	beq.n	c0d04806 <USBD_DeInit+0x28>
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, pdev->dev_config);  
c0d047f8:	6840      	ldr	r0, [r0, #4]
c0d047fa:	f7fe fa13 	bl	c0d02c24 <pic>
c0d047fe:	4602      	mov	r2, r0
c0d04800:	7921      	ldrb	r1, [r4, #4]
c0d04802:	4620      	mov	r0, r4
c0d04804:	4790      	blx	r2
  /* Set Default State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
  
  /* Free Class Resources */
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d04806:	1c76      	adds	r6, r6, #1
c0d04808:	2e03      	cmp	r6, #3
c0d0480a:	d1f1      	bne.n	c0d047f0 <USBD_DeInit+0x12>
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, pdev->dev_config);  
    }
  }
  
    /* Stop the low level driver  */
  USBD_LL_Stop(pdev); 
c0d0480c:	4620      	mov	r0, r4
c0d0480e:	f7ff fee3 	bl	c0d045d8 <USBD_LL_Stop>
  
  /* Initialize low level driver */
  USBD_LL_DeInit(pdev);
c0d04812:	4620      	mov	r0, r4
c0d04814:	f7ff feb2 	bl	c0d0457c <USBD_LL_DeInit>
  
  return USBD_OK;
c0d04818:	2000      	movs	r0, #0
c0d0481a:	bd70      	pop	{r4, r5, r6, pc}

c0d0481c <USBD_RegisterClassForInterface>:
  * @param  pDevice : Device Handle
  * @param  pclass: Class handle
  * @retval USBD Status
  */
USBD_StatusTypeDef USBD_RegisterClassForInterface(uint8_t interfaceidx, USBD_HandleTypeDef *pdev, USBD_ClassTypeDef *pclass)
{
c0d0481c:	2302      	movs	r3, #2
  USBD_StatusTypeDef   status = USBD_OK;
  if(pclass != 0)
c0d0481e:	2a00      	cmp	r2, #0
c0d04820:	d007      	beq.n	c0d04832 <USBD_RegisterClassForInterface+0x16>
c0d04822:	2300      	movs	r3, #0
  {
    if (interfaceidx < USBD_MAX_NUM_INTERFACES) {
c0d04824:	2802      	cmp	r0, #2
c0d04826:	d804      	bhi.n	c0d04832 <USBD_RegisterClassForInterface+0x16>
      /* link the class to the USB Device handle */
      pdev->interfacesClass[interfaceidx].pClass = pclass;
c0d04828:	00c0      	lsls	r0, r0, #3
c0d0482a:	1808      	adds	r0, r1, r0
c0d0482c:	2145      	movs	r1, #69	; 0x45
c0d0482e:	0089      	lsls	r1, r1, #2
c0d04830:	5042      	str	r2, [r0, r1]
  {
    USBD_ErrLog("Invalid Class handle");
    status = USBD_FAIL; 
  }
  
  return status;
c0d04832:	b2d8      	uxtb	r0, r3
c0d04834:	4770      	bx	lr

c0d04836 <USBD_Start>:
  *         Start the USB Device Core.
  * @param  pdev: Device Handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_Start  (USBD_HandleTypeDef *pdev)
{
c0d04836:	b580      	push	{r7, lr}
  
  /* Start the low level driver  */
  USBD_LL_Start(pdev); 
c0d04838:	f7ff feb2 	bl	c0d045a0 <USBD_LL_Start>
  
  return USBD_OK;  
c0d0483c:	2000      	movs	r0, #0
c0d0483e:	bd80      	pop	{r7, pc}

c0d04840 <USBD_SetClassConfig>:
* @param  cfgidx: configuration index
* @retval status
*/

USBD_StatusTypeDef USBD_SetClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d04840:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d04842:	b081      	sub	sp, #4
c0d04844:	460c      	mov	r4, r1
c0d04846:	4605      	mov	r5, r0
  /* Set configuration  and Start the Class*/
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d04848:	2045      	movs	r0, #69	; 0x45
c0d0484a:	0080      	lsls	r0, r0, #2
c0d0484c:	182f      	adds	r7, r5, r0
c0d0484e:	2600      	movs	r6, #0
    if(usbd_is_valid_intf(pdev, intf)) {
c0d04850:	4628      	mov	r0, r5
c0d04852:	4631      	mov	r1, r6
c0d04854:	f000 f97c 	bl	c0d04b50 <usbd_is_valid_intf>
c0d04858:	2800      	cmp	r0, #0
c0d0485a:	d008      	beq.n	c0d0486e <USBD_SetClassConfig+0x2e>
      ((Init_t)PIC(pdev->interfacesClass[intf].pClass->Init))(pdev, cfgidx);
c0d0485c:	00f0      	lsls	r0, r6, #3
c0d0485e:	5838      	ldr	r0, [r7, r0]
c0d04860:	6800      	ldr	r0, [r0, #0]
c0d04862:	f7fe f9df 	bl	c0d02c24 <pic>
c0d04866:	4602      	mov	r2, r0
c0d04868:	4628      	mov	r0, r5
c0d0486a:	4621      	mov	r1, r4
c0d0486c:	4790      	blx	r2

USBD_StatusTypeDef USBD_SetClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
  /* Set configuration  and Start the Class*/
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d0486e:	1c76      	adds	r6, r6, #1
c0d04870:	2e03      	cmp	r6, #3
c0d04872:	d1ed      	bne.n	c0d04850 <USBD_SetClassConfig+0x10>
    if(usbd_is_valid_intf(pdev, intf)) {
      ((Init_t)PIC(pdev->interfacesClass[intf].pClass->Init))(pdev, cfgidx);
    }
  }

  return USBD_OK; 
c0d04874:	2000      	movs	r0, #0
c0d04876:	b001      	add	sp, #4
c0d04878:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0487a <USBD_ClrClassConfig>:
* @param  pdev: device instance
* @param  cfgidx: configuration index
* @retval status: USBD_StatusTypeDef
*/
USBD_StatusTypeDef USBD_ClrClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d0487a:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0487c:	b081      	sub	sp, #4
c0d0487e:	460c      	mov	r4, r1
c0d04880:	4605      	mov	r5, r0
  /* Clear configuration  and De-initialize the Class process*/
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d04882:	2045      	movs	r0, #69	; 0x45
c0d04884:	0080      	lsls	r0, r0, #2
c0d04886:	182f      	adds	r7, r5, r0
c0d04888:	2600      	movs	r6, #0
    if(usbd_is_valid_intf(pdev, intf)) {
c0d0488a:	4628      	mov	r0, r5
c0d0488c:	4631      	mov	r1, r6
c0d0488e:	f000 f95f 	bl	c0d04b50 <usbd_is_valid_intf>
c0d04892:	2800      	cmp	r0, #0
c0d04894:	d008      	beq.n	c0d048a8 <USBD_ClrClassConfig+0x2e>
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, cfgidx);  
c0d04896:	00f0      	lsls	r0, r6, #3
c0d04898:	5838      	ldr	r0, [r7, r0]
c0d0489a:	6840      	ldr	r0, [r0, #4]
c0d0489c:	f7fe f9c2 	bl	c0d02c24 <pic>
c0d048a0:	4602      	mov	r2, r0
c0d048a2:	4628      	mov	r0, r5
c0d048a4:	4621      	mov	r1, r4
c0d048a6:	4790      	blx	r2
*/
USBD_StatusTypeDef USBD_ClrClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
  /* Clear configuration  and De-initialize the Class process*/
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d048a8:	1c76      	adds	r6, r6, #1
c0d048aa:	2e03      	cmp	r6, #3
c0d048ac:	d1ed      	bne.n	c0d0488a <USBD_ClrClassConfig+0x10>
    if(usbd_is_valid_intf(pdev, intf)) {
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, cfgidx);  
    }
  }
  return USBD_OK;
c0d048ae:	2000      	movs	r0, #0
c0d048b0:	b001      	add	sp, #4
c0d048b2:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d048b4 <USBD_LL_SetupStage>:
*         Handle the setup stage
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetupStage(USBD_HandleTypeDef *pdev, uint8_t *psetup)
{
c0d048b4:	b570      	push	{r4, r5, r6, lr}
c0d048b6:	4604      	mov	r4, r0
c0d048b8:	2021      	movs	r0, #33	; 0x21
c0d048ba:	00c6      	lsls	r6, r0, #3
  USBD_ParseSetupRequest(&pdev->request, psetup);
c0d048bc:	19a5      	adds	r5, r4, r6
c0d048be:	4628      	mov	r0, r5
c0d048c0:	f000 fba7 	bl	c0d05012 <USBD_ParseSetupRequest>
  
  pdev->ep0_state = USBD_EP0_SETUP;
c0d048c4:	20f4      	movs	r0, #244	; 0xf4
c0d048c6:	2101      	movs	r1, #1
c0d048c8:	5021      	str	r1, [r4, r0]
  pdev->ep0_data_len = pdev->request.wLength;
c0d048ca:	2087      	movs	r0, #135	; 0x87
c0d048cc:	0040      	lsls	r0, r0, #1
c0d048ce:	5a20      	ldrh	r0, [r4, r0]
c0d048d0:	21f8      	movs	r1, #248	; 0xf8
c0d048d2:	5060      	str	r0, [r4, r1]
  
  switch (pdev->request.bmRequest & 0x1F) 
c0d048d4:	5da1      	ldrb	r1, [r4, r6]
c0d048d6:	201f      	movs	r0, #31
c0d048d8:	4008      	ands	r0, r1
c0d048da:	2802      	cmp	r0, #2
c0d048dc:	d008      	beq.n	c0d048f0 <USBD_LL_SetupStage+0x3c>
c0d048de:	2801      	cmp	r0, #1
c0d048e0:	d00b      	beq.n	c0d048fa <USBD_LL_SetupStage+0x46>
c0d048e2:	2800      	cmp	r0, #0
c0d048e4:	d10e      	bne.n	c0d04904 <USBD_LL_SetupStage+0x50>
  {
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
c0d048e6:	4620      	mov	r0, r4
c0d048e8:	4629      	mov	r1, r5
c0d048ea:	f000 f93f 	bl	c0d04b6c <USBD_StdDevReq>
c0d048ee:	e00e      	b.n	c0d0490e <USBD_LL_SetupStage+0x5a>
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
c0d048f0:	4620      	mov	r0, r4
c0d048f2:	4629      	mov	r1, r5
c0d048f4:	f000 fb02 	bl	c0d04efc <USBD_StdEPReq>
c0d048f8:	e009      	b.n	c0d0490e <USBD_LL_SetupStage+0x5a>
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
c0d048fa:	4620      	mov	r0, r4
c0d048fc:	4629      	mov	r1, r5
c0d048fe:	f000 fad8 	bl	c0d04eb2 <USBD_StdItfReq>
c0d04902:	e004      	b.n	c0d0490e <USBD_LL_SetupStage+0x5a>
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
    break;
    
  default:           
    USBD_LL_StallEP(pdev , pdev->request.bmRequest & 0x80);
c0d04904:	2080      	movs	r0, #128	; 0x80
c0d04906:	4001      	ands	r1, r0
c0d04908:	4620      	mov	r0, r4
c0d0490a:	f7ff feb3 	bl	c0d04674 <USBD_LL_StallEP>
    break;
  }  
  return USBD_OK;  
c0d0490e:	2000      	movs	r0, #0
c0d04910:	bd70      	pop	{r4, r5, r6, pc}

c0d04912 <USBD_LL_DataOutStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataOutStage(USBD_HandleTypeDef *pdev , uint8_t epnum, uint8_t *pdata)
{
c0d04912:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d04914:	b083      	sub	sp, #12
c0d04916:	9202      	str	r2, [sp, #8]
c0d04918:	4604      	mov	r4, r0
c0d0491a:	9101      	str	r1, [sp, #4]
  USBD_EndpointTypeDef    *pep;
  
  if(epnum == 0) 
c0d0491c:	2900      	cmp	r1, #0
c0d0491e:	d01e      	beq.n	c0d0495e <USBD_LL_DataOutStage+0x4c>
    }
  }
  else {

    uint8_t intf;
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d04920:	2045      	movs	r0, #69	; 0x45
c0d04922:	0080      	lsls	r0, r0, #2
c0d04924:	1825      	adds	r5, r4, r0
c0d04926:	4626      	mov	r6, r4
c0d04928:	36fc      	adds	r6, #252	; 0xfc
c0d0492a:	2700      	movs	r7, #0
      if( usbd_is_valid_intf(pdev, intf) &&  (pdev->interfacesClass[intf].pClass->DataOut != NULL)&&
c0d0492c:	4620      	mov	r0, r4
c0d0492e:	4639      	mov	r1, r7
c0d04930:	f000 f90e 	bl	c0d04b50 <usbd_is_valid_intf>
c0d04934:	2800      	cmp	r0, #0
c0d04936:	d00e      	beq.n	c0d04956 <USBD_LL_DataOutStage+0x44>
c0d04938:	00f8      	lsls	r0, r7, #3
c0d0493a:	5828      	ldr	r0, [r5, r0]
c0d0493c:	6980      	ldr	r0, [r0, #24]
c0d0493e:	2800      	cmp	r0, #0
c0d04940:	d009      	beq.n	c0d04956 <USBD_LL_DataOutStage+0x44>
         (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d04942:	7831      	ldrb	r1, [r6, #0]
  }
  else {

    uint8_t intf;
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
      if( usbd_is_valid_intf(pdev, intf) &&  (pdev->interfacesClass[intf].pClass->DataOut != NULL)&&
c0d04944:	2903      	cmp	r1, #3
c0d04946:	d106      	bne.n	c0d04956 <USBD_LL_DataOutStage+0x44>
         (pdev->dev_state == USBD_STATE_CONFIGURED))
      {
        ((DataOut_t)PIC(pdev->interfacesClass[intf].pClass->DataOut))(pdev, epnum, pdata); 
c0d04948:	f7fe f96c 	bl	c0d02c24 <pic>
c0d0494c:	4603      	mov	r3, r0
c0d0494e:	4620      	mov	r0, r4
c0d04950:	9901      	ldr	r1, [sp, #4]
c0d04952:	9a02      	ldr	r2, [sp, #8]
c0d04954:	4798      	blx	r3
    }
  }
  else {

    uint8_t intf;
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d04956:	1c7f      	adds	r7, r7, #1
c0d04958:	2f03      	cmp	r7, #3
c0d0495a:	d1e7      	bne.n	c0d0492c <USBD_LL_DataOutStage+0x1a>
c0d0495c:	e035      	b.n	c0d049ca <USBD_LL_DataOutStage+0xb8>
  
  if(epnum == 0) 
  {
    pep = &pdev->ep_out[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_OUT)
c0d0495e:	20f4      	movs	r0, #244	; 0xf4
c0d04960:	5820      	ldr	r0, [r4, r0]
c0d04962:	2803      	cmp	r0, #3
c0d04964:	d131      	bne.n	c0d049ca <USBD_LL_DataOutStage+0xb8>
    {
      if(pep->rem_length > pep->maxpacket)
c0d04966:	2090      	movs	r0, #144	; 0x90
c0d04968:	5820      	ldr	r0, [r4, r0]
c0d0496a:	218c      	movs	r1, #140	; 0x8c
c0d0496c:	5861      	ldr	r1, [r4, r1]
c0d0496e:	4622      	mov	r2, r4
c0d04970:	328c      	adds	r2, #140	; 0x8c
c0d04972:	4281      	cmp	r1, r0
c0d04974:	d90a      	bls.n	c0d0498c <USBD_LL_DataOutStage+0x7a>
      {
        pep->rem_length -=  pep->maxpacket;
c0d04976:	1a09      	subs	r1, r1, r0
c0d04978:	6011      	str	r1, [r2, #0]
c0d0497a:	4281      	cmp	r1, r0
c0d0497c:	d300      	bcc.n	c0d04980 <USBD_LL_DataOutStage+0x6e>
c0d0497e:	4601      	mov	r1, r0
       
        USBD_CtlContinueRx (pdev, 
c0d04980:	b28a      	uxth	r2, r1
c0d04982:	4620      	mov	r0, r4
c0d04984:	9902      	ldr	r1, [sp, #8]
c0d04986:	f000 fd35 	bl	c0d053f4 <USBD_CtlContinueRx>
c0d0498a:	e01e      	b.n	c0d049ca <USBD_LL_DataOutStage+0xb8>
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        uint8_t intf;
        for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d0498c:	2045      	movs	r0, #69	; 0x45
c0d0498e:	0080      	lsls	r0, r0, #2
c0d04990:	1826      	adds	r6, r4, r0
c0d04992:	4627      	mov	r7, r4
c0d04994:	37fc      	adds	r7, #252	; 0xfc
c0d04996:	2500      	movs	r5, #0
          if(usbd_is_valid_intf(pdev, intf) &&  (pdev->interfacesClass[intf].pClass->EP0_RxReady != NULL)&&
c0d04998:	4620      	mov	r0, r4
c0d0499a:	4629      	mov	r1, r5
c0d0499c:	f000 f8d8 	bl	c0d04b50 <usbd_is_valid_intf>
c0d049a0:	2800      	cmp	r0, #0
c0d049a2:	d00c      	beq.n	c0d049be <USBD_LL_DataOutStage+0xac>
c0d049a4:	00e8      	lsls	r0, r5, #3
c0d049a6:	5830      	ldr	r0, [r6, r0]
c0d049a8:	6900      	ldr	r0, [r0, #16]
c0d049aa:	2800      	cmp	r0, #0
c0d049ac:	d007      	beq.n	c0d049be <USBD_LL_DataOutStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d049ae:	7839      	ldrb	r1, [r7, #0]
      }
      else
      {
        uint8_t intf;
        for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
          if(usbd_is_valid_intf(pdev, intf) &&  (pdev->interfacesClass[intf].pClass->EP0_RxReady != NULL)&&
c0d049b0:	2903      	cmp	r1, #3
c0d049b2:	d104      	bne.n	c0d049be <USBD_LL_DataOutStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
          {
            ((EP0_RxReady_t)PIC(pdev->interfacesClass[intf].pClass->EP0_RxReady))(pdev); 
c0d049b4:	f7fe f936 	bl	c0d02c24 <pic>
c0d049b8:	4601      	mov	r1, r0
c0d049ba:	4620      	mov	r0, r4
c0d049bc:	4788      	blx	r1
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        uint8_t intf;
        for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d049be:	1c6d      	adds	r5, r5, #1
c0d049c0:	2d03      	cmp	r5, #3
c0d049c2:	d1e9      	bne.n	c0d04998 <USBD_LL_DataOutStage+0x86>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
          {
            ((EP0_RxReady_t)PIC(pdev->interfacesClass[intf].pClass->EP0_RxReady))(pdev); 
          }
        }
        USBD_CtlSendStatus(pdev);
c0d049c4:	4620      	mov	r0, r4
c0d049c6:	f000 fd1c 	bl	c0d05402 <USBD_CtlSendStatus>
      {
        ((DataOut_t)PIC(pdev->interfacesClass[intf].pClass->DataOut))(pdev, epnum, pdata); 
      }
    }
  }  
  return USBD_OK;
c0d049ca:	2000      	movs	r0, #0
c0d049cc:	b003      	add	sp, #12
c0d049ce:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d049d0 <USBD_LL_DataInStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataInStage(USBD_HandleTypeDef *pdev ,uint8_t epnum, uint8_t *pdata)
{
c0d049d0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d049d2:	b081      	sub	sp, #4
c0d049d4:	4604      	mov	r4, r0
c0d049d6:	9100      	str	r1, [sp, #0]
  USBD_EndpointTypeDef    *pep;
  UNUSED(pdata);
    
  if(epnum == 0) 
c0d049d8:	2900      	cmp	r1, #0
c0d049da:	d01d      	beq.n	c0d04a18 <USBD_LL_DataInStage+0x48>
      pdev->dev_test_mode = 0;
    }
  }
  else {
    uint8_t intf;
    for (intf = 0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d049dc:	2045      	movs	r0, #69	; 0x45
c0d049de:	0080      	lsls	r0, r0, #2
c0d049e0:	1827      	adds	r7, r4, r0
c0d049e2:	4625      	mov	r5, r4
c0d049e4:	35fc      	adds	r5, #252	; 0xfc
c0d049e6:	2600      	movs	r6, #0
      if( usbd_is_valid_intf(pdev, intf) && (pdev->interfacesClass[intf].pClass->DataIn != NULL)&&
c0d049e8:	4620      	mov	r0, r4
c0d049ea:	4631      	mov	r1, r6
c0d049ec:	f000 f8b0 	bl	c0d04b50 <usbd_is_valid_intf>
c0d049f0:	2800      	cmp	r0, #0
c0d049f2:	d00d      	beq.n	c0d04a10 <USBD_LL_DataInStage+0x40>
c0d049f4:	00f0      	lsls	r0, r6, #3
c0d049f6:	5838      	ldr	r0, [r7, r0]
c0d049f8:	6940      	ldr	r0, [r0, #20]
c0d049fa:	2800      	cmp	r0, #0
c0d049fc:	d008      	beq.n	c0d04a10 <USBD_LL_DataInStage+0x40>
         (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d049fe:	7829      	ldrb	r1, [r5, #0]
    }
  }
  else {
    uint8_t intf;
    for (intf = 0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
      if( usbd_is_valid_intf(pdev, intf) && (pdev->interfacesClass[intf].pClass->DataIn != NULL)&&
c0d04a00:	2903      	cmp	r1, #3
c0d04a02:	d105      	bne.n	c0d04a10 <USBD_LL_DataInStage+0x40>
         (pdev->dev_state == USBD_STATE_CONFIGURED))
      {
        ((DataIn_t)PIC(pdev->interfacesClass[intf].pClass->DataIn))(pdev, epnum); 
c0d04a04:	f7fe f90e 	bl	c0d02c24 <pic>
c0d04a08:	4602      	mov	r2, r0
c0d04a0a:	4620      	mov	r0, r4
c0d04a0c:	9900      	ldr	r1, [sp, #0]
c0d04a0e:	4790      	blx	r2
      pdev->dev_test_mode = 0;
    }
  }
  else {
    uint8_t intf;
    for (intf = 0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d04a10:	1c76      	adds	r6, r6, #1
c0d04a12:	2e03      	cmp	r6, #3
c0d04a14:	d1e8      	bne.n	c0d049e8 <USBD_LL_DataInStage+0x18>
c0d04a16:	e051      	b.n	c0d04abc <USBD_LL_DataInStage+0xec>
    
  if(epnum == 0) 
  {
    pep = &pdev->ep_in[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_IN)
c0d04a18:	20f4      	movs	r0, #244	; 0xf4
c0d04a1a:	5820      	ldr	r0, [r4, r0]
c0d04a1c:	2802      	cmp	r0, #2
c0d04a1e:	d145      	bne.n	c0d04aac <USBD_LL_DataInStage+0xdc>
    {
      if(pep->rem_length > pep->maxpacket)
c0d04a20:	69e0      	ldr	r0, [r4, #28]
c0d04a22:	6a25      	ldr	r5, [r4, #32]
c0d04a24:	42a8      	cmp	r0, r5
c0d04a26:	d90b      	bls.n	c0d04a40 <USBD_LL_DataInStage+0x70>
      {
        pep->rem_length -=  pep->maxpacket;
c0d04a28:	1b40      	subs	r0, r0, r5
c0d04a2a:	61e0      	str	r0, [r4, #28]
        pdev->pData += pep->maxpacket;
c0d04a2c:	2113      	movs	r1, #19
c0d04a2e:	010a      	lsls	r2, r1, #4
c0d04a30:	58a1      	ldr	r1, [r4, r2]
c0d04a32:	1949      	adds	r1, r1, r5
c0d04a34:	50a1      	str	r1, [r4, r2]
        USBD_LL_PrepareReceive (pdev,
                                0,
                                0);  
        */
        
        USBD_CtlContinueSendData (pdev, 
c0d04a36:	b282      	uxth	r2, r0
c0d04a38:	4620      	mov	r0, r4
c0d04a3a:	f000 fccd 	bl	c0d053d8 <USBD_CtlContinueSendData>
c0d04a3e:	e035      	b.n	c0d04aac <USBD_LL_DataInStage+0xdc>
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d04a40:	69a6      	ldr	r6, [r4, #24]
c0d04a42:	4630      	mov	r0, r6
c0d04a44:	4629      	mov	r1, r5
c0d04a46:	f001 fb37 	bl	c0d060b8 <__aeabi_uidivmod>
c0d04a4a:	42ae      	cmp	r6, r5
c0d04a4c:	d30f      	bcc.n	c0d04a6e <USBD_LL_DataInStage+0x9e>
c0d04a4e:	2900      	cmp	r1, #0
c0d04a50:	d10d      	bne.n	c0d04a6e <USBD_LL_DataInStage+0x9e>
           (pep->total_length >= pep->maxpacket) &&
             (pep->total_length < pdev->ep0_data_len ))
c0d04a52:	20f8      	movs	r0, #248	; 0xf8
c0d04a54:	5820      	ldr	r0, [r4, r0]
c0d04a56:	4627      	mov	r7, r4
c0d04a58:	37f8      	adds	r7, #248	; 0xf8
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d04a5a:	4286      	cmp	r6, r0
c0d04a5c:	d207      	bcs.n	c0d04a6e <USBD_LL_DataInStage+0x9e>
c0d04a5e:	2500      	movs	r5, #0
          USBD_LL_PrepareReceive (pdev,
                                  0,
                                  0);
          */

          USBD_CtlContinueSendData(pdev , NULL, 0);
c0d04a60:	4620      	mov	r0, r4
c0d04a62:	4629      	mov	r1, r5
c0d04a64:	462a      	mov	r2, r5
c0d04a66:	f000 fcb7 	bl	c0d053d8 <USBD_CtlContinueSendData>
          pdev->ep0_data_len = 0;
c0d04a6a:	603d      	str	r5, [r7, #0]
c0d04a6c:	e01e      	b.n	c0d04aac <USBD_LL_DataInStage+0xdc>
          
        }
        else
        {
          uint8_t intf;
          for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d04a6e:	2045      	movs	r0, #69	; 0x45
c0d04a70:	0080      	lsls	r0, r0, #2
c0d04a72:	1826      	adds	r6, r4, r0
c0d04a74:	4627      	mov	r7, r4
c0d04a76:	37fc      	adds	r7, #252	; 0xfc
c0d04a78:	2500      	movs	r5, #0
            if(usbd_is_valid_intf(pdev, intf) && (pdev->interfacesClass[intf].pClass->EP0_TxSent != NULL)&&
c0d04a7a:	4620      	mov	r0, r4
c0d04a7c:	4629      	mov	r1, r5
c0d04a7e:	f000 f867 	bl	c0d04b50 <usbd_is_valid_intf>
c0d04a82:	2800      	cmp	r0, #0
c0d04a84:	d00c      	beq.n	c0d04aa0 <USBD_LL_DataInStage+0xd0>
c0d04a86:	00e8      	lsls	r0, r5, #3
c0d04a88:	5830      	ldr	r0, [r6, r0]
c0d04a8a:	68c0      	ldr	r0, [r0, #12]
c0d04a8c:	2800      	cmp	r0, #0
c0d04a8e:	d007      	beq.n	c0d04aa0 <USBD_LL_DataInStage+0xd0>
               (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d04a90:	7839      	ldrb	r1, [r7, #0]
        }
        else
        {
          uint8_t intf;
          for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
            if(usbd_is_valid_intf(pdev, intf) && (pdev->interfacesClass[intf].pClass->EP0_TxSent != NULL)&&
c0d04a92:	2903      	cmp	r1, #3
c0d04a94:	d104      	bne.n	c0d04aa0 <USBD_LL_DataInStage+0xd0>
               (pdev->dev_state == USBD_STATE_CONFIGURED))
            {
              ((EP0_RxReady_t)PIC(pdev->interfacesClass[intf].pClass->EP0_TxSent))(pdev); 
c0d04a96:	f7fe f8c5 	bl	c0d02c24 <pic>
c0d04a9a:	4601      	mov	r1, r0
c0d04a9c:	4620      	mov	r0, r4
c0d04a9e:	4788      	blx	r1
          
        }
        else
        {
          uint8_t intf;
          for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d04aa0:	1c6d      	adds	r5, r5, #1
c0d04aa2:	2d03      	cmp	r5, #3
c0d04aa4:	d1e9      	bne.n	c0d04a7a <USBD_LL_DataInStage+0xaa>
               (pdev->dev_state == USBD_STATE_CONFIGURED))
            {
              ((EP0_RxReady_t)PIC(pdev->interfacesClass[intf].pClass->EP0_TxSent))(pdev); 
            }
          }
          USBD_CtlReceiveStatus(pdev);
c0d04aa6:	4620      	mov	r0, r4
c0d04aa8:	f000 fcb7 	bl	c0d0541a <USBD_CtlReceiveStatus>
        }
      }
    }
    if (pdev->dev_test_mode == 1)
c0d04aac:	2001      	movs	r0, #1
c0d04aae:	0201      	lsls	r1, r0, #8
c0d04ab0:	1860      	adds	r0, r4, r1
c0d04ab2:	5c61      	ldrb	r1, [r4, r1]
c0d04ab4:	2901      	cmp	r1, #1
c0d04ab6:	d101      	bne.n	c0d04abc <USBD_LL_DataInStage+0xec>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
c0d04ab8:	2100      	movs	r1, #0
c0d04aba:	7001      	strb	r1, [r0, #0]
      {
        ((DataIn_t)PIC(pdev->interfacesClass[intf].pClass->DataIn))(pdev, epnum); 
      }
    }
  }
  return USBD_OK;
c0d04abc:	2000      	movs	r0, #0
c0d04abe:	b001      	add	sp, #4
c0d04ac0:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d04ac2 <USBD_LL_Reset>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Reset(USBD_HandleTypeDef  *pdev)
{
c0d04ac2:	b570      	push	{r4, r5, r6, lr}
c0d04ac4:	4604      	mov	r4, r0
  pdev->ep_out[0].maxpacket = USB_MAX_EP0_SIZE;
c0d04ac6:	2090      	movs	r0, #144	; 0x90
c0d04ac8:	2140      	movs	r1, #64	; 0x40
c0d04aca:	5021      	str	r1, [r4, r0]
  

  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
c0d04acc:	6221      	str	r1, [r4, #32]
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
c0d04ace:	20fc      	movs	r0, #252	; 0xfc
c0d04ad0:	2101      	movs	r1, #1
c0d04ad2:	5421      	strb	r1, [r4, r0]
 
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d04ad4:	2045      	movs	r0, #69	; 0x45
c0d04ad6:	0080      	lsls	r0, r0, #2
c0d04ad8:	1826      	adds	r6, r4, r0
c0d04ada:	2500      	movs	r5, #0
    if( usbd_is_valid_intf(pdev, intf))
c0d04adc:	4620      	mov	r0, r4
c0d04ade:	4629      	mov	r1, r5
c0d04ae0:	f000 f836 	bl	c0d04b50 <usbd_is_valid_intf>
c0d04ae4:	2800      	cmp	r0, #0
c0d04ae6:	d008      	beq.n	c0d04afa <USBD_LL_Reset+0x38>
    {
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, pdev->dev_config); 
c0d04ae8:	00e8      	lsls	r0, r5, #3
c0d04aea:	5830      	ldr	r0, [r6, r0]
c0d04aec:	6840      	ldr	r0, [r0, #4]
c0d04aee:	f7fe f899 	bl	c0d02c24 <pic>
c0d04af2:	4602      	mov	r2, r0
c0d04af4:	7921      	ldrb	r1, [r4, #4]
c0d04af6:	4620      	mov	r0, r4
c0d04af8:	4790      	blx	r2
  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
 
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d04afa:	1c6d      	adds	r5, r5, #1
c0d04afc:	2d03      	cmp	r5, #3
c0d04afe:	d1ed      	bne.n	c0d04adc <USBD_LL_Reset+0x1a>
    {
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, pdev->dev_config); 
    }
  }
  
  return USBD_OK;
c0d04b00:	2000      	movs	r0, #0
c0d04b02:	bd70      	pop	{r4, r5, r6, pc}

c0d04b04 <USBD_LL_SetSpeed>:
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetSpeed(USBD_HandleTypeDef  *pdev, USBD_SpeedTypeDef speed)
{
  pdev->dev_speed = speed;
c0d04b04:	7401      	strb	r1, [r0, #16]
c0d04b06:	2000      	movs	r0, #0
  return USBD_OK;
c0d04b08:	4770      	bx	lr

c0d04b0a <USBD_LL_Suspend>:
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_old_state =  pdev->dev_state;
  //pdev->dev_state  = USBD_STATE_SUSPENDED;
  return USBD_OK;
c0d04b0a:	2000      	movs	r0, #0
c0d04b0c:	4770      	bx	lr

c0d04b0e <USBD_LL_Resume>:
USBD_StatusTypeDef USBD_LL_Resume(USBD_HandleTypeDef  *pdev)
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_state = pdev->dev_old_state;  
  return USBD_OK;
c0d04b0e:	2000      	movs	r0, #0
c0d04b10:	4770      	bx	lr

c0d04b12 <USBD_LL_SOF>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_SOF(USBD_HandleTypeDef  *pdev)
{
c0d04b12:	b570      	push	{r4, r5, r6, lr}
c0d04b14:	4604      	mov	r4, r0
  if(pdev->dev_state == USBD_STATE_CONFIGURED)
c0d04b16:	20fc      	movs	r0, #252	; 0xfc
c0d04b18:	5c20      	ldrb	r0, [r4, r0]
c0d04b1a:	2803      	cmp	r0, #3
c0d04b1c:	d116      	bne.n	c0d04b4c <USBD_LL_SOF+0x3a>
  {
    uint8_t intf;
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
      if( usbd_is_valid_intf(pdev, intf) && pdev->interfacesClass[intf].pClass->SOF != NULL)
c0d04b1e:	2045      	movs	r0, #69	; 0x45
c0d04b20:	0080      	lsls	r0, r0, #2
c0d04b22:	1826      	adds	r6, r4, r0
c0d04b24:	2500      	movs	r5, #0
c0d04b26:	4620      	mov	r0, r4
c0d04b28:	4629      	mov	r1, r5
c0d04b2a:	f000 f811 	bl	c0d04b50 <usbd_is_valid_intf>
c0d04b2e:	2800      	cmp	r0, #0
c0d04b30:	d009      	beq.n	c0d04b46 <USBD_LL_SOF+0x34>
c0d04b32:	00e8      	lsls	r0, r5, #3
c0d04b34:	5830      	ldr	r0, [r6, r0]
c0d04b36:	69c0      	ldr	r0, [r0, #28]
c0d04b38:	2800      	cmp	r0, #0
c0d04b3a:	d004      	beq.n	c0d04b46 <USBD_LL_SOF+0x34>
      {
        ((SOF_t)PIC(pdev->interfacesClass[intf].pClass->SOF))(pdev); 
c0d04b3c:	f7fe f872 	bl	c0d02c24 <pic>
c0d04b40:	4601      	mov	r1, r0
c0d04b42:	4620      	mov	r0, r4
c0d04b44:	4788      	blx	r1
USBD_StatusTypeDef USBD_LL_SOF(USBD_HandleTypeDef  *pdev)
{
  if(pdev->dev_state == USBD_STATE_CONFIGURED)
  {
    uint8_t intf;
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d04b46:	1c6d      	adds	r5, r5, #1
c0d04b48:	2d03      	cmp	r5, #3
c0d04b4a:	d1ec      	bne.n	c0d04b26 <USBD_LL_SOF+0x14>
      {
        ((SOF_t)PIC(pdev->interfacesClass[intf].pClass->SOF))(pdev); 
      }
    }
  }
  return USBD_OK;
c0d04b4c:	2000      	movs	r0, #0
c0d04b4e:	bd70      	pop	{r4, r5, r6, pc}

c0d04b50 <usbd_is_valid_intf>:

/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
c0d04b50:	4602      	mov	r2, r0
c0d04b52:	2000      	movs	r0, #0
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d04b54:	2902      	cmp	r1, #2
c0d04b56:	d808      	bhi.n	c0d04b6a <usbd_is_valid_intf+0x1a>
c0d04b58:	00c8      	lsls	r0, r1, #3
c0d04b5a:	1810      	adds	r0, r2, r0
c0d04b5c:	2145      	movs	r1, #69	; 0x45
c0d04b5e:	0089      	lsls	r1, r1, #2
c0d04b60:	5841      	ldr	r1, [r0, r1]
c0d04b62:	2001      	movs	r0, #1
c0d04b64:	2900      	cmp	r1, #0
c0d04b66:	d100      	bne.n	c0d04b6a <usbd_is_valid_intf+0x1a>
c0d04b68:	4608      	mov	r0, r1
c0d04b6a:	4770      	bx	lr

c0d04b6c <USBD_StdDevReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdDevReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d04b6c:	b580      	push	{r7, lr}
c0d04b6e:	784a      	ldrb	r2, [r1, #1]
  USBD_StatusTypeDef ret = USBD_OK;  
  
  switch (req->bRequest) 
c0d04b70:	2a04      	cmp	r2, #4
c0d04b72:	dd08      	ble.n	c0d04b86 <USBD_StdDevReq+0x1a>
c0d04b74:	2a07      	cmp	r2, #7
c0d04b76:	dc0f      	bgt.n	c0d04b98 <USBD_StdDevReq+0x2c>
c0d04b78:	2a05      	cmp	r2, #5
c0d04b7a:	d014      	beq.n	c0d04ba6 <USBD_StdDevReq+0x3a>
c0d04b7c:	2a06      	cmp	r2, #6
c0d04b7e:	d11b      	bne.n	c0d04bb8 <USBD_StdDevReq+0x4c>
  {
  case USB_REQ_GET_DESCRIPTOR: 
    
    USBD_GetDescriptor (pdev, req) ;
c0d04b80:	f000 f821 	bl	c0d04bc6 <USBD_GetDescriptor>
c0d04b84:	e01d      	b.n	c0d04bc2 <USBD_StdDevReq+0x56>
c0d04b86:	2a00      	cmp	r2, #0
c0d04b88:	d010      	beq.n	c0d04bac <USBD_StdDevReq+0x40>
c0d04b8a:	2a01      	cmp	r2, #1
c0d04b8c:	d017      	beq.n	c0d04bbe <USBD_StdDevReq+0x52>
c0d04b8e:	2a03      	cmp	r2, #3
c0d04b90:	d112      	bne.n	c0d04bb8 <USBD_StdDevReq+0x4c>
    USBD_GetStatus (pdev , req);
    break;
    
    
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
c0d04b92:	f000 f93b 	bl	c0d04e0c <USBD_SetFeature>
c0d04b96:	e014      	b.n	c0d04bc2 <USBD_StdDevReq+0x56>
c0d04b98:	2a08      	cmp	r2, #8
c0d04b9a:	d00a      	beq.n	c0d04bb2 <USBD_StdDevReq+0x46>
c0d04b9c:	2a09      	cmp	r2, #9
c0d04b9e:	d10b      	bne.n	c0d04bb8 <USBD_StdDevReq+0x4c>
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
    break;
    
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
c0d04ba0:	f000 f8c3 	bl	c0d04d2a <USBD_SetConfig>
c0d04ba4:	e00d      	b.n	c0d04bc2 <USBD_StdDevReq+0x56>
    
    USBD_GetDescriptor (pdev, req) ;
    break;
    
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
c0d04ba6:	f000 f89b 	bl	c0d04ce0 <USBD_SetAddress>
c0d04baa:	e00a      	b.n	c0d04bc2 <USBD_StdDevReq+0x56>
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_STATUS:                                  
    USBD_GetStatus (pdev , req);
c0d04bac:	f000 f90b 	bl	c0d04dc6 <USBD_GetStatus>
c0d04bb0:	e007      	b.n	c0d04bc2 <USBD_StdDevReq+0x56>
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
c0d04bb2:	f000 f8f1 	bl	c0d04d98 <USBD_GetConfig>
c0d04bb6:	e004      	b.n	c0d04bc2 <USBD_StdDevReq+0x56>
  case USB_REQ_CLEAR_FEATURE:                                   
    USBD_ClrFeature (pdev , req);
    break;
    
  default:  
    USBD_CtlError(pdev , req);
c0d04bb8:	f000 f971 	bl	c0d04e9e <USBD_CtlError>
c0d04bbc:	e001      	b.n	c0d04bc2 <USBD_StdDevReq+0x56>
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
    break;
    
  case USB_REQ_CLEAR_FEATURE:                                   
    USBD_ClrFeature (pdev , req);
c0d04bbe:	f000 f944 	bl	c0d04e4a <USBD_ClrFeature>
  default:  
    USBD_CtlError(pdev , req);
    break;
  }
  
  return ret;
c0d04bc2:	2000      	movs	r0, #0
c0d04bc4:	bd80      	pop	{r7, pc}

c0d04bc6 <USBD_GetDescriptor>:
* @param  req: usb request
* @retval status
*/
void USBD_GetDescriptor(USBD_HandleTypeDef *pdev , 
                               USBD_SetupReqTypedef *req)
{
c0d04bc6:	b5b0      	push	{r4, r5, r7, lr}
c0d04bc8:	b082      	sub	sp, #8
c0d04bca:	460d      	mov	r5, r1
c0d04bcc:	4604      	mov	r4, r0
  uint16_t len;
  uint8_t *pbuf = NULL;
  
    
  switch (req->wValue >> 8)
c0d04bce:	8869      	ldrh	r1, [r5, #2]
c0d04bd0:	0a08      	lsrs	r0, r1, #8
c0d04bd2:	2805      	cmp	r0, #5
c0d04bd4:	dc13      	bgt.n	c0d04bfe <USBD_GetDescriptor+0x38>
c0d04bd6:	2801      	cmp	r0, #1
c0d04bd8:	d01c      	beq.n	c0d04c14 <USBD_GetDescriptor+0x4e>
c0d04bda:	2802      	cmp	r0, #2
c0d04bdc:	d025      	beq.n	c0d04c2a <USBD_GetDescriptor+0x64>
c0d04bde:	2803      	cmp	r0, #3
c0d04be0:	d13b      	bne.n	c0d04c5a <USBD_GetDescriptor+0x94>
c0d04be2:	b2c8      	uxtb	r0, r1
      }
    }
    break;
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
c0d04be4:	2802      	cmp	r0, #2
c0d04be6:	dc3d      	bgt.n	c0d04c64 <USBD_GetDescriptor+0x9e>
c0d04be8:	2800      	cmp	r0, #0
c0d04bea:	d065      	beq.n	c0d04cb8 <USBD_GetDescriptor+0xf2>
c0d04bec:	2801      	cmp	r0, #1
c0d04bee:	d06d      	beq.n	c0d04ccc <USBD_GetDescriptor+0x106>
c0d04bf0:	2802      	cmp	r0, #2
c0d04bf2:	d132      	bne.n	c0d04c5a <USBD_GetDescriptor+0x94>
    case USBD_IDX_MFC_STR:
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
      break;
      
    case USBD_IDX_PRODUCT_STR:
      pbuf = ((GetProductStrDescriptor_t)PIC(pdev->pDesc->GetProductStrDescriptor))(pdev->dev_speed, &len);
c0d04bf4:	2011      	movs	r0, #17
c0d04bf6:	0100      	lsls	r0, r0, #4
c0d04bf8:	5820      	ldr	r0, [r4, r0]
c0d04bfa:	68c0      	ldr	r0, [r0, #12]
c0d04bfc:	e00e      	b.n	c0d04c1c <USBD_GetDescriptor+0x56>
c0d04bfe:	2806      	cmp	r0, #6
c0d04c00:	d01e      	beq.n	c0d04c40 <USBD_GetDescriptor+0x7a>
c0d04c02:	2807      	cmp	r0, #7
c0d04c04:	d026      	beq.n	c0d04c54 <USBD_GetDescriptor+0x8e>
c0d04c06:	280f      	cmp	r0, #15
c0d04c08:	d127      	bne.n	c0d04c5a <USBD_GetDescriptor+0x94>
    
  switch (req->wValue >> 8)
  { 
#if (USBD_LPM_ENABLED == 1)
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
c0d04c0a:	2011      	movs	r0, #17
c0d04c0c:	0100      	lsls	r0, r0, #4
c0d04c0e:	5820      	ldr	r0, [r4, r0]
c0d04c10:	69c0      	ldr	r0, [r0, #28]
c0d04c12:	e003      	b.n	c0d04c1c <USBD_GetDescriptor+0x56>
    break;
#endif    
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
c0d04c14:	2011      	movs	r0, #17
c0d04c16:	0100      	lsls	r0, r0, #4
c0d04c18:	5820      	ldr	r0, [r4, r0]
c0d04c1a:	6800      	ldr	r0, [r0, #0]
c0d04c1c:	f7fe f802 	bl	c0d02c24 <pic>
c0d04c20:	4602      	mov	r2, r0
c0d04c22:	7c20      	ldrb	r0, [r4, #16]
c0d04c24:	a901      	add	r1, sp, #4
c0d04c26:	4790      	blx	r2
c0d04c28:	e034      	b.n	c0d04c94 <USBD_GetDescriptor+0xce>
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->interfacesClass[0].pClass != NULL) {
c0d04c2a:	2045      	movs	r0, #69	; 0x45
c0d04c2c:	0080      	lsls	r0, r0, #2
c0d04c2e:	5820      	ldr	r0, [r4, r0]
c0d04c30:	2100      	movs	r1, #0
c0d04c32:	2800      	cmp	r0, #0
c0d04c34:	d02f      	beq.n	c0d04c96 <USBD_GetDescriptor+0xd0>
      if(pdev->dev_speed == USBD_SPEED_HIGH )   
c0d04c36:	7c21      	ldrb	r1, [r4, #16]
c0d04c38:	2900      	cmp	r1, #0
c0d04c3a:	d025      	beq.n	c0d04c88 <USBD_GetDescriptor+0xc2>
        pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetHSConfigDescriptor))(&len);
        //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
      }
      else
      {
        pbuf   = (uint8_t *)((GetFSConfigDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetFSConfigDescriptor))(&len);
c0d04c3c:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d04c3e:	e024      	b.n	c0d04c8a <USBD_GetDescriptor+0xc4>
#endif   
    }
    break;
  case USB_DESC_TYPE_DEVICE_QUALIFIER:                   

    if(pdev->dev_speed == USBD_SPEED_HIGH && pdev->interfacesClass[0].pClass != NULL )   
c0d04c40:	7c20      	ldrb	r0, [r4, #16]
c0d04c42:	2800      	cmp	r0, #0
c0d04c44:	d109      	bne.n	c0d04c5a <USBD_GetDescriptor+0x94>
c0d04c46:	2045      	movs	r0, #69	; 0x45
c0d04c48:	0080      	lsls	r0, r0, #2
c0d04c4a:	5820      	ldr	r0, [r4, r0]
c0d04c4c:	2800      	cmp	r0, #0
c0d04c4e:	d004      	beq.n	c0d04c5a <USBD_GetDescriptor+0x94>
    {
      pbuf   = (uint8_t *)((GetDeviceQualifierDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetDeviceQualifierDescriptor))(&len);
c0d04c50:	6b40      	ldr	r0, [r0, #52]	; 0x34
c0d04c52:	e01a      	b.n	c0d04c8a <USBD_GetDescriptor+0xc4>
      USBD_CtlError(pdev , req);
      return;
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH && pdev->interfacesClass[0].pClass != NULL)   
c0d04c54:	7c20      	ldrb	r0, [r4, #16]
c0d04c56:	2800      	cmp	r0, #0
c0d04c58:	d00f      	beq.n	c0d04c7a <USBD_GetDescriptor+0xb4>
c0d04c5a:	4620      	mov	r0, r4
c0d04c5c:	4629      	mov	r1, r5
c0d04c5e:	f000 f91e 	bl	c0d04e9e <USBD_CtlError>
c0d04c62:	e027      	b.n	c0d04cb4 <USBD_GetDescriptor+0xee>
c0d04c64:	2803      	cmp	r0, #3
c0d04c66:	d02c      	beq.n	c0d04cc2 <USBD_GetDescriptor+0xfc>
c0d04c68:	2804      	cmp	r0, #4
c0d04c6a:	d034      	beq.n	c0d04cd6 <USBD_GetDescriptor+0x110>
c0d04c6c:	2805      	cmp	r0, #5
c0d04c6e:	d1f4      	bne.n	c0d04c5a <USBD_GetDescriptor+0x94>
    case USBD_IDX_CONFIG_STR:
      pbuf = ((GetConfigurationStrDescriptor_t)PIC(pdev->pDesc->GetConfigurationStrDescriptor))(pdev->dev_speed, &len);
      break;
      
    case USBD_IDX_INTERFACE_STR:
      pbuf = ((GetInterfaceStrDescriptor_t)PIC(pdev->pDesc->GetInterfaceStrDescriptor))(pdev->dev_speed, &len);
c0d04c70:	2011      	movs	r0, #17
c0d04c72:	0100      	lsls	r0, r0, #4
c0d04c74:	5820      	ldr	r0, [r4, r0]
c0d04c76:	6980      	ldr	r0, [r0, #24]
c0d04c78:	e7d0      	b.n	c0d04c1c <USBD_GetDescriptor+0x56>
      USBD_CtlError(pdev , req);
      return;
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH && pdev->interfacesClass[0].pClass != NULL)   
c0d04c7a:	2045      	movs	r0, #69	; 0x45
c0d04c7c:	0080      	lsls	r0, r0, #2
c0d04c7e:	5820      	ldr	r0, [r4, r0]
c0d04c80:	2800      	cmp	r0, #0
c0d04c82:	d0ea      	beq.n	c0d04c5a <USBD_GetDescriptor+0x94>
    {
      pbuf   = (uint8_t *)((GetOtherSpeedConfigDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetOtherSpeedConfigDescriptor))(&len);
c0d04c84:	6b00      	ldr	r0, [r0, #48]	; 0x30
c0d04c86:	e000      	b.n	c0d04c8a <USBD_GetDescriptor+0xc4>
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->interfacesClass[0].pClass != NULL) {
      if(pdev->dev_speed == USBD_SPEED_HIGH )   
      {
        pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetHSConfigDescriptor))(&len);
c0d04c88:	6a80      	ldr	r0, [r0, #40]	; 0x28
c0d04c8a:	f7fd ffcb 	bl	c0d02c24 <pic>
c0d04c8e:	4601      	mov	r1, r0
c0d04c90:	a801      	add	r0, sp, #4
c0d04c92:	4788      	blx	r1
c0d04c94:	4601      	mov	r1, r0
c0d04c96:	a801      	add	r0, sp, #4
  default: 
     USBD_CtlError(pdev , req);
    return;
  }
  
  if((len != 0)&& (req->wLength != 0))
c0d04c98:	8802      	ldrh	r2, [r0, #0]
c0d04c9a:	2a00      	cmp	r2, #0
c0d04c9c:	d00a      	beq.n	c0d04cb4 <USBD_GetDescriptor+0xee>
c0d04c9e:	88e8      	ldrh	r0, [r5, #6]
c0d04ca0:	2800      	cmp	r0, #0
c0d04ca2:	d007      	beq.n	c0d04cb4 <USBD_GetDescriptor+0xee>
  {
    
    len = MIN(len , req->wLength);
c0d04ca4:	4282      	cmp	r2, r0
c0d04ca6:	d300      	bcc.n	c0d04caa <USBD_GetDescriptor+0xe4>
c0d04ca8:	4602      	mov	r2, r0
c0d04caa:	a801      	add	r0, sp, #4
c0d04cac:	8002      	strh	r2, [r0, #0]
    
    // prepare abort if host does not read the whole data
    //USBD_CtlReceiveStatus(pdev);

    // start transfer
    USBD_CtlSendData (pdev, 
c0d04cae:	4620      	mov	r0, r4
c0d04cb0:	f000 fb7c 	bl	c0d053ac <USBD_CtlSendData>
                      pbuf,
                      len);
  }
  
}
c0d04cb4:	b002      	add	sp, #8
c0d04cb6:	bdb0      	pop	{r4, r5, r7, pc}
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
    {
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
c0d04cb8:	2011      	movs	r0, #17
c0d04cba:	0100      	lsls	r0, r0, #4
c0d04cbc:	5820      	ldr	r0, [r4, r0]
c0d04cbe:	6840      	ldr	r0, [r0, #4]
c0d04cc0:	e7ac      	b.n	c0d04c1c <USBD_GetDescriptor+0x56>
    case USBD_IDX_PRODUCT_STR:
      pbuf = ((GetProductStrDescriptor_t)PIC(pdev->pDesc->GetProductStrDescriptor))(pdev->dev_speed, &len);
      break;
      
    case USBD_IDX_SERIAL_STR:
      pbuf = ((GetSerialStrDescriptor_t)PIC(pdev->pDesc->GetSerialStrDescriptor))(pdev->dev_speed, &len);
c0d04cc2:	2011      	movs	r0, #17
c0d04cc4:	0100      	lsls	r0, r0, #4
c0d04cc6:	5820      	ldr	r0, [r4, r0]
c0d04cc8:	6900      	ldr	r0, [r0, #16]
c0d04cca:	e7a7      	b.n	c0d04c1c <USBD_GetDescriptor+0x56>
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
      break;
      
    case USBD_IDX_MFC_STR:
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
c0d04ccc:	2011      	movs	r0, #17
c0d04cce:	0100      	lsls	r0, r0, #4
c0d04cd0:	5820      	ldr	r0, [r4, r0]
c0d04cd2:	6880      	ldr	r0, [r0, #8]
c0d04cd4:	e7a2      	b.n	c0d04c1c <USBD_GetDescriptor+0x56>
    case USBD_IDX_SERIAL_STR:
      pbuf = ((GetSerialStrDescriptor_t)PIC(pdev->pDesc->GetSerialStrDescriptor))(pdev->dev_speed, &len);
      break;
      
    case USBD_IDX_CONFIG_STR:
      pbuf = ((GetConfigurationStrDescriptor_t)PIC(pdev->pDesc->GetConfigurationStrDescriptor))(pdev->dev_speed, &len);
c0d04cd6:	2011      	movs	r0, #17
c0d04cd8:	0100      	lsls	r0, r0, #4
c0d04cda:	5820      	ldr	r0, [r4, r0]
c0d04cdc:	6940      	ldr	r0, [r0, #20]
c0d04cde:	e79d      	b.n	c0d04c1c <USBD_GetDescriptor+0x56>

c0d04ce0 <USBD_SetAddress>:
* @param  req: usb request
* @retval status
*/
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d04ce0:	b570      	push	{r4, r5, r6, lr}
c0d04ce2:	4604      	mov	r4, r0
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d04ce4:	8888      	ldrh	r0, [r1, #4]
c0d04ce6:	2800      	cmp	r0, #0
c0d04ce8:	d10b      	bne.n	c0d04d02 <USBD_SetAddress+0x22>
c0d04cea:	88c8      	ldrh	r0, [r1, #6]
c0d04cec:	2800      	cmp	r0, #0
c0d04cee:	d108      	bne.n	c0d04d02 <USBD_SetAddress+0x22>
  {
    dev_addr = (uint8_t)(req->wValue) & 0x7F;     
c0d04cf0:	8848      	ldrh	r0, [r1, #2]
c0d04cf2:	267f      	movs	r6, #127	; 0x7f
c0d04cf4:	4006      	ands	r6, r0
    
    if (pdev->dev_state == USBD_STATE_CONFIGURED) 
c0d04cf6:	20fc      	movs	r0, #252	; 0xfc
c0d04cf8:	5c20      	ldrb	r0, [r4, r0]
c0d04cfa:	4625      	mov	r5, r4
c0d04cfc:	35fc      	adds	r5, #252	; 0xfc
c0d04cfe:	2803      	cmp	r0, #3
c0d04d00:	d103      	bne.n	c0d04d0a <USBD_SetAddress+0x2a>
c0d04d02:	4620      	mov	r0, r4
c0d04d04:	f000 f8cb 	bl	c0d04e9e <USBD_CtlError>
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d04d08:	bd70      	pop	{r4, r5, r6, pc}
    {
      USBD_CtlError(pdev , req);
    } 
    else 
    {
      pdev->dev_address = dev_addr;
c0d04d0a:	20fe      	movs	r0, #254	; 0xfe
c0d04d0c:	5426      	strb	r6, [r4, r0]
      USBD_LL_SetUSBAddress(pdev, dev_addr);               
c0d04d0e:	b2f1      	uxtb	r1, r6
c0d04d10:	4620      	mov	r0, r4
c0d04d12:	f7ff fd0b 	bl	c0d0472c <USBD_LL_SetUSBAddress>
      USBD_CtlSendStatus(pdev);                         
c0d04d16:	4620      	mov	r0, r4
c0d04d18:	f000 fb73 	bl	c0d05402 <USBD_CtlSendStatus>
      
      if (dev_addr != 0) 
c0d04d1c:	2002      	movs	r0, #2
c0d04d1e:	2101      	movs	r1, #1
c0d04d20:	2e00      	cmp	r6, #0
c0d04d22:	d100      	bne.n	c0d04d26 <USBD_SetAddress+0x46>
c0d04d24:	4608      	mov	r0, r1
c0d04d26:	7028      	strb	r0, [r5, #0]
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d04d28:	bd70      	pop	{r4, r5, r6, pc}

c0d04d2a <USBD_SetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_SetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d04d2a:	b570      	push	{r4, r5, r6, lr}
c0d04d2c:	460d      	mov	r5, r1
c0d04d2e:	4604      	mov	r4, r0
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
c0d04d30:	78ae      	ldrb	r6, [r5, #2]
  
  if (cfgidx > USBD_MAX_NUM_CONFIGURATION ) 
c0d04d32:	2e02      	cmp	r6, #2
c0d04d34:	d21d      	bcs.n	c0d04d72 <USBD_SetConfig+0x48>
  {            
     USBD_CtlError(pdev , req);                              
  } 
  else 
  {
    switch (pdev->dev_state) 
c0d04d36:	20fc      	movs	r0, #252	; 0xfc
c0d04d38:	5c21      	ldrb	r1, [r4, r0]
c0d04d3a:	4620      	mov	r0, r4
c0d04d3c:	30fc      	adds	r0, #252	; 0xfc
c0d04d3e:	2903      	cmp	r1, #3
c0d04d40:	d007      	beq.n	c0d04d52 <USBD_SetConfig+0x28>
c0d04d42:	2902      	cmp	r1, #2
c0d04d44:	d115      	bne.n	c0d04d72 <USBD_SetConfig+0x48>
    {
    case USBD_STATE_ADDRESSED:
      if (cfgidx) 
c0d04d46:	2e00      	cmp	r6, #0
c0d04d48:	d022      	beq.n	c0d04d90 <USBD_SetConfig+0x66>
      {                                			   							   							   				
        pdev->dev_config = cfgidx;
c0d04d4a:	6066      	str	r6, [r4, #4]
        pdev->dev_state = USBD_STATE_CONFIGURED;
c0d04d4c:	2103      	movs	r1, #3
c0d04d4e:	7001      	strb	r1, [r0, #0]
c0d04d50:	e009      	b.n	c0d04d66 <USBD_SetConfig+0x3c>
      }
      USBD_CtlSendStatus(pdev);
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
c0d04d52:	2e00      	cmp	r6, #0
c0d04d54:	d012      	beq.n	c0d04d7c <USBD_SetConfig+0x52>
        pdev->dev_state = USBD_STATE_ADDRESSED;
        pdev->dev_config = cfgidx;          
        USBD_ClrClassConfig(pdev , cfgidx);
        USBD_CtlSendStatus(pdev);
      } 
      else  if (cfgidx != pdev->dev_config) 
c0d04d56:	6860      	ldr	r0, [r4, #4]
c0d04d58:	4286      	cmp	r6, r0
c0d04d5a:	d019      	beq.n	c0d04d90 <USBD_SetConfig+0x66>
      {
        /* Clear old configuration */
        USBD_ClrClassConfig(pdev , pdev->dev_config);
c0d04d5c:	b2c1      	uxtb	r1, r0
c0d04d5e:	4620      	mov	r0, r4
c0d04d60:	f7ff fd8b 	bl	c0d0487a <USBD_ClrClassConfig>
        
        /* set new configuration */
        pdev->dev_config = cfgidx;
c0d04d64:	6066      	str	r6, [r4, #4]
c0d04d66:	4620      	mov	r0, r4
c0d04d68:	4631      	mov	r1, r6
c0d04d6a:	f7ff fd69 	bl	c0d04840 <USBD_SetClassConfig>
c0d04d6e:	2802      	cmp	r0, #2
c0d04d70:	d10e      	bne.n	c0d04d90 <USBD_SetConfig+0x66>
c0d04d72:	4620      	mov	r0, r4
c0d04d74:	4629      	mov	r1, r5
c0d04d76:	f000 f892 	bl	c0d04e9e <USBD_CtlError>
    default:					
       USBD_CtlError(pdev , req);                     
      break;
    }
  }
}
c0d04d7a:	bd70      	pop	{r4, r5, r6, pc}
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
      {                           
        pdev->dev_state = USBD_STATE_ADDRESSED;
c0d04d7c:	2102      	movs	r1, #2
c0d04d7e:	7001      	strb	r1, [r0, #0]
        pdev->dev_config = cfgidx;          
c0d04d80:	6066      	str	r6, [r4, #4]
        USBD_ClrClassConfig(pdev , cfgidx);
c0d04d82:	4620      	mov	r0, r4
c0d04d84:	4631      	mov	r1, r6
c0d04d86:	f7ff fd78 	bl	c0d0487a <USBD_ClrClassConfig>
        USBD_CtlSendStatus(pdev);
c0d04d8a:	4620      	mov	r0, r4
c0d04d8c:	f000 fb39 	bl	c0d05402 <USBD_CtlSendStatus>
c0d04d90:	4620      	mov	r0, r4
c0d04d92:	f000 fb36 	bl	c0d05402 <USBD_CtlSendStatus>
    default:					
       USBD_CtlError(pdev , req);                     
      break;
    }
  }
}
c0d04d96:	bd70      	pop	{r4, r5, r6, pc}

c0d04d98 <USBD_GetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d04d98:	b580      	push	{r7, lr}

  if (req->wLength != 1) 
c0d04d9a:	88ca      	ldrh	r2, [r1, #6]
c0d04d9c:	2a01      	cmp	r2, #1
c0d04d9e:	d10a      	bne.n	c0d04db6 <USBD_GetConfig+0x1e>
  {                   
     USBD_CtlError(pdev , req);
  }
  else 
  {
    switch (pdev->dev_state )  
c0d04da0:	22fc      	movs	r2, #252	; 0xfc
c0d04da2:	5c82      	ldrb	r2, [r0, r2]
c0d04da4:	2a03      	cmp	r2, #3
c0d04da6:	d009      	beq.n	c0d04dbc <USBD_GetConfig+0x24>
c0d04da8:	2a02      	cmp	r2, #2
c0d04daa:	d104      	bne.n	c0d04db6 <USBD_GetConfig+0x1e>
    {
    case USBD_STATE_ADDRESSED:                     
      pdev->dev_default_config = 0;
c0d04dac:	2100      	movs	r1, #0
c0d04dae:	6081      	str	r1, [r0, #8]
c0d04db0:	4601      	mov	r1, r0
c0d04db2:	3108      	adds	r1, #8
c0d04db4:	e003      	b.n	c0d04dbe <USBD_GetConfig+0x26>
c0d04db6:	f000 f872 	bl	c0d04e9e <USBD_CtlError>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d04dba:	bd80      	pop	{r7, pc}
                        1);
      break;
      
    case USBD_STATE_CONFIGURED:   
      USBD_CtlSendData (pdev, 
                        (uint8_t *)&pdev->dev_config,
c0d04dbc:	1d01      	adds	r1, r0, #4
c0d04dbe:	2201      	movs	r2, #1
c0d04dc0:	f000 faf4 	bl	c0d053ac <USBD_CtlSendData>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d04dc4:	bd80      	pop	{r7, pc}

c0d04dc6 <USBD_GetStatus>:
* @param  req: usb request
* @retval status
*/
void USBD_GetStatus(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d04dc6:	b5b0      	push	{r4, r5, r7, lr}
c0d04dc8:	4604      	mov	r4, r0
  
    
  switch (pdev->dev_state) 
c0d04dca:	20fc      	movs	r0, #252	; 0xfc
c0d04dcc:	5c20      	ldrb	r0, [r4, r0]
c0d04dce:	22fe      	movs	r2, #254	; 0xfe
c0d04dd0:	4002      	ands	r2, r0
c0d04dd2:	2a02      	cmp	r2, #2
c0d04dd4:	d116      	bne.n	c0d04e04 <USBD_GetStatus+0x3e>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d04dd6:	2001      	movs	r0, #1
c0d04dd8:	60e0      	str	r0, [r4, #12]
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d04dda:	2041      	movs	r0, #65	; 0x41
c0d04ddc:	0080      	lsls	r0, r0, #2
c0d04dde:	5821      	ldr	r1, [r4, r0]
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d04de0:	4625      	mov	r5, r4
c0d04de2:	350c      	adds	r5, #12
c0d04de4:	2003      	movs	r0, #3
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d04de6:	2900      	cmp	r1, #0
c0d04de8:	d005      	beq.n	c0d04df6 <USBD_GetStatus+0x30>
c0d04dea:	4620      	mov	r0, r4
c0d04dec:	f000 fb15 	bl	c0d0541a <USBD_CtlReceiveStatus>
c0d04df0:	68e1      	ldr	r1, [r4, #12]
c0d04df2:	2002      	movs	r0, #2
c0d04df4:	4308      	orrs	r0, r1
    {
       pdev->dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;                                
c0d04df6:	60e0      	str	r0, [r4, #12]
    }
    
    USBD_CtlSendData (pdev, 
c0d04df8:	2202      	movs	r2, #2
c0d04dfa:	4620      	mov	r0, r4
c0d04dfc:	4629      	mov	r1, r5
c0d04dfe:	f000 fad5 	bl	c0d053ac <USBD_CtlSendData>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d04e02:	bdb0      	pop	{r4, r5, r7, pc}
                      (uint8_t *)& pdev->dev_config_status,
                      2);
    break;
    
  default :
    USBD_CtlError(pdev , req);                        
c0d04e04:	4620      	mov	r0, r4
c0d04e06:	f000 f84a 	bl	c0d04e9e <USBD_CtlError>
    break;
  }
}
c0d04e0a:	bdb0      	pop	{r4, r5, r7, pc}

c0d04e0c <USBD_SetFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_SetFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d04e0c:	b5b0      	push	{r4, r5, r7, lr}
c0d04e0e:	460d      	mov	r5, r1
c0d04e10:	4604      	mov	r4, r0

  if (req->wValue == USB_FEATURE_REMOTE_WAKEUP)
c0d04e12:	8868      	ldrh	r0, [r5, #2]
c0d04e14:	2801      	cmp	r0, #1
c0d04e16:	d117      	bne.n	c0d04e48 <USBD_SetFeature+0x3c>
  {
    pdev->dev_remote_wakeup = 1;  
c0d04e18:	2041      	movs	r0, #65	; 0x41
c0d04e1a:	0080      	lsls	r0, r0, #2
c0d04e1c:	2101      	movs	r1, #1
c0d04e1e:	5021      	str	r1, [r4, r0]
    if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d04e20:	7928      	ldrb	r0, [r5, #4]
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d04e22:	2802      	cmp	r0, #2
c0d04e24:	d80d      	bhi.n	c0d04e42 <USBD_SetFeature+0x36>
c0d04e26:	00c0      	lsls	r0, r0, #3
c0d04e28:	1820      	adds	r0, r4, r0
c0d04e2a:	2145      	movs	r1, #69	; 0x45
c0d04e2c:	0089      	lsls	r1, r1, #2
c0d04e2e:	5840      	ldr	r0, [r0, r1]
{

  if (req->wValue == USB_FEATURE_REMOTE_WAKEUP)
  {
    pdev->dev_remote_wakeup = 1;  
    if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d04e30:	2800      	cmp	r0, #0
c0d04e32:	d006      	beq.n	c0d04e42 <USBD_SetFeature+0x36>
      ((Setup_t)PIC(pdev->interfacesClass[LOBYTE(req->wIndex)].pClass->Setup)) (pdev, req);   
c0d04e34:	6880      	ldr	r0, [r0, #8]
c0d04e36:	f7fd fef5 	bl	c0d02c24 <pic>
c0d04e3a:	4602      	mov	r2, r0
c0d04e3c:	4620      	mov	r0, r4
c0d04e3e:	4629      	mov	r1, r5
c0d04e40:	4790      	blx	r2
    }
    USBD_CtlSendStatus(pdev);
c0d04e42:	4620      	mov	r0, r4
c0d04e44:	f000 fadd 	bl	c0d05402 <USBD_CtlSendStatus>
  }

}
c0d04e48:	bdb0      	pop	{r4, r5, r7, pc}

c0d04e4a <USBD_ClrFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_ClrFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d04e4a:	b5b0      	push	{r4, r5, r7, lr}
c0d04e4c:	460d      	mov	r5, r1
c0d04e4e:	4604      	mov	r4, r0
  switch (pdev->dev_state)
c0d04e50:	20fc      	movs	r0, #252	; 0xfc
c0d04e52:	5c20      	ldrb	r0, [r4, r0]
c0d04e54:	21fe      	movs	r1, #254	; 0xfe
c0d04e56:	4001      	ands	r1, r0
c0d04e58:	2902      	cmp	r1, #2
c0d04e5a:	d11b      	bne.n	c0d04e94 <USBD_ClrFeature+0x4a>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    if (req->wValue == USB_FEATURE_REMOTE_WAKEUP) 
c0d04e5c:	8868      	ldrh	r0, [r5, #2]
c0d04e5e:	2801      	cmp	r0, #1
c0d04e60:	d11c      	bne.n	c0d04e9c <USBD_ClrFeature+0x52>
    {
      pdev->dev_remote_wakeup = 0; 
c0d04e62:	2041      	movs	r0, #65	; 0x41
c0d04e64:	0080      	lsls	r0, r0, #2
c0d04e66:	2100      	movs	r1, #0
c0d04e68:	5021      	str	r1, [r4, r0]
      if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d04e6a:	7928      	ldrb	r0, [r5, #4]
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d04e6c:	2802      	cmp	r0, #2
c0d04e6e:	d80d      	bhi.n	c0d04e8c <USBD_ClrFeature+0x42>
c0d04e70:	00c0      	lsls	r0, r0, #3
c0d04e72:	1820      	adds	r0, r4, r0
c0d04e74:	2145      	movs	r1, #69	; 0x45
c0d04e76:	0089      	lsls	r1, r1, #2
c0d04e78:	5840      	ldr	r0, [r0, r1]
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    if (req->wValue == USB_FEATURE_REMOTE_WAKEUP) 
    {
      pdev->dev_remote_wakeup = 0; 
      if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d04e7a:	2800      	cmp	r0, #0
c0d04e7c:	d006      	beq.n	c0d04e8c <USBD_ClrFeature+0x42>
        ((Setup_t)PIC(pdev->interfacesClass[LOBYTE(req->wIndex)].pClass->Setup)) (pdev, req);   
c0d04e7e:	6880      	ldr	r0, [r0, #8]
c0d04e80:	f7fd fed0 	bl	c0d02c24 <pic>
c0d04e84:	4602      	mov	r2, r0
c0d04e86:	4620      	mov	r0, r4
c0d04e88:	4629      	mov	r1, r5
c0d04e8a:	4790      	blx	r2
      }
      USBD_CtlSendStatus(pdev);
c0d04e8c:	4620      	mov	r0, r4
c0d04e8e:	f000 fab8 	bl	c0d05402 <USBD_CtlSendStatus>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d04e92:	bdb0      	pop	{r4, r5, r7, pc}
      USBD_CtlSendStatus(pdev);
    }
    break;
    
  default :
     USBD_CtlError(pdev , req);
c0d04e94:	4620      	mov	r0, r4
c0d04e96:	4629      	mov	r1, r5
c0d04e98:	f000 f801 	bl	c0d04e9e <USBD_CtlError>
    break;
  }
}
c0d04e9c:	bdb0      	pop	{r4, r5, r7, pc}

c0d04e9e <USBD_CtlError>:
  USBD_LL_StallEP(pdev , 0);
}

__weak void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
c0d04e9e:	b510      	push	{r4, lr}
c0d04ea0:	4604      	mov	r4, r0
* @param  req: usb request
* @retval None
*/
void USBD_CtlStall( USBD_HandleTypeDef *pdev)
{
  USBD_LL_StallEP(pdev , 0x80);
c0d04ea2:	2180      	movs	r1, #128	; 0x80
c0d04ea4:	f7ff fbe6 	bl	c0d04674 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d04ea8:	2100      	movs	r1, #0
c0d04eaa:	4620      	mov	r0, r4
c0d04eac:	f7ff fbe2 	bl	c0d04674 <USBD_LL_StallEP>
__weak void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_CtlStall(pdev);
}
c0d04eb0:	bd10      	pop	{r4, pc}

c0d04eb2 <USBD_StdItfReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d04eb2:	b5b0      	push	{r4, r5, r7, lr}
c0d04eb4:	460d      	mov	r5, r1
c0d04eb6:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d04eb8:	20fc      	movs	r0, #252	; 0xfc
c0d04eba:	5c20      	ldrb	r0, [r4, r0]
c0d04ebc:	2803      	cmp	r0, #3
c0d04ebe:	d117      	bne.n	c0d04ef0 <USBD_StdItfReq+0x3e>
  {
  case USBD_STATE_CONFIGURED:
    
    if (usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) 
c0d04ec0:	7928      	ldrb	r0, [r5, #4]
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d04ec2:	2802      	cmp	r0, #2
c0d04ec4:	d814      	bhi.n	c0d04ef0 <USBD_StdItfReq+0x3e>
c0d04ec6:	00c0      	lsls	r0, r0, #3
c0d04ec8:	1820      	adds	r0, r4, r0
c0d04eca:	2145      	movs	r1, #69	; 0x45
c0d04ecc:	0089      	lsls	r1, r1, #2
c0d04ece:	5840      	ldr	r0, [r0, r1]
  
  switch (pdev->dev_state) 
  {
  case USBD_STATE_CONFIGURED:
    
    if (usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) 
c0d04ed0:	2800      	cmp	r0, #0
c0d04ed2:	d00d      	beq.n	c0d04ef0 <USBD_StdItfReq+0x3e>
    {
      ((Setup_t)PIC(pdev->interfacesClass[LOBYTE(req->wIndex)].pClass->Setup)) (pdev, req);
c0d04ed4:	6880      	ldr	r0, [r0, #8]
c0d04ed6:	f7fd fea5 	bl	c0d02c24 <pic>
c0d04eda:	4602      	mov	r2, r0
c0d04edc:	4620      	mov	r0, r4
c0d04ede:	4629      	mov	r1, r5
c0d04ee0:	4790      	blx	r2
      
      if((req->wLength == 0)&& (ret == USBD_OK))
c0d04ee2:	88e8      	ldrh	r0, [r5, #6]
c0d04ee4:	2800      	cmp	r0, #0
c0d04ee6:	d107      	bne.n	c0d04ef8 <USBD_StdItfReq+0x46>
      {
         USBD_CtlSendStatus(pdev);
c0d04ee8:	4620      	mov	r0, r4
c0d04eea:	f000 fa8a 	bl	c0d05402 <USBD_CtlSendStatus>
c0d04eee:	e003      	b.n	c0d04ef8 <USBD_StdItfReq+0x46>
c0d04ef0:	4620      	mov	r0, r4
c0d04ef2:	4629      	mov	r1, r5
c0d04ef4:	f7ff ffd3 	bl	c0d04e9e <USBD_CtlError>
    
  default:
     USBD_CtlError(pdev , req);
    break;
  }
  return USBD_OK;
c0d04ef8:	2000      	movs	r0, #0
c0d04efa:	bdb0      	pop	{r4, r5, r7, pc}

c0d04efc <USBD_StdEPReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdEPReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d04efc:	b570      	push	{r4, r5, r6, lr}
c0d04efe:	460d      	mov	r5, r1
c0d04f00:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20 && usbd_is_valid_intf(pdev, LOBYTE(req->wIndex)))
c0d04f02:	7828      	ldrb	r0, [r5, #0]
c0d04f04:	2160      	movs	r1, #96	; 0x60
c0d04f06:	4001      	ands	r1, r0
{
  
  uint8_t   ep_addr;
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
c0d04f08:	792e      	ldrb	r6, [r5, #4]
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20 && usbd_is_valid_intf(pdev, LOBYTE(req->wIndex)))
c0d04f0a:	2920      	cmp	r1, #32
c0d04f0c:	d110      	bne.n	c0d04f30 <USBD_StdEPReq+0x34>
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d04f0e:	2e02      	cmp	r6, #2
c0d04f10:	d80e      	bhi.n	c0d04f30 <USBD_StdEPReq+0x34>
c0d04f12:	00f0      	lsls	r0, r6, #3
c0d04f14:	1820      	adds	r0, r4, r0
c0d04f16:	2145      	movs	r1, #69	; 0x45
c0d04f18:	0089      	lsls	r1, r1, #2
c0d04f1a:	5840      	ldr	r0, [r0, r1]
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20 && usbd_is_valid_intf(pdev, LOBYTE(req->wIndex)))
c0d04f1c:	2800      	cmp	r0, #0
c0d04f1e:	d007      	beq.n	c0d04f30 <USBD_StdEPReq+0x34>
  {
    ((Setup_t)PIC(pdev->interfacesClass[LOBYTE(req->wIndex)].pClass->Setup)) (pdev, req);
c0d04f20:	6880      	ldr	r0, [r0, #8]
c0d04f22:	f7fd fe7f 	bl	c0d02c24 <pic>
c0d04f26:	4602      	mov	r2, r0
c0d04f28:	4620      	mov	r0, r4
c0d04f2a:	4629      	mov	r1, r5
c0d04f2c:	4790      	blx	r2
c0d04f2e:	e06e      	b.n	c0d0500e <USBD_StdEPReq+0x112>
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d04f30:	7868      	ldrb	r0, [r5, #1]
c0d04f32:	2800      	cmp	r0, #0
c0d04f34:	d017      	beq.n	c0d04f66 <USBD_StdEPReq+0x6a>
c0d04f36:	2801      	cmp	r0, #1
c0d04f38:	d01e      	beq.n	c0d04f78 <USBD_StdEPReq+0x7c>
c0d04f3a:	2803      	cmp	r0, #3
c0d04f3c:	d167      	bne.n	c0d0500e <USBD_StdEPReq+0x112>
  {
    
  case USB_REQ_SET_FEATURE :
    
    switch (pdev->dev_state) 
c0d04f3e:	20fc      	movs	r0, #252	; 0xfc
c0d04f40:	5c20      	ldrb	r0, [r4, r0]
c0d04f42:	2803      	cmp	r0, #3
c0d04f44:	d11c      	bne.n	c0d04f80 <USBD_StdEPReq+0x84>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d04f46:	8868      	ldrh	r0, [r5, #2]
c0d04f48:	2800      	cmp	r0, #0
c0d04f4a:	d108      	bne.n	c0d04f5e <USBD_StdEPReq+0x62>
      {
        if ((ep_addr != 0x00) && (ep_addr != 0x80)) 
c0d04f4c:	2080      	movs	r0, #128	; 0x80
c0d04f4e:	4330      	orrs	r0, r6
c0d04f50:	2880      	cmp	r0, #128	; 0x80
c0d04f52:	d004      	beq.n	c0d04f5e <USBD_StdEPReq+0x62>
        { 
          USBD_LL_StallEP(pdev , ep_addr);
c0d04f54:	4620      	mov	r0, r4
c0d04f56:	4631      	mov	r1, r6
c0d04f58:	f7ff fb8c 	bl	c0d04674 <USBD_LL_StallEP>
          
        }
c0d04f5c:	792e      	ldrb	r6, [r5, #4]
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d04f5e:	2e02      	cmp	r6, #2
c0d04f60:	d852      	bhi.n	c0d05008 <USBD_StdEPReq+0x10c>
c0d04f62:	00f0      	lsls	r0, r6, #3
c0d04f64:	e043      	b.n	c0d04fee <USBD_StdEPReq+0xf2>
      break;    
    }
    break;
    
  case USB_REQ_GET_STATUS:                  
    switch (pdev->dev_state) 
c0d04f66:	20fc      	movs	r0, #252	; 0xfc
c0d04f68:	5c20      	ldrb	r0, [r4, r0]
c0d04f6a:	2803      	cmp	r0, #3
c0d04f6c:	d018      	beq.n	c0d04fa0 <USBD_StdEPReq+0xa4>
c0d04f6e:	2802      	cmp	r0, #2
c0d04f70:	d111      	bne.n	c0d04f96 <USBD_StdEPReq+0x9a>
    {
    case USBD_STATE_ADDRESSED:          
      if ((ep_addr & 0x7F) != 0x00) 
c0d04f72:	0670      	lsls	r0, r6, #25
c0d04f74:	d10a      	bne.n	c0d04f8c <USBD_StdEPReq+0x90>
c0d04f76:	e04a      	b.n	c0d0500e <USBD_StdEPReq+0x112>
    }
    break;
    
  case USB_REQ_CLEAR_FEATURE :
    
    switch (pdev->dev_state) 
c0d04f78:	20fc      	movs	r0, #252	; 0xfc
c0d04f7a:	5c20      	ldrb	r0, [r4, r0]
c0d04f7c:	2803      	cmp	r0, #3
c0d04f7e:	d029      	beq.n	c0d04fd4 <USBD_StdEPReq+0xd8>
c0d04f80:	2802      	cmp	r0, #2
c0d04f82:	d108      	bne.n	c0d04f96 <USBD_StdEPReq+0x9a>
c0d04f84:	2080      	movs	r0, #128	; 0x80
c0d04f86:	4330      	orrs	r0, r6
c0d04f88:	2880      	cmp	r0, #128	; 0x80
c0d04f8a:	d040      	beq.n	c0d0500e <USBD_StdEPReq+0x112>
c0d04f8c:	4620      	mov	r0, r4
c0d04f8e:	4631      	mov	r1, r6
c0d04f90:	f7ff fb70 	bl	c0d04674 <USBD_LL_StallEP>
c0d04f94:	e03b      	b.n	c0d0500e <USBD_StdEPReq+0x112>
c0d04f96:	4620      	mov	r0, r4
c0d04f98:	4629      	mov	r1, r5
c0d04f9a:	f7ff ff80 	bl	c0d04e9e <USBD_CtlError>
c0d04f9e:	e036      	b.n	c0d0500e <USBD_StdEPReq+0x112>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d04fa0:	4625      	mov	r5, r4
c0d04fa2:	3514      	adds	r5, #20
                                         &pdev->ep_out[ep_addr & 0x7F];
c0d04fa4:	4620      	mov	r0, r4
c0d04fa6:	3084      	adds	r0, #132	; 0x84
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d04fa8:	2180      	movs	r1, #128	; 0x80
c0d04faa:	420e      	tst	r6, r1
c0d04fac:	d100      	bne.n	c0d04fb0 <USBD_StdEPReq+0xb4>
c0d04fae:	4605      	mov	r5, r0
                                         &pdev->ep_out[ep_addr & 0x7F];
      if(USBD_LL_IsStallEP(pdev, ep_addr))
c0d04fb0:	4620      	mov	r0, r4
c0d04fb2:	4631      	mov	r1, r6
c0d04fb4:	f7ff fba8 	bl	c0d04708 <USBD_LL_IsStallEP>
c0d04fb8:	2101      	movs	r1, #1
c0d04fba:	2800      	cmp	r0, #0
c0d04fbc:	d100      	bne.n	c0d04fc0 <USBD_StdEPReq+0xc4>
c0d04fbe:	4601      	mov	r1, r0
c0d04fc0:	207f      	movs	r0, #127	; 0x7f
c0d04fc2:	4006      	ands	r6, r0
c0d04fc4:	0130      	lsls	r0, r6, #4
c0d04fc6:	5029      	str	r1, [r5, r0]
c0d04fc8:	1829      	adds	r1, r5, r0
      else
      {
        pep->status = 0x0000;  
      }
      
      USBD_CtlSendData (pdev,
c0d04fca:	2202      	movs	r2, #2
c0d04fcc:	4620      	mov	r0, r4
c0d04fce:	f000 f9ed 	bl	c0d053ac <USBD_CtlSendData>
c0d04fd2:	e01c      	b.n	c0d0500e <USBD_StdEPReq+0x112>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d04fd4:	8868      	ldrh	r0, [r5, #2]
c0d04fd6:	2800      	cmp	r0, #0
c0d04fd8:	d119      	bne.n	c0d0500e <USBD_StdEPReq+0x112>
      {
        if ((ep_addr & 0x7F) != 0x00) 
c0d04fda:	0670      	lsls	r0, r6, #25
c0d04fdc:	d014      	beq.n	c0d05008 <USBD_StdEPReq+0x10c>
        {        
          USBD_LL_ClearStallEP(pdev , ep_addr);
c0d04fde:	4620      	mov	r0, r4
c0d04fe0:	4631      	mov	r1, r6
c0d04fe2:	f7ff fb6d 	bl	c0d046c0 <USBD_LL_ClearStallEP>
          if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d04fe6:	7928      	ldrb	r0, [r5, #4]
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d04fe8:	2802      	cmp	r0, #2
c0d04fea:	d80d      	bhi.n	c0d05008 <USBD_StdEPReq+0x10c>
c0d04fec:	00c0      	lsls	r0, r0, #3
c0d04fee:	1820      	adds	r0, r4, r0
c0d04ff0:	2145      	movs	r1, #69	; 0x45
c0d04ff2:	0089      	lsls	r1, r1, #2
c0d04ff4:	5840      	ldr	r0, [r0, r1]
c0d04ff6:	2800      	cmp	r0, #0
c0d04ff8:	d006      	beq.n	c0d05008 <USBD_StdEPReq+0x10c>
c0d04ffa:	6880      	ldr	r0, [r0, #8]
c0d04ffc:	f7fd fe12 	bl	c0d02c24 <pic>
c0d05000:	4602      	mov	r2, r0
c0d05002:	4620      	mov	r0, r4
c0d05004:	4629      	mov	r1, r5
c0d05006:	4790      	blx	r2
c0d05008:	4620      	mov	r0, r4
c0d0500a:	f000 f9fa 	bl	c0d05402 <USBD_CtlSendStatus>
    
  default:
    break;
  }
  return ret;
}
c0d0500e:	2000      	movs	r0, #0
c0d05010:	bd70      	pop	{r4, r5, r6, pc}

c0d05012 <USBD_ParseSetupRequest>:
* @retval None
*/

void USBD_ParseSetupRequest(USBD_SetupReqTypedef *req, uint8_t *pdata)
{
  req->bmRequest     = *(uint8_t *)  (pdata);
c0d05012:	780a      	ldrb	r2, [r1, #0]
c0d05014:	7002      	strb	r2, [r0, #0]
  req->bRequest      = *(uint8_t *)  (pdata +  1);
c0d05016:	784a      	ldrb	r2, [r1, #1]
c0d05018:	7042      	strb	r2, [r0, #1]
  req->wValue        = SWAPBYTE      (pdata +  2);
c0d0501a:	788a      	ldrb	r2, [r1, #2]
c0d0501c:	78cb      	ldrb	r3, [r1, #3]
c0d0501e:	021b      	lsls	r3, r3, #8
c0d05020:	4313      	orrs	r3, r2
c0d05022:	8043      	strh	r3, [r0, #2]
  req->wIndex        = SWAPBYTE      (pdata +  4);
c0d05024:	790a      	ldrb	r2, [r1, #4]
c0d05026:	794b      	ldrb	r3, [r1, #5]
c0d05028:	021b      	lsls	r3, r3, #8
c0d0502a:	4313      	orrs	r3, r2
c0d0502c:	8083      	strh	r3, [r0, #4]
  req->wLength       = SWAPBYTE      (pdata +  6);
c0d0502e:	798a      	ldrb	r2, [r1, #6]
c0d05030:	79c9      	ldrb	r1, [r1, #7]
c0d05032:	0209      	lsls	r1, r1, #8
c0d05034:	4311      	orrs	r1, r2
c0d05036:	80c1      	strh	r1, [r0, #6]

}
c0d05038:	4770      	bx	lr

c0d0503a <USBD_HID_Setup>:
  * @param  req: usb requests
  * @retval status
  */
uint8_t  USBD_HID_Setup (USBD_HandleTypeDef *pdev, 
                                USBD_SetupReqTypedef *req)
{
c0d0503a:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0503c:	b083      	sub	sp, #12
c0d0503e:	460d      	mov	r5, r1
c0d05040:	4604      	mov	r4, r0
c0d05042:	a802      	add	r0, sp, #8
c0d05044:	2700      	movs	r7, #0
  uint16_t len = 0;
c0d05046:	8007      	strh	r7, [r0, #0]
c0d05048:	a801      	add	r0, sp, #4
  uint8_t  *pbuf = NULL;

  uint8_t val = 0;
c0d0504a:	7007      	strb	r7, [r0, #0]

  switch (req->bmRequest & USB_REQ_TYPE_MASK)
c0d0504c:	7829      	ldrb	r1, [r5, #0]
c0d0504e:	2060      	movs	r0, #96	; 0x60
c0d05050:	4008      	ands	r0, r1
c0d05052:	2800      	cmp	r0, #0
c0d05054:	d010      	beq.n	c0d05078 <USBD_HID_Setup+0x3e>
c0d05056:	2820      	cmp	r0, #32
c0d05058:	d138      	bne.n	c0d050cc <USBD_HID_Setup+0x92>
c0d0505a:	7868      	ldrb	r0, [r5, #1]
  {
  case USB_REQ_TYPE_CLASS :  
    switch (req->bRequest)
c0d0505c:	4601      	mov	r1, r0
c0d0505e:	390a      	subs	r1, #10
c0d05060:	2902      	cmp	r1, #2
c0d05062:	d333      	bcc.n	c0d050cc <USBD_HID_Setup+0x92>
c0d05064:	2802      	cmp	r0, #2
c0d05066:	d01c      	beq.n	c0d050a2 <USBD_HID_Setup+0x68>
c0d05068:	2803      	cmp	r0, #3
c0d0506a:	d01a      	beq.n	c0d050a2 <USBD_HID_Setup+0x68>
                        (uint8_t *)&val,
                        1);      
      break;      
      
    default:
      USBD_CtlError (pdev, req);
c0d0506c:	4620      	mov	r0, r4
c0d0506e:	4629      	mov	r1, r5
c0d05070:	f7ff ff15 	bl	c0d04e9e <USBD_CtlError>
c0d05074:	2702      	movs	r7, #2
c0d05076:	e029      	b.n	c0d050cc <USBD_HID_Setup+0x92>
      return USBD_FAIL; 
    }
    break;
    
  case USB_REQ_TYPE_STANDARD:
    switch (req->bRequest)
c0d05078:	7868      	ldrb	r0, [r5, #1]
c0d0507a:	280b      	cmp	r0, #11
c0d0507c:	d014      	beq.n	c0d050a8 <USBD_HID_Setup+0x6e>
c0d0507e:	280a      	cmp	r0, #10
c0d05080:	d00f      	beq.n	c0d050a2 <USBD_HID_Setup+0x68>
c0d05082:	2806      	cmp	r0, #6
c0d05084:	d122      	bne.n	c0d050cc <USBD_HID_Setup+0x92>
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
c0d05086:	8868      	ldrh	r0, [r5, #2]
c0d05088:	0a00      	lsrs	r0, r0, #8
c0d0508a:	2700      	movs	r7, #0
c0d0508c:	2821      	cmp	r0, #33	; 0x21
c0d0508e:	d00f      	beq.n	c0d050b0 <USBD_HID_Setup+0x76>
c0d05090:	2822      	cmp	r0, #34	; 0x22
      
      //USBD_CtlReceiveStatus(pdev);
      
      USBD_CtlSendData (pdev, 
                        pbuf,
                        len);
c0d05092:	463a      	mov	r2, r7
c0d05094:	4639      	mov	r1, r7
c0d05096:	d116      	bne.n	c0d050c6 <USBD_HID_Setup+0x8c>
c0d05098:	ae02      	add	r6, sp, #8
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
      {
        pbuf =  USBD_HID_GetReportDescriptor_impl(&len);
c0d0509a:	4630      	mov	r0, r6
c0d0509c:	f000 f858 	bl	c0d05150 <USBD_HID_GetReportDescriptor_impl>
c0d050a0:	e00a      	b.n	c0d050b8 <USBD_HID_Setup+0x7e>
c0d050a2:	a901      	add	r1, sp, #4
c0d050a4:	2201      	movs	r2, #1
c0d050a6:	e00e      	b.n	c0d050c6 <USBD_HID_Setup+0x8c>
                        len);
      break;

    case USB_REQ_SET_INTERFACE :
      //hhid->AltSetting = (uint8_t)(req->wValue);
      USBD_CtlSendStatus(pdev);
c0d050a8:	4620      	mov	r0, r4
c0d050aa:	f000 f9aa 	bl	c0d05402 <USBD_CtlSendStatus>
c0d050ae:	e00d      	b.n	c0d050cc <USBD_HID_Setup+0x92>
c0d050b0:	ae02      	add	r6, sp, #8
        len = MIN(len , req->wLength);
      }
      // 0x21
      else if( req->wValue >> 8 == HID_DESCRIPTOR_TYPE)
      {
        pbuf = USBD_HID_GetHidDescriptor_impl(&len);
c0d050b2:	4630      	mov	r0, r6
c0d050b4:	f000 f832 	bl	c0d0511c <USBD_HID_GetHidDescriptor_impl>
c0d050b8:	4601      	mov	r1, r0
c0d050ba:	8832      	ldrh	r2, [r6, #0]
c0d050bc:	88e8      	ldrh	r0, [r5, #6]
c0d050be:	4282      	cmp	r2, r0
c0d050c0:	d300      	bcc.n	c0d050c4 <USBD_HID_Setup+0x8a>
c0d050c2:	4602      	mov	r2, r0
c0d050c4:	8032      	strh	r2, [r6, #0]
c0d050c6:	4620      	mov	r0, r4
c0d050c8:	f000 f970 	bl	c0d053ac <USBD_CtlSendData>
      
    }
  }

  return USBD_OK;
}
c0d050cc:	b2f8      	uxtb	r0, r7
c0d050ce:	b003      	add	sp, #12
c0d050d0:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d050d2 <USBD_HID_Init>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d050d2:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d050d4:	b081      	sub	sp, #4
c0d050d6:	4604      	mov	r4, r0
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d050d8:	2182      	movs	r1, #130	; 0x82
c0d050da:	2603      	movs	r6, #3
c0d050dc:	2540      	movs	r5, #64	; 0x40
c0d050de:	4632      	mov	r2, r6
c0d050e0:	462b      	mov	r3, r5
c0d050e2:	f7ff fa8b 	bl	c0d045fc <USBD_LL_OpenEP>
c0d050e6:	2702      	movs	r7, #2
                 HID_EPIN_ADDR,
                 USBD_EP_TYPE_INTR,
                 HID_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d050e8:	4620      	mov	r0, r4
c0d050ea:	4639      	mov	r1, r7
c0d050ec:	4632      	mov	r2, r6
c0d050ee:	462b      	mov	r3, r5
c0d050f0:	f7ff fa84 	bl	c0d045fc <USBD_LL_OpenEP>
                 HID_EPOUT_ADDR,
                 USBD_EP_TYPE_INTR,
                 HID_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR, HID_EPOUT_SIZE);
c0d050f4:	4620      	mov	r0, r4
c0d050f6:	4639      	mov	r1, r7
c0d050f8:	462a      	mov	r2, r5
c0d050fa:	f7ff fb42 	bl	c0d04782 <USBD_LL_PrepareReceive>
  USBD_LL_Transmit (pdev, 
                    HID_EPIN_ADDR,                                      
                    NULL,
                    0);
  */
  return USBD_OK;
c0d050fe:	2000      	movs	r0, #0
c0d05100:	b001      	add	sp, #4
c0d05102:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d05104 <USBD_HID_DeInit>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_DeInit (USBD_HandleTypeDef *pdev, 
                                 uint8_t cfgidx)
{
c0d05104:	b510      	push	{r4, lr}
c0d05106:	4604      	mov	r4, r0
  UNUSED(cfgidx);
  /* Close HID EP IN */
  USBD_LL_CloseEP(pdev,
c0d05108:	2182      	movs	r1, #130	; 0x82
c0d0510a:	f7ff fa9d 	bl	c0d04648 <USBD_LL_CloseEP>
                  HID_EPIN_ADDR);
  
  /* Close HID EP OUT */
  USBD_LL_CloseEP(pdev,
c0d0510e:	2102      	movs	r1, #2
c0d05110:	4620      	mov	r0, r4
c0d05112:	f7ff fa99 	bl	c0d04648 <USBD_LL_CloseEP>
                  HID_EPOUT_ADDR);
  
  return USBD_OK;
c0d05116:	2000      	movs	r0, #0
c0d05118:	bd10      	pop	{r4, pc}
	...

c0d0511c <USBD_HID_GetHidDescriptor_impl>:
  *length = sizeof (USBD_CfgDesc);
  return (uint8_t*)USBD_CfgDesc;
}

uint8_t* USBD_HID_GetHidDescriptor_impl(uint16_t* len) {
  switch (USBD_Device.request.wIndex&0xFF) {
c0d0511c:	2143      	movs	r1, #67	; 0x43
c0d0511e:	0089      	lsls	r1, r1, #2
c0d05120:	4a08      	ldr	r2, [pc, #32]	; (c0d05144 <USBD_HID_GetHidDescriptor_impl+0x28>)
c0d05122:	5c51      	ldrb	r1, [r2, r1]
c0d05124:	2209      	movs	r2, #9
c0d05126:	2900      	cmp	r1, #0
c0d05128:	d004      	beq.n	c0d05134 <USBD_HID_GetHidDescriptor_impl+0x18>
c0d0512a:	2901      	cmp	r1, #1
c0d0512c:	d105      	bne.n	c0d0513a <USBD_HID_GetHidDescriptor_impl+0x1e>
c0d0512e:	4907      	ldr	r1, [pc, #28]	; (c0d0514c <USBD_HID_GetHidDescriptor_impl+0x30>)
c0d05130:	4479      	add	r1, pc
c0d05132:	e004      	b.n	c0d0513e <USBD_HID_GetHidDescriptor_impl+0x22>
c0d05134:	4904      	ldr	r1, [pc, #16]	; (c0d05148 <USBD_HID_GetHidDescriptor_impl+0x2c>)
c0d05136:	4479      	add	r1, pc
c0d05138:	e001      	b.n	c0d0513e <USBD_HID_GetHidDescriptor_impl+0x22>
c0d0513a:	2200      	movs	r2, #0
c0d0513c:	4611      	mov	r1, r2
c0d0513e:	8002      	strh	r2, [r0, #0]
      *len = sizeof(USBD_HID_Desc);
      return (uint8_t*)USBD_HID_Desc; 
  }
  *len = 0;
  return 0;
}
c0d05140:	4608      	mov	r0, r1
c0d05142:	4770      	bx	lr
c0d05144:	20002160 	.word	0x20002160
c0d05148:	00002626 	.word	0x00002626
c0d0514c:	00002620 	.word	0x00002620

c0d05150 <USBD_HID_GetReportDescriptor_impl>:

uint8_t* USBD_HID_GetReportDescriptor_impl(uint16_t* len) {
c0d05150:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d05152:	b081      	sub	sp, #4
c0d05154:	4602      	mov	r2, r0
  switch (USBD_Device.request.wIndex&0xFF) {
c0d05156:	2043      	movs	r0, #67	; 0x43
c0d05158:	0080      	lsls	r0, r0, #2
c0d0515a:	4914      	ldr	r1, [pc, #80]	; (c0d051ac <USBD_HID_GetReportDescriptor_impl+0x5c>)
c0d0515c:	5c08      	ldrb	r0, [r1, r0]
c0d0515e:	2422      	movs	r4, #34	; 0x22
c0d05160:	2800      	cmp	r0, #0
c0d05162:	d01a      	beq.n	c0d0519a <USBD_HID_GetReportDescriptor_impl+0x4a>
c0d05164:	2801      	cmp	r0, #1
c0d05166:	d11b      	bne.n	c0d051a0 <USBD_HID_GetReportDescriptor_impl+0x50>
#ifdef HAVE_IO_U2F
  case U2F_INTF:

    // very dirty work due to lack of callback when USB_HID_Init is called
    USBD_LL_OpenEP(&USBD_Device,
c0d05168:	4810      	ldr	r0, [pc, #64]	; (c0d051ac <USBD_HID_GetReportDescriptor_impl+0x5c>)
c0d0516a:	2181      	movs	r1, #129	; 0x81
c0d0516c:	2703      	movs	r7, #3
c0d0516e:	2640      	movs	r6, #64	; 0x40
c0d05170:	9200      	str	r2, [sp, #0]
c0d05172:	463a      	mov	r2, r7
c0d05174:	4633      	mov	r3, r6
c0d05176:	f7ff fa41 	bl	c0d045fc <USBD_LL_OpenEP>
c0d0517a:	2501      	movs	r5, #1
                   U2F_EPIN_ADDR,
                   USBD_EP_TYPE_INTR,
                   U2F_EPIN_SIZE);
    
    USBD_LL_OpenEP(&USBD_Device,
c0d0517c:	480b      	ldr	r0, [pc, #44]	; (c0d051ac <USBD_HID_GetReportDescriptor_impl+0x5c>)
c0d0517e:	4629      	mov	r1, r5
c0d05180:	463a      	mov	r2, r7
c0d05182:	4633      	mov	r3, r6
c0d05184:	f7ff fa3a 	bl	c0d045fc <USBD_LL_OpenEP>
                   U2F_EPOUT_ADDR,
                   USBD_EP_TYPE_INTR,
                   U2F_EPOUT_SIZE);

    /* Prepare Out endpoint to receive 1st packet */ 
    USBD_LL_PrepareReceive(&USBD_Device, U2F_EPOUT_ADDR, U2F_EPOUT_SIZE);
c0d05188:	4808      	ldr	r0, [pc, #32]	; (c0d051ac <USBD_HID_GetReportDescriptor_impl+0x5c>)
c0d0518a:	4629      	mov	r1, r5
c0d0518c:	4632      	mov	r2, r6
c0d0518e:	f7ff faf8 	bl	c0d04782 <USBD_LL_PrepareReceive>
c0d05192:	9a00      	ldr	r2, [sp, #0]
c0d05194:	4807      	ldr	r0, [pc, #28]	; (c0d051b4 <USBD_HID_GetReportDescriptor_impl+0x64>)
c0d05196:	4478      	add	r0, pc
c0d05198:	e004      	b.n	c0d051a4 <USBD_HID_GetReportDescriptor_impl+0x54>
c0d0519a:	4805      	ldr	r0, [pc, #20]	; (c0d051b0 <USBD_HID_GetReportDescriptor_impl+0x60>)
c0d0519c:	4478      	add	r0, pc
c0d0519e:	e001      	b.n	c0d051a4 <USBD_HID_GetReportDescriptor_impl+0x54>
c0d051a0:	2400      	movs	r4, #0
c0d051a2:	4620      	mov	r0, r4
c0d051a4:	8014      	strh	r4, [r2, #0]
    *len = sizeof(HID_ReportDesc);
    return (uint8_t*)HID_ReportDesc;
  }
  *len = 0;
  return 0;
}
c0d051a6:	b001      	add	sp, #4
c0d051a8:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d051aa:	46c0      	nop			; (mov r8, r8)
c0d051ac:	20002160 	.word	0x20002160
c0d051b0:	000025eb 	.word	0x000025eb
c0d051b4:	000025cf 	.word	0x000025cf

c0d051b8 <USBD_U2F_Init>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_U2F_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d051b8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d051ba:	b081      	sub	sp, #4
c0d051bc:	4604      	mov	r4, r0
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d051be:	2181      	movs	r1, #129	; 0x81
c0d051c0:	2603      	movs	r6, #3
c0d051c2:	2540      	movs	r5, #64	; 0x40
c0d051c4:	4632      	mov	r2, r6
c0d051c6:	462b      	mov	r3, r5
c0d051c8:	f7ff fa18 	bl	c0d045fc <USBD_LL_OpenEP>
c0d051cc:	2701      	movs	r7, #1
                 U2F_EPIN_ADDR,
                 USBD_EP_TYPE_INTR,
                 U2F_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d051ce:	4620      	mov	r0, r4
c0d051d0:	4639      	mov	r1, r7
c0d051d2:	4632      	mov	r2, r6
c0d051d4:	462b      	mov	r3, r5
c0d051d6:	f7ff fa11 	bl	c0d045fc <USBD_LL_OpenEP>
                 U2F_EPOUT_ADDR,
                 USBD_EP_TYPE_INTR,
                 U2F_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, U2F_EPOUT_ADDR, U2F_EPOUT_SIZE);
c0d051da:	4620      	mov	r0, r4
c0d051dc:	4639      	mov	r1, r7
c0d051de:	462a      	mov	r2, r5
c0d051e0:	f7ff facf 	bl	c0d04782 <USBD_LL_PrepareReceive>

  return USBD_OK;
c0d051e4:	2000      	movs	r0, #0
c0d051e6:	b001      	add	sp, #4
c0d051e8:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d051ec <USBD_U2F_DataIn_impl>:
}

uint8_t  USBD_U2F_DataIn_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum)
{
c0d051ec:	b580      	push	{r7, lr}
  UNUSED(pdev);
  // only the data hid endpoint will receive data
  switch (epnum) {
c0d051ee:	2901      	cmp	r1, #1
c0d051f0:	d103      	bne.n	c0d051fa <USBD_U2F_DataIn_impl+0xe>
  // FIDO endpoint
  case (U2F_EPIN_ADDR&0x7F):
    // advance the u2f sending machine state
    u2f_transport_sent(&G_io_u2f, U2F_MEDIA_USB);
c0d051f2:	4803      	ldr	r0, [pc, #12]	; (c0d05200 <USBD_U2F_DataIn_impl+0x14>)
c0d051f4:	2101      	movs	r1, #1
c0d051f6:	f7fe fe3d 	bl	c0d03e74 <u2f_transport_sent>
    break;
  } 
  return USBD_OK;
c0d051fa:	2000      	movs	r0, #0
c0d051fc:	bd80      	pop	{r7, pc}
c0d051fe:	46c0      	nop			; (mov r8, r8)
c0d05200:	20001aa8 	.word	0x20001aa8

c0d05204 <USBD_U2F_DataOut_impl>:
}

uint8_t  USBD_U2F_DataOut_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d05204:	b5b0      	push	{r4, r5, r7, lr}
c0d05206:	4614      	mov	r4, r2
  switch (epnum) {
c0d05208:	2901      	cmp	r1, #1
c0d0520a:	d10d      	bne.n	c0d05228 <USBD_U2F_DataOut_impl+0x24>
c0d0520c:	2501      	movs	r5, #1
  // FIDO endpoint
  case (U2F_EPOUT_ADDR&0x7F):
      USBD_LL_PrepareReceive(pdev, U2F_EPOUT_ADDR , U2F_EPOUT_SIZE);
c0d0520e:	2240      	movs	r2, #64	; 0x40
c0d05210:	4629      	mov	r1, r5
c0d05212:	f7ff fab6 	bl	c0d04782 <USBD_LL_PrepareReceive>
      u2f_transport_received(&G_io_u2f, buffer, io_seproxyhal_get_ep_rx_size(U2F_EPOUT_ADDR), U2F_MEDIA_USB);
c0d05216:	4628      	mov	r0, r5
c0d05218:	f7fc fcac 	bl	c0d01b74 <io_seproxyhal_get_ep_rx_size>
c0d0521c:	4602      	mov	r2, r0
c0d0521e:	4803      	ldr	r0, [pc, #12]	; (c0d0522c <USBD_U2F_DataOut_impl+0x28>)
c0d05220:	4621      	mov	r1, r4
c0d05222:	462b      	mov	r3, r5
c0d05224:	f7fe ff60 	bl	c0d040e8 <u2f_transport_received>
    break;
  }

  return USBD_OK;
c0d05228:	2000      	movs	r0, #0
c0d0522a:	bdb0      	pop	{r4, r5, r7, pc}
c0d0522c:	20001aa8 	.word	0x20001aa8

c0d05230 <USBD_HID_DataIn_impl>:
}
#endif // HAVE_IO_U2F

uint8_t  USBD_HID_DataIn_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum)
{
c0d05230:	b580      	push	{r7, lr}
  UNUSED(pdev);
  switch (epnum) {
c0d05232:	2902      	cmp	r1, #2
c0d05234:	d103      	bne.n	c0d0523e <USBD_HID_DataIn_impl+0xe>
    // HID gen endpoint
    case (HID_EPIN_ADDR&0x7F):
      io_usb_hid_sent(io_usb_send_apdu_data);
c0d05236:	4803      	ldr	r0, [pc, #12]	; (c0d05244 <USBD_HID_DataIn_impl+0x14>)
c0d05238:	4478      	add	r0, pc
c0d0523a:	f7fc fba9 	bl	c0d01990 <io_usb_hid_sent>
      break;
  }

  return USBD_OK;
c0d0523e:	2000      	movs	r0, #0
c0d05240:	bd80      	pop	{r7, pc}
c0d05242:	46c0      	nop			; (mov r8, r8)
c0d05244:	ffffc9fd 	.word	0xffffc9fd

c0d05248 <USBD_HID_DataOut_impl>:
}

uint8_t  USBD_HID_DataOut_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d05248:	b5b0      	push	{r4, r5, r7, lr}
c0d0524a:	4614      	mov	r4, r2
  // only the data hid endpoint will receive data
  switch (epnum) {
c0d0524c:	2902      	cmp	r1, #2
c0d0524e:	d11b      	bne.n	c0d05288 <USBD_HID_DataOut_impl+0x40>

  // HID gen endpoint
  case (HID_EPOUT_ADDR&0x7F):
    // prepare receiving the next chunk (masked time)
    USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR , HID_EPOUT_SIZE);
c0d05250:	2102      	movs	r1, #2
c0d05252:	2240      	movs	r2, #64	; 0x40
c0d05254:	f7ff fa95 	bl	c0d04782 <USBD_LL_PrepareReceive>

    // avoid troubles when an apdu has not been replied yet
    if (G_io_apdu_media == IO_APDU_MEDIA_NONE) {      
c0d05258:	4d0c      	ldr	r5, [pc, #48]	; (c0d0528c <USBD_HID_DataOut_impl+0x44>)
c0d0525a:	7828      	ldrb	r0, [r5, #0]
c0d0525c:	2800      	cmp	r0, #0
c0d0525e:	d113      	bne.n	c0d05288 <USBD_HID_DataOut_impl+0x40>
      // add to the hid transport
      switch(io_usb_hid_receive(io_usb_send_apdu_data, buffer, io_seproxyhal_get_ep_rx_size(HID_EPOUT_ADDR))) {
c0d05260:	2002      	movs	r0, #2
c0d05262:	f7fc fc87 	bl	c0d01b74 <io_seproxyhal_get_ep_rx_size>
c0d05266:	4602      	mov	r2, r0
c0d05268:	480c      	ldr	r0, [pc, #48]	; (c0d0529c <USBD_HID_DataOut_impl+0x54>)
c0d0526a:	4478      	add	r0, pc
c0d0526c:	4621      	mov	r1, r4
c0d0526e:	f7fc fabd 	bl	c0d017ec <io_usb_hid_receive>
c0d05272:	2802      	cmp	r0, #2
c0d05274:	d108      	bne.n	c0d05288 <USBD_HID_DataOut_impl+0x40>
        default:
          break;

        case IO_USB_APDU_RECEIVED:
          G_io_apdu_media = IO_APDU_MEDIA_USB_HID; // for application code
c0d05276:	2001      	movs	r0, #1
c0d05278:	7028      	strb	r0, [r5, #0]
          G_io_apdu_state = APDU_USB_HID; // for next call to io_exchange
c0d0527a:	4805      	ldr	r0, [pc, #20]	; (c0d05290 <USBD_HID_DataOut_impl+0x48>)
c0d0527c:	2107      	movs	r1, #7
c0d0527e:	7001      	strb	r1, [r0, #0]
          G_io_apdu_length = G_io_usb_hid_total_length;
c0d05280:	4804      	ldr	r0, [pc, #16]	; (c0d05294 <USBD_HID_DataOut_impl+0x4c>)
c0d05282:	6800      	ldr	r0, [r0, #0]
c0d05284:	4904      	ldr	r1, [pc, #16]	; (c0d05298 <USBD_HID_DataOut_impl+0x50>)
c0d05286:	8008      	strh	r0, [r1, #0]
      }
    }
    break;
  }

  return USBD_OK;
c0d05288:	2000      	movs	r0, #0
c0d0528a:	bdb0      	pop	{r4, r5, r7, pc}
c0d0528c:	20001a80 	.word	0x20001a80
c0d05290:	20001a96 	.word	0x20001a96
c0d05294:	2000191c 	.word	0x2000191c
c0d05298:	20001a98 	.word	0x20001a98
c0d0529c:	ffffc9cb 	.word	0xffffc9cb

c0d052a0 <USBD_DeviceDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_DeviceDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_DeviceDesc);
c0d052a0:	2012      	movs	r0, #18
c0d052a2:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_DeviceDesc;
c0d052a4:	4801      	ldr	r0, [pc, #4]	; (c0d052ac <USBD_DeviceDescriptor+0xc>)
c0d052a6:	4478      	add	r0, pc
c0d052a8:	4770      	bx	lr
c0d052aa:	46c0      	nop			; (mov r8, r8)
c0d052ac:	00002596 	.word	0x00002596

c0d052b0 <USBD_LangIDStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_LangIDStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_LangIDDesc);  
c0d052b0:	2004      	movs	r0, #4
c0d052b2:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_LangIDDesc;
c0d052b4:	4801      	ldr	r0, [pc, #4]	; (c0d052bc <USBD_LangIDStrDescriptor+0xc>)
c0d052b6:	4478      	add	r0, pc
c0d052b8:	4770      	bx	lr
c0d052ba:	46c0      	nop			; (mov r8, r8)
c0d052bc:	00002598 	.word	0x00002598

c0d052c0 <USBD_ManufacturerStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ManufacturerStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_MANUFACTURER_STRING);
c0d052c0:	200e      	movs	r0, #14
c0d052c2:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_MANUFACTURER_STRING;
c0d052c4:	4801      	ldr	r0, [pc, #4]	; (c0d052cc <USBD_ManufacturerStrDescriptor+0xc>)
c0d052c6:	4478      	add	r0, pc
c0d052c8:	4770      	bx	lr
c0d052ca:	46c0      	nop			; (mov r8, r8)
c0d052cc:	0000258c 	.word	0x0000258c

c0d052d0 <USBD_ProductStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ProductStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_PRODUCT_FS_STRING);
c0d052d0:	200e      	movs	r0, #14
c0d052d2:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_PRODUCT_FS_STRING;
c0d052d4:	4801      	ldr	r0, [pc, #4]	; (c0d052dc <USBD_ProductStrDescriptor+0xc>)
c0d052d6:	4478      	add	r0, pc
c0d052d8:	4770      	bx	lr
c0d052da:	46c0      	nop			; (mov r8, r8)
c0d052dc:	0000258a 	.word	0x0000258a

c0d052e0 <USBD_SerialStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_SerialStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USB_SERIAL_STRING);
c0d052e0:	200a      	movs	r0, #10
c0d052e2:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USB_SERIAL_STRING;
c0d052e4:	4801      	ldr	r0, [pc, #4]	; (c0d052ec <USBD_SerialStrDescriptor+0xc>)
c0d052e6:	4478      	add	r0, pc
c0d052e8:	4770      	bx	lr
c0d052ea:	46c0      	nop			; (mov r8, r8)
c0d052ec:	00002588 	.word	0x00002588

c0d052f0 <USBD_ConfigStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ConfigStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_CONFIGURATION_FS_STRING);
c0d052f0:	200e      	movs	r0, #14
c0d052f2:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_CONFIGURATION_FS_STRING;
c0d052f4:	4801      	ldr	r0, [pc, #4]	; (c0d052fc <USBD_ConfigStrDescriptor+0xc>)
c0d052f6:	4478      	add	r0, pc
c0d052f8:	4770      	bx	lr
c0d052fa:	46c0      	nop			; (mov r8, r8)
c0d052fc:	0000256a 	.word	0x0000256a

c0d05300 <USBD_InterfaceStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_InterfaceStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_INTERFACE_FS_STRING);
c0d05300:	200e      	movs	r0, #14
c0d05302:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_INTERFACE_FS_STRING;
c0d05304:	4801      	ldr	r0, [pc, #4]	; (c0d0530c <USBD_InterfaceStrDescriptor+0xc>)
c0d05306:	4478      	add	r0, pc
c0d05308:	4770      	bx	lr
c0d0530a:	46c0      	nop			; (mov r8, r8)
c0d0530c:	0000255a 	.word	0x0000255a

c0d05310 <USB_power>:
  // nothing to do ?
  return 0;
}
#endif // HAVE_USB_CLASS_CCID

void USB_power(unsigned char enabled) {
c0d05310:	b570      	push	{r4, r5, r6, lr}
c0d05312:	4604      	mov	r4, r0
c0d05314:	204d      	movs	r0, #77	; 0x4d
c0d05316:	0085      	lsls	r5, r0, #2
  os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d05318:	4816      	ldr	r0, [pc, #88]	; (c0d05374 <USB_power+0x64>)
c0d0531a:	2100      	movs	r1, #0
c0d0531c:	462a      	mov	r2, r5
c0d0531e:	f7fc fb0d 	bl	c0d0193c <os_memset>

  if (enabled) {
c0d05322:	2c00      	cmp	r4, #0
c0d05324:	d022      	beq.n	c0d0536c <USB_power+0x5c>
    os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d05326:	4c13      	ldr	r4, [pc, #76]	; (c0d05374 <USB_power+0x64>)
c0d05328:	2600      	movs	r6, #0
c0d0532a:	4620      	mov	r0, r4
c0d0532c:	4631      	mov	r1, r6
c0d0532e:	462a      	mov	r2, r5
c0d05330:	f7fc fb04 	bl	c0d0193c <os_memset>
    /* Init Device Library */
    USBD_Init(&USBD_Device, (USBD_DescriptorsTypeDef*)&HID_Desc, 0);
c0d05334:	4912      	ldr	r1, [pc, #72]	; (c0d05380 <USB_power+0x70>)
c0d05336:	4479      	add	r1, pc
c0d05338:	4620      	mov	r0, r4
c0d0533a:	4632      	mov	r2, r6
c0d0533c:	f7ff fa34 	bl	c0d047a8 <USBD_Init>
    
    /* Register the HID class */
    USBD_RegisterClassForInterface(HID_INTF,  &USBD_Device, (USBD_ClassTypeDef*)&USBD_HID);
c0d05340:	4a10      	ldr	r2, [pc, #64]	; (c0d05384 <USB_power+0x74>)
c0d05342:	447a      	add	r2, pc
c0d05344:	4630      	mov	r0, r6
c0d05346:	4621      	mov	r1, r4
c0d05348:	f7ff fa68 	bl	c0d0481c <USBD_RegisterClassForInterface>
#ifdef HAVE_IO_U2F
    USBD_RegisterClassForInterface(U2F_INTF,  &USBD_Device, (USBD_ClassTypeDef*)&USBD_U2F);
c0d0534c:	2001      	movs	r0, #1
c0d0534e:	4a0e      	ldr	r2, [pc, #56]	; (c0d05388 <USB_power+0x78>)
c0d05350:	447a      	add	r2, pc
c0d05352:	4621      	mov	r1, r4
c0d05354:	f7ff fa62 	bl	c0d0481c <USBD_RegisterClassForInterface>
    // initialize the U2F tunnel transport
    u2f_transport_init(&G_io_u2f, G_io_apdu_buffer, IO_APDU_BUFFER_SIZE);
c0d05358:	22ff      	movs	r2, #255	; 0xff
c0d0535a:	3252      	adds	r2, #82	; 0x52
c0d0535c:	4806      	ldr	r0, [pc, #24]	; (c0d05378 <USB_power+0x68>)
c0d0535e:	4907      	ldr	r1, [pc, #28]	; (c0d0537c <USB_power+0x6c>)
c0d05360:	f7fe fd7a 	bl	c0d03e58 <u2f_transport_init>
    USBD_RegisterClassForInterface(WEBUSB_INTF, &USBD_Device, (USBD_ClassTypeDef*)&USBD_WEBUSB);
    USBD_LL_PrepareReceive(&USBD_Device, WEBUSB_EPOUT_ADDR , WEBUSB_EPOUT_SIZE);
#endif // HAVE_WEBUSB

    /* Start Device Process */
    USBD_Start(&USBD_Device);
c0d05364:	4620      	mov	r0, r4
c0d05366:	f7ff fa66 	bl	c0d04836 <USBD_Start>
  }
  else {
    USBD_DeInit(&USBD_Device);
  }
}
c0d0536a:	bd70      	pop	{r4, r5, r6, pc}

    /* Start Device Process */
    USBD_Start(&USBD_Device);
  }
  else {
    USBD_DeInit(&USBD_Device);
c0d0536c:	4801      	ldr	r0, [pc, #4]	; (c0d05374 <USB_power+0x64>)
c0d0536e:	f7ff fa36 	bl	c0d047de <USBD_DeInit>
  }
}
c0d05372:	bd70      	pop	{r4, r5, r6, pc}
c0d05374:	20002160 	.word	0x20002160
c0d05378:	20001aa8 	.word	0x20001aa8
c0d0537c:	20001924 	.word	0x20001924
c0d05380:	00002476 	.word	0x00002476
c0d05384:	0000248a 	.word	0x0000248a
c0d05388:	000024b4 	.word	0x000024b4

c0d0538c <USBD_GetCfgDesc_impl>:
  * @param  length : pointer data length
  * @retval pointer to descriptor buffer
  */
static uint8_t  *USBD_GetCfgDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_CfgDesc);
c0d0538c:	2149      	movs	r1, #73	; 0x49
c0d0538e:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_CfgDesc;
c0d05390:	4801      	ldr	r0, [pc, #4]	; (c0d05398 <USBD_GetCfgDesc_impl+0xc>)
c0d05392:	4478      	add	r0, pc
c0d05394:	4770      	bx	lr
c0d05396:	46c0      	nop			; (mov r8, r8)
c0d05398:	000024e6 	.word	0x000024e6

c0d0539c <USBD_GetDeviceQualifierDesc_impl>:
* @param  length : pointer data length
* @retval pointer to descriptor buffer
*/
static uint8_t  *USBD_GetDeviceQualifierDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_DeviceQualifierDesc);
c0d0539c:	210a      	movs	r1, #10
c0d0539e:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_DeviceQualifierDesc;
c0d053a0:	4801      	ldr	r0, [pc, #4]	; (c0d053a8 <USBD_GetDeviceQualifierDesc_impl+0xc>)
c0d053a2:	4478      	add	r0, pc
c0d053a4:	4770      	bx	lr
c0d053a6:	46c0      	nop			; (mov r8, r8)
c0d053a8:	00002522 	.word	0x00002522

c0d053ac <USBD_CtlSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendData (USBD_HandleTypeDef  *pdev, 
                               uint8_t *pbuf,
                               uint16_t len)
{
c0d053ac:	b5b0      	push	{r4, r5, r7, lr}
c0d053ae:	460c      	mov	r4, r1
  /* Set EP0 State */
  pdev->ep0_state          = USBD_EP0_DATA_IN;                                      
c0d053b0:	21f4      	movs	r1, #244	; 0xf4
c0d053b2:	2302      	movs	r3, #2
c0d053b4:	5043      	str	r3, [r0, r1]
  pdev->ep_in[0].total_length = len;
c0d053b6:	6182      	str	r2, [r0, #24]
  pdev->ep_in[0].rem_length   = len;
c0d053b8:	61c2      	str	r2, [r0, #28]
  // store the continuation data if needed
  pdev->pData = pbuf;
c0d053ba:	2113      	movs	r1, #19
c0d053bc:	0109      	lsls	r1, r1, #4
c0d053be:	5044      	str	r4, [r0, r1]
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));  
c0d053c0:	6a01      	ldr	r1, [r0, #32]
c0d053c2:	428a      	cmp	r2, r1
c0d053c4:	d300      	bcc.n	c0d053c8 <USBD_CtlSendData+0x1c>
c0d053c6:	460a      	mov	r2, r1
c0d053c8:	b293      	uxth	r3, r2
c0d053ca:	2500      	movs	r5, #0
c0d053cc:	4629      	mov	r1, r5
c0d053ce:	4622      	mov	r2, r4
c0d053d0:	f7ff f9be 	bl	c0d04750 <USBD_LL_Transmit>
  
  return USBD_OK;
c0d053d4:	4628      	mov	r0, r5
c0d053d6:	bdb0      	pop	{r4, r5, r7, pc}

c0d053d8 <USBD_CtlContinueSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueSendData (USBD_HandleTypeDef  *pdev, 
                                       uint8_t *pbuf,
                                       uint16_t len)
{
c0d053d8:	b5b0      	push	{r4, r5, r7, lr}
c0d053da:	460c      	mov	r4, r1
 /* Start the next transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));   
c0d053dc:	6a01      	ldr	r1, [r0, #32]
c0d053de:	428a      	cmp	r2, r1
c0d053e0:	d300      	bcc.n	c0d053e4 <USBD_CtlContinueSendData+0xc>
c0d053e2:	460a      	mov	r2, r1
c0d053e4:	b293      	uxth	r3, r2
c0d053e6:	2500      	movs	r5, #0
c0d053e8:	4629      	mov	r1, r5
c0d053ea:	4622      	mov	r2, r4
c0d053ec:	f7ff f9b0 	bl	c0d04750 <USBD_LL_Transmit>
  return USBD_OK;
c0d053f0:	4628      	mov	r0, r5
c0d053f2:	bdb0      	pop	{r4, r5, r7, pc}

c0d053f4 <USBD_CtlContinueRx>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueRx (USBD_HandleTypeDef  *pdev, 
                                          uint8_t *pbuf,                                          
                                          uint16_t len)
{
c0d053f4:	b510      	push	{r4, lr}
c0d053f6:	2400      	movs	r4, #0
  UNUSED(pbuf);
  USBD_LL_PrepareReceive (pdev,
c0d053f8:	4621      	mov	r1, r4
c0d053fa:	f7ff f9c2 	bl	c0d04782 <USBD_LL_PrepareReceive>
                          0,                                            
                          len);
  return USBD_OK;
c0d053fe:	4620      	mov	r0, r4
c0d05400:	bd10      	pop	{r4, pc}

c0d05402 <USBD_CtlSendStatus>:
*         send zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendStatus (USBD_HandleTypeDef  *pdev)
{
c0d05402:	b510      	push	{r4, lr}

  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_IN;
c0d05404:	21f4      	movs	r1, #244	; 0xf4
c0d05406:	2204      	movs	r2, #4
c0d05408:	5042      	str	r2, [r0, r1]
c0d0540a:	2400      	movs	r4, #0
  
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, NULL, 0);   
c0d0540c:	4621      	mov	r1, r4
c0d0540e:	4622      	mov	r2, r4
c0d05410:	4623      	mov	r3, r4
c0d05412:	f7ff f99d 	bl	c0d04750 <USBD_LL_Transmit>
  
  return USBD_OK;
c0d05416:	4620      	mov	r0, r4
c0d05418:	bd10      	pop	{r4, pc}

c0d0541a <USBD_CtlReceiveStatus>:
*         receive zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlReceiveStatus (USBD_HandleTypeDef  *pdev)
{
c0d0541a:	b510      	push	{r4, lr}
  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_OUT; 
c0d0541c:	21f4      	movs	r1, #244	; 0xf4
c0d0541e:	2205      	movs	r2, #5
c0d05420:	5042      	str	r2, [r0, r1]
c0d05422:	2400      	movs	r4, #0
  
 /* Start the transfer */  
  USBD_LL_PrepareReceive ( pdev,
c0d05424:	4621      	mov	r1, r4
c0d05426:	4622      	mov	r2, r4
c0d05428:	f7ff f9ab 	bl	c0d04782 <USBD_LL_PrepareReceive>
                    0,
                    0);  

  return USBD_OK;
c0d0542c:	4620      	mov	r0, r4
c0d0542e:	bd10      	pop	{r4, pc}

c0d05430 <accept>:
#define UIID_ICONRIGHT2 0x55

#define UIID_MARKER1    0x60
#define UIID_MARKER2    0x61

void accept(unsigned int _) {
c0d05430:	b580      	push	{r7, lr}
    UNUSED(_);
    if (ehAccept != NULL) ehAccept();
c0d05432:	4803      	ldr	r0, [pc, #12]	; (c0d05440 <accept+0x10>)
c0d05434:	6800      	ldr	r0, [r0, #0]
c0d05436:	2800      	cmp	r0, #0
c0d05438:	d000      	beq.n	c0d0543c <accept+0xc>
c0d0543a:	4780      	blx	r0
}
c0d0543c:	bd80      	pop	{r7, pc}
c0d0543e:	46c0      	nop			; (mov r8, r8)
c0d05440:	20002298 	.word	0x20002298

c0d05444 <reject>:

void reject(unsigned int _) {
c0d05444:	b580      	push	{r7, lr}
    UNUSED(_);
    if (ehReject != NULL) ehReject();
c0d05446:	4803      	ldr	r0, [pc, #12]	; (c0d05454 <reject+0x10>)
c0d05448:	6800      	ldr	r0, [r0, #0]
c0d0544a:	2800      	cmp	r0, #0
c0d0544c:	d000      	beq.n	c0d05450 <reject+0xc>
c0d0544e:	4780      	blx	r0
}
c0d05450:	bd80      	pop	{r7, pc}
c0d05452:	46c0      	nop			; (mov r8, r8)
c0d05454:	2000229c 	.word	0x2000229c

c0d05458 <show_idle_menu>:

void show_idle_menu() {
c0d05458:	b580      	push	{r7, lr}
    UX_INIT();
}

void view_idle(unsigned int ignored) {
#if defined(TARGET_NANOS)
    UX_MENU_DISPLAY(0, menu_main, NULL);
c0d0545a:	4903      	ldr	r1, [pc, #12]	; (c0d05468 <show_idle_menu+0x10>)
c0d0545c:	4479      	add	r1, pc
c0d0545e:	2000      	movs	r0, #0
c0d05460:	4602      	mov	r2, r0
c0d05462:	f7fd f939 	bl	c0d026d8 <ux_menu_display>
    if (ehReject != NULL) ehReject();
}

void show_idle_menu() {
    view_idle(0);
}
c0d05466:	bd80      	pop	{r7, pc}
c0d05468:	00002584 	.word	0x00002584

c0d0546c <view_idle>:

void view_init(void) {
    UX_INIT();
}

void view_idle(unsigned int ignored) {
c0d0546c:	b580      	push	{r7, lr}
#if defined(TARGET_NANOS)
    UX_MENU_DISPLAY(0, menu_main, NULL);
c0d0546e:	4903      	ldr	r1, [pc, #12]	; (c0d0547c <view_idle+0x10>)
c0d05470:	4479      	add	r1, pc
c0d05472:	2000      	movs	r0, #0
c0d05474:	4602      	mov	r2, r0
c0d05476:	f7fd f92f 	bl	c0d026d8 <ux_menu_display>
    if(G_ux.stack_count == 0) {
        ux_stack_push();
    }
    ux_flow_init(0, ux_idle_flow, NULL);
#endif
}
c0d0547a:	bd80      	pop	{r7, pc}
c0d0547c:	00002570 	.word	0x00002570

c0d05480 <view_tx_show>:
#if defined(TARGET_NANOS)
    UX_MENU_DISPLAY(0, menu_status, NULL);
#endif
}

void view_tx_show(unsigned int start_page) {
c0d05480:	b580      	push	{r7, lr}
    if (ehGetData == NULL) { return; }
c0d05482:	4905      	ldr	r1, [pc, #20]	; (c0d05498 <view_tx_show+0x18>)
c0d05484:	6809      	ldr	r1, [r1, #0]
c0d05486:	2900      	cmp	r1, #0
c0d05488:	d004      	beq.n	c0d05494 <view_tx_show+0x14>
    viewexpl_start(start_page,
c0d0548a:	2200      	movs	r2, #0
c0d0548c:	4b03      	ldr	r3, [pc, #12]	; (c0d0549c <view_tx_show+0x1c>)
c0d0548e:	447b      	add	r3, pc
c0d05490:	f000 fcc2 	bl	c0d05e18 <viewexpl_start>
                   ehGetData,
                   NULL,
                   view_tx_menu);

}
c0d05494:	bd80      	pop	{r7, pc}
c0d05496:	46c0      	nop			; (mov r8, r8)
c0d05498:	20002294 	.word	0x20002294
c0d0549c:	00000133 	.word	0x00000133

c0d054a0 <view_addr_choose_show>:

void view_addr_choose_refresh() {
    UX_DISPLAY(view_addr_choose, view_addr_choose_prepro);
}

void view_addr_choose_show(unsigned int _) {
c0d054a0:	b510      	push	{r4, lr}
    // Initialize show view
    view_addr_choose_data.status.mode = VIEW_ADDR_MODE_ACCOUNT;
c0d054a2:	480c      	ldr	r0, [pc, #48]	; (c0d054d4 <view_addr_choose_show+0x34>)
c0d054a4:	7801      	ldrb	r1, [r0, #0]
c0d054a6:	22f0      	movs	r2, #240	; 0xf0
c0d054a8:	400a      	ands	r2, r1
c0d054aa:	7002      	strb	r2, [r0, #0]
c0d054ac:	2400      	movs	r4, #0
    view_addr_choose_data.account = 0;
c0d054ae:	6044      	str	r4, [r0, #4]
    view_addr_choose_data.index = 0;
c0d054b0:	6084      	str	r4, [r0, #8]
    strcpy(bech32_hrp, "cosmos");
c0d054b2:	4809      	ldr	r0, [pc, #36]	; (c0d054d8 <view_addr_choose_show+0x38>)
c0d054b4:	a109      	add	r1, pc, #36	; (adr r1, c0d054dc <view_addr_choose_show+0x3c>)
c0d054b6:	2207      	movs	r2, #7
c0d054b8:	f000 fef4 	bl	c0d062a4 <__aeabi_memcpy>
    ehAccept = show_idle_menu;
c0d054bc:	4809      	ldr	r0, [pc, #36]	; (c0d054e4 <view_addr_choose_show+0x44>)
c0d054be:	490b      	ldr	r1, [pc, #44]	; (c0d054ec <view_addr_choose_show+0x4c>)
c0d054c0:	4479      	add	r1, pc
c0d054c2:	6001      	str	r1, [r0, #0]
    ehReject = NULL;
c0d054c4:	4808      	ldr	r0, [pc, #32]	; (c0d054e8 <view_addr_choose_show+0x48>)
c0d054c6:	6004      	str	r4, [r0, #0]

    // Now show view
    view_addr_choose_update();
c0d054c8:	f000 f886 	bl	c0d055d8 <view_addr_choose_update>
    view_addr_choose_refresh();
c0d054cc:	f000 fa10 	bl	c0d058f0 <view_addr_choose_refresh>
}
c0d054d0:	bd10      	pop	{r4, pc}
c0d054d2:	46c0      	nop			; (mov r8, r8)
c0d054d4:	200022a0 	.word	0x200022a0
c0d054d8:	200018c1 	.word	0x200018c1
c0d054dc:	6d736f63 	.word	0x6d736f63
c0d054e0:	0000736f 	.word	0x0000736f
c0d054e4:	20002298 	.word	0x20002298
c0d054e8:	2000229c 	.word	0x2000229c
c0d054ec:	ffffff95 	.word	0xffffff95

c0d054f0 <view_addr_choose_prepro>:

    UI_LabelLineScrolling(UIID_LABELSCROLL, 16, 30, 96, 11, UI_WHITE, UI_BLACK, (const char *) viewctl.dataValue),
#endif
};

const bagl_element_t *view_addr_choose_prepro(const bagl_element_t *element) {
c0d054f0:	b5b0      	push	{r4, r5, r7, lr}
c0d054f2:	4604      	mov	r4, r0
c0d054f4:	7860      	ldrb	r0, [r4, #1]
    switch (element->component.userid) {
c0d054f6:	2853      	cmp	r0, #83	; 0x53
c0d054f8:	dd08      	ble.n	c0d0550c <view_addr_choose_prepro+0x1c>
c0d054fa:	2860      	cmp	r0, #96	; 0x60
c0d054fc:	dc1d      	bgt.n	c0d0553a <view_addr_choose_prepro+0x4a>
c0d054fe:	4601      	mov	r1, r0
c0d05500:	3954      	subs	r1, #84	; 0x54
c0d05502:	2902      	cmp	r1, #2
c0d05504:	d32f      	bcc.n	c0d05566 <view_addr_choose_prepro+0x76>
c0d05506:	2860      	cmp	r0, #96	; 0x60
c0d05508:	d010      	beq.n	c0d0552c <view_addr_choose_prepro+0x3c>
c0d0550a:	e03b      	b.n	c0d05584 <view_addr_choose_prepro+0x94>
c0d0550c:	4601      	mov	r1, r0
c0d0550e:	3952      	subs	r1, #82	; 0x52
c0d05510:	2902      	cmp	r1, #2
c0d05512:	d30b      	bcc.n	c0d0552c <view_addr_choose_prepro+0x3c>
c0d05514:	2850      	cmp	r0, #80	; 0x50
c0d05516:	d02e      	beq.n	c0d05576 <view_addr_choose_prepro+0x86>
c0d05518:	2851      	cmp	r0, #81	; 0x51
c0d0551a:	d133      	bne.n	c0d05584 <view_addr_choose_prepro+0x94>
                view_addr_choose_data.status.mode != VIEW_ADDR_MODE_SHOW)
                return NULL;
            break;

        case UIID_ICONREJECT:
            if (view_addr_choose_data.status.mode != VIEW_ADDR_MODE_CONFIRM)
c0d0551c:	481c      	ldr	r0, [pc, #112]	; (c0d05590 <view_addr_choose_prepro+0xa0>)
c0d0551e:	7800      	ldrb	r0, [r0, #0]
c0d05520:	210f      	movs	r1, #15
c0d05522:	4001      	ands	r1, r0
c0d05524:	2000      	movs	r0, #0
c0d05526:	2903      	cmp	r1, #3
c0d05528:	d02c      	beq.n	c0d05584 <view_addr_choose_prepro+0x94>
c0d0552a:	e02c      	b.n	c0d05586 <view_addr_choose_prepro+0x96>
c0d0552c:	4818      	ldr	r0, [pc, #96]	; (c0d05590 <view_addr_choose_prepro+0xa0>)
c0d0552e:	7800      	ldrb	r0, [r0, #0]
c0d05530:	0701      	lsls	r1, r0, #28
c0d05532:	2000      	movs	r0, #0
c0d05534:	2900      	cmp	r1, #0
c0d05536:	d126      	bne.n	c0d05586 <view_addr_choose_prepro+0x96>
c0d05538:	e024      	b.n	c0d05584 <view_addr_choose_prepro+0x94>
c0d0553a:	2861      	cmp	r0, #97	; 0x61
c0d0553c:	d013      	beq.n	c0d05566 <view_addr_choose_prepro+0x76>
c0d0553e:	2871      	cmp	r0, #113	; 0x71
c0d05540:	d120      	bne.n	c0d05584 <view_addr_choose_prepro+0x94>
                return NULL;
            break;

        case UIID_LABELSCROLL:
            UX_CALLBACK_SET_INTERVAL(MAX(3000, 1000 + bagl_label_roundtrip_duration_ms(element, 7)));
c0d05542:	2107      	movs	r1, #7
c0d05544:	4620      	mov	r0, r4
c0d05546:	f7fc fda9 	bl	c0d0209c <bagl_label_roundtrip_duration_ms>
c0d0554a:	217d      	movs	r1, #125	; 0x7d
c0d0554c:	00cd      	lsls	r5, r1, #3
c0d0554e:	1941      	adds	r1, r0, r5
c0d05550:	480d      	ldr	r0, [pc, #52]	; (c0d05588 <view_addr_choose_prepro+0x98>)
c0d05552:	4281      	cmp	r1, r0
c0d05554:	d304      	bcc.n	c0d05560 <view_addr_choose_prepro+0x70>
c0d05556:	2107      	movs	r1, #7
c0d05558:	4620      	mov	r0, r4
c0d0555a:	f7fc fd9f 	bl	c0d0209c <bagl_label_roundtrip_duration_ms>
c0d0555e:	1940      	adds	r0, r0, r5
c0d05560:	490a      	ldr	r1, [pc, #40]	; (c0d0558c <view_addr_choose_prepro+0x9c>)
c0d05562:	6148      	str	r0, [r1, #20]
c0d05564:	e00e      	b.n	c0d05584 <view_addr_choose_prepro+0x94>
c0d05566:	480a      	ldr	r0, [pc, #40]	; (c0d05590 <view_addr_choose_prepro+0xa0>)
c0d05568:	7800      	ldrb	r0, [r0, #0]
c0d0556a:	210f      	movs	r1, #15
c0d0556c:	4001      	ands	r1, r0
c0d0556e:	2000      	movs	r0, #0
c0d05570:	2901      	cmp	r1, #1
c0d05572:	d007      	beq.n	c0d05584 <view_addr_choose_prepro+0x94>
c0d05574:	e007      	b.n	c0d05586 <view_addr_choose_prepro+0x96>
            if (view_addr_choose_data.status.mode != VIEW_ADDR_MODE_INDEX)
                return NULL;
            break;

        case UIID_ICONACCEPT:
            if (view_addr_choose_data.status.mode != VIEW_ADDR_MODE_CONFIRM &&
c0d05576:	4806      	ldr	r0, [pc, #24]	; (c0d05590 <view_addr_choose_prepro+0xa0>)
c0d05578:	7800      	ldrb	r0, [r0, #0]
c0d0557a:	210e      	movs	r1, #14
c0d0557c:	4001      	ands	r1, r0
c0d0557e:	2000      	movs	r0, #0
c0d05580:	2902      	cmp	r1, #2
c0d05582:	d100      	bne.n	c0d05586 <view_addr_choose_prepro+0x96>
c0d05584:	4620      	mov	r0, r4
        case UIID_LABELSCROLL:
            UX_CALLBACK_SET_INTERVAL(MAX(3000, 1000 + bagl_label_roundtrip_duration_ms(element, 7)));
            break;
    }
    return element;
}
c0d05586:	bdb0      	pop	{r4, r5, r7, pc}
c0d05588:	00000bb8 	.word	0x00000bb8
c0d0558c:	200022ac 	.word	0x200022ac
c0d05590:	200022a0 	.word	0x200022a0

c0d05594 <io_seproxyhal_display>:

////////////////////////////////
////////////////////////////////
////////////////////////////////

void io_seproxyhal_display(const bagl_element_t *element) {
c0d05594:	b580      	push	{r7, lr}
    io_seproxyhal_display_default((bagl_element_t *) element);
c0d05596:	f7fc fd3f 	bl	c0d02018 <io_seproxyhal_display_default>
}
c0d0559a:	bd80      	pop	{r7, pc}

c0d0559c <view_init>:

void view_init(void) {
c0d0559c:	b580      	push	{r7, lr}
    UX_INIT();
c0d0559e:	4803      	ldr	r0, [pc, #12]	; (c0d055ac <view_init+0x10>)
c0d055a0:	2100      	movs	r1, #0
c0d055a2:	22b0      	movs	r2, #176	; 0xb0
c0d055a4:	f7fc f9ca 	bl	c0d0193c <os_memset>
}
c0d055a8:	bd80      	pop	{r7, pc}
c0d055aa:	46c0      	nop			; (mov r8, r8)
c0d055ac:	200022ac 	.word	0x200022ac

c0d055b0 <view_status>:
    }
    ux_flow_init(0, ux_idle_flow, NULL);
#endif
}

void view_status(unsigned int ignored) {
c0d055b0:	b580      	push	{r7, lr}
#if defined(TARGET_NANOS)
    UX_MENU_DISPLAY(0, menu_status, NULL);
c0d055b2:	4903      	ldr	r1, [pc, #12]	; (c0d055c0 <view_status+0x10>)
c0d055b4:	4479      	add	r1, pc
c0d055b6:	2000      	movs	r0, #0
c0d055b8:	4602      	mov	r2, r0
c0d055ba:	f7fd f88d 	bl	c0d026d8 <ux_menu_display>
#endif
}
c0d055be:	bd80      	pop	{r7, pc}
c0d055c0:	000024b8 	.word	0x000024b8

c0d055c4 <view_tx_menu>:
    }
    ux_flow_init(0, ux_addr_flow, NULL);
#endif
}

void view_tx_menu(unsigned int unused) {
c0d055c4:	b580      	push	{r7, lr}
    UNUSED(unused);

#if defined(TARGET_NANOS)
    UX_MENU_DISPLAY(0, menu_transaction_info, NULL);
c0d055c6:	4903      	ldr	r1, [pc, #12]	; (c0d055d4 <view_tx_menu+0x10>)
c0d055c8:	4479      	add	r1, pc
c0d055ca:	2000      	movs	r0, #0
c0d055cc:	4602      	mov	r2, r0
c0d055ce:	f7fd f883 	bl	c0d026d8 <ux_menu_display>
    if(G_ux.stack_count == 0) {
        ux_stack_push();
    }
    ux_flow_init(0, ux_tx_flow, NULL);
#endif
}
c0d055d2:	bd80      	pop	{r7, pc}
c0d055d4:	000023a8 	.word	0x000023a8

c0d055d8 <view_addr_choose_update>:
                   NULL,
                   view_tx_menu);

}

void view_addr_choose_update() {
c0d055d8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d055da:	b081      	sub	sp, #4
    print_title("Account %u", view_addr_choose_data.account);
c0d055dc:	4c66      	ldr	r4, [pc, #408]	; (c0d05778 <view_addr_choose_update+0x1a0>)
c0d055de:	6863      	ldr	r3, [r4, #4]
c0d055e0:	4d66      	ldr	r5, [pc, #408]	; (c0d0577c <view_addr_choose_update+0x1a4>)
c0d055e2:	4628      	mov	r0, r5
c0d055e4:	300a      	adds	r0, #10
c0d055e6:	2113      	movs	r1, #19
c0d055e8:	a265      	add	r2, pc, #404	; (adr r2, c0d05780 <view_addr_choose_update+0x1a8>)
c0d055ea:	f7fd f905 	bl	c0d027f8 <snprintf>
    print_key("Index %u", view_addr_choose_data.index);
c0d055ee:	68a3      	ldr	r3, [r4, #8]
c0d055f0:	4628      	mov	r0, r5
c0d055f2:	301d      	adds	r0, #29
c0d055f4:	2140      	movs	r1, #64	; 0x40
c0d055f6:	a265      	add	r2, pc, #404	; (adr r2, c0d0578c <view_addr_choose_update+0x1b4>)
c0d055f8:	f7fd f8fe 	bl	c0d027f8 <snprintf>

    print_value("...");
c0d055fc:	355d      	adds	r5, #93	; 0x5d
c0d055fe:	21c0      	movs	r1, #192	; 0xc0
c0d05600:	a265      	add	r2, pc, #404	; (adr r2, c0d05798 <view_addr_choose_update+0x1c0>)
c0d05602:	4628      	mov	r0, r5
c0d05604:	f7fd f8f8 	bl	c0d027f8 <snprintf>
    if (view_addr_choose_data.status.mode == VIEW_ADDR_MODE_SHOW) {
c0d05608:	7820      	ldrb	r0, [r4, #0]
c0d0560a:	210f      	movs	r1, #15
c0d0560c:	4001      	ands	r1, r0
c0d0560e:	2902      	cmp	r1, #2
c0d05610:	d000      	beq.n	c0d05614 <view_addr_choose_update+0x3c>
c0d05612:	e08d      	b.n	c0d05730 <view_addr_choose_update+0x158>
        print_value("....?....");
c0d05614:	21c0      	movs	r1, #192	; 0xc0
c0d05616:	a261      	add	r2, pc, #388	; (adr r2, c0d0579c <view_addr_choose_update+0x1c4>)
c0d05618:	9500      	str	r5, [sp, #0]
c0d0561a:	4628      	mov	r0, r5
c0d0561c:	f7fd f8ec 	bl	c0d027f8 <snprintf>
        UX_DISPLAY(view_addr_choose, view_addr_choose_prepro);
c0d05620:	4f61      	ldr	r7, [pc, #388]	; (c0d057a8 <view_addr_choose_update+0x1d0>)
c0d05622:	4866      	ldr	r0, [pc, #408]	; (c0d057bc <view_addr_choose_update+0x1e4>)
c0d05624:	4478      	add	r0, pc
c0d05626:	6038      	str	r0, [r7, #0]
c0d05628:	200a      	movs	r0, #10
c0d0562a:	6078      	str	r0, [r7, #4]
c0d0562c:	4864      	ldr	r0, [pc, #400]	; (c0d057c0 <view_addr_choose_update+0x1e8>)
c0d0562e:	4478      	add	r0, pc
c0d05630:	6138      	str	r0, [r7, #16]
c0d05632:	4864      	ldr	r0, [pc, #400]	; (c0d057c4 <view_addr_choose_update+0x1ec>)
c0d05634:	4478      	add	r0, pc
c0d05636:	60f8      	str	r0, [r7, #12]
c0d05638:	2003      	movs	r0, #3
c0d0563a:	7638      	strb	r0, [r7, #24]
c0d0563c:	2500      	movs	r5, #0
c0d0563e:	61fd      	str	r5, [r7, #28]
c0d05640:	4638      	mov	r0, r7
c0d05642:	3018      	adds	r0, #24
c0d05644:	f7fd fd6c 	bl	c0d03120 <os_ux>
c0d05648:	61f8      	str	r0, [r7, #28]
c0d0564a:	f7fd f8d3 	bl	c0d027f4 <ux_check_status_default>
c0d0564e:	f7fc fb8f 	bl	c0d01d70 <io_seproxyhal_init_ux>
c0d05652:	f7fc fb93 	bl	c0d01d7c <io_seproxyhal_init_button>
c0d05656:	60bd      	str	r5, [r7, #8]
c0d05658:	6838      	ldr	r0, [r7, #0]
c0d0565a:	2800      	cmp	r0, #0
c0d0565c:	d028      	beq.n	c0d056b0 <view_addr_choose_update+0xd8>
c0d0565e:	69f8      	ldr	r0, [r7, #28]
c0d05660:	4952      	ldr	r1, [pc, #328]	; (c0d057ac <view_addr_choose_update+0x1d4>)
c0d05662:	4288      	cmp	r0, r1
c0d05664:	d024      	beq.n	c0d056b0 <view_addr_choose_update+0xd8>
c0d05666:	2800      	cmp	r0, #0
c0d05668:	d022      	beq.n	c0d056b0 <view_addr_choose_update+0xd8>
c0d0566a:	2500      	movs	r5, #0
c0d0566c:	6878      	ldr	r0, [r7, #4]
c0d0566e:	4285      	cmp	r5, r0
c0d05670:	d21e      	bcs.n	c0d056b0 <view_addr_choose_update+0xd8>
c0d05672:	f7fd fddf 	bl	c0d03234 <io_seproxyhal_spi_is_status_sent>
c0d05676:	2800      	cmp	r0, #0
c0d05678:	d119      	bne.n	c0d056ae <view_addr_choose_update+0xd6>
c0d0567a:	68b8      	ldr	r0, [r7, #8]
c0d0567c:	68f9      	ldr	r1, [r7, #12]
c0d0567e:	2538      	movs	r5, #56	; 0x38
c0d05680:	4368      	muls	r0, r5
c0d05682:	683a      	ldr	r2, [r7, #0]
c0d05684:	1810      	adds	r0, r2, r0
c0d05686:	2900      	cmp	r1, #0
c0d05688:	d002      	beq.n	c0d05690 <view_addr_choose_update+0xb8>
c0d0568a:	4788      	blx	r1
c0d0568c:	2800      	cmp	r0, #0
c0d0568e:	d007      	beq.n	c0d056a0 <view_addr_choose_update+0xc8>
c0d05690:	2801      	cmp	r0, #1
c0d05692:	d103      	bne.n	c0d0569c <view_addr_choose_update+0xc4>
c0d05694:	68b8      	ldr	r0, [r7, #8]
c0d05696:	4345      	muls	r5, r0
c0d05698:	6838      	ldr	r0, [r7, #0]
c0d0569a:	1940      	adds	r0, r0, r5
////////////////////////////////
////////////////////////////////
////////////////////////////////

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *) element);
c0d0569c:	f7fc fcbc 	bl	c0d02018 <io_seproxyhal_display_default>
    print_key("Index %u", view_addr_choose_data.index);

    print_value("...");
    if (view_addr_choose_data.status.mode == VIEW_ADDR_MODE_SHOW) {
        print_value("....?....");
        UX_DISPLAY(view_addr_choose, view_addr_choose_prepro);
c0d056a0:	68b8      	ldr	r0, [r7, #8]
c0d056a2:	1c45      	adds	r5, r0, #1
c0d056a4:	60bd      	str	r5, [r7, #8]
c0d056a6:	6838      	ldr	r0, [r7, #0]
c0d056a8:	2800      	cmp	r0, #0
c0d056aa:	d1df      	bne.n	c0d0566c <view_addr_choose_update+0x94>
c0d056ac:	e000      	b.n	c0d056b0 <view_addr_choose_update+0xd8>
c0d056ae:	68bd      	ldr	r5, [r7, #8]
        UX_WAIT();
c0d056b0:	687e      	ldr	r6, [r7, #4]
c0d056b2:	483f      	ldr	r0, [pc, #252]	; (c0d057b0 <view_addr_choose_update+0x1d8>)
c0d056b4:	2180      	movs	r1, #128	; 0x80
c0d056b6:	2200      	movs	r2, #0
c0d056b8:	f7fd fdd2 	bl	c0d03260 <io_seproxyhal_spi_recv>
c0d056bc:	42b5      	cmp	r5, r6
c0d056be:	d22d      	bcs.n	c0d0571c <view_addr_choose_update+0x144>
c0d056c0:	4d3b      	ldr	r5, [pc, #236]	; (c0d057b0 <view_addr_choose_update+0x1d8>)
c0d056c2:	6838      	ldr	r0, [r7, #0]
c0d056c4:	2800      	cmp	r0, #0
c0d056c6:	d020      	beq.n	c0d0570a <view_addr_choose_update+0x132>
c0d056c8:	68b8      	ldr	r0, [r7, #8]
c0d056ca:	6879      	ldr	r1, [r7, #4]
c0d056cc:	4288      	cmp	r0, r1
c0d056ce:	d21c      	bcs.n	c0d0570a <view_addr_choose_update+0x132>
c0d056d0:	f7fd fdb0 	bl	c0d03234 <io_seproxyhal_spi_is_status_sent>
c0d056d4:	2800      	cmp	r0, #0
c0d056d6:	d118      	bne.n	c0d0570a <view_addr_choose_update+0x132>
c0d056d8:	68b8      	ldr	r0, [r7, #8]
c0d056da:	68f9      	ldr	r1, [r7, #12]
c0d056dc:	2638      	movs	r6, #56	; 0x38
c0d056de:	4370      	muls	r0, r6
c0d056e0:	683a      	ldr	r2, [r7, #0]
c0d056e2:	1810      	adds	r0, r2, r0
c0d056e4:	2900      	cmp	r1, #0
c0d056e6:	d002      	beq.n	c0d056ee <view_addr_choose_update+0x116>
c0d056e8:	4788      	blx	r1
c0d056ea:	2800      	cmp	r0, #0
c0d056ec:	d007      	beq.n	c0d056fe <view_addr_choose_update+0x126>
c0d056ee:	2801      	cmp	r0, #1
c0d056f0:	d103      	bne.n	c0d056fa <view_addr_choose_update+0x122>
c0d056f2:	68b8      	ldr	r0, [r7, #8]
c0d056f4:	4346      	muls	r6, r0
c0d056f6:	6838      	ldr	r0, [r7, #0]
c0d056f8:	1980      	adds	r0, r0, r6
////////////////////////////////
////////////////////////////////
////////////////////////////////

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *) element);
c0d056fa:	f7fc fc8d 	bl	c0d02018 <io_seproxyhal_display_default>

    print_value("...");
    if (view_addr_choose_data.status.mode == VIEW_ADDR_MODE_SHOW) {
        print_value("....?....");
        UX_DISPLAY(view_addr_choose, view_addr_choose_prepro);
        UX_WAIT();
c0d056fe:	68b8      	ldr	r0, [r7, #8]
c0d05700:	1c40      	adds	r0, r0, #1
c0d05702:	60b8      	str	r0, [r7, #8]
c0d05704:	6839      	ldr	r1, [r7, #0]
c0d05706:	2900      	cmp	r1, #0
c0d05708:	d1df      	bne.n	c0d056ca <view_addr_choose_update+0xf2>
c0d0570a:	687e      	ldr	r6, [r7, #4]
c0d0570c:	68bc      	ldr	r4, [r7, #8]
c0d0570e:	2180      	movs	r1, #128	; 0x80
c0d05710:	2200      	movs	r2, #0
c0d05712:	4628      	mov	r0, r5
c0d05714:	f7fd fda4 	bl	c0d03260 <io_seproxyhal_spi_recv>
c0d05718:	42b4      	cmp	r4, r6
c0d0571a:	d3d2      	bcc.n	c0d056c2 <view_addr_choose_update+0xea>
c0d0571c:	f7fc f9d8 	bl	c0d01ad0 <io_seproxyhal_general_status>
c0d05720:	4823      	ldr	r0, [pc, #140]	; (c0d057b0 <view_addr_choose_update+0x1d8>)
c0d05722:	2180      	movs	r1, #128	; 0x80
c0d05724:	2200      	movs	r2, #0
c0d05726:	f7fd fd9b 	bl	c0d03260 <io_seproxyhal_spi_recv>
c0d0572a:	4c13      	ldr	r4, [pc, #76]	; (c0d05778 <view_addr_choose_update+0x1a0>)
c0d0572c:	7820      	ldrb	r0, [r4, #0]
c0d0572e:	9d00      	ldr	r5, [sp, #0]
    }

    if (view_addr_choose_data.status.mode == VIEW_ADDR_MODE_SHOW ||
c0d05730:	210e      	movs	r1, #14
c0d05732:	4001      	ands	r1, r0
c0d05734:	2902      	cmp	r1, #2
c0d05736:	d11b      	bne.n	c0d05770 <view_addr_choose_update+0x198>
        view_addr_choose_data.status.mode == VIEW_ADDR_MODE_CONFIRM) {
        print_value("This is a very long string that needs to be scrolled otherwise it does not fit");
c0d05738:	21c0      	movs	r1, #192	; 0xc0
c0d0573a:	4a23      	ldr	r2, [pc, #140]	; (c0d057c8 <view_addr_choose_update+0x1f0>)
c0d0573c:	447a      	add	r2, pc
c0d0573e:	4628      	mov	r0, r5
c0d05740:	f7fd f85a 	bl	c0d027f8 <snprintf>

        bip32_depth = 5;
c0d05744:	481b      	ldr	r0, [pc, #108]	; (c0d057b4 <view_addr_choose_update+0x1dc>)
c0d05746:	2105      	movs	r1, #5
c0d05748:	7001      	strb	r1, [r0, #0]
        bip32_path[0] = BIP32_0_DEFAULT;
        bip32_path[1] = BIP32_1_DEFAULT;
c0d0574a:	2001      	movs	r0, #1
c0d0574c:	07c0      	lsls	r0, r0, #31
    if (view_addr_choose_data.status.mode == VIEW_ADDR_MODE_SHOW ||
        view_addr_choose_data.status.mode == VIEW_ADDR_MODE_CONFIRM) {
        print_value("This is a very long string that needs to be scrolled otherwise it does not fit");

        bip32_depth = 5;
        bip32_path[0] = BIP32_0_DEFAULT;
c0d0574e:	4601      	mov	r1, r0
c0d05750:	312c      	adds	r1, #44	; 0x2c
c0d05752:	4a19      	ldr	r2, [pc, #100]	; (c0d057b8 <view_addr_choose_update+0x1e0>)
c0d05754:	6011      	str	r1, [r2, #0]
        bip32_path[1] = BIP32_1_DEFAULT;
c0d05756:	4601      	mov	r1, r0
c0d05758:	3176      	adds	r1, #118	; 0x76
c0d0575a:	6051      	str	r1, [r2, #4]
        bip32_path[2] = 0x80000000 | view_addr_choose_data.account;
c0d0575c:	6861      	ldr	r1, [r4, #4]
c0d0575e:	4301      	orrs	r1, r0
c0d05760:	6091      	str	r1, [r2, #8]
c0d05762:	2000      	movs	r0, #0
        bip32_path[3] = BIP32_3_DEFAULT;
c0d05764:	60d0      	str	r0, [r2, #12]
        bip32_path[4] = view_addr_choose_data.index;
c0d05766:	68a0      	ldr	r0, [r4, #8]
c0d05768:	6110      	str	r0, [r2, #16]
        get_bech32_addr(viewctl.dataValue);
c0d0576a:	4628      	mov	r0, r5
c0d0576c:	f7fb fc4a 	bl	c0d01004 <get_bech32_addr>
    }

    viewctl_dataValue_split();
c0d05770:	f000 f9ac 	bl	c0d05acc <viewctl_dataValue_split>
}
c0d05774:	b001      	add	sp, #4
c0d05776:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d05778:	200022a0 	.word	0x200022a0
c0d0577c:	2000236c 	.word	0x2000236c
c0d05780:	6f636341 	.word	0x6f636341
c0d05784:	20746e75 	.word	0x20746e75
c0d05788:	00007525 	.word	0x00007525
c0d0578c:	65646e49 	.word	0x65646e49
c0d05790:	75252078 	.word	0x75252078
c0d05794:	00000000 	.word	0x00000000
c0d05798:	002e2e2e 	.word	0x002e2e2e
c0d0579c:	2e2e2e2e 	.word	0x2e2e2e2e
c0d057a0:	2e2e2e3f 	.word	0x2e2e2e3f
c0d057a4:	0000002e 	.word	0x0000002e
c0d057a8:	200022ac 	.word	0x200022ac
c0d057ac:	b0105044 	.word	0xb0105044
c0d057b0:	20001800 	.word	0x20001800
c0d057b4:	200018c0 	.word	0x200018c0
c0d057b8:	20001898 	.word	0x20001898
c0d057bc:	00002480 	.word	0x00002480
c0d057c0:	0000019b 	.word	0x0000019b
c0d057c4:	fffffeb9 	.word	0xfffffeb9
c0d057c8:	000021e5 	.word	0x000021e5

c0d057cc <view_addr_choose_button>:

uint32_t bip32_field_add(uint32_t field, int16_t value) {
    return (field + value) & 0x7FFFFFFF;
}

static unsigned int view_addr_choose_button(unsigned int button_mask, unsigned int button_mask_counter) {
c0d057cc:	b580      	push	{r7, lr}
c0d057ce:	493e      	ldr	r1, [pc, #248]	; (c0d058c8 <view_addr_choose_button+0xfc>)
    switch (button_mask) {
c0d057d0:	4a3e      	ldr	r2, [pc, #248]	; (c0d058cc <view_addr_choose_button+0x100>)
c0d057d2:	4290      	cmp	r0, r2
c0d057d4:	dd17      	ble.n	c0d05806 <view_addr_choose_button+0x3a>
c0d057d6:	4a3e      	ldr	r2, [pc, #248]	; (c0d058d0 <view_addr_choose_button+0x104>)
c0d057d8:	4290      	cmp	r0, r2
c0d057da:	d027      	beq.n	c0d0582c <view_addr_choose_button+0x60>
c0d057dc:	4a3d      	ldr	r2, [pc, #244]	; (c0d058d4 <view_addr_choose_button+0x108>)
c0d057de:	4290      	cmp	r0, r2
c0d057e0:	d032      	beq.n	c0d05848 <view_addr_choose_button+0x7c>
c0d057e2:	493d      	ldr	r1, [pc, #244]	; (c0d058d8 <view_addr_choose_button+0x10c>)
c0d057e4:	4288      	cmp	r0, r1
c0d057e6:	d153      	bne.n	c0d05890 <view_addr_choose_button+0xc4>
        case BUTTON_EVT_RELEASED | BUTTON_LEFT | BUTTON_RIGHT:
            // Press both to accept / switch mode
            switch (view_addr_choose_data.status.mode) {
c0d057e8:	483d      	ldr	r0, [pc, #244]	; (c0d058e0 <view_addr_choose_button+0x114>)
c0d057ea:	7801      	ldrb	r1, [r0, #0]
c0d057ec:	230f      	movs	r3, #15
c0d057ee:	400b      	ands	r3, r1
c0d057f0:	2202      	movs	r2, #2
c0d057f2:	2b01      	cmp	r3, #1
c0d057f4:	d002      	beq.n	c0d057fc <view_addr_choose_button+0x30>
c0d057f6:	2b00      	cmp	r3, #0
c0d057f8:	d14a      	bne.n	c0d05890 <view_addr_choose_button+0xc4>
c0d057fa:	2201      	movs	r2, #1
c0d057fc:	23f0      	movs	r3, #240	; 0xf0
c0d057fe:	4019      	ands	r1, r3
c0d05800:	4311      	orrs	r1, r2
c0d05802:	7001      	strb	r1, [r0, #0]
c0d05804:	e040      	b.n	c0d05888 <view_addr_choose_button+0xbc>
c0d05806:	4a35      	ldr	r2, [pc, #212]	; (c0d058dc <view_addr_choose_button+0x110>)
c0d05808:	4290      	cmp	r0, r2
c0d0580a:	d02c      	beq.n	c0d05866 <view_addr_choose_button+0x9a>
c0d0580c:	4a2f      	ldr	r2, [pc, #188]	; (c0d058cc <view_addr_choose_button+0x100>)
c0d0580e:	4290      	cmp	r0, r2
c0d05810:	d13e      	bne.n	c0d05890 <view_addr_choose_button+0xc4>
            }
            break;

        case BUTTON_EVT_RELEASED | BUTTON_RIGHT:
            // Press right -> next element
            switch (view_addr_choose_data.status.mode) {
c0d05812:	4b33      	ldr	r3, [pc, #204]	; (c0d058e0 <view_addr_choose_button+0x114>)
c0d05814:	7818      	ldrb	r0, [r3, #0]
c0d05816:	220f      	movs	r2, #15
c0d05818:	4002      	ands	r2, r0
c0d0581a:	4618      	mov	r0, r3
c0d0581c:	3008      	adds	r0, #8
c0d0581e:	2a01      	cmp	r2, #1
c0d05820:	dc38      	bgt.n	c0d05894 <view_addr_choose_button+0xc8>
c0d05822:	2a00      	cmp	r2, #0
c0d05824:	d042      	beq.n	c0d058ac <view_addr_choose_button+0xe0>
c0d05826:	2a01      	cmp	r2, #1
c0d05828:	d041      	beq.n	c0d058ae <view_addr_choose_button+0xe2>
c0d0582a:	e031      	b.n	c0d05890 <view_addr_choose_button+0xc4>
            }
            break;

        case BUTTON_EVT_FAST | BUTTON_RIGHT:
            // Press right -> next element (fast)
            switch (view_addr_choose_data.status.mode) {
c0d0582c:	482c      	ldr	r0, [pc, #176]	; (c0d058e0 <view_addr_choose_button+0x114>)
c0d0582e:	7802      	ldrb	r2, [r0, #0]
c0d05830:	230f      	movs	r3, #15
c0d05832:	4013      	ands	r3, r2
c0d05834:	4602      	mov	r2, r0
c0d05836:	3208      	adds	r2, #8
c0d05838:	2b01      	cmp	r3, #1
c0d0583a:	d002      	beq.n	c0d05842 <view_addr_choose_button+0x76>
c0d0583c:	2b00      	cmp	r3, #0
c0d0583e:	d127      	bne.n	c0d05890 <view_addr_choose_button+0xc4>
c0d05840:	1d02      	adds	r2, r0, #4
c0d05842:	6810      	ldr	r0, [r2, #0]
    }
    return element;
}

uint32_t bip32_field_add(uint32_t field, int16_t value) {
    return (field + value) & 0x7FFFFFFF;
c0d05844:	300a      	adds	r0, #10
c0d05846:	e01d      	b.n	c0d05884 <view_addr_choose_button+0xb8>
            }
            break;

        case BUTTON_EVT_FAST | BUTTON_LEFT:
            // Hold left -> previous element (fast)
            switch (view_addr_choose_data.status.mode) {
c0d05848:	4825      	ldr	r0, [pc, #148]	; (c0d058e0 <view_addr_choose_button+0x114>)
c0d0584a:	7802      	ldrb	r2, [r0, #0]
c0d0584c:	230f      	movs	r3, #15
c0d0584e:	4013      	ands	r3, r2
c0d05850:	4602      	mov	r2, r0
c0d05852:	3208      	adds	r2, #8
c0d05854:	2b01      	cmp	r3, #1
c0d05856:	d002      	beq.n	c0d0585e <view_addr_choose_button+0x92>
c0d05858:	2b00      	cmp	r3, #0
c0d0585a:	d119      	bne.n	c0d05890 <view_addr_choose_button+0xc4>
c0d0585c:	1d02      	adds	r2, r0, #4
c0d0585e:	6810      	ldr	r0, [r2, #0]
c0d05860:	1840      	adds	r0, r0, r1
    }
    return element;
}

uint32_t bip32_field_add(uint32_t field, int16_t value) {
    return (field + value) & 0x7FFFFFFF;
c0d05862:	3809      	subs	r0, #9
c0d05864:	e00e      	b.n	c0d05884 <view_addr_choose_button+0xb8>
            }
            break;

        case BUTTON_EVT_RELEASED | BUTTON_LEFT:
            // Press left -> previous element
            switch (view_addr_choose_data.status.mode) {
c0d05866:	481e      	ldr	r0, [pc, #120]	; (c0d058e0 <view_addr_choose_button+0x114>)
c0d05868:	7802      	ldrb	r2, [r0, #0]
c0d0586a:	230f      	movs	r3, #15
c0d0586c:	4013      	ands	r3, r2
c0d0586e:	4602      	mov	r2, r0
c0d05870:	3208      	adds	r2, #8
c0d05872:	2b03      	cmp	r3, #3
c0d05874:	d014      	beq.n	c0d058a0 <view_addr_choose_button+0xd4>
c0d05876:	2b01      	cmp	r3, #1
c0d05878:	d002      	beq.n	c0d05880 <view_addr_choose_button+0xb4>
c0d0587a:	2b00      	cmp	r3, #0
c0d0587c:	d108      	bne.n	c0d05890 <view_addr_choose_button+0xc4>
c0d0587e:	1d02      	adds	r2, r0, #4
c0d05880:	6810      	ldr	r0, [r2, #0]
    }
    return element;
}

uint32_t bip32_field_add(uint32_t field, int16_t value) {
    return (field + value) & 0x7FFFFFFF;
c0d05882:	1840      	adds	r0, r0, r1
c0d05884:	4008      	ands	r0, r1
c0d05886:	6010      	str	r0, [r2, #0]

        default:
            return 0;
    }

    view_addr_choose_update();
c0d05888:	f7ff fea6 	bl	c0d055d8 <view_addr_choose_update>
    view_addr_choose_refresh();
c0d0588c:	f000 f830 	bl	c0d058f0 <view_addr_choose_refresh>
    return 0;
}
c0d05890:	2000      	movs	r0, #0
c0d05892:	bd80      	pop	{r7, pc}
c0d05894:	2a02      	cmp	r2, #2
c0d05896:	d00f      	beq.n	c0d058b8 <view_addr_choose_button+0xec>
c0d05898:	2a03      	cmp	r2, #3
c0d0589a:	d1f9      	bne.n	c0d05890 <view_addr_choose_button+0xc4>
#define UIID_MARKER1    0x60
#define UIID_MARKER2    0x61

void accept(unsigned int _) {
    UNUSED(_);
    if (ehAccept != NULL) ehAccept();
c0d0589c:	4811      	ldr	r0, [pc, #68]	; (c0d058e4 <view_addr_choose_button+0x118>)
c0d0589e:	e000      	b.n	c0d058a2 <view_addr_choose_button+0xd6>
}

void reject(unsigned int _) {
    UNUSED(_);
    if (ehReject != NULL) ehReject();
c0d058a0:	4811      	ldr	r0, [pc, #68]	; (c0d058e8 <view_addr_choose_button+0x11c>)
c0d058a2:	6800      	ldr	r0, [r0, #0]
c0d058a4:	2800      	cmp	r0, #0
c0d058a6:	d0f3      	beq.n	c0d05890 <view_addr_choose_button+0xc4>
c0d058a8:	4780      	blx	r0
c0d058aa:	e7f1      	b.n	c0d05890 <view_addr_choose_button+0xc4>
c0d058ac:	1d18      	adds	r0, r3, #4
c0d058ae:	6802      	ldr	r2, [r0, #0]
    }
    return element;
}

uint32_t bip32_field_add(uint32_t field, int16_t value) {
    return (field + value) & 0x7FFFFFFF;
c0d058b0:	1c52      	adds	r2, r2, #1
c0d058b2:	400a      	ands	r2, r1
c0d058b4:	6002      	str	r2, [r0, #0]
c0d058b6:	e7e7      	b.n	c0d05888 <view_addr_choose_button+0xbc>
    UX_INIT();
}

void view_idle(unsigned int ignored) {
#if defined(TARGET_NANOS)
    UX_MENU_DISPLAY(0, menu_main, NULL);
c0d058b8:	490c      	ldr	r1, [pc, #48]	; (c0d058ec <view_addr_choose_button+0x120>)
c0d058ba:	4479      	add	r1, pc
c0d058bc:	2000      	movs	r0, #0
c0d058be:	4602      	mov	r2, r0
c0d058c0:	f7fc ff0a 	bl	c0d026d8 <ux_menu_display>
c0d058c4:	e7e4      	b.n	c0d05890 <view_addr_choose_button+0xc4>
c0d058c6:	46c0      	nop			; (mov r8, r8)
c0d058c8:	7fffffff 	.word	0x7fffffff
c0d058cc:	80000002 	.word	0x80000002
c0d058d0:	40000002 	.word	0x40000002
c0d058d4:	40000001 	.word	0x40000001
c0d058d8:	80000003 	.word	0x80000003
c0d058dc:	80000001 	.word	0x80000001
c0d058e0:	200022a0 	.word	0x200022a0
c0d058e4:	20002298 	.word	0x20002298
c0d058e8:	2000229c 	.word	0x2000229c
c0d058ec:	00002126 	.word	0x00002126

c0d058f0 <view_addr_choose_refresh>:
    }

    viewctl_dataValue_split();
}

void view_addr_choose_refresh() {
c0d058f0:	b5b0      	push	{r4, r5, r7, lr}
    UX_DISPLAY(view_addr_choose, view_addr_choose_prepro);
c0d058f2:	4c22      	ldr	r4, [pc, #136]	; (c0d0597c <view_addr_choose_refresh+0x8c>)
c0d058f4:	4823      	ldr	r0, [pc, #140]	; (c0d05984 <view_addr_choose_refresh+0x94>)
c0d058f6:	4478      	add	r0, pc
c0d058f8:	6020      	str	r0, [r4, #0]
c0d058fa:	200a      	movs	r0, #10
c0d058fc:	6060      	str	r0, [r4, #4]
c0d058fe:	4822      	ldr	r0, [pc, #136]	; (c0d05988 <view_addr_choose_refresh+0x98>)
c0d05900:	4478      	add	r0, pc
c0d05902:	6120      	str	r0, [r4, #16]
c0d05904:	4821      	ldr	r0, [pc, #132]	; (c0d0598c <view_addr_choose_refresh+0x9c>)
c0d05906:	4478      	add	r0, pc
c0d05908:	60e0      	str	r0, [r4, #12]
c0d0590a:	2003      	movs	r0, #3
c0d0590c:	7620      	strb	r0, [r4, #24]
c0d0590e:	2500      	movs	r5, #0
c0d05910:	61e5      	str	r5, [r4, #28]
c0d05912:	4620      	mov	r0, r4
c0d05914:	3018      	adds	r0, #24
c0d05916:	f7fd fc03 	bl	c0d03120 <os_ux>
c0d0591a:	61e0      	str	r0, [r4, #28]
c0d0591c:	f7fc ff6a 	bl	c0d027f4 <ux_check_status_default>
c0d05920:	f7fc fa26 	bl	c0d01d70 <io_seproxyhal_init_ux>
c0d05924:	f7fc fa2a 	bl	c0d01d7c <io_seproxyhal_init_button>
c0d05928:	60a5      	str	r5, [r4, #8]
c0d0592a:	6820      	ldr	r0, [r4, #0]
c0d0592c:	2800      	cmp	r0, #0
c0d0592e:	d024      	beq.n	c0d0597a <view_addr_choose_refresh+0x8a>
c0d05930:	69e0      	ldr	r0, [r4, #28]
c0d05932:	4913      	ldr	r1, [pc, #76]	; (c0d05980 <view_addr_choose_refresh+0x90>)
c0d05934:	4288      	cmp	r0, r1
c0d05936:	d11e      	bne.n	c0d05976 <view_addr_choose_refresh+0x86>
c0d05938:	e01f      	b.n	c0d0597a <view_addr_choose_refresh+0x8a>
c0d0593a:	6860      	ldr	r0, [r4, #4]
c0d0593c:	4285      	cmp	r5, r0
c0d0593e:	d21c      	bcs.n	c0d0597a <view_addr_choose_refresh+0x8a>
c0d05940:	f7fd fc78 	bl	c0d03234 <io_seproxyhal_spi_is_status_sent>
c0d05944:	2800      	cmp	r0, #0
c0d05946:	d118      	bne.n	c0d0597a <view_addr_choose_refresh+0x8a>
c0d05948:	68a0      	ldr	r0, [r4, #8]
c0d0594a:	68e1      	ldr	r1, [r4, #12]
c0d0594c:	2538      	movs	r5, #56	; 0x38
c0d0594e:	4368      	muls	r0, r5
c0d05950:	6822      	ldr	r2, [r4, #0]
c0d05952:	1810      	adds	r0, r2, r0
c0d05954:	2900      	cmp	r1, #0
c0d05956:	d002      	beq.n	c0d0595e <view_addr_choose_refresh+0x6e>
c0d05958:	4788      	blx	r1
c0d0595a:	2800      	cmp	r0, #0
c0d0595c:	d007      	beq.n	c0d0596e <view_addr_choose_refresh+0x7e>
c0d0595e:	2801      	cmp	r0, #1
c0d05960:	d103      	bne.n	c0d0596a <view_addr_choose_refresh+0x7a>
c0d05962:	68a0      	ldr	r0, [r4, #8]
c0d05964:	4345      	muls	r5, r0
c0d05966:	6820      	ldr	r0, [r4, #0]
c0d05968:	1940      	adds	r0, r0, r5
////////////////////////////////
////////////////////////////////
////////////////////////////////

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *) element);
c0d0596a:	f7fc fb55 	bl	c0d02018 <io_seproxyhal_display_default>

    viewctl_dataValue_split();
}

void view_addr_choose_refresh() {
    UX_DISPLAY(view_addr_choose, view_addr_choose_prepro);
c0d0596e:	68a0      	ldr	r0, [r4, #8]
c0d05970:	1c45      	adds	r5, r0, #1
c0d05972:	60a5      	str	r5, [r4, #8]
c0d05974:	6820      	ldr	r0, [r4, #0]
c0d05976:	2800      	cmp	r0, #0
c0d05978:	d1df      	bne.n	c0d0593a <view_addr_choose_refresh+0x4a>
}
c0d0597a:	bdb0      	pop	{r4, r5, r7, pc}
c0d0597c:	200022ac 	.word	0x200022ac
c0d05980:	b0105044 	.word	0xb0105044
c0d05984:	000021ae 	.word	0x000021ae
c0d05988:	fffffec9 	.word	0xfffffec9
c0d0598c:	fffffbe7 	.word	0xfffffbe7

c0d05990 <view_addr_confirm>:
    // Now show view
    view_addr_choose_update();
    view_addr_choose_refresh();
}

void view_addr_confirm(unsigned int _) {
c0d05990:	b580      	push	{r7, lr}
    view_addr_choose_data.status.mode = VIEW_ADDR_MODE_CONFIRM;
c0d05992:	480a      	ldr	r0, [pc, #40]	; (c0d059bc <view_addr_confirm+0x2c>)
c0d05994:	7801      	ldrb	r1, [r0, #0]
c0d05996:	22f0      	movs	r2, #240	; 0xf0
c0d05998:	400a      	ands	r2, r1
c0d0599a:	2103      	movs	r1, #3
c0d0599c:	4311      	orrs	r1, r2
c0d0599e:	7001      	strb	r1, [r0, #0]
    view_addr_choose_data.account = BIP32_ACCOUNT;
c0d059a0:	4907      	ldr	r1, [pc, #28]	; (c0d059c0 <view_addr_confirm+0x30>)
c0d059a2:	688a      	ldr	r2, [r1, #8]
    view_addr_choose_data.index = BIP32_INDEX;
c0d059a4:	4b07      	ldr	r3, [pc, #28]	; (c0d059c4 <view_addr_confirm+0x34>)
    view_addr_choose_refresh();
}

void view_addr_confirm(unsigned int _) {
    view_addr_choose_data.status.mode = VIEW_ADDR_MODE_CONFIRM;
    view_addr_choose_data.account = BIP32_ACCOUNT;
c0d059a6:	401a      	ands	r2, r3
c0d059a8:	6042      	str	r2, [r0, #4]
    view_addr_choose_data.index = BIP32_INDEX;
c0d059aa:	6909      	ldr	r1, [r1, #16]
c0d059ac:	4019      	ands	r1, r3
c0d059ae:	6081      	str	r1, [r0, #8]
    view_addr_choose_update();
c0d059b0:	f7ff fe12 	bl	c0d055d8 <view_addr_choose_update>

#if defined(TARGET_NANOS)
    view_addr_choose_refresh();
c0d059b4:	f7ff ff9c 	bl	c0d058f0 <view_addr_choose_refresh>
    if(G_ux.stack_count == 0) {
        ux_stack_push();
    }
    ux_flow_init(0, ux_addr_flow, NULL);
#endif
}
c0d059b8:	bd80      	pop	{r7, pc}
c0d059ba:	46c0      	nop			; (mov r8, r8)
c0d059bc:	200022a0 	.word	0x200022a0
c0d059c0:	20001898 	.word	0x20001898
c0d059c4:	07ffffff 	.word	0x07ffffff

c0d059c8 <view_set_handlers>:
}

void view_set_handlers(viewctl_delegate_getData func_getData,
                       viewctl_delegate_accept func_accept,
                       viewctl_delegate_reject func_reject) {
    ehGetData = func_getData;
c0d059c8:	4b03      	ldr	r3, [pc, #12]	; (c0d059d8 <view_set_handlers+0x10>)
c0d059ca:	6018      	str	r0, [r3, #0]
    ehAccept = func_accept;
c0d059cc:	4803      	ldr	r0, [pc, #12]	; (c0d059dc <view_set_handlers+0x14>)
c0d059ce:	6001      	str	r1, [r0, #0]
    ehReject = func_reject;
c0d059d0:	4803      	ldr	r0, [pc, #12]	; (c0d059e0 <view_set_handlers+0x18>)
c0d059d2:	6002      	str	r2, [r0, #0]
}
c0d059d4:	4770      	bx	lr
c0d059d6:	46c0      	nop			; (mov r8, r8)
c0d059d8:	20002294 	.word	0x20002294
c0d059dc:	20002298 	.word	0x20002298
c0d059e0:	2000229c 	.word	0x2000229c

c0d059e4 <viewctl_start>:

void viewctl_start(int start_page,
                   viewctl_delegate_getData func_getData,
                   viewctl_delegate_ready ehReady,
                   viewctl_delegate_exit ehExit,
                   viewctl_delegate_display_ux func_display_ux) {
c0d059e4:	b510      	push	{r4, lr}
    // set handlers
    viewctl_ehGetData = func_getData;
c0d059e6:	4c0c      	ldr	r4, [pc, #48]	; (c0d05a18 <viewctl_start+0x34>)
c0d059e8:	6021      	str	r1, [r4, #0]
    viewctl_ehReady = ehReady;
c0d059ea:	4c0c      	ldr	r4, [pc, #48]	; (c0d05a1c <viewctl_start+0x38>)
c0d059ec:	6022      	str	r2, [r4, #0]
    viewctl_ehExit = ehExit;
c0d059ee:	490c      	ldr	r1, [pc, #48]	; (c0d05a20 <viewctl_start+0x3c>)
c0d059f0:	600b      	str	r3, [r1, #0]
    viewctl_display_ux = func_display_ux;
c0d059f2:	490c      	ldr	r1, [pc, #48]	; (c0d05a24 <viewctl_start+0x40>)
c0d059f4:	9a02      	ldr	r2, [sp, #8]
c0d059f6:	600a      	str	r2, [r1, #0]

    // initialize variables
    viewctl.scrolling_mode = PENDING;
c0d059f8:	490b      	ldr	r1, [pc, #44]	; (c0d05a28 <viewctl_start+0x44>)
c0d059fa:	2203      	movs	r2, #3
c0d059fc:	700a      	strb	r2, [r1, #0]
    viewctl.detailsCurrentPage = start_page;
c0d059fe:	8048      	strh	r0, [r1, #2]
c0d05a00:	2000      	movs	r0, #0
    viewctl.chunksIndex = 0;
c0d05a02:	80c8      	strh	r0, [r1, #6]
    viewctl.chunksCount = 1;
c0d05a04:	2001      	movs	r0, #1
c0d05a06:	8108      	strh	r0, [r1, #8]

    viewctl_display_page();
c0d05a08:	f000 f862 	bl	c0d05ad0 <viewctl_display_page>
    if (viewctl_ehReady != NULL) {
c0d05a0c:	6821      	ldr	r1, [r4, #0]
c0d05a0e:	2900      	cmp	r1, #0
c0d05a10:	d001      	beq.n	c0d05a16 <viewctl_start+0x32>
        viewctl_ehReady(0);
c0d05a12:	2000      	movs	r0, #0
c0d05a14:	4788      	blx	r1
    }
}
c0d05a16:	bd10      	pop	{r4, pc}
c0d05a18:	2000235c 	.word	0x2000235c
c0d05a1c:	20002360 	.word	0x20002360
c0d05a20:	20002364 	.word	0x20002364
c0d05a24:	20002368 	.word	0x20002368
c0d05a28:	2000236c 	.word	0x2000236c

c0d05a2c <submenu_left>:
            break;
    }
    return element;
}

void submenu_left() {
c0d05a2c:	b580      	push	{r7, lr}
    viewctl.chunksIndex--;
c0d05a2e:	4804      	ldr	r0, [pc, #16]	; (c0d05a40 <submenu_left+0x14>)
c0d05a30:	88c1      	ldrh	r1, [r0, #6]
c0d05a32:	1e49      	subs	r1, r1, #1
c0d05a34:	80c1      	strh	r1, [r0, #6]
    viewctl.scrolling_mode = PENDING;
c0d05a36:	2103      	movs	r1, #3
c0d05a38:	7001      	strb	r1, [r0, #0]
    viewctl_display_page();
c0d05a3a:	f000 f849 	bl	c0d05ad0 <viewctl_display_page>
}
c0d05a3e:	bd80      	pop	{r7, pc}
c0d05a40:	2000236c 	.word	0x2000236c

c0d05a44 <submenu_right>:

void submenu_right() {
c0d05a44:	b580      	push	{r7, lr}
    viewctl.chunksIndex++;
c0d05a46:	4804      	ldr	r0, [pc, #16]	; (c0d05a58 <submenu_right+0x14>)
c0d05a48:	88c1      	ldrh	r1, [r0, #6]
c0d05a4a:	1c49      	adds	r1, r1, #1
c0d05a4c:	80c1      	strh	r1, [r0, #6]
    viewctl.scrolling_mode = PENDING;
c0d05a4e:	2103      	movs	r1, #3
c0d05a50:	7001      	strb	r1, [r0, #0]
    viewctl_display_page();
c0d05a52:	f000 f83d 	bl	c0d05ad0 <viewctl_display_page>
}
c0d05a56:	bd80      	pop	{r7, pc}
c0d05a58:	2000236c 	.word	0x2000236c

c0d05a5c <menu_left>:

void menu_left() {
c0d05a5c:	b580      	push	{r7, lr}
    viewctl.scrolling_mode = PENDING;
c0d05a5e:	480a      	ldr	r0, [pc, #40]	; (c0d05a88 <menu_left+0x2c>)
c0d05a60:	2103      	movs	r1, #3
c0d05a62:	7001      	strb	r1, [r0, #0]
    viewctl.chunksIndex = 0;
c0d05a64:	2100      	movs	r1, #0
c0d05a66:	80c1      	strh	r1, [r0, #6]
c0d05a68:	2101      	movs	r1, #1
    viewctl.chunksCount = 1;
c0d05a6a:	8101      	strh	r1, [r0, #8]
    if (viewctl.detailsCurrentPage > 0) {
c0d05a6c:	2102      	movs	r1, #2
c0d05a6e:	5e41      	ldrsh	r1, [r0, r1]
c0d05a70:	2901      	cmp	r1, #1
c0d05a72:	db04      	blt.n	c0d05a7e <menu_left+0x22>
        viewctl.detailsCurrentPage--;
c0d05a74:	1e49      	subs	r1, r1, #1
c0d05a76:	8041      	strh	r1, [r0, #2]
        viewctl_display_page();
c0d05a78:	f000 f82a 	bl	c0d05ad0 <viewctl_display_page>
    } else {
        viewctl_ehExit(0);
    }
}
c0d05a7c:	bd80      	pop	{r7, pc}
    viewctl.chunksCount = 1;
    if (viewctl.detailsCurrentPage > 0) {
        viewctl.detailsCurrentPage--;
        viewctl_display_page();
    } else {
        viewctl_ehExit(0);
c0d05a7e:	4803      	ldr	r0, [pc, #12]	; (c0d05a8c <menu_left+0x30>)
c0d05a80:	6801      	ldr	r1, [r0, #0]
c0d05a82:	2000      	movs	r0, #0
c0d05a84:	4788      	blx	r1
    }
}
c0d05a86:	bd80      	pop	{r7, pc}
c0d05a88:	2000236c 	.word	0x2000236c
c0d05a8c:	20002364 	.word	0x20002364

c0d05a90 <menu_right>:

void menu_right() {
c0d05a90:	b580      	push	{r7, lr}
    viewctl.scrolling_mode = PENDING;
c0d05a92:	480c      	ldr	r0, [pc, #48]	; (c0d05ac4 <menu_right+0x34>)
c0d05a94:	2103      	movs	r1, #3
c0d05a96:	7001      	strb	r1, [r0, #0]
    viewctl.chunksIndex = 0;
c0d05a98:	2100      	movs	r1, #0
c0d05a9a:	80c1      	strh	r1, [r0, #6]
    viewctl.chunksCount = 1;
c0d05a9c:	2101      	movs	r1, #1
c0d05a9e:	8101      	strh	r1, [r0, #8]
    if (viewctl.detailsCurrentPage < viewctl.detailsPageCount - 1) {
c0d05aa0:	2102      	movs	r1, #2
c0d05aa2:	5e41      	ldrsh	r1, [r0, r1]
c0d05aa4:	2204      	movs	r2, #4
c0d05aa6:	5e82      	ldrsh	r2, [r0, r2]
c0d05aa8:	1e52      	subs	r2, r2, #1
c0d05aaa:	4291      	cmp	r1, r2
c0d05aac:	da05      	bge.n	c0d05aba <menu_right+0x2a>
c0d05aae:	b289      	uxth	r1, r1
        viewctl.detailsCurrentPage++;
c0d05ab0:	1c49      	adds	r1, r1, #1
c0d05ab2:	8041      	strh	r1, [r0, #2]
        viewctl_display_page();
c0d05ab4:	f000 f80c 	bl	c0d05ad0 <viewctl_display_page>
    } else {
        viewctl_ehExit(0);
    }
}
c0d05ab8:	bd80      	pop	{r7, pc}
    viewctl.chunksCount = 1;
    if (viewctl.detailsCurrentPage < viewctl.detailsPageCount - 1) {
        viewctl.detailsCurrentPage++;
        viewctl_display_page();
    } else {
        viewctl_ehExit(0);
c0d05aba:	4803      	ldr	r0, [pc, #12]	; (c0d05ac8 <menu_right+0x38>)
c0d05abc:	6801      	ldr	r1, [r0, #0]
c0d05abe:	2000      	movs	r0, #0
c0d05ac0:	4788      	blx	r1
    }
}
c0d05ac2:	bd80      	pop	{r7, pc}
c0d05ac4:	2000236c 	.word	0x2000236c
c0d05ac8:	20002364 	.word	0x20002364

c0d05acc <viewctl_dataValue_split>:
            snprintf((char *) viewctl.dataValueChunk[i], MAX_SCREEN_LINE_WIDTH, "%s", viewctl.dataValue + offset);
        }
        offset += (MAX_SCREEN_LINE_WIDTH - 1);
    }
#endif
}
c0d05acc:	4770      	bx	lr
	...

c0d05ad0 <viewctl_display_page>:

void viewctl_display_page() {
c0d05ad0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d05ad2:	b08b      	sub	sp, #44	; 0x2c
    if (viewctl_ehGetData == NULL) {
c0d05ad4:	483e      	ldr	r0, [pc, #248]	; (c0d05bd0 <viewctl_display_page+0x100>)
c0d05ad6:	6800      	ldr	r0, [r0, #0]
c0d05ad8:	2800      	cmp	r0, #0
c0d05ada:	d077      	beq.n	c0d05bcc <viewctl_display_page+0xfc>
        return;
    }

    strcpy(viewctl.title, "?");
c0d05adc:	4c3d      	ldr	r4, [pc, #244]	; (c0d05bd4 <viewctl_display_page+0x104>)
c0d05ade:	900a      	str	r0, [sp, #40]	; 0x28
c0d05ae0:	203f      	movs	r0, #63	; 0x3f
c0d05ae2:	8160      	strh	r0, [r4, #10]
c0d05ae4:	2200      	movs	r2, #0
    strcpy(viewctl.dataKey, "?");
c0d05ae6:	77a2      	strb	r2, [r4, #30]
c0d05ae8:	7760      	strb	r0, [r4, #29]
    strcpy(viewctl.dataValue, "?");
c0d05aea:	215e      	movs	r1, #94	; 0x5e
c0d05aec:	9209      	str	r2, [sp, #36]	; 0x24
c0d05aee:	5462      	strb	r2, [r4, r1]
c0d05af0:	215d      	movs	r1, #93	; 0x5d
c0d05af2:	5460      	strb	r0, [r4, r1]
    // Read key and value strings from json
    viewctl_ehGetData(
            (char *) viewctl.title, sizeof(viewctl.title),
            (char *) viewctl.dataKey, sizeof(viewctl.dataKey),
            (char *) viewctl.dataValue, sizeof(viewctl.dataValue),
            viewctl.detailsCurrentPage, viewctl.chunksIndex,
c0d05af4:	2002      	movs	r0, #2
c0d05af6:	9006      	str	r0, [sp, #24]
    strcpy(viewctl.title, "?");
    strcpy(viewctl.dataKey, "?");
    strcpy(viewctl.dataValue, "?");

    // Read key and value strings from json
    viewctl_ehGetData(
c0d05af8:	5e20      	ldrsh	r0, [r4, r0]
            (char *) viewctl.title, sizeof(viewctl.title),
            (char *) viewctl.dataKey, sizeof(viewctl.dataKey),
            (char *) viewctl.dataValue, sizeof(viewctl.dataValue),
            viewctl.detailsCurrentPage, viewctl.chunksIndex,
c0d05afa:	2106      	movs	r1, #6
c0d05afc:	9108      	str	r1, [sp, #32]
    strcpy(viewctl.title, "?");
    strcpy(viewctl.dataKey, "?");
    strcpy(viewctl.dataValue, "?");

    // Read key and value strings from json
    viewctl_ehGetData(
c0d05afe:	5e61      	ldrsh	r1, [r4, r1]
c0d05b00:	4622      	mov	r2, r4
c0d05b02:	3208      	adds	r2, #8
c0d05b04:	466b      	mov	r3, sp
c0d05b06:	1d25      	adds	r5, r4, #4
c0d05b08:	27c0      	movs	r7, #192	; 0xc0
        return;
    }

    strcpy(viewctl.title, "?");
    strcpy(viewctl.dataKey, "?");
    strcpy(viewctl.dataValue, "?");
c0d05b0a:	4626      	mov	r6, r4
c0d05b0c:	365d      	adds	r6, #93	; 0x5d

    // Read key and value strings from json
    viewctl_ehGetData(
c0d05b0e:	c3c0      	stmia	r3!, {r6, r7}
c0d05b10:	3b08      	subs	r3, #8
c0d05b12:	461f      	mov	r7, r3
c0d05b14:	3708      	adds	r7, #8
c0d05b16:	c723      	stmia	r7!, {r0, r1, r5}
c0d05b18:	615a      	str	r2, [r3, #20]
c0d05b1a:	4625      	mov	r5, r4
void viewctl_display_page() {
    if (viewctl_ehGetData == NULL) {
        return;
    }

    strcpy(viewctl.title, "?");
c0d05b1c:	462f      	mov	r7, r5
c0d05b1e:	370a      	adds	r7, #10
    strcpy(viewctl.dataKey, "?");
c0d05b20:	351d      	adds	r5, #29
    strcpy(viewctl.dataValue, "?");

    // Read key and value strings from json
    viewctl_ehGetData(
c0d05b22:	2113      	movs	r1, #19
c0d05b24:	2340      	movs	r3, #64	; 0x40
c0d05b26:	4638      	mov	r0, r7
c0d05b28:	462a      	mov	r2, r5
c0d05b2a:	9307      	str	r3, [sp, #28]
c0d05b2c:	9c0a      	ldr	r4, [sp, #40]	; 0x28
c0d05b2e:	47a0      	blx	r4
            (char *) viewctl.dataValue, sizeof(viewctl.dataValue),
            viewctl.detailsCurrentPage, viewctl.chunksIndex,
            &viewctl.detailsPageCount, &viewctl.chunksCount);

    // fix possible utf8 issues
    asciify((char *) viewctl.title);
c0d05b30:	4638      	mov	r0, r7
c0d05b32:	f000 fa10 	bl	c0d05f56 <asciify>
    asciify((char *) viewctl.dataKey);
c0d05b36:	4628      	mov	r0, r5
c0d05b38:	f000 fa0d 	bl	c0d05f56 <asciify>
c0d05b3c:	960a      	str	r6, [sp, #40]	; 0x28
    asciify((char *) viewctl.dataValue);
c0d05b3e:	4630      	mov	r0, r6
c0d05b40:	4e24      	ldr	r6, [pc, #144]	; (c0d05bd4 <viewctl_display_page+0x104>)
c0d05b42:	f000 fa08 	bl	c0d05f56 <asciify>
c0d05b46:	2008      	movs	r0, #8

    if (viewctl.chunksCount > 0) {
c0d05b48:	5e34      	ldrsh	r4, [r6, r0]
c0d05b4a:	2c01      	cmp	r4, #1
c0d05b4c:	db3b      	blt.n	c0d05bc6 <viewctl_display_page+0xf6>
c0d05b4e:	d00e      	beq.n	c0d05b6e <viewctl_display_page+0x9e>
        // If value is very long, we split it into chunks
        // and add chunk index/count information at the end of the key
        if (viewctl.chunksCount > 1) {
            int position = strlen((char *) viewctl.dataKey);
c0d05b50:	4628      	mov	r0, r5
c0d05b52:	f000 fc95 	bl	c0d06480 <strlen>
            snprintf((char *) viewctl.dataKey + position,
                     sizeof(viewctl.dataKey) - position,
                     " %d/%d",
                     viewctl.chunksIndex + 1,
c0d05b56:	9908      	ldr	r1, [sp, #32]
c0d05b58:	5e72      	ldrsh	r2, [r6, r1]
    if (viewctl.chunksCount > 0) {
        // If value is very long, we split it into chunks
        // and add chunk index/count information at the end of the key
        if (viewctl.chunksCount > 1) {
            int position = strlen((char *) viewctl.dataKey);
            snprintf((char *) viewctl.dataKey + position,
c0d05b5a:	4669      	mov	r1, sp
c0d05b5c:	600c      	str	r4, [r1, #0]
c0d05b5e:	182f      	adds	r7, r5, r0
                     sizeof(viewctl.dataKey) - position,
c0d05b60:	9907      	ldr	r1, [sp, #28]
c0d05b62:	1a09      	subs	r1, r1, r0
                     " %d/%d",
                     viewctl.chunksIndex + 1,
c0d05b64:	1c53      	adds	r3, r2, #1
    if (viewctl.chunksCount > 0) {
        // If value is very long, we split it into chunks
        // and add chunk index/count information at the end of the key
        if (viewctl.chunksCount > 1) {
            int position = strlen((char *) viewctl.dataKey);
            snprintf((char *) viewctl.dataKey + position,
c0d05b66:	a21c      	add	r2, pc, #112	; (adr r2, c0d05bd8 <viewctl_display_page+0x108>)
c0d05b68:	4638      	mov	r0, r7
c0d05b6a:	f7fc fe45 	bl	c0d027f8 <snprintf>
        }

#if defined(TARGET_NANOX)
        viewctl_dataValue_split();
#elif defined(TARGET_NANOS)
        switch (viewctl.scrolling_mode) {
c0d05b6e:	7830      	ldrb	r0, [r6, #0]
c0d05b70:	2803      	cmp	r0, #3
c0d05b72:	d012      	beq.n	c0d05b9a <viewctl_display_page+0xca>
c0d05b74:	2801      	cmp	r0, #1
c0d05b76:	d126      	bne.n	c0d05bc6 <viewctl_display_page+0xf6>
        viewctl_ehExit(0);
    }
}

void viewctl_crop_key() {
    int offset = strlen((char *) viewctl.dataKey) - MAX_SCREEN_LINE_WIDTH;
c0d05b78:	4628      	mov	r0, r5
c0d05b7a:	f000 fc81 	bl	c0d06480 <strlen>
c0d05b7e:	4601      	mov	r1, r0
c0d05b80:	3913      	subs	r1, #19
    if (offset > 0) {
c0d05b82:	2901      	cmp	r1, #1
c0d05b84:	db07      	blt.n	c0d05b96 <viewctl_display_page+0xc6>
        char *start = (char *) viewctl.dataKey;
        for (;;) {
            *start = start[offset];
c0d05b86:	1829      	adds	r1, r5, r0
c0d05b88:	2212      	movs	r2, #18
c0d05b8a:	43d2      	mvns	r2, r2
c0d05b8c:	5c89      	ldrb	r1, [r1, r2]
c0d05b8e:	7029      	strb	r1, [r5, #0]
            if (*start++ == '\0')
c0d05b90:	1c6d      	adds	r5, r5, #1
c0d05b92:	2900      	cmp	r1, #0
c0d05b94:	d1f7      	bne.n	c0d05b86 <viewctl_display_page+0xb6>
        viewctl_dataValue_split();
#elif defined(TARGET_NANOS)
        switch (viewctl.scrolling_mode) {
        case KEY_SCROLLING_NO_VALUE: {
            viewctl_crop_key();
            viewctl.scrolling_mode = VALUE_SCROLLING;
c0d05b96:	9809      	ldr	r0, [sp, #36]	; 0x24
c0d05b98:	e014      	b.n	c0d05bc4 <viewctl_display_page+0xf4>
            break;
        }
        case PENDING: {
            viewctl.scrolling_mode = VALUE_SCROLLING;
c0d05b9a:	9809      	ldr	r0, [sp, #36]	; 0x24
c0d05b9c:	7030      	strb	r0, [r6, #0]
            if (strlen((char *) viewctl.dataKey) > MAX_SCREEN_LINE_WIDTH) {
c0d05b9e:	4630      	mov	r0, r6
c0d05ba0:	301d      	adds	r0, #29
c0d05ba2:	f000 fc6d 	bl	c0d06480 <strlen>
c0d05ba6:	2814      	cmp	r0, #20
c0d05ba8:	d30d      	bcc.n	c0d05bc6 <viewctl_display_page+0xf6>
c0d05baa:	9c0a      	ldr	r4, [sp, #40]	; 0x28
                int value_length = strlen((char *) viewctl.dataValue);
c0d05bac:	4620      	mov	r0, r4
c0d05bae:	f000 fc67 	bl	c0d06480 <strlen>
                if (value_length > MAX_SCREEN_LINE_WIDTH) {
c0d05bb2:	2814      	cmp	r0, #20
c0d05bb4:	9806      	ldr	r0, [sp, #24]
c0d05bb6:	db05      	blt.n	c0d05bc4 <viewctl_display_page+0xf4>
                    strcpy((char *) viewctl.dataValue, "DBL-CLICK FOR VALUE");
c0d05bb8:	a109      	add	r1, pc, #36	; (adr r1, c0d05be0 <viewctl_display_page+0x110>)
c0d05bba:	2214      	movs	r2, #20
c0d05bbc:	4620      	mov	r0, r4
c0d05bbe:	f000 fb71 	bl	c0d062a4 <__aeabi_memcpy>
c0d05bc2:	2001      	movs	r0, #1
c0d05bc4:	7030      	strb	r0, [r6, #0]
            break;
    }
#endif
    }

    viewctl_display_ux();
c0d05bc6:	480b      	ldr	r0, [pc, #44]	; (c0d05bf4 <viewctl_display_page+0x124>)
c0d05bc8:	6800      	ldr	r0, [r0, #0]
c0d05bca:	4780      	blx	r0
}
c0d05bcc:	b00b      	add	sp, #44	; 0x2c
c0d05bce:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d05bd0:	2000235c 	.word	0x2000235c
c0d05bd4:	2000236c 	.word	0x2000236c
c0d05bd8:	2f642520 	.word	0x2f642520
c0d05bdc:	00006425 	.word	0x00006425
c0d05be0:	2d4c4244 	.word	0x2d4c4244
c0d05be4:	43494c43 	.word	0x43494c43
c0d05be8:	4f46204b 	.word	0x4f46204b
c0d05bec:	41562052 	.word	0x41562052
c0d05bf0:	0045554c 	.word	0x0045554c
c0d05bf4:	20002368 	.word	0x20002368

c0d05bf8 <viewexpl_bagl_prepro>:
    return viewexpl_bagl_keyscrolling_button(button_mask, button_mask_counter);
}

#endif

const bagl_element_t *viewexpl_bagl_prepro(const bagl_element_t *element) {
c0d05bf8:	b5b0      	push	{r4, r5, r7, lr}
c0d05bfa:	4604      	mov	r4, r0
c0d05bfc:	257d      	movs	r5, #125	; 0x7d
c0d05bfe:	0128      	lsls	r0, r5, #4
c0d05c00:	7861      	ldrb	r1, [r4, #1]
    switch (element->component.userid) {
c0d05c02:	460a      	mov	r2, r1
c0d05c04:	3a10      	subs	r2, #16
c0d05c06:	2a02      	cmp	r2, #2
c0d05c08:	d30f      	bcc.n	c0d05c2a <viewexpl_bagl_prepro+0x32>
c0d05c0a:	2971      	cmp	r1, #113	; 0x71
c0d05c0c:	d10f      	bne.n	c0d05c2e <viewexpl_bagl_prepro+0x36>
            break;
        case UIID_ICONRIGHT:
            UX_CALLBACK_SET_INTERVAL(2000);
            break;
        case UIID_LABELSCROLL:
            UX_CALLBACK_SET_INTERVAL(MAX(3000, 1000 + bagl_label_roundtrip_duration_ms(element, 7)));
c0d05c0e:	2107      	movs	r1, #7
c0d05c10:	4620      	mov	r0, r4
c0d05c12:	f7fc fa43 	bl	c0d0209c <bagl_label_roundtrip_duration_ms>
c0d05c16:	00ed      	lsls	r5, r5, #3
c0d05c18:	1941      	adds	r1, r0, r5
c0d05c1a:	4806      	ldr	r0, [pc, #24]	; (c0d05c34 <viewexpl_bagl_prepro+0x3c>)
c0d05c1c:	4281      	cmp	r1, r0
c0d05c1e:	d304      	bcc.n	c0d05c2a <viewexpl_bagl_prepro+0x32>
c0d05c20:	2107      	movs	r1, #7
c0d05c22:	4620      	mov	r0, r4
c0d05c24:	f7fc fa3a 	bl	c0d0209c <bagl_label_roundtrip_duration_ms>
c0d05c28:	1940      	adds	r0, r0, r5
c0d05c2a:	4903      	ldr	r1, [pc, #12]	; (c0d05c38 <viewexpl_bagl_prepro+0x40>)
c0d05c2c:	6148      	str	r0, [r1, #20]
            break;
    }
    return element;
c0d05c2e:	4620      	mov	r0, r4
c0d05c30:	bdb0      	pop	{r4, r5, r7, pc}
c0d05c32:	46c0      	nop			; (mov r8, r8)
c0d05c34:	00000bb8 	.word	0x00000bb8
c0d05c38:	200022ac 	.word	0x200022ac

c0d05c3c <viewexpl_display_ux>:
}

void viewexpl_display_ux() {
c0d05c3c:	b5b0      	push	{r4, r5, r7, lr}
#if defined(TARGET_NANOX)
    UX_DISPLAY(viewexpl_bagl, viewexpl_bagl_prepro);
#else
    if (viewctl.scrolling_mode == VALUE_SCROLLING) {
c0d05c3e:	4846      	ldr	r0, [pc, #280]	; (c0d05d58 <viewexpl_display_ux+0x11c>)
c0d05c40:	7800      	ldrb	r0, [r0, #0]
        UX_DISPLAY(viewexpl_bagl_valuescrolling, viewexpl_bagl_prepro);
    } else {
        UX_DISPLAY(viewexpl_bagl_keyscrolling, viewexpl_bagl_prepro);
c0d05c42:	4c46      	ldr	r4, [pc, #280]	; (c0d05d5c <viewexpl_display_ux+0x120>)

void viewexpl_display_ux() {
#if defined(TARGET_NANOX)
    UX_DISPLAY(viewexpl_bagl, viewexpl_bagl_prepro);
#else
    if (viewctl.scrolling_mode == VALUE_SCROLLING) {
c0d05c44:	2800      	cmp	r0, #0
c0d05c46:	d043      	beq.n	c0d05cd0 <viewexpl_display_ux+0x94>
        UX_DISPLAY(viewexpl_bagl_valuescrolling, viewexpl_bagl_prepro);
    } else {
        UX_DISPLAY(viewexpl_bagl_keyscrolling, viewexpl_bagl_prepro);
c0d05c48:	4849      	ldr	r0, [pc, #292]	; (c0d05d70 <viewexpl_display_ux+0x134>)
c0d05c4a:	4478      	add	r0, pc
c0d05c4c:	6020      	str	r0, [r4, #0]
c0d05c4e:	2006      	movs	r0, #6
c0d05c50:	6060      	str	r0, [r4, #4]
c0d05c52:	4848      	ldr	r0, [pc, #288]	; (c0d05d74 <viewexpl_display_ux+0x138>)
c0d05c54:	4478      	add	r0, pc
c0d05c56:	6120      	str	r0, [r4, #16]
c0d05c58:	4847      	ldr	r0, [pc, #284]	; (c0d05d78 <viewexpl_display_ux+0x13c>)
c0d05c5a:	4478      	add	r0, pc
c0d05c5c:	60e0      	str	r0, [r4, #12]
c0d05c5e:	2003      	movs	r0, #3
c0d05c60:	7620      	strb	r0, [r4, #24]
c0d05c62:	2500      	movs	r5, #0
c0d05c64:	61e5      	str	r5, [r4, #28]
c0d05c66:	4620      	mov	r0, r4
c0d05c68:	3018      	adds	r0, #24
c0d05c6a:	f7fd fa59 	bl	c0d03120 <os_ux>
c0d05c6e:	61e0      	str	r0, [r4, #28]
c0d05c70:	f7fc fdc0 	bl	c0d027f4 <ux_check_status_default>
c0d05c74:	f7fc f87c 	bl	c0d01d70 <io_seproxyhal_init_ux>
c0d05c78:	f7fc f880 	bl	c0d01d7c <io_seproxyhal_init_button>
c0d05c7c:	60a5      	str	r5, [r4, #8]
c0d05c7e:	6820      	ldr	r0, [r4, #0]
c0d05c80:	2800      	cmp	r0, #0
c0d05c82:	d068      	beq.n	c0d05d56 <viewexpl_display_ux+0x11a>
c0d05c84:	69e0      	ldr	r0, [r4, #28]
c0d05c86:	4936      	ldr	r1, [pc, #216]	; (c0d05d60 <viewexpl_display_ux+0x124>)
c0d05c88:	4288      	cmp	r0, r1
c0d05c8a:	d11e      	bne.n	c0d05cca <viewexpl_display_ux+0x8e>
c0d05c8c:	e063      	b.n	c0d05d56 <viewexpl_display_ux+0x11a>
c0d05c8e:	6860      	ldr	r0, [r4, #4]
c0d05c90:	4285      	cmp	r5, r0
c0d05c92:	d260      	bcs.n	c0d05d56 <viewexpl_display_ux+0x11a>
c0d05c94:	f7fd face 	bl	c0d03234 <io_seproxyhal_spi_is_status_sent>
c0d05c98:	2800      	cmp	r0, #0
c0d05c9a:	d15c      	bne.n	c0d05d56 <viewexpl_display_ux+0x11a>
c0d05c9c:	68a0      	ldr	r0, [r4, #8]
c0d05c9e:	68e1      	ldr	r1, [r4, #12]
c0d05ca0:	2538      	movs	r5, #56	; 0x38
c0d05ca2:	4368      	muls	r0, r5
c0d05ca4:	6822      	ldr	r2, [r4, #0]
c0d05ca6:	1810      	adds	r0, r2, r0
c0d05ca8:	2900      	cmp	r1, #0
c0d05caa:	d002      	beq.n	c0d05cb2 <viewexpl_display_ux+0x76>
c0d05cac:	4788      	blx	r1
c0d05cae:	2800      	cmp	r0, #0
c0d05cb0:	d007      	beq.n	c0d05cc2 <viewexpl_display_ux+0x86>
c0d05cb2:	2801      	cmp	r0, #1
c0d05cb4:	d103      	bne.n	c0d05cbe <viewexpl_display_ux+0x82>
c0d05cb6:	68a0      	ldr	r0, [r4, #8]
c0d05cb8:	4345      	muls	r5, r0
c0d05cba:	6820      	ldr	r0, [r4, #0]
c0d05cbc:	1940      	adds	r0, r0, r5
c0d05cbe:	f7ff fc69 	bl	c0d05594 <io_seproxyhal_display>
c0d05cc2:	68a0      	ldr	r0, [r4, #8]
c0d05cc4:	1c45      	adds	r5, r0, #1
c0d05cc6:	60a5      	str	r5, [r4, #8]
c0d05cc8:	6820      	ldr	r0, [r4, #0]
c0d05cca:	2800      	cmp	r0, #0
c0d05ccc:	d1df      	bne.n	c0d05c8e <viewexpl_display_ux+0x52>
c0d05cce:	e042      	b.n	c0d05d56 <viewexpl_display_ux+0x11a>
void viewexpl_display_ux() {
#if defined(TARGET_NANOX)
    UX_DISPLAY(viewexpl_bagl, viewexpl_bagl_prepro);
#else
    if (viewctl.scrolling_mode == VALUE_SCROLLING) {
        UX_DISPLAY(viewexpl_bagl_valuescrolling, viewexpl_bagl_prepro);
c0d05cd0:	4824      	ldr	r0, [pc, #144]	; (c0d05d64 <viewexpl_display_ux+0x128>)
c0d05cd2:	4478      	add	r0, pc
c0d05cd4:	6020      	str	r0, [r4, #0]
c0d05cd6:	2006      	movs	r0, #6
c0d05cd8:	6060      	str	r0, [r4, #4]
c0d05cda:	4823      	ldr	r0, [pc, #140]	; (c0d05d68 <viewexpl_display_ux+0x12c>)
c0d05cdc:	4478      	add	r0, pc
c0d05cde:	6120      	str	r0, [r4, #16]
c0d05ce0:	4822      	ldr	r0, [pc, #136]	; (c0d05d6c <viewexpl_display_ux+0x130>)
c0d05ce2:	4478      	add	r0, pc
c0d05ce4:	60e0      	str	r0, [r4, #12]
c0d05ce6:	2003      	movs	r0, #3
c0d05ce8:	7620      	strb	r0, [r4, #24]
c0d05cea:	2500      	movs	r5, #0
c0d05cec:	61e5      	str	r5, [r4, #28]
c0d05cee:	4620      	mov	r0, r4
c0d05cf0:	3018      	adds	r0, #24
c0d05cf2:	f7fd fa15 	bl	c0d03120 <os_ux>
c0d05cf6:	61e0      	str	r0, [r4, #28]
c0d05cf8:	f7fc fd7c 	bl	c0d027f4 <ux_check_status_default>
c0d05cfc:	f7fc f838 	bl	c0d01d70 <io_seproxyhal_init_ux>
c0d05d00:	f7fc f83c 	bl	c0d01d7c <io_seproxyhal_init_button>
c0d05d04:	60a5      	str	r5, [r4, #8]
c0d05d06:	6820      	ldr	r0, [r4, #0]
c0d05d08:	2800      	cmp	r0, #0
c0d05d0a:	d024      	beq.n	c0d05d56 <viewexpl_display_ux+0x11a>
c0d05d0c:	69e0      	ldr	r0, [r4, #28]
c0d05d0e:	4914      	ldr	r1, [pc, #80]	; (c0d05d60 <viewexpl_display_ux+0x124>)
c0d05d10:	4288      	cmp	r0, r1
c0d05d12:	d11e      	bne.n	c0d05d52 <viewexpl_display_ux+0x116>
c0d05d14:	e01f      	b.n	c0d05d56 <viewexpl_display_ux+0x11a>
c0d05d16:	6860      	ldr	r0, [r4, #4]
c0d05d18:	4285      	cmp	r5, r0
c0d05d1a:	d21c      	bcs.n	c0d05d56 <viewexpl_display_ux+0x11a>
c0d05d1c:	f7fd fa8a 	bl	c0d03234 <io_seproxyhal_spi_is_status_sent>
c0d05d20:	2800      	cmp	r0, #0
c0d05d22:	d118      	bne.n	c0d05d56 <viewexpl_display_ux+0x11a>
c0d05d24:	68a0      	ldr	r0, [r4, #8]
c0d05d26:	68e1      	ldr	r1, [r4, #12]
c0d05d28:	2538      	movs	r5, #56	; 0x38
c0d05d2a:	4368      	muls	r0, r5
c0d05d2c:	6822      	ldr	r2, [r4, #0]
c0d05d2e:	1810      	adds	r0, r2, r0
c0d05d30:	2900      	cmp	r1, #0
c0d05d32:	d002      	beq.n	c0d05d3a <viewexpl_display_ux+0xfe>
c0d05d34:	4788      	blx	r1
c0d05d36:	2800      	cmp	r0, #0
c0d05d38:	d007      	beq.n	c0d05d4a <viewexpl_display_ux+0x10e>
c0d05d3a:	2801      	cmp	r0, #1
c0d05d3c:	d103      	bne.n	c0d05d46 <viewexpl_display_ux+0x10a>
c0d05d3e:	68a0      	ldr	r0, [r4, #8]
c0d05d40:	4345      	muls	r5, r0
c0d05d42:	6820      	ldr	r0, [r4, #0]
c0d05d44:	1940      	adds	r0, r0, r5
c0d05d46:	f7ff fc25 	bl	c0d05594 <io_seproxyhal_display>
c0d05d4a:	68a0      	ldr	r0, [r4, #8]
c0d05d4c:	1c45      	adds	r5, r0, #1
c0d05d4e:	60a5      	str	r5, [r4, #8]
c0d05d50:	6820      	ldr	r0, [r4, #0]
c0d05d52:	2800      	cmp	r0, #0
c0d05d54:	d1df      	bne.n	c0d05d16 <viewexpl_display_ux+0xda>
    } else {
        UX_DISPLAY(viewexpl_bagl_keyscrolling, viewexpl_bagl_prepro);
    }
#endif
}
c0d05d56:	bdb0      	pop	{r4, r5, r7, pc}
c0d05d58:	2000236c 	.word	0x2000236c
c0d05d5c:	200022ac 	.word	0x200022ac
c0d05d60:	b0105044 	.word	0xb0105044
c0d05d64:	00002002 	.word	0x00002002
c0d05d68:	0000009d 	.word	0x0000009d
c0d05d6c:	ffffff13 	.word	0xffffff13
c0d05d70:	000021da 	.word	0x000021da
c0d05d74:	00000131 	.word	0x00000131
c0d05d78:	ffffff9b 	.word	0xffffff9b

c0d05d7c <viewexpl_bagl_valuescrolling_button>:
    return 0;
}

static unsigned int viewexpl_bagl_valuescrolling_button(
        unsigned int button_mask,
        unsigned int button_mask_counter) {
c0d05d7c:	b580      	push	{r7, lr}
    return viewexpl_bagl_keyscrolling_button(button_mask, button_mask_counter);
c0d05d7e:	f000 f803 	bl	c0d05d88 <viewexpl_bagl_keyscrolling_button>
c0d05d82:	2000      	movs	r0, #0
c0d05d84:	bd80      	pop	{r7, pc}
	...

c0d05d88 <viewexpl_bagl_keyscrolling_button>:
    UI_LabelLineScrolling(UIID_LABELSCROLL, 16, 19, 96, UI_11PX, UI_WHITE, UI_BLACK, (const char *) viewctl.dataKey),
};

static unsigned int viewexpl_bagl_keyscrolling_button(
        unsigned int button_mask,
        unsigned int button_mask_counter) {
c0d05d88:	b580      	push	{r7, lr}
    switch (button_mask) {
c0d05d8a:	491c      	ldr	r1, [pc, #112]	; (c0d05dfc <viewexpl_bagl_keyscrolling_button+0x74>)
c0d05d8c:	4288      	cmp	r0, r1
c0d05d8e:	dd0f      	ble.n	c0d05db0 <viewexpl_bagl_keyscrolling_button+0x28>
c0d05d90:	491b      	ldr	r1, [pc, #108]	; (c0d05e00 <viewexpl_bagl_keyscrolling_button+0x78>)
c0d05d92:	4288      	cmp	r0, r1
c0d05d94:	d01d      	beq.n	c0d05dd2 <viewexpl_bagl_keyscrolling_button+0x4a>
c0d05d96:	491b      	ldr	r1, [pc, #108]	; (c0d05e04 <viewexpl_bagl_keyscrolling_button+0x7c>)
c0d05d98:	4288      	cmp	r0, r1
c0d05d9a:	d025      	beq.n	c0d05de8 <viewexpl_bagl_keyscrolling_button+0x60>
c0d05d9c:	491a      	ldr	r1, [pc, #104]	; (c0d05e08 <viewexpl_bagl_keyscrolling_button+0x80>)
c0d05d9e:	4288      	cmp	r0, r1
c0d05da0:	d129      	bne.n	c0d05df6 <viewexpl_bagl_keyscrolling_button+0x6e>
        // Press both left and right to switch to value scrolling
        case BUTTON_EVT_RELEASED | BUTTON_LEFT | BUTTON_RIGHT: {
            if (viewctl.scrolling_mode == KEY_SCROLLING_NO_VALUE) {
c0d05da2:	481b      	ldr	r0, [pc, #108]	; (c0d05e10 <viewexpl_bagl_keyscrolling_button+0x88>)
c0d05da4:	7800      	ldrb	r0, [r0, #0]
c0d05da6:	2801      	cmp	r0, #1
c0d05da8:	d121      	bne.n	c0d05dee <viewexpl_bagl_keyscrolling_button+0x66>
                viewctl_display_page();
c0d05daa:	f7ff fe91 	bl	c0d05ad0 <viewctl_display_page>
c0d05dae:	e022      	b.n	c0d05df6 <viewexpl_bagl_keyscrolling_button+0x6e>
c0d05db0:	4916      	ldr	r1, [pc, #88]	; (c0d05e0c <viewexpl_bagl_keyscrolling_button+0x84>)
c0d05db2:	4288      	cmp	r0, r1
c0d05db4:	d010      	beq.n	c0d05dd8 <viewexpl_bagl_keyscrolling_button+0x50>
c0d05db6:	4911      	ldr	r1, [pc, #68]	; (c0d05dfc <viewexpl_bagl_keyscrolling_button+0x74>)
c0d05db8:	4288      	cmp	r0, r1
c0d05dba:	d11c      	bne.n	c0d05df6 <viewexpl_bagl_keyscrolling_button+0x6e>
            break;
        }

            // Press right to progress to the next element
        case BUTTON_EVT_RELEASED | BUTTON_RIGHT: {
            if (viewctl.chunksIndex < viewctl.chunksCount - 1) {
c0d05dbc:	2006      	movs	r0, #6
c0d05dbe:	4914      	ldr	r1, [pc, #80]	; (c0d05e10 <viewexpl_bagl_keyscrolling_button+0x88>)
c0d05dc0:	5e08      	ldrsh	r0, [r1, r0]
c0d05dc2:	2208      	movs	r2, #8
c0d05dc4:	5e89      	ldrsh	r1, [r1, r2]
c0d05dc6:	1e49      	subs	r1, r1, #1
c0d05dc8:	4288      	cmp	r0, r1
c0d05dca:	da02      	bge.n	c0d05dd2 <viewexpl_bagl_keyscrolling_button+0x4a>
                submenu_right();
c0d05dcc:	f7ff fe3a 	bl	c0d05a44 <submenu_right>
c0d05dd0:	e011      	b.n	c0d05df6 <viewexpl_bagl_keyscrolling_button+0x6e>
c0d05dd2:	f7ff fe5d 	bl	c0d05a90 <menu_right>
c0d05dd6:	e00e      	b.n	c0d05df6 <viewexpl_bagl_keyscrolling_button+0x6e>
            break;
        }

            // Press left to progress to the previous element
        case BUTTON_EVT_RELEASED | BUTTON_LEFT: {
            if (viewctl.chunksIndex > 0) {
c0d05dd8:	2006      	movs	r0, #6
c0d05dda:	490d      	ldr	r1, [pc, #52]	; (c0d05e10 <viewexpl_bagl_keyscrolling_button+0x88>)
c0d05ddc:	5e08      	ldrsh	r0, [r1, r0]
c0d05dde:	2801      	cmp	r0, #1
c0d05de0:	db02      	blt.n	c0d05de8 <viewexpl_bagl_keyscrolling_button+0x60>
                submenu_left();
c0d05de2:	f7ff fe23 	bl	c0d05a2c <submenu_left>
c0d05de6:	e006      	b.n	c0d05df6 <viewexpl_bagl_keyscrolling_button+0x6e>
c0d05de8:	f7ff fe38 	bl	c0d05a5c <menu_left>
c0d05dec:	e003      	b.n	c0d05df6 <viewexpl_bagl_keyscrolling_button+0x6e>
        // Press both left and right to switch to value scrolling
        case BUTTON_EVT_RELEASED | BUTTON_LEFT | BUTTON_RIGHT: {
            if (viewctl.scrolling_mode == KEY_SCROLLING_NO_VALUE) {
                viewctl_display_page();
            } else {
                viewctl_ehExit(0);
c0d05dee:	4809      	ldr	r0, [pc, #36]	; (c0d05e14 <viewexpl_bagl_keyscrolling_button+0x8c>)
c0d05df0:	6801      	ldr	r1, [r0, #0]
c0d05df2:	2000      	movs	r0, #0
c0d05df4:	4788      	blx	r1
        case BUTTON_EVT_FAST | BUTTON_RIGHT: {
            menu_right();
            break;
        }
    }
    return 0;
c0d05df6:	2000      	movs	r0, #0
c0d05df8:	bd80      	pop	{r7, pc}
c0d05dfa:	46c0      	nop			; (mov r8, r8)
c0d05dfc:	80000002 	.word	0x80000002
c0d05e00:	40000002 	.word	0x40000002
c0d05e04:	40000001 	.word	0x40000001
c0d05e08:	80000003 	.word	0x80000003
c0d05e0c:	80000001 	.word	0x80000001
c0d05e10:	2000236c 	.word	0x2000236c
c0d05e14:	20002364 	.word	0x20002364

c0d05e18 <viewexpl_start>:
}

void viewexpl_start(int start_page,
                    viewctl_delegate_getData ehUpdate,
                    viewctl_delegate_ready ehReady,
                    viewctl_delegate_exit ehExit) {
c0d05e18:	b5b0      	push	{r4, r5, r7, lr}
c0d05e1a:	b082      	sub	sp, #8
    viewctl_start(start_page, ehUpdate, ehReady, ehExit, viewexpl_display_ux);
c0d05e1c:	4c03      	ldr	r4, [pc, #12]	; (c0d05e2c <viewexpl_start+0x14>)
c0d05e1e:	447c      	add	r4, pc
c0d05e20:	466d      	mov	r5, sp
c0d05e22:	602c      	str	r4, [r5, #0]
c0d05e24:	f7ff fdde 	bl	c0d059e4 <viewctl_start>
}
c0d05e28:	b002      	add	sp, #8
c0d05e2a:	bdb0      	pop	{r4, r5, r7, pc}
c0d05e2c:	fffffe1b 	.word	0xfffffe1b

c0d05e30 <utf8codepoint>:

    return utf8_null;
}

void *utf8codepoint(const void *utf8_restrict str,
                    utf8_int32_t *utf8_restrict out_codepoint) {
c0d05e30:	b5b0      	push	{r4, r5, r7, lr}
    const char *s = (const char *)str;

    if (0xf0 == (0xf8 & s[0])) {
c0d05e32:	7802      	ldrb	r2, [r0, #0]
c0d05e34:	23f8      	movs	r3, #248	; 0xf8
c0d05e36:	4013      	ands	r3, r2
c0d05e38:	2bf0      	cmp	r3, #240	; 0xf0
c0d05e3a:	d10f      	bne.n	c0d05e5c <utf8codepoint+0x2c>
        // 4 byte utf8 codepoint
        *out_codepoint = ((0x07 & s[0]) << 18) | ((0x3f & s[1]) << 12) |
c0d05e3c:	2307      	movs	r3, #7
c0d05e3e:	049b      	lsls	r3, r3, #18
c0d05e40:	0492      	lsls	r2, r2, #18
c0d05e42:	401a      	ands	r2, r3
c0d05e44:	7843      	ldrb	r3, [r0, #1]
c0d05e46:	243f      	movs	r4, #63	; 0x3f
c0d05e48:	4023      	ands	r3, r4
c0d05e4a:	031b      	lsls	r3, r3, #12
c0d05e4c:	4313      	orrs	r3, r2
                         ((0x3f & s[2]) << 6) | (0x3f & s[3]);
c0d05e4e:	7882      	ldrb	r2, [r0, #2]
c0d05e50:	4022      	ands	r2, r4
c0d05e52:	0194      	lsls	r4, r2, #6
                    utf8_int32_t *utf8_restrict out_codepoint) {
    const char *s = (const char *)str;

    if (0xf0 == (0xf8 & s[0])) {
        // 4 byte utf8 codepoint
        *out_codepoint = ((0x07 & s[0]) << 18) | ((0x3f & s[1]) << 12) |
c0d05e54:	431c      	orrs	r4, r3
c0d05e56:	2304      	movs	r3, #4
c0d05e58:	2203      	movs	r2, #3
c0d05e5a:	e018      	b.n	c0d05e8e <utf8codepoint+0x5e>
                         ((0x3f & s[2]) << 6) | (0x3f & s[3]);
        s += 4;
    } else if (0xe0 == (0xf0 & s[0])) {
c0d05e5c:	23f0      	movs	r3, #240	; 0xf0
c0d05e5e:	4013      	ands	r3, r2
c0d05e60:	2be0      	cmp	r3, #224	; 0xe0
c0d05e62:	d109      	bne.n	c0d05e78 <utf8codepoint+0x48>
        // 3 byte utf8 codepoint
        *out_codepoint =
                ((0x0f & s[0]) << 12) | ((0x3f & s[1]) << 6) | (0x3f & s[2]);
c0d05e64:	7843      	ldrb	r3, [r0, #1]
c0d05e66:	243f      	movs	r4, #63	; 0x3f
c0d05e68:	401c      	ands	r4, r3
c0d05e6a:	01a3      	lsls	r3, r4, #6
c0d05e6c:	0312      	lsls	r2, r2, #12
c0d05e6e:	b294      	uxth	r4, r2
c0d05e70:	431c      	orrs	r4, r3
c0d05e72:	2303      	movs	r3, #3
c0d05e74:	2202      	movs	r2, #2
c0d05e76:	e00a      	b.n	c0d05e8e <utf8codepoint+0x5e>
        s += 3;
    } else if (0xc0 == (0xe0 & s[0])) {
c0d05e78:	24e0      	movs	r4, #224	; 0xe0
c0d05e7a:	4014      	ands	r4, r2
c0d05e7c:	2301      	movs	r3, #1
c0d05e7e:	2cc0      	cmp	r4, #192	; 0xc0
c0d05e80:	d109      	bne.n	c0d05e96 <utf8codepoint+0x66>
        // 2 byte utf8 codepoint
        *out_codepoint = ((0x1f & s[0]) << 6) | (0x3f & s[1]);
c0d05e82:	231f      	movs	r3, #31
c0d05e84:	019b      	lsls	r3, r3, #6
c0d05e86:	0194      	lsls	r4, r2, #6
c0d05e88:	401c      	ands	r4, r3
c0d05e8a:	2302      	movs	r3, #2
c0d05e8c:	2201      	movs	r2, #1
c0d05e8e:	5c85      	ldrb	r5, [r0, r2]
c0d05e90:	223f      	movs	r2, #63	; 0x3f
c0d05e92:	402a      	ands	r2, r5
c0d05e94:	4322      	orrs	r2, r4
c0d05e96:	600a      	str	r2, [r1, #0]
c0d05e98:	18c0      	adds	r0, r0, r3
        // 1 byte utf8 codepoint otherwise
        *out_codepoint = s[0];
        s += 1;
    }

    return (void *)s;
c0d05e9a:	bdb0      	pop	{r4, r5, r7, pc}

c0d05e9c <utf8valid>:
        // Roll back to the next code point in the haystack to test
        h = nextH;
    }
}

void *utf8valid(const void *str) {
c0d05e9c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d05e9e:	4601      	mov	r1, r0
    const char *s = (const char *)str;

    while ('\0' != *s) {
c0d05ea0:	780c      	ldrb	r4, [r1, #0]
c0d05ea2:	2200      	movs	r2, #0
c0d05ea4:	2c00      	cmp	r4, #0
c0d05ea6:	d054      	beq.n	c0d05f52 <utf8valid+0xb6>
            if (0x80 != (0xc0 & s[1])) {
                return (void *)s;
            }

            // ensure that our utf8 codepoint ended after 2 bytes
            if (0x80 == (0xc0 & s[2])) {
c0d05ea8:	2380      	movs	r3, #128	; 0x80
c0d05eaa:	4608      	mov	r0, r1

void *utf8valid(const void *str) {
    const char *s = (const char *)str;

    while ('\0' != *s) {
        if (0xf0 == (0xf8 & *s)) {
c0d05eac:	21f8      	movs	r1, #248	; 0xf8
c0d05eae:	4021      	ands	r1, r4
c0d05eb0:	29f0      	cmp	r1, #240	; 0xf0
c0d05eb2:	d11b      	bne.n	c0d05eec <utf8valid+0x50>
            // ensure each of the 3 following bytes in this 4-byte
            // utf8 codepoint began with 0b10xxxxxx
            if ((0x80 != (0xc0 & s[1])) || (0x80 != (0xc0 & s[2])) ||
c0d05eb4:	7845      	ldrb	r5, [r0, #1]
c0d05eb6:	26c0      	movs	r6, #192	; 0xc0
c0d05eb8:	4629      	mov	r1, r5
c0d05eba:	4031      	ands	r1, r6
c0d05ebc:	2980      	cmp	r1, #128	; 0x80
c0d05ebe:	d149      	bne.n	c0d05f54 <utf8valid+0xb8>
c0d05ec0:	7881      	ldrb	r1, [r0, #2]
c0d05ec2:	4031      	ands	r1, r6
c0d05ec4:	4299      	cmp	r1, r3
c0d05ec6:	d145      	bne.n	c0d05f54 <utf8valid+0xb8>
                (0x80 != (0xc0 & s[3]))) {
c0d05ec8:	78c1      	ldrb	r1, [r0, #3]
c0d05eca:	4031      	ands	r1, r6

    while ('\0' != *s) {
        if (0xf0 == (0xf8 & *s)) {
            // ensure each of the 3 following bytes in this 4-byte
            // utf8 codepoint began with 0b10xxxxxx
            if ((0x80 != (0xc0 & s[1])) || (0x80 != (0xc0 & s[2])) ||
c0d05ecc:	4299      	cmp	r1, r3
c0d05ece:	d141      	bne.n	c0d05f54 <utf8valid+0xb8>
                (0x80 != (0xc0 & s[3]))) {
                return (void *)s;
            }

            // ensure that our utf8 codepoint ended after 4 bytes
            if (0x80 == (0xc0 & s[4])) {
c0d05ed0:	7907      	ldrb	r7, [r0, #4]
c0d05ed2:	403e      	ands	r6, r7
c0d05ed4:	1d01      	adds	r1, r0, #4
c0d05ed6:	429e      	cmp	r6, r3
c0d05ed8:	d03c      	beq.n	c0d05f54 <utf8valid+0xb8>
            }

            // ensure that the top 5 bits of this 4-byte utf8
            // codepoint were not 0, as then we could have used
            // one of the smaller encodings
            if ((0 == (0x07 & s[0])) && (0 == (0x30 & s[1]))) {
c0d05eda:	2607      	movs	r6, #7
c0d05edc:	4034      	ands	r4, r6
c0d05ede:	2630      	movs	r6, #48	; 0x30
c0d05ee0:	4035      	ands	r5, r6
c0d05ee2:	4325      	orrs	r5, r4
c0d05ee4:	2d00      	cmp	r5, #0
}

void *utf8valid(const void *str) {
    const char *s = (const char *)str;

    while ('\0' != *s) {
c0d05ee6:	463c      	mov	r4, r7
c0d05ee8:	d131      	bne.n	c0d05f4e <utf8valid+0xb2>
c0d05eea:	e033      	b.n	c0d05f54 <utf8valid+0xb8>
                return (void *)s;
            }

            // 4-byte utf8 code point (began with 0b11110xxx)
            s += 4;
        } else if (0xe0 == (0xf0 & *s)) {
c0d05eec:	21f0      	movs	r1, #240	; 0xf0
c0d05eee:	4021      	ands	r1, r4
c0d05ef0:	29e0      	cmp	r1, #224	; 0xe0
c0d05ef2:	d115      	bne.n	c0d05f20 <utf8valid+0x84>
            // ensure each of the 2 following bytes in this 3-byte
            // utf8 codepoint began with 0b10xxxxxx
            if ((0x80 != (0xc0 & s[1])) || (0x80 != (0xc0 & s[2]))) {
c0d05ef4:	7845      	ldrb	r5, [r0, #1]
c0d05ef6:	27c0      	movs	r7, #192	; 0xc0
c0d05ef8:	4629      	mov	r1, r5
c0d05efa:	4039      	ands	r1, r7
c0d05efc:	2980      	cmp	r1, #128	; 0x80
c0d05efe:	d129      	bne.n	c0d05f54 <utf8valid+0xb8>
c0d05f00:	7881      	ldrb	r1, [r0, #2]
c0d05f02:	4039      	ands	r1, r7
c0d05f04:	4299      	cmp	r1, r3
c0d05f06:	d125      	bne.n	c0d05f54 <utf8valid+0xb8>
                return (void *)s;
            }

            // ensure that our utf8 codepoint ended after 3 bytes
            if (0x80 == (0xc0 & s[3])) {
c0d05f08:	78c6      	ldrb	r6, [r0, #3]
c0d05f0a:	4037      	ands	r7, r6
c0d05f0c:	1cc1      	adds	r1, r0, #3
c0d05f0e:	429f      	cmp	r7, r3
c0d05f10:	d020      	beq.n	c0d05f54 <utf8valid+0xb8>
            }

            // ensure that the top 5 bits of this 3-byte utf8
            // codepoint were not 0, as then we could have used
            // one of the smaller encodings
            if ((0 == (0x0f & s[0])) && (0 == (0x20 & s[1]))) {
c0d05f12:	270f      	movs	r7, #15
c0d05f14:	403c      	ands	r4, r7
c0d05f16:	2720      	movs	r7, #32
c0d05f18:	403d      	ands	r5, r7
c0d05f1a:	4325      	orrs	r5, r4
c0d05f1c:	2d00      	cmp	r5, #0
c0d05f1e:	e00f      	b.n	c0d05f40 <utf8valid+0xa4>
                return (void *)s;
            }

            // 3-byte utf8 code point (began with 0b1110xxxx)
            s += 3;
        } else if (0xc0 == (0xe0 & *s)) {
c0d05f20:	21e0      	movs	r1, #224	; 0xe0
c0d05f22:	4021      	ands	r1, r4
c0d05f24:	29c0      	cmp	r1, #192	; 0xc0
c0d05f26:	d10e      	bne.n	c0d05f46 <utf8valid+0xaa>
            // ensure the 1 following byte in this 2-byte
            // utf8 codepoint began with 0b10xxxxxx
            if (0x80 != (0xc0 & s[1])) {
c0d05f28:	7841      	ldrb	r1, [r0, #1]
c0d05f2a:	25c0      	movs	r5, #192	; 0xc0
c0d05f2c:	4029      	ands	r1, r5
c0d05f2e:	4299      	cmp	r1, r3
c0d05f30:	d110      	bne.n	c0d05f54 <utf8valid+0xb8>
                return (void *)s;
            }

            // ensure that our utf8 codepoint ended after 2 bytes
            if (0x80 == (0xc0 & s[2])) {
c0d05f32:	7886      	ldrb	r6, [r0, #2]
c0d05f34:	4035      	ands	r5, r6
c0d05f36:	1c81      	adds	r1, r0, #2
c0d05f38:	06e4      	lsls	r4, r4, #27
c0d05f3a:	0f24      	lsrs	r4, r4, #28
c0d05f3c:	d00a      	beq.n	c0d05f54 <utf8valid+0xb8>
c0d05f3e:	429d      	cmp	r5, r3
c0d05f40:	4634      	mov	r4, r6
c0d05f42:	d104      	bne.n	c0d05f4e <utf8valid+0xb2>
c0d05f44:	e006      	b.n	c0d05f54 <utf8valid+0xb8>
                return (void *)s;
            }

            // 2-byte utf8 code point (began with 0b110xxxxx)
            s += 2;
        } else if (0x00 == (0x80 & *s)) {
c0d05f46:	0621      	lsls	r1, r4, #24
c0d05f48:	d404      	bmi.n	c0d05f54 <utf8valid+0xb8>
c0d05f4a:	7844      	ldrb	r4, [r0, #1]
            // 1-byte ascii (began with 0b0xxxxxxx)
            s += 1;
c0d05f4c:	1c41      	adds	r1, r0, #1
}

void *utf8valid(const void *str) {
    const char *s = (const char *)str;

    while ('\0' != *s) {
c0d05f4e:	2c00      	cmp	r4, #0
c0d05f50:	d1ab      	bne.n	c0d05eaa <utf8valid+0xe>
c0d05f52:	4610      	mov	r0, r2
            return (void *)s;
        }
    }

    return utf8_null;
}
c0d05f54:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d05f56 <asciify>:
void __logstack() {}

#endif

size_t asciify(char *utf8_in_ascii_out)
{
c0d05f56:	b580      	push	{r7, lr}
    return asciify_ext(utf8_in_ascii_out, utf8_in_ascii_out);
c0d05f58:	4601      	mov	r1, r0
c0d05f5a:	f000 f801 	bl	c0d05f60 <asciify_ext>
c0d05f5e:	bd80      	pop	{r7, pc}

c0d05f60 <asciify_ext>:
}

size_t asciify_ext(const char *utf8_in, char *ascii_only_out) {
c0d05f60:	b570      	push	{r4, r5, r6, lr}
c0d05f62:	b082      	sub	sp, #8
c0d05f64:	460c      	mov	r4, r1
c0d05f66:	4605      	mov	r5, r0
    void *p = (void *) utf8_in;
    char *q = ascii_only_out;

    // utf8valid returns zero on success
    while (*((char *) p) && utf8valid(p) == 0) {
c0d05f68:	7828      	ldrb	r0, [r5, #0]
c0d05f6a:	2800      	cmp	r0, #0
c0d05f6c:	4626      	mov	r6, r4
c0d05f6e:	d018      	beq.n	c0d05fa2 <asciify_ext+0x42>
c0d05f70:	4626      	mov	r6, r4
c0d05f72:	4628      	mov	r0, r5
c0d05f74:	f7ff ff92 	bl	c0d05e9c <utf8valid>
c0d05f78:	2800      	cmp	r0, #0
c0d05f7a:	d112      	bne.n	c0d05fa2 <asciify_ext+0x42>
c0d05f7c:	2000      	movs	r0, #0
        utf8_int32_t tmp_codepoint = 0;
c0d05f7e:	9001      	str	r0, [sp, #4]
c0d05f80:	a901      	add	r1, sp, #4
        p = utf8codepoint(p, &tmp_codepoint);
c0d05f82:	4628      	mov	r0, r5
c0d05f84:	f7ff ff54 	bl	c0d05e30 <utf8codepoint>
c0d05f88:	4605      	mov	r5, r0
        *q = (tmp_codepoint >= 32 && tmp_codepoint <= 0x7F)? tmp_codepoint : '.';
c0d05f8a:	9801      	ldr	r0, [sp, #4]
c0d05f8c:	4602      	mov	r2, r0
c0d05f8e:	3a20      	subs	r2, #32
c0d05f90:	212e      	movs	r1, #46	; 0x2e
c0d05f92:	2a60      	cmp	r2, #96	; 0x60
c0d05f94:	d300      	bcc.n	c0d05f98 <asciify_ext+0x38>
c0d05f96:	4608      	mov	r0, r1
c0d05f98:	7030      	strb	r0, [r6, #0]
size_t asciify_ext(const char *utf8_in, char *ascii_only_out) {
    void *p = (void *) utf8_in;
    char *q = ascii_only_out;

    // utf8valid returns zero on success
    while (*((char *) p) && utf8valid(p) == 0) {
c0d05f9a:	7828      	ldrb	r0, [r5, #0]
        utf8_int32_t tmp_codepoint = 0;
        p = utf8codepoint(p, &tmp_codepoint);
        *q = (tmp_codepoint >= 32 && tmp_codepoint <= 0x7F)? tmp_codepoint : '.';
        q++;
c0d05f9c:	1c76      	adds	r6, r6, #1
size_t asciify_ext(const char *utf8_in, char *ascii_only_out) {
    void *p = (void *) utf8_in;
    char *q = ascii_only_out;

    // utf8valid returns zero on success
    while (*((char *) p) && utf8valid(p) == 0) {
c0d05f9e:	2800      	cmp	r0, #0
c0d05fa0:	d1e7      	bne.n	c0d05f72 <asciify_ext+0x12>
        *q = (tmp_codepoint >= 32 && tmp_codepoint <= 0x7F)? tmp_codepoint : '.';
        q++;
    }

    // Terminate string
    *q = 0;
c0d05fa2:	2000      	movs	r0, #0
c0d05fa4:	7030      	strb	r0, [r6, #0]
    return q - ascii_only_out;
c0d05fa6:	1b30      	subs	r0, r6, r4
c0d05fa8:	b002      	add	sp, #8
c0d05faa:	bd70      	pop	{r4, r5, r6, pc}

c0d05fac <__aeabi_uidiv>:
c0d05fac:	2200      	movs	r2, #0
c0d05fae:	0843      	lsrs	r3, r0, #1
c0d05fb0:	428b      	cmp	r3, r1
c0d05fb2:	d374      	bcc.n	c0d0609e <__aeabi_uidiv+0xf2>
c0d05fb4:	0903      	lsrs	r3, r0, #4
c0d05fb6:	428b      	cmp	r3, r1
c0d05fb8:	d35f      	bcc.n	c0d0607a <__aeabi_uidiv+0xce>
c0d05fba:	0a03      	lsrs	r3, r0, #8
c0d05fbc:	428b      	cmp	r3, r1
c0d05fbe:	d344      	bcc.n	c0d0604a <__aeabi_uidiv+0x9e>
c0d05fc0:	0b03      	lsrs	r3, r0, #12
c0d05fc2:	428b      	cmp	r3, r1
c0d05fc4:	d328      	bcc.n	c0d06018 <__aeabi_uidiv+0x6c>
c0d05fc6:	0c03      	lsrs	r3, r0, #16
c0d05fc8:	428b      	cmp	r3, r1
c0d05fca:	d30d      	bcc.n	c0d05fe8 <__aeabi_uidiv+0x3c>
c0d05fcc:	22ff      	movs	r2, #255	; 0xff
c0d05fce:	0209      	lsls	r1, r1, #8
c0d05fd0:	ba12      	rev	r2, r2
c0d05fd2:	0c03      	lsrs	r3, r0, #16
c0d05fd4:	428b      	cmp	r3, r1
c0d05fd6:	d302      	bcc.n	c0d05fde <__aeabi_uidiv+0x32>
c0d05fd8:	1212      	asrs	r2, r2, #8
c0d05fda:	0209      	lsls	r1, r1, #8
c0d05fdc:	d065      	beq.n	c0d060aa <__aeabi_uidiv+0xfe>
c0d05fde:	0b03      	lsrs	r3, r0, #12
c0d05fe0:	428b      	cmp	r3, r1
c0d05fe2:	d319      	bcc.n	c0d06018 <__aeabi_uidiv+0x6c>
c0d05fe4:	e000      	b.n	c0d05fe8 <__aeabi_uidiv+0x3c>
c0d05fe6:	0a09      	lsrs	r1, r1, #8
c0d05fe8:	0bc3      	lsrs	r3, r0, #15
c0d05fea:	428b      	cmp	r3, r1
c0d05fec:	d301      	bcc.n	c0d05ff2 <__aeabi_uidiv+0x46>
c0d05fee:	03cb      	lsls	r3, r1, #15
c0d05ff0:	1ac0      	subs	r0, r0, r3
c0d05ff2:	4152      	adcs	r2, r2
c0d05ff4:	0b83      	lsrs	r3, r0, #14
c0d05ff6:	428b      	cmp	r3, r1
c0d05ff8:	d301      	bcc.n	c0d05ffe <__aeabi_uidiv+0x52>
c0d05ffa:	038b      	lsls	r3, r1, #14
c0d05ffc:	1ac0      	subs	r0, r0, r3
c0d05ffe:	4152      	adcs	r2, r2
c0d06000:	0b43      	lsrs	r3, r0, #13
c0d06002:	428b      	cmp	r3, r1
c0d06004:	d301      	bcc.n	c0d0600a <__aeabi_uidiv+0x5e>
c0d06006:	034b      	lsls	r3, r1, #13
c0d06008:	1ac0      	subs	r0, r0, r3
c0d0600a:	4152      	adcs	r2, r2
c0d0600c:	0b03      	lsrs	r3, r0, #12
c0d0600e:	428b      	cmp	r3, r1
c0d06010:	d301      	bcc.n	c0d06016 <__aeabi_uidiv+0x6a>
c0d06012:	030b      	lsls	r3, r1, #12
c0d06014:	1ac0      	subs	r0, r0, r3
c0d06016:	4152      	adcs	r2, r2
c0d06018:	0ac3      	lsrs	r3, r0, #11
c0d0601a:	428b      	cmp	r3, r1
c0d0601c:	d301      	bcc.n	c0d06022 <__aeabi_uidiv+0x76>
c0d0601e:	02cb      	lsls	r3, r1, #11
c0d06020:	1ac0      	subs	r0, r0, r3
c0d06022:	4152      	adcs	r2, r2
c0d06024:	0a83      	lsrs	r3, r0, #10
c0d06026:	428b      	cmp	r3, r1
c0d06028:	d301      	bcc.n	c0d0602e <__aeabi_uidiv+0x82>
c0d0602a:	028b      	lsls	r3, r1, #10
c0d0602c:	1ac0      	subs	r0, r0, r3
c0d0602e:	4152      	adcs	r2, r2
c0d06030:	0a43      	lsrs	r3, r0, #9
c0d06032:	428b      	cmp	r3, r1
c0d06034:	d301      	bcc.n	c0d0603a <__aeabi_uidiv+0x8e>
c0d06036:	024b      	lsls	r3, r1, #9
c0d06038:	1ac0      	subs	r0, r0, r3
c0d0603a:	4152      	adcs	r2, r2
c0d0603c:	0a03      	lsrs	r3, r0, #8
c0d0603e:	428b      	cmp	r3, r1
c0d06040:	d301      	bcc.n	c0d06046 <__aeabi_uidiv+0x9a>
c0d06042:	020b      	lsls	r3, r1, #8
c0d06044:	1ac0      	subs	r0, r0, r3
c0d06046:	4152      	adcs	r2, r2
c0d06048:	d2cd      	bcs.n	c0d05fe6 <__aeabi_uidiv+0x3a>
c0d0604a:	09c3      	lsrs	r3, r0, #7
c0d0604c:	428b      	cmp	r3, r1
c0d0604e:	d301      	bcc.n	c0d06054 <__aeabi_uidiv+0xa8>
c0d06050:	01cb      	lsls	r3, r1, #7
c0d06052:	1ac0      	subs	r0, r0, r3
c0d06054:	4152      	adcs	r2, r2
c0d06056:	0983      	lsrs	r3, r0, #6
c0d06058:	428b      	cmp	r3, r1
c0d0605a:	d301      	bcc.n	c0d06060 <__aeabi_uidiv+0xb4>
c0d0605c:	018b      	lsls	r3, r1, #6
c0d0605e:	1ac0      	subs	r0, r0, r3
c0d06060:	4152      	adcs	r2, r2
c0d06062:	0943      	lsrs	r3, r0, #5
c0d06064:	428b      	cmp	r3, r1
c0d06066:	d301      	bcc.n	c0d0606c <__aeabi_uidiv+0xc0>
c0d06068:	014b      	lsls	r3, r1, #5
c0d0606a:	1ac0      	subs	r0, r0, r3
c0d0606c:	4152      	adcs	r2, r2
c0d0606e:	0903      	lsrs	r3, r0, #4
c0d06070:	428b      	cmp	r3, r1
c0d06072:	d301      	bcc.n	c0d06078 <__aeabi_uidiv+0xcc>
c0d06074:	010b      	lsls	r3, r1, #4
c0d06076:	1ac0      	subs	r0, r0, r3
c0d06078:	4152      	adcs	r2, r2
c0d0607a:	08c3      	lsrs	r3, r0, #3
c0d0607c:	428b      	cmp	r3, r1
c0d0607e:	d301      	bcc.n	c0d06084 <__aeabi_uidiv+0xd8>
c0d06080:	00cb      	lsls	r3, r1, #3
c0d06082:	1ac0      	subs	r0, r0, r3
c0d06084:	4152      	adcs	r2, r2
c0d06086:	0883      	lsrs	r3, r0, #2
c0d06088:	428b      	cmp	r3, r1
c0d0608a:	d301      	bcc.n	c0d06090 <__aeabi_uidiv+0xe4>
c0d0608c:	008b      	lsls	r3, r1, #2
c0d0608e:	1ac0      	subs	r0, r0, r3
c0d06090:	4152      	adcs	r2, r2
c0d06092:	0843      	lsrs	r3, r0, #1
c0d06094:	428b      	cmp	r3, r1
c0d06096:	d301      	bcc.n	c0d0609c <__aeabi_uidiv+0xf0>
c0d06098:	004b      	lsls	r3, r1, #1
c0d0609a:	1ac0      	subs	r0, r0, r3
c0d0609c:	4152      	adcs	r2, r2
c0d0609e:	1a41      	subs	r1, r0, r1
c0d060a0:	d200      	bcs.n	c0d060a4 <__aeabi_uidiv+0xf8>
c0d060a2:	4601      	mov	r1, r0
c0d060a4:	4152      	adcs	r2, r2
c0d060a6:	4610      	mov	r0, r2
c0d060a8:	4770      	bx	lr
c0d060aa:	e7ff      	b.n	c0d060ac <__aeabi_uidiv+0x100>
c0d060ac:	b501      	push	{r0, lr}
c0d060ae:	2000      	movs	r0, #0
c0d060b0:	f000 f8f0 	bl	c0d06294 <__aeabi_idiv0>
c0d060b4:	bd02      	pop	{r1, pc}
c0d060b6:	46c0      	nop			; (mov r8, r8)

c0d060b8 <__aeabi_uidivmod>:
c0d060b8:	2900      	cmp	r1, #0
c0d060ba:	d0f7      	beq.n	c0d060ac <__aeabi_uidiv+0x100>
c0d060bc:	e776      	b.n	c0d05fac <__aeabi_uidiv>
c0d060be:	4770      	bx	lr

c0d060c0 <__aeabi_idiv>:
c0d060c0:	4603      	mov	r3, r0
c0d060c2:	430b      	orrs	r3, r1
c0d060c4:	d47f      	bmi.n	c0d061c6 <__aeabi_idiv+0x106>
c0d060c6:	2200      	movs	r2, #0
c0d060c8:	0843      	lsrs	r3, r0, #1
c0d060ca:	428b      	cmp	r3, r1
c0d060cc:	d374      	bcc.n	c0d061b8 <__aeabi_idiv+0xf8>
c0d060ce:	0903      	lsrs	r3, r0, #4
c0d060d0:	428b      	cmp	r3, r1
c0d060d2:	d35f      	bcc.n	c0d06194 <__aeabi_idiv+0xd4>
c0d060d4:	0a03      	lsrs	r3, r0, #8
c0d060d6:	428b      	cmp	r3, r1
c0d060d8:	d344      	bcc.n	c0d06164 <__aeabi_idiv+0xa4>
c0d060da:	0b03      	lsrs	r3, r0, #12
c0d060dc:	428b      	cmp	r3, r1
c0d060de:	d328      	bcc.n	c0d06132 <__aeabi_idiv+0x72>
c0d060e0:	0c03      	lsrs	r3, r0, #16
c0d060e2:	428b      	cmp	r3, r1
c0d060e4:	d30d      	bcc.n	c0d06102 <__aeabi_idiv+0x42>
c0d060e6:	22ff      	movs	r2, #255	; 0xff
c0d060e8:	0209      	lsls	r1, r1, #8
c0d060ea:	ba12      	rev	r2, r2
c0d060ec:	0c03      	lsrs	r3, r0, #16
c0d060ee:	428b      	cmp	r3, r1
c0d060f0:	d302      	bcc.n	c0d060f8 <__aeabi_idiv+0x38>
c0d060f2:	1212      	asrs	r2, r2, #8
c0d060f4:	0209      	lsls	r1, r1, #8
c0d060f6:	d065      	beq.n	c0d061c4 <__aeabi_idiv+0x104>
c0d060f8:	0b03      	lsrs	r3, r0, #12
c0d060fa:	428b      	cmp	r3, r1
c0d060fc:	d319      	bcc.n	c0d06132 <__aeabi_idiv+0x72>
c0d060fe:	e000      	b.n	c0d06102 <__aeabi_idiv+0x42>
c0d06100:	0a09      	lsrs	r1, r1, #8
c0d06102:	0bc3      	lsrs	r3, r0, #15
c0d06104:	428b      	cmp	r3, r1
c0d06106:	d301      	bcc.n	c0d0610c <__aeabi_idiv+0x4c>
c0d06108:	03cb      	lsls	r3, r1, #15
c0d0610a:	1ac0      	subs	r0, r0, r3
c0d0610c:	4152      	adcs	r2, r2
c0d0610e:	0b83      	lsrs	r3, r0, #14
c0d06110:	428b      	cmp	r3, r1
c0d06112:	d301      	bcc.n	c0d06118 <__aeabi_idiv+0x58>
c0d06114:	038b      	lsls	r3, r1, #14
c0d06116:	1ac0      	subs	r0, r0, r3
c0d06118:	4152      	adcs	r2, r2
c0d0611a:	0b43      	lsrs	r3, r0, #13
c0d0611c:	428b      	cmp	r3, r1
c0d0611e:	d301      	bcc.n	c0d06124 <__aeabi_idiv+0x64>
c0d06120:	034b      	lsls	r3, r1, #13
c0d06122:	1ac0      	subs	r0, r0, r3
c0d06124:	4152      	adcs	r2, r2
c0d06126:	0b03      	lsrs	r3, r0, #12
c0d06128:	428b      	cmp	r3, r1
c0d0612a:	d301      	bcc.n	c0d06130 <__aeabi_idiv+0x70>
c0d0612c:	030b      	lsls	r3, r1, #12
c0d0612e:	1ac0      	subs	r0, r0, r3
c0d06130:	4152      	adcs	r2, r2
c0d06132:	0ac3      	lsrs	r3, r0, #11
c0d06134:	428b      	cmp	r3, r1
c0d06136:	d301      	bcc.n	c0d0613c <__aeabi_idiv+0x7c>
c0d06138:	02cb      	lsls	r3, r1, #11
c0d0613a:	1ac0      	subs	r0, r0, r3
c0d0613c:	4152      	adcs	r2, r2
c0d0613e:	0a83      	lsrs	r3, r0, #10
c0d06140:	428b      	cmp	r3, r1
c0d06142:	d301      	bcc.n	c0d06148 <__aeabi_idiv+0x88>
c0d06144:	028b      	lsls	r3, r1, #10
c0d06146:	1ac0      	subs	r0, r0, r3
c0d06148:	4152      	adcs	r2, r2
c0d0614a:	0a43      	lsrs	r3, r0, #9
c0d0614c:	428b      	cmp	r3, r1
c0d0614e:	d301      	bcc.n	c0d06154 <__aeabi_idiv+0x94>
c0d06150:	024b      	lsls	r3, r1, #9
c0d06152:	1ac0      	subs	r0, r0, r3
c0d06154:	4152      	adcs	r2, r2
c0d06156:	0a03      	lsrs	r3, r0, #8
c0d06158:	428b      	cmp	r3, r1
c0d0615a:	d301      	bcc.n	c0d06160 <__aeabi_idiv+0xa0>
c0d0615c:	020b      	lsls	r3, r1, #8
c0d0615e:	1ac0      	subs	r0, r0, r3
c0d06160:	4152      	adcs	r2, r2
c0d06162:	d2cd      	bcs.n	c0d06100 <__aeabi_idiv+0x40>
c0d06164:	09c3      	lsrs	r3, r0, #7
c0d06166:	428b      	cmp	r3, r1
c0d06168:	d301      	bcc.n	c0d0616e <__aeabi_idiv+0xae>
c0d0616a:	01cb      	lsls	r3, r1, #7
c0d0616c:	1ac0      	subs	r0, r0, r3
c0d0616e:	4152      	adcs	r2, r2
c0d06170:	0983      	lsrs	r3, r0, #6
c0d06172:	428b      	cmp	r3, r1
c0d06174:	d301      	bcc.n	c0d0617a <__aeabi_idiv+0xba>
c0d06176:	018b      	lsls	r3, r1, #6
c0d06178:	1ac0      	subs	r0, r0, r3
c0d0617a:	4152      	adcs	r2, r2
c0d0617c:	0943      	lsrs	r3, r0, #5
c0d0617e:	428b      	cmp	r3, r1
c0d06180:	d301      	bcc.n	c0d06186 <__aeabi_idiv+0xc6>
c0d06182:	014b      	lsls	r3, r1, #5
c0d06184:	1ac0      	subs	r0, r0, r3
c0d06186:	4152      	adcs	r2, r2
c0d06188:	0903      	lsrs	r3, r0, #4
c0d0618a:	428b      	cmp	r3, r1
c0d0618c:	d301      	bcc.n	c0d06192 <__aeabi_idiv+0xd2>
c0d0618e:	010b      	lsls	r3, r1, #4
c0d06190:	1ac0      	subs	r0, r0, r3
c0d06192:	4152      	adcs	r2, r2
c0d06194:	08c3      	lsrs	r3, r0, #3
c0d06196:	428b      	cmp	r3, r1
c0d06198:	d301      	bcc.n	c0d0619e <__aeabi_idiv+0xde>
c0d0619a:	00cb      	lsls	r3, r1, #3
c0d0619c:	1ac0      	subs	r0, r0, r3
c0d0619e:	4152      	adcs	r2, r2
c0d061a0:	0883      	lsrs	r3, r0, #2
c0d061a2:	428b      	cmp	r3, r1
c0d061a4:	d301      	bcc.n	c0d061aa <__aeabi_idiv+0xea>
c0d061a6:	008b      	lsls	r3, r1, #2
c0d061a8:	1ac0      	subs	r0, r0, r3
c0d061aa:	4152      	adcs	r2, r2
c0d061ac:	0843      	lsrs	r3, r0, #1
c0d061ae:	428b      	cmp	r3, r1
c0d061b0:	d301      	bcc.n	c0d061b6 <__aeabi_idiv+0xf6>
c0d061b2:	004b      	lsls	r3, r1, #1
c0d061b4:	1ac0      	subs	r0, r0, r3
c0d061b6:	4152      	adcs	r2, r2
c0d061b8:	1a41      	subs	r1, r0, r1
c0d061ba:	d200      	bcs.n	c0d061be <__aeabi_idiv+0xfe>
c0d061bc:	4601      	mov	r1, r0
c0d061be:	4152      	adcs	r2, r2
c0d061c0:	4610      	mov	r0, r2
c0d061c2:	4770      	bx	lr
c0d061c4:	e05d      	b.n	c0d06282 <__aeabi_idiv+0x1c2>
c0d061c6:	0fca      	lsrs	r2, r1, #31
c0d061c8:	d000      	beq.n	c0d061cc <__aeabi_idiv+0x10c>
c0d061ca:	4249      	negs	r1, r1
c0d061cc:	1003      	asrs	r3, r0, #32
c0d061ce:	d300      	bcc.n	c0d061d2 <__aeabi_idiv+0x112>
c0d061d0:	4240      	negs	r0, r0
c0d061d2:	4053      	eors	r3, r2
c0d061d4:	2200      	movs	r2, #0
c0d061d6:	469c      	mov	ip, r3
c0d061d8:	0903      	lsrs	r3, r0, #4
c0d061da:	428b      	cmp	r3, r1
c0d061dc:	d32d      	bcc.n	c0d0623a <__aeabi_idiv+0x17a>
c0d061de:	0a03      	lsrs	r3, r0, #8
c0d061e0:	428b      	cmp	r3, r1
c0d061e2:	d312      	bcc.n	c0d0620a <__aeabi_idiv+0x14a>
c0d061e4:	22fc      	movs	r2, #252	; 0xfc
c0d061e6:	0189      	lsls	r1, r1, #6
c0d061e8:	ba12      	rev	r2, r2
c0d061ea:	0a03      	lsrs	r3, r0, #8
c0d061ec:	428b      	cmp	r3, r1
c0d061ee:	d30c      	bcc.n	c0d0620a <__aeabi_idiv+0x14a>
c0d061f0:	0189      	lsls	r1, r1, #6
c0d061f2:	1192      	asrs	r2, r2, #6
c0d061f4:	428b      	cmp	r3, r1
c0d061f6:	d308      	bcc.n	c0d0620a <__aeabi_idiv+0x14a>
c0d061f8:	0189      	lsls	r1, r1, #6
c0d061fa:	1192      	asrs	r2, r2, #6
c0d061fc:	428b      	cmp	r3, r1
c0d061fe:	d304      	bcc.n	c0d0620a <__aeabi_idiv+0x14a>
c0d06200:	0189      	lsls	r1, r1, #6
c0d06202:	d03a      	beq.n	c0d0627a <__aeabi_idiv+0x1ba>
c0d06204:	1192      	asrs	r2, r2, #6
c0d06206:	e000      	b.n	c0d0620a <__aeabi_idiv+0x14a>
c0d06208:	0989      	lsrs	r1, r1, #6
c0d0620a:	09c3      	lsrs	r3, r0, #7
c0d0620c:	428b      	cmp	r3, r1
c0d0620e:	d301      	bcc.n	c0d06214 <__aeabi_idiv+0x154>
c0d06210:	01cb      	lsls	r3, r1, #7
c0d06212:	1ac0      	subs	r0, r0, r3
c0d06214:	4152      	adcs	r2, r2
c0d06216:	0983      	lsrs	r3, r0, #6
c0d06218:	428b      	cmp	r3, r1
c0d0621a:	d301      	bcc.n	c0d06220 <__aeabi_idiv+0x160>
c0d0621c:	018b      	lsls	r3, r1, #6
c0d0621e:	1ac0      	subs	r0, r0, r3
c0d06220:	4152      	adcs	r2, r2
c0d06222:	0943      	lsrs	r3, r0, #5
c0d06224:	428b      	cmp	r3, r1
c0d06226:	d301      	bcc.n	c0d0622c <__aeabi_idiv+0x16c>
c0d06228:	014b      	lsls	r3, r1, #5
c0d0622a:	1ac0      	subs	r0, r0, r3
c0d0622c:	4152      	adcs	r2, r2
c0d0622e:	0903      	lsrs	r3, r0, #4
c0d06230:	428b      	cmp	r3, r1
c0d06232:	d301      	bcc.n	c0d06238 <__aeabi_idiv+0x178>
c0d06234:	010b      	lsls	r3, r1, #4
c0d06236:	1ac0      	subs	r0, r0, r3
c0d06238:	4152      	adcs	r2, r2
c0d0623a:	08c3      	lsrs	r3, r0, #3
c0d0623c:	428b      	cmp	r3, r1
c0d0623e:	d301      	bcc.n	c0d06244 <__aeabi_idiv+0x184>
c0d06240:	00cb      	lsls	r3, r1, #3
c0d06242:	1ac0      	subs	r0, r0, r3
c0d06244:	4152      	adcs	r2, r2
c0d06246:	0883      	lsrs	r3, r0, #2
c0d06248:	428b      	cmp	r3, r1
c0d0624a:	d301      	bcc.n	c0d06250 <__aeabi_idiv+0x190>
c0d0624c:	008b      	lsls	r3, r1, #2
c0d0624e:	1ac0      	subs	r0, r0, r3
c0d06250:	4152      	adcs	r2, r2
c0d06252:	d2d9      	bcs.n	c0d06208 <__aeabi_idiv+0x148>
c0d06254:	0843      	lsrs	r3, r0, #1
c0d06256:	428b      	cmp	r3, r1
c0d06258:	d301      	bcc.n	c0d0625e <__aeabi_idiv+0x19e>
c0d0625a:	004b      	lsls	r3, r1, #1
c0d0625c:	1ac0      	subs	r0, r0, r3
c0d0625e:	4152      	adcs	r2, r2
c0d06260:	1a41      	subs	r1, r0, r1
c0d06262:	d200      	bcs.n	c0d06266 <__aeabi_idiv+0x1a6>
c0d06264:	4601      	mov	r1, r0
c0d06266:	4663      	mov	r3, ip
c0d06268:	4152      	adcs	r2, r2
c0d0626a:	105b      	asrs	r3, r3, #1
c0d0626c:	4610      	mov	r0, r2
c0d0626e:	d301      	bcc.n	c0d06274 <__aeabi_idiv+0x1b4>
c0d06270:	4240      	negs	r0, r0
c0d06272:	2b00      	cmp	r3, #0
c0d06274:	d500      	bpl.n	c0d06278 <__aeabi_idiv+0x1b8>
c0d06276:	4249      	negs	r1, r1
c0d06278:	4770      	bx	lr
c0d0627a:	4663      	mov	r3, ip
c0d0627c:	105b      	asrs	r3, r3, #1
c0d0627e:	d300      	bcc.n	c0d06282 <__aeabi_idiv+0x1c2>
c0d06280:	4240      	negs	r0, r0
c0d06282:	b501      	push	{r0, lr}
c0d06284:	2000      	movs	r0, #0
c0d06286:	f000 f805 	bl	c0d06294 <__aeabi_idiv0>
c0d0628a:	bd02      	pop	{r1, pc}

c0d0628c <__aeabi_idivmod>:
c0d0628c:	2900      	cmp	r1, #0
c0d0628e:	d0f8      	beq.n	c0d06282 <__aeabi_idiv+0x1c2>
c0d06290:	e716      	b.n	c0d060c0 <__aeabi_idiv>
c0d06292:	4770      	bx	lr

c0d06294 <__aeabi_idiv0>:
c0d06294:	4770      	bx	lr
c0d06296:	46c0      	nop			; (mov r8, r8)

c0d06298 <__aeabi_memclr>:
c0d06298:	b510      	push	{r4, lr}
c0d0629a:	2200      	movs	r2, #0
c0d0629c:	f000 f806 	bl	c0d062ac <__aeabi_memset>
c0d062a0:	bd10      	pop	{r4, pc}
c0d062a2:	46c0      	nop			; (mov r8, r8)

c0d062a4 <__aeabi_memcpy>:
c0d062a4:	b510      	push	{r4, lr}
c0d062a6:	f000 f809 	bl	c0d062bc <memcpy>
c0d062aa:	bd10      	pop	{r4, pc}

c0d062ac <__aeabi_memset>:
c0d062ac:	0013      	movs	r3, r2
c0d062ae:	b510      	push	{r4, lr}
c0d062b0:	000a      	movs	r2, r1
c0d062b2:	0019      	movs	r1, r3
c0d062b4:	f000 f840 	bl	c0d06338 <memset>
c0d062b8:	bd10      	pop	{r4, pc}
c0d062ba:	46c0      	nop			; (mov r8, r8)

c0d062bc <memcpy>:
c0d062bc:	b570      	push	{r4, r5, r6, lr}
c0d062be:	2a0f      	cmp	r2, #15
c0d062c0:	d932      	bls.n	c0d06328 <memcpy+0x6c>
c0d062c2:	000c      	movs	r4, r1
c0d062c4:	4304      	orrs	r4, r0
c0d062c6:	000b      	movs	r3, r1
c0d062c8:	07a4      	lsls	r4, r4, #30
c0d062ca:	d131      	bne.n	c0d06330 <memcpy+0x74>
c0d062cc:	0015      	movs	r5, r2
c0d062ce:	0004      	movs	r4, r0
c0d062d0:	3d10      	subs	r5, #16
c0d062d2:	092d      	lsrs	r5, r5, #4
c0d062d4:	3501      	adds	r5, #1
c0d062d6:	012d      	lsls	r5, r5, #4
c0d062d8:	1949      	adds	r1, r1, r5
c0d062da:	681e      	ldr	r6, [r3, #0]
c0d062dc:	6026      	str	r6, [r4, #0]
c0d062de:	685e      	ldr	r6, [r3, #4]
c0d062e0:	6066      	str	r6, [r4, #4]
c0d062e2:	689e      	ldr	r6, [r3, #8]
c0d062e4:	60a6      	str	r6, [r4, #8]
c0d062e6:	68de      	ldr	r6, [r3, #12]
c0d062e8:	3310      	adds	r3, #16
c0d062ea:	60e6      	str	r6, [r4, #12]
c0d062ec:	3410      	adds	r4, #16
c0d062ee:	4299      	cmp	r1, r3
c0d062f0:	d1f3      	bne.n	c0d062da <memcpy+0x1e>
c0d062f2:	230f      	movs	r3, #15
c0d062f4:	1945      	adds	r5, r0, r5
c0d062f6:	4013      	ands	r3, r2
c0d062f8:	2b03      	cmp	r3, #3
c0d062fa:	d91b      	bls.n	c0d06334 <memcpy+0x78>
c0d062fc:	1f1c      	subs	r4, r3, #4
c0d062fe:	2300      	movs	r3, #0
c0d06300:	08a4      	lsrs	r4, r4, #2
c0d06302:	3401      	adds	r4, #1
c0d06304:	00a4      	lsls	r4, r4, #2
c0d06306:	58ce      	ldr	r6, [r1, r3]
c0d06308:	50ee      	str	r6, [r5, r3]
c0d0630a:	3304      	adds	r3, #4
c0d0630c:	429c      	cmp	r4, r3
c0d0630e:	d1fa      	bne.n	c0d06306 <memcpy+0x4a>
c0d06310:	2303      	movs	r3, #3
c0d06312:	192d      	adds	r5, r5, r4
c0d06314:	1909      	adds	r1, r1, r4
c0d06316:	401a      	ands	r2, r3
c0d06318:	d005      	beq.n	c0d06326 <memcpy+0x6a>
c0d0631a:	2300      	movs	r3, #0
c0d0631c:	5ccc      	ldrb	r4, [r1, r3]
c0d0631e:	54ec      	strb	r4, [r5, r3]
c0d06320:	3301      	adds	r3, #1
c0d06322:	429a      	cmp	r2, r3
c0d06324:	d1fa      	bne.n	c0d0631c <memcpy+0x60>
c0d06326:	bd70      	pop	{r4, r5, r6, pc}
c0d06328:	0005      	movs	r5, r0
c0d0632a:	2a00      	cmp	r2, #0
c0d0632c:	d1f5      	bne.n	c0d0631a <memcpy+0x5e>
c0d0632e:	e7fa      	b.n	c0d06326 <memcpy+0x6a>
c0d06330:	0005      	movs	r5, r0
c0d06332:	e7f2      	b.n	c0d0631a <memcpy+0x5e>
c0d06334:	001a      	movs	r2, r3
c0d06336:	e7f8      	b.n	c0d0632a <memcpy+0x6e>

c0d06338 <memset>:
c0d06338:	b570      	push	{r4, r5, r6, lr}
c0d0633a:	0783      	lsls	r3, r0, #30
c0d0633c:	d03f      	beq.n	c0d063be <memset+0x86>
c0d0633e:	1e54      	subs	r4, r2, #1
c0d06340:	2a00      	cmp	r2, #0
c0d06342:	d03b      	beq.n	c0d063bc <memset+0x84>
c0d06344:	b2ce      	uxtb	r6, r1
c0d06346:	0003      	movs	r3, r0
c0d06348:	2503      	movs	r5, #3
c0d0634a:	e003      	b.n	c0d06354 <memset+0x1c>
c0d0634c:	1e62      	subs	r2, r4, #1
c0d0634e:	2c00      	cmp	r4, #0
c0d06350:	d034      	beq.n	c0d063bc <memset+0x84>
c0d06352:	0014      	movs	r4, r2
c0d06354:	3301      	adds	r3, #1
c0d06356:	1e5a      	subs	r2, r3, #1
c0d06358:	7016      	strb	r6, [r2, #0]
c0d0635a:	422b      	tst	r3, r5
c0d0635c:	d1f6      	bne.n	c0d0634c <memset+0x14>
c0d0635e:	2c03      	cmp	r4, #3
c0d06360:	d924      	bls.n	c0d063ac <memset+0x74>
c0d06362:	25ff      	movs	r5, #255	; 0xff
c0d06364:	400d      	ands	r5, r1
c0d06366:	022a      	lsls	r2, r5, #8
c0d06368:	4315      	orrs	r5, r2
c0d0636a:	042a      	lsls	r2, r5, #16
c0d0636c:	4315      	orrs	r5, r2
c0d0636e:	2c0f      	cmp	r4, #15
c0d06370:	d911      	bls.n	c0d06396 <memset+0x5e>
c0d06372:	0026      	movs	r6, r4
c0d06374:	3e10      	subs	r6, #16
c0d06376:	0936      	lsrs	r6, r6, #4
c0d06378:	3601      	adds	r6, #1
c0d0637a:	0136      	lsls	r6, r6, #4
c0d0637c:	001a      	movs	r2, r3
c0d0637e:	199b      	adds	r3, r3, r6
c0d06380:	6015      	str	r5, [r2, #0]
c0d06382:	6055      	str	r5, [r2, #4]
c0d06384:	6095      	str	r5, [r2, #8]
c0d06386:	60d5      	str	r5, [r2, #12]
c0d06388:	3210      	adds	r2, #16
c0d0638a:	4293      	cmp	r3, r2
c0d0638c:	d1f8      	bne.n	c0d06380 <memset+0x48>
c0d0638e:	220f      	movs	r2, #15
c0d06390:	4014      	ands	r4, r2
c0d06392:	2c03      	cmp	r4, #3
c0d06394:	d90a      	bls.n	c0d063ac <memset+0x74>
c0d06396:	1f26      	subs	r6, r4, #4
c0d06398:	08b6      	lsrs	r6, r6, #2
c0d0639a:	3601      	adds	r6, #1
c0d0639c:	00b6      	lsls	r6, r6, #2
c0d0639e:	001a      	movs	r2, r3
c0d063a0:	199b      	adds	r3, r3, r6
c0d063a2:	c220      	stmia	r2!, {r5}
c0d063a4:	4293      	cmp	r3, r2
c0d063a6:	d1fc      	bne.n	c0d063a2 <memset+0x6a>
c0d063a8:	2203      	movs	r2, #3
c0d063aa:	4014      	ands	r4, r2
c0d063ac:	2c00      	cmp	r4, #0
c0d063ae:	d005      	beq.n	c0d063bc <memset+0x84>
c0d063b0:	b2c9      	uxtb	r1, r1
c0d063b2:	191c      	adds	r4, r3, r4
c0d063b4:	7019      	strb	r1, [r3, #0]
c0d063b6:	3301      	adds	r3, #1
c0d063b8:	429c      	cmp	r4, r3
c0d063ba:	d1fb      	bne.n	c0d063b4 <memset+0x7c>
c0d063bc:	bd70      	pop	{r4, r5, r6, pc}
c0d063be:	0014      	movs	r4, r2
c0d063c0:	0003      	movs	r3, r0
c0d063c2:	e7cc      	b.n	c0d0635e <memset+0x26>

c0d063c4 <setjmp>:
c0d063c4:	c0f0      	stmia	r0!, {r4, r5, r6, r7}
c0d063c6:	4641      	mov	r1, r8
c0d063c8:	464a      	mov	r2, r9
c0d063ca:	4653      	mov	r3, sl
c0d063cc:	465c      	mov	r4, fp
c0d063ce:	466d      	mov	r5, sp
c0d063d0:	4676      	mov	r6, lr
c0d063d2:	c07e      	stmia	r0!, {r1, r2, r3, r4, r5, r6}
c0d063d4:	3828      	subs	r0, #40	; 0x28
c0d063d6:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d063d8:	2000      	movs	r0, #0
c0d063da:	4770      	bx	lr

c0d063dc <longjmp>:
c0d063dc:	3010      	adds	r0, #16
c0d063de:	c87c      	ldmia	r0!, {r2, r3, r4, r5, r6}
c0d063e0:	4690      	mov	r8, r2
c0d063e2:	4699      	mov	r9, r3
c0d063e4:	46a2      	mov	sl, r4
c0d063e6:	46ab      	mov	fp, r5
c0d063e8:	46b5      	mov	sp, r6
c0d063ea:	c808      	ldmia	r0!, {r3}
c0d063ec:	3828      	subs	r0, #40	; 0x28
c0d063ee:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d063f0:	1c08      	adds	r0, r1, #0
c0d063f2:	d100      	bne.n	c0d063f6 <longjmp+0x1a>
c0d063f4:	2001      	movs	r0, #1
c0d063f6:	4718      	bx	r3

c0d063f8 <strcmp>:
c0d063f8:	4602      	mov	r2, r0
c0d063fa:	b570      	push	{r4, r5, r6, lr}
c0d063fc:	430a      	orrs	r2, r1
c0d063fe:	0792      	lsls	r2, r2, #30
c0d06400:	d12a      	bne.n	c0d06458 <strcmp+0x60>
c0d06402:	4d1e      	ldr	r5, [pc, #120]	; (c0d0647c <strcmp+0x84>)
c0d06404:	01ee      	lsls	r6, r5, #7
c0d06406:	c804      	ldmia	r0!, {r2}
c0d06408:	c908      	ldmia	r1!, {r3}
c0d0640a:	1b54      	subs	r4, r2, r5
c0d0640c:	4394      	bics	r4, r2
c0d0640e:	4034      	ands	r4, r6
c0d06410:	d017      	beq.n	c0d06442 <strcmp+0x4a>
c0d06412:	b2d0      	uxtb	r0, r2
c0d06414:	b2d9      	uxtb	r1, r3
c0d06416:	1a40      	subs	r0, r0, r1
c0d06418:	0621      	lsls	r1, r4, #24
c0d0641a:	4301      	orrs	r1, r0
c0d0641c:	d110      	bne.n	c0d06440 <strcmp+0x48>
c0d0641e:	b290      	uxth	r0, r2
c0d06420:	b299      	uxth	r1, r3
c0d06422:	1a40      	subs	r0, r0, r1
c0d06424:	0421      	lsls	r1, r4, #16
c0d06426:	4301      	orrs	r1, r0
c0d06428:	d10a      	bne.n	c0d06440 <strcmp+0x48>
c0d0642a:	0210      	lsls	r0, r2, #8
c0d0642c:	0219      	lsls	r1, r3, #8
c0d0642e:	0a00      	lsrs	r0, r0, #8
c0d06430:	0a09      	lsrs	r1, r1, #8
c0d06432:	1a40      	subs	r0, r0, r1
c0d06434:	0221      	lsls	r1, r4, #8
c0d06436:	4301      	orrs	r1, r0
c0d06438:	d102      	bne.n	c0d06440 <strcmp+0x48>
c0d0643a:	0e10      	lsrs	r0, r2, #24
c0d0643c:	0e19      	lsrs	r1, r3, #24
c0d0643e:	1a40      	subs	r0, r0, r1
c0d06440:	bd70      	pop	{r4, r5, r6, pc}
c0d06442:	429a      	cmp	r2, r3
c0d06444:	d0df      	beq.n	c0d06406 <strcmp+0xe>
c0d06446:	ba10      	rev	r0, r2
c0d06448:	ba19      	rev	r1, r3
c0d0644a:	4288      	cmp	r0, r1
c0d0644c:	d901      	bls.n	c0d06452 <strcmp+0x5a>
c0d0644e:	2001      	movs	r0, #1
c0d06450:	bd70      	pop	{r4, r5, r6, pc}
c0d06452:	2000      	movs	r0, #0
c0d06454:	43c0      	mvns	r0, r0
c0d06456:	bd70      	pop	{r4, r5, r6, pc}
c0d06458:	7802      	ldrb	r2, [r0, #0]
c0d0645a:	780b      	ldrb	r3, [r1, #0]
c0d0645c:	3001      	adds	r0, #1
c0d0645e:	3101      	adds	r1, #1
c0d06460:	2a00      	cmp	r2, #0
c0d06462:	d009      	beq.n	c0d06478 <strcmp+0x80>
c0d06464:	429a      	cmp	r2, r3
c0d06466:	d107      	bne.n	c0d06478 <strcmp+0x80>
c0d06468:	7802      	ldrb	r2, [r0, #0]
c0d0646a:	780b      	ldrb	r3, [r1, #0]
c0d0646c:	3001      	adds	r0, #1
c0d0646e:	3101      	adds	r1, #1
c0d06470:	2a00      	cmp	r2, #0
c0d06472:	d001      	beq.n	c0d06478 <strcmp+0x80>
c0d06474:	429a      	cmp	r2, r3
c0d06476:	d0ef      	beq.n	c0d06458 <strcmp+0x60>
c0d06478:	1ad0      	subs	r0, r2, r3
c0d0647a:	bd70      	pop	{r4, r5, r6, pc}
c0d0647c:	01010101 	.word	0x01010101

c0d06480 <strlen>:
c0d06480:	b510      	push	{r4, lr}
c0d06482:	0783      	lsls	r3, r0, #30
c0d06484:	d027      	beq.n	c0d064d6 <strlen+0x56>
c0d06486:	7803      	ldrb	r3, [r0, #0]
c0d06488:	2b00      	cmp	r3, #0
c0d0648a:	d026      	beq.n	c0d064da <strlen+0x5a>
c0d0648c:	0003      	movs	r3, r0
c0d0648e:	2103      	movs	r1, #3
c0d06490:	e002      	b.n	c0d06498 <strlen+0x18>
c0d06492:	781a      	ldrb	r2, [r3, #0]
c0d06494:	2a00      	cmp	r2, #0
c0d06496:	d01c      	beq.n	c0d064d2 <strlen+0x52>
c0d06498:	3301      	adds	r3, #1
c0d0649a:	420b      	tst	r3, r1
c0d0649c:	d1f9      	bne.n	c0d06492 <strlen+0x12>
c0d0649e:	6819      	ldr	r1, [r3, #0]
c0d064a0:	4a0f      	ldr	r2, [pc, #60]	; (c0d064e0 <strlen+0x60>)
c0d064a2:	4c10      	ldr	r4, [pc, #64]	; (c0d064e4 <strlen+0x64>)
c0d064a4:	188a      	adds	r2, r1, r2
c0d064a6:	438a      	bics	r2, r1
c0d064a8:	4222      	tst	r2, r4
c0d064aa:	d10f      	bne.n	c0d064cc <strlen+0x4c>
c0d064ac:	3304      	adds	r3, #4
c0d064ae:	6819      	ldr	r1, [r3, #0]
c0d064b0:	4a0b      	ldr	r2, [pc, #44]	; (c0d064e0 <strlen+0x60>)
c0d064b2:	188a      	adds	r2, r1, r2
c0d064b4:	438a      	bics	r2, r1
c0d064b6:	4222      	tst	r2, r4
c0d064b8:	d108      	bne.n	c0d064cc <strlen+0x4c>
c0d064ba:	3304      	adds	r3, #4
c0d064bc:	6819      	ldr	r1, [r3, #0]
c0d064be:	4a08      	ldr	r2, [pc, #32]	; (c0d064e0 <strlen+0x60>)
c0d064c0:	188a      	adds	r2, r1, r2
c0d064c2:	438a      	bics	r2, r1
c0d064c4:	4222      	tst	r2, r4
c0d064c6:	d0f1      	beq.n	c0d064ac <strlen+0x2c>
c0d064c8:	e000      	b.n	c0d064cc <strlen+0x4c>
c0d064ca:	3301      	adds	r3, #1
c0d064cc:	781a      	ldrb	r2, [r3, #0]
c0d064ce:	2a00      	cmp	r2, #0
c0d064d0:	d1fb      	bne.n	c0d064ca <strlen+0x4a>
c0d064d2:	1a18      	subs	r0, r3, r0
c0d064d4:	bd10      	pop	{r4, pc}
c0d064d6:	0003      	movs	r3, r0
c0d064d8:	e7e1      	b.n	c0d0649e <strlen+0x1e>
c0d064da:	2000      	movs	r0, #0
c0d064dc:	e7fa      	b.n	c0d064d4 <strlen+0x54>
c0d064de:	46c0      	nop			; (mov r8, r8)
c0d064e0:	fefefeff 	.word	0xfefefeff
c0d064e4:	80808080 	.word	0x80808080

c0d064e8 <strncpy>:
c0d064e8:	000b      	movs	r3, r1
c0d064ea:	4303      	orrs	r3, r0
c0d064ec:	b570      	push	{r4, r5, r6, lr}
c0d064ee:	0005      	movs	r5, r0
c0d064f0:	079b      	lsls	r3, r3, #30
c0d064f2:	d101      	bne.n	c0d064f8 <strncpy+0x10>
c0d064f4:	2a03      	cmp	r2, #3
c0d064f6:	d815      	bhi.n	c0d06524 <strncpy+0x3c>
c0d064f8:	2a00      	cmp	r2, #0
c0d064fa:	d012      	beq.n	c0d06522 <strncpy+0x3a>
c0d064fc:	1c4c      	adds	r4, r1, #1
c0d064fe:	7809      	ldrb	r1, [r1, #0]
c0d06500:	3a01      	subs	r2, #1
c0d06502:	1c6b      	adds	r3, r5, #1
c0d06504:	7029      	strb	r1, [r5, #0]
c0d06506:	2900      	cmp	r1, #0
c0d06508:	d01b      	beq.n	c0d06542 <strncpy+0x5a>
c0d0650a:	0021      	movs	r1, r4
c0d0650c:	e007      	b.n	c0d0651e <strncpy+0x36>
c0d0650e:	780c      	ldrb	r4, [r1, #0]
c0d06510:	3301      	adds	r3, #1
c0d06512:	1e5d      	subs	r5, r3, #1
c0d06514:	3a01      	subs	r2, #1
c0d06516:	702c      	strb	r4, [r5, #0]
c0d06518:	3101      	adds	r1, #1
c0d0651a:	2c00      	cmp	r4, #0
c0d0651c:	d011      	beq.n	c0d06542 <strncpy+0x5a>
c0d0651e:	2a00      	cmp	r2, #0
c0d06520:	d1f5      	bne.n	c0d0650e <strncpy+0x26>
c0d06522:	bd70      	pop	{r4, r5, r6, pc}
c0d06524:	4e0b      	ldr	r6, [pc, #44]	; (c0d06554 <strncpy+0x6c>)
c0d06526:	680c      	ldr	r4, [r1, #0]
c0d06528:	4b0b      	ldr	r3, [pc, #44]	; (c0d06558 <strncpy+0x70>)
c0d0652a:	18e3      	adds	r3, r4, r3
c0d0652c:	43a3      	bics	r3, r4
c0d0652e:	4233      	tst	r3, r6
c0d06530:	d1e4      	bne.n	c0d064fc <strncpy+0x14>
c0d06532:	3504      	adds	r5, #4
c0d06534:	1f2b      	subs	r3, r5, #4
c0d06536:	3a04      	subs	r2, #4
c0d06538:	3104      	adds	r1, #4
c0d0653a:	601c      	str	r4, [r3, #0]
c0d0653c:	2a03      	cmp	r2, #3
c0d0653e:	d8f2      	bhi.n	c0d06526 <strncpy+0x3e>
c0d06540:	e7da      	b.n	c0d064f8 <strncpy+0x10>
c0d06542:	189c      	adds	r4, r3, r2
c0d06544:	2100      	movs	r1, #0
c0d06546:	2a00      	cmp	r2, #0
c0d06548:	d0eb      	beq.n	c0d06522 <strncpy+0x3a>
c0d0654a:	7019      	strb	r1, [r3, #0]
c0d0654c:	3301      	adds	r3, #1
c0d0654e:	42a3      	cmp	r3, r4
c0d06550:	d1fb      	bne.n	c0d0654a <strncpy+0x62>
c0d06552:	e7e6      	b.n	c0d06522 <strncpy+0x3a>
c0d06554:	80808080 	.word	0x80808080
c0d06558:	fefefeff 	.word	0xfefefeff

c0d0655c <C_icon_app_colors>:
c0d0655c:	00000000 00ffffff                       ........

c0d06564 <C_icon_app_bitmap>:
c0d06564:	ffffffff e43fffff f18fe01f e467e0c7     ......?.......g.
c0d06574:	e307e627 f807f18f fffffc27 ffffffff     '.......'.......

c0d06584 <C_icon_app>:
c0d06584:	00000010 00000010 00000001 c0d0655c     ............\e..
c0d06594:	c0d06564                                de..

c0d06598 <C_icon_crossmark_colors>:
c0d06598:	00000000 00ffffff                       ........

c0d065a0 <C_icon_crossmark_bitmap>:
c0d065a0:	e6018000 383871c0 1e00fc07 03f00780     .....q88........
c0d065b0:	38e1c1ce 00180670 00000000              ...8p.......

c0d065bc <C_icon_crossmark>:
c0d065bc:	0000000e 0000000e 00000001 c0d06598     .............e..
c0d065cc:	c0d065a0                                .e..

c0d065d0 <C_icon_dashboard_colors>:
c0d065d0:	00000000 00ffffff                       ........

c0d065d8 <C_icon_dashboard_bitmap>:
c0d065d8:	00000000 f007800c ffc1fe03 03f03ff0     .............?..
c0d065e8:	c03300cc 0000000c 00000000              ..3.........

c0d065f4 <C_icon_dashboard>:
c0d065f4:	0000000e 0000000e 00000001 c0d065d0     .............e..
c0d06604:	c0d065d8 3a4b4f54 4f534a20 7473204e     .e..TOK: JSON st
c0d06614:	676e6972 6e6f6320 6e696174 6f742073     ring contains to
c0d06624:	616d206f 7420796e 6e656b6f 00000073     o many tokens...

c0d06634 <ux_menu_elements>:
c0d06634:	00008003 00800000 00000020 00000001     ........ .......
c0d06644:	00000000 00ffffff 00000000 00000000     ................
	...
c0d0666c:	00038105 0007000e 00000004 00000000     ................
c0d0667c:	00ffffff 00000000 000b0000 00000000     ................
	...
c0d066a4:	00768205 0007000e 00000004 00000000     ..v.............
c0d066b4:	00ffffff 00000000 000c0000 00000000     ................
	...
c0d066dc:	000e4107 00640003 0000000c 00000000     .A....d.........
c0d066ec:	00ffffff 00000000 0000800a 00000000     ................
	...
c0d06714:	000e4207 00640023 0000000c 00000000     .B..#.d.........
c0d06724:	00ffffff 00000000 0000800a 00000000     ................
	...
c0d0674c:	000e1005 00000009 00000000 00000000     ................
c0d0675c:	00ffffff 00000000 00000000 00000000     ................
	...
c0d06784:	000e2007 00640013 0000000c 00000000     . ....d.........
c0d06794:	00ffffff 00000000 00008008 00000000     ................
	...
c0d067bc:	000e2107 0064000c 0000000c 00000000     .!....d.........
c0d067cc:	00ffffff 00000000 00008008 00000000     ................
	...
c0d067f4:	000e2207 0064001a 0000000c 00000000     ."....d.........
c0d06804:	00ffffff 00000000 00008008 00000000     ................
	...

c0d0682c <UX_MENU_END_ENTRY>:
	...
c0d06848:	69616863 64695f6e 71657300 636e6575     chain_id.sequenc
c0d06858:	00020065                                         e.

c0d0685a <root_max_level>:
c0d0685a:	00020002 00010002 00020002              ............

c0d06866 <key_substitutions>:
c0d06866:	69616863 64695f6e 00000000 00000000     chain_id........
	...
c0d06896:	68430000 206e6961 00004449 00000000     ..Chain ID......
	...
c0d068ca:	6f636361 5f746e75 626d756e 00007265     account_number..
	...
c0d068fa:	63410000 6e756f63 00000074 00000000     ..Account.......
	...
c0d0692e:	75716573 65636e65 00000000 00000000     sequence........
	...
c0d0695e:	65530000 6e657571 00006563 00000000     ..Sequence......
	...
c0d06992:	6f6d656d 00000000 00000000 00000000     memo............
	...
c0d069c2:	654d0000 00006f6d 00000000 00000000     ..Memo..........
	...
c0d069f6:	2f656566 756f6d61 0000746e 00000000     fee/amount......
	...
c0d06a26:	65460000 00000065 00000000 00000000     ..Fee...........
	...
c0d06a5a:	2f656566 00736167 00000000 00000000     fee/gas.........
	...
c0d06a8a:	61470000 00000073 00000000 00000000     ..Gas...........
	...
c0d06abe:	7367736d 7079742f 00000065 00000000     msgs/type.......
	...
c0d06aee:	79540000 00006570 00000000 00000000     ..Type..........
	...
c0d06b22:	7367736d 706e692f 2f737475 72646461     msgs/inputs/addr
c0d06b32:	00737365 00000000 00000000 00000000     ess.............
	...
c0d06b52:	6f530000 65637275 64644120 73736572     ..Source Address
	...
c0d06b86:	7367736d 706e692f 2f737475 6e696f63     msgs/inputs/coin
c0d06b96:	00000073 00000000 00000000 00000000     s...............
	...
c0d06bb6:	6f530000 65637275 696f4320 0000736e     ..Source Coins..
	...
c0d06bea:	7367736d 74756f2f 73747570 6464612f     msgs/outputs/add
c0d06bfa:	73736572 00000000 00000000 00000000     ress............
	...
c0d06c1a:	65440000 41207473 65726464 00007373     ..Dest Address..
	...
c0d06c4e:	7367736d 74756f2f 73747570 696f632f     msgs/outputs/coi
c0d06c5e:	0000736e 00000000 00000000 00000000     ns..............
	...
c0d06c7e:	65440000 43207473 736e696f 00000000     ..Dest Coins....
	...
c0d06cb2:	7367736d 6c61762f 662f6575 5f6d6f72     msgs/value/from_
c0d06cc2:	72646461 00737365 00000000 00000000     address.........
	...
c0d06ce2:	72460000 00006d6f 00000000 00000000     ..From..........
	...
c0d06d16:	7367736d 6c61762f 742f6575 64615f6f     msgs/value/to_ad
c0d06d26:	73657264 00000073 00000000 00000000     dress...........
	...
c0d06d46:	6f540000 00000000 00000000 00000000     ..To............
	...
c0d06d7a:	7367736d 6c61762f 612f6575 6e756f6d     msgs/value/amoun
c0d06d8a:	00000074 00000000 00000000 00000000     t...............
	...
c0d06daa:	6d410000 746e756f 00000000 00000000     ..Amount........
	...
c0d06dde:	7367736d 6c61762f 642f6575 67656c65     msgs/value/deleg
c0d06dee:	726f7461 6464615f 73736572 00000000     ator_address....
	...
c0d06e0e:	65440000 6167656c 00726f74 00000000     ..Delegator.....
	...
c0d06e42:	7367736d 6c61762f 762f6575 64696c61     msgs/value/valid
c0d06e52:	726f7461 6464615f 73736572 00000000     ator_address....
	...
c0d06e72:	61560000 6164696c 00726f74 00000000     ..Validator.....
	...
c0d06ea6:	7367736d 6c61762f 762f6575 64696c61     msgs/value/valid
c0d06eb6:	726f7461 6372735f 6464615f 73736572     ator_src_address
	...
c0d06ed6:	61560000 6164696c 20726f74 72756f53     ..Validator Sour
c0d06ee6:	00006563 00000000 00000000 00000000     ce..............
	...
c0d06f0a:	7367736d 6c61762f 762f6575 64696c61     msgs/value/valid
c0d06f1a:	726f7461 7473645f 6464615f 73736572     ator_dst_address
	...
c0d06f3a:	61560000 6164696c 20726f74 74736544     ..Validator Dest
	...
c0d06f6e:	7367736d 6c61762f 642f6575 72637365     msgs/value/descr
c0d06f7e:	69747069 00006e6f 00000000 00000000     iption..........
	...
c0d06f9e:	65440000 69726373 6f697470 0000006e     ..Description...
	...
c0d06fd2:	7367736d 6c61762f 692f6575 6974696e     msgs/value/initi
c0d06fe2:	645f6c61 736f7065 612f7469 6e756f6d     al_deposit/amoun
c0d06ff2:	00000074 00000000 00000000 00000000     t...............
c0d07002:	65440000 69736f70 6d412074 746e756f     ..Deposit Amount
	...
c0d07036:	7367736d 6c61762f 692f6575 6974696e     msgs/value/initi
c0d07046:	645f6c61 736f7065 642f7469 6d6f6e65     al_deposit/denom
	...
c0d07066:	65440000 69736f70 65442074 006d6f6e     ..Deposit Denom.
	...
c0d0709a:	7367736d 6c61762f 702f6575 6f706f72     msgs/value/propo
c0d070aa:	5f6c6173 65707974 00000000 00000000     sal_type........
	...
c0d070ca:	72500000 736f706f 00006c61 00000000     ..Proposal......
	...
c0d070fe:	7367736d 6c61762f 702f6575 6f706f72     msgs/value/propo
c0d0710e:	00726573 00000000 00000000 00000000     ser.............
	...
c0d0712e:	72500000 736f706f 00007265 00000000     ..Proposer......
	...
c0d07162:	7367736d 6c61762f 742f6575 656c7469     msgs/value/title
	...
c0d07192:	69540000 00656c74 00000000 00000000     ..Title.........
	...
c0d071c6:	7367736d 6c61762f 642f6575 736f7065     msgs/value/depos
c0d071d6:	72657469 00000000 00000000 00000000     iter............
	...
c0d071f6:	65530000 7265646e 00000000 00000000     ..Sender........
	...
c0d0722a:	7367736d 6c61762f 702f6575 6f706f72     msgs/value/propo
c0d0723a:	5f6c6173 00006469 00000000 00000000     sal_id..........
	...
c0d0725a:	72500000 736f706f 49206c61 00000044     ..Proposal ID...
	...
c0d0728e:	7367736d 6c61762f 612f6575 6e756f6d     msgs/value/amoun
c0d0729e:	00000074 00000000 00000000 00000000     t...............
	...
c0d072be:	6d410000 746e756f 00000000 00000000     ..Amount........
	...
c0d072f2:	7367736d 6c61762f 762f6575 7265746f     msgs/value/voter
	...
c0d07322:	65440000 69726373 6f697470 0000006e     ..Description...
	...
c0d07356:	7367736d 6c61762f 6f2f6575 6f697470     msgs/value/optio
c0d07366:	0000006e 00000000 00000000 00000000     n...............
	...
c0d07386:	704f0000 6e6f6974 00000000 00000000     ..Option........
	...

c0d073ba <value_substitutions>:
c0d073ba:	6d736f63 732d736f 4d2f6b64 65536773     cosmos-sdk/MsgSe
c0d073ca:	0000646e 00000000 00000000 00000000     nd..............
	...
c0d073ea:	65530000 0000646e 00000000 00000000     ..Send..........
	...
c0d0741e:	6d736f63 732d736f 4d2f6b64 65446773     cosmos-sdk/MsgDe
c0d0742e:	6167656c 00006574 00000000 00000000     legate..........
	...
c0d0744e:	65440000 6167656c 00006574 00000000     ..Delegate......
	...
c0d07482:	6d736f63 732d736f 4d2f6b64 6e556773     cosmos-sdk/MsgUn
c0d07492:	656c6564 65746167 00000000 00000000     delegate........
	...
c0d074b2:	6e550000 656c6564 65746167 00000000     ..Undelegate....
	...
c0d074e6:	6d736f63 732d736f 4d2f6b64 65426773     cosmos-sdk/MsgBe
c0d074f6:	526e6967 6c656465 74616765 00000065     ginRedelegate...
	...
c0d07516:	65520000 656c6564 65746167 00000000     ..Redelegate....
	...
c0d0754a:	6d736f63 732d736f 4d2f6b64 75536773     cosmos-sdk/MsgSu
c0d0755a:	74696d62 706f7250 6c61736f 00000000     bmitProposal....
	...
c0d0757a:	72500000 736f706f 00000065 00000000     ..Propose.......
	...
c0d075ae:	6d736f63 732d736f 4d2f6b64 65446773     cosmos-sdk/MsgDe
c0d075be:	69736f70 00000074 00000000 00000000     posit...........
	...
c0d075de:	65440000 69736f70 00000074 00000000     ..Deposit.......
	...
c0d07612:	6d736f63 732d736f 4d2f6b64 6f566773     cosmos-sdk/MsgVo
c0d07622:	00006574 00000000 00000000 00000000     te..............
	...
c0d07642:	6f560000 00006574 00000000 00000000     ..Vote..........
	...
c0d07676:	6d736f63 732d736f 4d2f6b64 69576773     cosmos-sdk/MsgWi
c0d07686:	72646874 65447761 6167656c 6e6f6974     thdrawDelegation
c0d07696:	61776552 00006472 00000000 00000000     Reward..........
c0d076a6:	69570000 72646874 52207761 72617765     ..Withdraw Rewar
c0d076b6:	00000064 00000000 00000000 00000000     d...............
	...

c0d076da <whitespaces>:
c0d076da:	0d0a0c20 534a0b09 4d204e4f 69737369      .....JSON Missi
c0d076ea:	6620676e 4a006565 204e4f53 7373694d     ng fee.JSON Miss
c0d076fa:	20676e69 7367736d 4f534a00 694d204e     ing msgs.JSON Mi
c0d0770a:	6e697373 63612067 6e756f63 756e5f74     ssing account_nu
c0d0771a:	7265626d 4f534a00 694d204e 6e697373     mber.JSON Missin
c0d0772a:	656d2067 6f006f6d                                g memo.

c0d07731 <SW_INTERNAL>:
c0d07731:	0190006f                                         o.

c0d07733 <SW_BUSY>:
c0d07733:	00670190                                         ..

c0d07735 <SW_WRONG_LENGTH>:
c0d07735:	85690067                                         g.

c0d07737 <SW_PROOF_OF_PRESENCE_REQUIRED>:
c0d07737:	806a8569                                         i.

c0d07739 <SW_BAD_KEY_HANDLE>:
c0d07739:	3255806a                                         j.

c0d0773b <U2F_VERSION>:
c0d0773b:	5f463255 00903256                       U2F_V2..

c0d07743 <INFO>:
c0d07743:	00900901                                ....

c0d07747 <SW_UNKNOWN_CLASS>:
c0d07747:	006d006e                                         n.

c0d07749 <SW_UNKNOWN_INSTRUCTION>:
c0d07749:	ffff006d                                         m.

c0d0774b <BROADCAST_CHANNEL>:
c0d0774b:	ffffffff                                ....

c0d0774f <FORBIDDEN_CHANNEL>:
c0d0774f:	00000000 11210900                                .....

c0d07754 <USBD_HID_Desc_fido>:
c0d07754:	01112109 22220121 00000000              .!..!.""....

c0d07760 <USBD_HID_Desc>:
c0d07760:	01112109 22220100 f1d00600                       .!...."".

c0d07769 <HID_ReportDesc_fido>:
c0d07769:	09f1d006 0901a101 26001503 087500ff     ...........&..u.
c0d07779:	08814095 00150409 7500ff26 91409508     .@......&..u..@.
c0d07789:	a006c008                                         ..

c0d0778b <HID_ReportDesc>:
c0d0778b:	09ffa006 0901a101 26001503 087500ff     ...........&..u.
c0d0779b:	08814095 00150409 7500ff26 91409508     .@......&..u..@.
c0d077ab:	0000c008 d052a100                                .....

c0d077b0 <HID_Desc>:
c0d077b0:	c0d052a1 c0d052b1 c0d052c1 c0d052d1     .R...R...R...R..
c0d077c0:	c0d052e1 c0d052f1 c0d05301 00000000     .R...R...S......

c0d077d0 <USBD_HID>:
c0d077d0:	c0d050d3 c0d05105 c0d0503b 00000000     .P...Q..;P......
c0d077e0:	00000000 c0d05231 c0d05249 00000000     ....1R..IR......
	...
c0d077f8:	c0d0538d c0d0538d c0d0538d c0d0539d     .S...S...S...S..

c0d07808 <USBD_U2F>:
c0d07808:	c0d051b9 c0d05105 c0d0503b 00000000     .Q...Q..;P......
c0d07818:	00000000 c0d051ed c0d05205 00000000     .....Q...R......
	...
c0d07830:	c0d0538d c0d0538d c0d0538d c0d0539d     .S...S...S...S..

c0d07840 <USBD_DeviceDesc>:
c0d07840:	02000112 40000000 00012c97 02010200     .......@.,......
c0d07850:	03040103                                         ..

c0d07852 <USBD_LangIDDesc>:
c0d07852:	04090304                                ....

c0d07856 <USBD_MANUFACTURER_STRING>:
c0d07856:	004c030e 00640065 00650067 030e0072              ..L.e.d.g.e.r.

c0d07864 <USBD_PRODUCT_FS_STRING>:
c0d07864:	004e030e 006e0061 0020006f 030a0053              ..N.a.n.o. .S.

c0d07872 <USB_SERIAL_STRING>:
c0d07872:	0030030a 00300030 02090031                       ..0.0.0.1.

c0d0787c <USBD_CfgDesc>:
c0d0787c:	00490209 c0020102 00040932 00030200     ..I.....2.......
c0d0788c:	21090200 01000111 07002222 40038205     ...!...."".....@
c0d0789c:	05070100 00400302 01040901 01030200     ......@.........
c0d078ac:	21090201 01210111 07002222 40038105     ...!..!."".....@
c0d078bc:	05070100 00400301 00000001              ......@.....

c0d078c8 <USBD_DeviceQualifierDesc>:
c0d078c8:	0200060a 40000000 69560001 74207765     .......@..View t
c0d078d8:	736e6172 69746361 53006e6f 206e6769     ransaction.Sign 
c0d078e8:	6e617274 74636173 006e6f69 656a6552     transaction.Reje
c0d078f8:	50007463 6d736972 6c6f4300 0073726f     ct.Prism.Colors.
c0d07908:	776f6853 64644120 73736572 2e317600     Show Address.v1.
c0d07918:	00322e35 74697551 70706120 69685400     5.2.Quit app.Thi
c0d07928:	73692073 76206120 20797265 676e6f6c     s is a very long
c0d07938:	72747320 20676e69 74616874 65656e20      string that nee
c0d07948:	74207364 6562206f 72637320 656c6c6f     ds to be scrolle
c0d07958:	746f2064 77726568 20657369 64207469     d otherwise it d
c0d07968:	2073656f 20746f6e 00746966              oes not fit.

c0d07974 <menu_transaction_info>:
c0d07974:	00000000 c0d05481 00000000 00000000     .....T..........
c0d07984:	c0d078d2 00000000 00000000 00000000     .x..............
c0d07994:	c0d05431 00000000 00000000 c0d078e3     1T...........x..
	...
c0d079b0:	c0d05445 00000000 c0d065bc c0d078f4     ET.......e...x..
c0d079c0:	00000000 0000283c 00000000 00000000     ....<(..........
	...

c0d079e4 <menu_main>:
	...
c0d079f0:	c0d06584 c0d078fb c0d07901 00000c21     .e...x...y..!...
c0d07a00:	00000000 c0d054a1 00000000 00000000     .....T..........
c0d07a10:	c0d07908 00000000 00000000 00000000     .y..............
	...
c0d07a2c:	c0d07915 00000000 00000000 00000000     .y..............
c0d07a3c:	c0d030f5 00000000 c0d065f4 c0d0791c     .0.......e...y..
c0d07a4c:	00000000 00001d32 00000000 00000000     ....2...........
	...

c0d07a70 <menu_status>:
	...
c0d07a7c:	c0d06584 20002389 200023c9 00000c21     .e...#. .#. !...
	...

c0d07aa8 <view_addr_choose>:
c0d07aa8:	00000003 00800000 00000020 00000001     ........ .......
c0d07ab8:	00000000 00ffffff 00000000 00000000     ................
	...
c0d07ae0:	00002007 00800009 0000000b 00000000     . ..............
c0d07af0:	00ffffff 00000000 0000800a 20002376     ............v#. 
	...
c0d07b18:	00002107 00800014 0000000b 00000000     .!..............
c0d07b28:	00ffffff 00000000 0000800a 20002389     .............#. 
	...
c0d07b50:	00005105 00070000 00000007 00000000     .Q..............
c0d07b60:	00ffffff 00000000 00070000 00000000     ................
	...
c0d07b88:	00795005 00070000 00000007 00000000     .Py.............
c0d07b98:	00ffffff 00000000 00060000 00000000     ................
	...
c0d07bc0:	00005205 00070000 00000007 00000000     .R..............
c0d07bd0:	00ffffff 00000000 00090000 00000000     ................
	...
c0d07bf8:	00795305 00070000 00000007 00000000     .Sy.............
c0d07c08:	00ffffff 00000000 000a0000 00000000     ................
	...
c0d07c30:	00005405 00070009 00000007 00000000     .T..............
c0d07c40:	00ffffff 00000000 00090000 00000000     ................
	...
c0d07c68:	00795505 00070009 00000007 00000000     .Uy.............
c0d07c78:	00ffffff 00000000 000a0000 00000000     ................
	...
c0d07ca0:	00107107 0060001e 0085000b 00000000     .q....`.........
c0d07cb0:	00ffffff 00000000 0032800a 200023c9     ..........2..#. 
	...

c0d07cd8 <viewexpl_bagl_valuescrolling>:
c0d07cd8:	00000003 00800000 00000020 00000001     ........ .......
c0d07ce8:	00000000 00ffffff 00000000 00000000     ................
	...
c0d07d10:	00001005 00070000 00000007 00000000     ................
c0d07d20:	00ffffff 00000000 00090000 00000000     ................
	...
c0d07d48:	00791105 00070000 00000007 00000000     ..y.............
c0d07d58:	00ffffff 00000000 000a0000 00000000     ................
	...
c0d07d80:	00002007 00800008 0000000b 00000000     . ..............
c0d07d90:	00ffffff 00000000 0000800a 20002376     ............v#. 
	...
c0d07db8:	00002107 00800013 0000000b 00000000     .!..............
c0d07dc8:	00ffffff 00000000 0000800a 20002389     .............#. 
	...
c0d07df0:	00107107 0060001e 0085000b 00000000     .q....`.........
c0d07e00:	00ffffff 00000000 0032800a 200023c9     ..........2..#. 
	...

c0d07e28 <viewexpl_bagl_keyscrolling>:
c0d07e28:	00000003 00800000 00000020 00000001     ........ .......
c0d07e38:	00000000 00ffffff 00000000 00000000     ................
	...
c0d07e60:	00001005 00070000 00000007 00000000     ................
c0d07e70:	00ffffff 00000000 00090000 00000000     ................
	...
c0d07e98:	00791105 00070000 00000007 00000000     ..y.............
c0d07ea8:	00ffffff 00000000 000a0000 00000000     ................
	...
c0d07ed0:	00002007 00800008 0000000b 00000000     . ..............
c0d07ee0:	00ffffff 00000000 0000800a 20002376     ............v#. 
	...
c0d07f08:	00002107 0080001e 0000000b 00000000     .!..............
c0d07f18:	00ffffff 00000000 0000800a 200023c9     .............#. 
	...
c0d07f40:	00107107 00600013 0085000b 00000000     .q....`.........
c0d07f50:	00ffffff 00000000 0032800a 20002389     ..........2..#. 
	...

c0d07f78 <_etext>:
	...

c0d07f80 <N_appdata_impl>:
	...
