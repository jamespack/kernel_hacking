#include "drm/drm_device.h"
#include "drm/drm_drv.h"
#include "linux/platform_device.h"
#include <linux/init.h>
#include <linux/module.h>
#include <linux/uaccess.h>
#include <linux/fs.h>
#include <linux/proc_fs.h>
#include <drm/drm.h>
#include <drm/drm_file.h>
#include <drm/drm_ioctl.h>
#include <drm/drm_module.h>
#include <drm/drm_gem.h>
#include <linux/pci.h>



#define DRIVER_NAME "Packmans Driver"
#define DRIVER_DESC "Simple PCI Driver"
#define DRIVER_DATE "0"

#define DRIVER_MAJOR 0
#define DRIVER_MINOR 1
#define DRIVER_PATCHLEVEL 0

#define STATE_INITIALIZING 0
#define STATE_OK 1
#define STATE_ERR 2

#define MAX_CAPSET_ID 63
#define MAX_RINGS 64

static const struct file_operations packman_fops = {
    .owner = ((struct module *)0),
    .open = drm_open,
    .release = drm_release,
    .unlocked_ioctl = drm_ioctl,
    .compat_ioctl = drm_compat_ioctl,
    .poll = drm_poll,
    .read = drm_read,
    .llseek = noop_llseek,
    .mmap = drm_gem_mmap,
    .fop_flags = ((fop_flags_t)(1 << 5))
    };
static struct pci_driver packmans_pci_driver;

static int packmans_pci_probe(struct pci_dev* dev, const struct pci_device_id *id){
    printk("Probing for device %d:%d\n",dev->vendor, dev->device);
    return 0;
}
static void packmans_pci_remove(struct pci_dev* dev){
    
}
static void packmans_pci_shutdown(struct pci_dev* dev){

}




static const struct pci_device_id pciidlist[] = {
	{
		.vendor    = 0xaaaa,
		.device    = 0xaaaa,
	},
	{ /* end if list */ }
};

static struct pci_driver packmans_pci_driver = {
	.name = DRIVER_NAME,
	.id_table = pciidlist,
	.probe = packmans_pci_probe,
	.remove = packmans_pci_remove,
	.shutdown = packmans_pci_shutdown,
};

MODULE_DEVICE_TABLE(pci, pciidlist);

module_pci_driver(packmans_pci_driver)


// Module metadata
MODULE_AUTHOR("James Pack");
MODULE_DESCRIPTION("Hello world driver");
MODULE_LICENSE("GPL");