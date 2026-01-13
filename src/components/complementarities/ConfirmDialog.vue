<template>
    <el-dialog v-model="open" :title="title" :width="width" :close-on-click-modal="false" :show-close="true"
        class="vt-dialog">
        <div class="vt-body">
            <slot />
        </div>

        <template #footer>
            <div class="vt-footer">
                <el-button round @click="onCancel" :disabled="loading">
                    {{ finalCancelText }}
                </el-button>

                <el-button type="primary" round @click="onConfirm" :loading="loading">
                    {{ finalConfirmText }}
                </el-button>
            </div>
        </template>
    </el-dialog>
</template>

<script>
export default {
    name: "ConfirmDialog",
    props: {
        modelValue: { type: Boolean, default: false },
        title: { type: String, default: "" },
        width: { type: String, default: "92%" },
        confirmText: { type: String, default: undefined },
        cancelText: { type: String, default: undefined },
        loading: { type: Boolean, default: false },
    },
    emits: ["update:modelValue", "confirm", "cancel"],
    computed: {
        open: {
            get() { return this.modelValue; },
            set(v) { this.$emit("update:modelValue", v); },
        },
        finalConfirmText() {
            return this.confirmText || this.$t('common.send');
        },
        finalCancelText() {
            return this.cancelText || this.$t('common.cancel');
        }
    },
    methods: {
        onCancel() {
            this.$emit("cancel");
            this.open = false;
        },
        onConfirm() {
            this.$emit("confirm");
        },
    },
};
</script>

<style scoped>
.vt-dialog :deep(.el-dialog) {
    border-radius: 18px;
    overflow: hidden;
}

.vt-body {
    padding-top: 6px;
}

.vt-footer {
    display: flex;
    gap: 10px;
    justify-content: flex-end;
}
</style>