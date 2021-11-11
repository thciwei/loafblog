<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="80px">
    <el-form-item label="站点名称" prop="name">
      <el-input v-model="dataForm.name" placeholder="站点名称"></el-input>
    </el-form-item>
    <el-form-item label="站点链接" prop="link">
      <el-input v-model="dataForm.link" placeholder="站点链接"></el-input>
    </el-form-item>
    <el-form-item label="网站介绍" prop="descp">
      <el-input v-model="dataForm.descp" placeholder="网站介绍"></el-input>
    </el-form-item>
    <el-form-item label="友链邮箱" prop="mail">
      <el-input v-model="dataForm.mail" placeholder="友链邮箱"></el-input>
    </el-form-item>
    </el-form>
    <span slot="footer" class="dialog-footer">
      <el-button @click="visible = false">取消</el-button>
      <el-button type="primary" @click="dataFormSubmit()">确定</el-button>
    </span>
  </el-dialog>
</template>

<script>
  export default {
    data () {
      return {
        visible: false,
        dataForm: {
          id: 0,
          name: '',
          link: '',
          descp: '',
          mail: ''
        },
        dataRule: {
          name: [
            { required: true, message: '站点名称不能为空', trigger: 'blur' }
          ],
          link: [
            { required: true, message: '站点链接不能为空', trigger: 'blur' }
          ],
          descp: [
            { required: true, message: '网站介绍不能为空', trigger: 'blur' }
          ],
          mail: [
            { required: true, message: '友链邮箱不能为空', trigger: 'blur' }
          ]
        }
      }
    },
    methods: {
      init (id) {
        this.dataForm.id = id || 0
        this.visible = true
        this.$nextTick(() => {
          this.$refs['dataForm'].resetFields()
          if (this.dataForm.id) {
            this.$http({
              url: this.$http.adornUrl(`/blog/websiteinfo/info/${this.dataForm.id}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.name = data.websiteinfo.name
                this.dataForm.link = data.websiteinfo.link
                this.dataForm.descp = data.websiteinfo.descp
                this.dataForm.mail = data.websiteinfo.mail
              }
            })
          }
        })
      },
      // 表单提交
      dataFormSubmit () {
        this.$refs['dataForm'].validate((valid) => {
          if (valid) {
            console.log(this.dataForm)
            this.$http({
              url: this.$http.adornUrl(`/blog/websiteinfo/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
                'name': this.dataForm.name,
                'link': this.dataForm.link,
                'descp': this.dataForm.descp,
                'mail': this.dataForm.mail
              })
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.$message({
                  message: '操作成功',
                  type: 'success',
                  duration: 1500,
                  onClose: () => {
                    this.visible = false
                    this.$emit('refreshDataList')
                  }
                })
              } else {
                this.$message.error(data.msg)
              }
            })
          }
        })
      }
    }
  }
</script>
