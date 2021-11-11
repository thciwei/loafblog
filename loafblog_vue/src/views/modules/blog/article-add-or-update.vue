<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :visible.sync="visible" fullscreen>
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()"
             label-width="80px">
      <el-form-item label="标题" prop="title">
        <el-input v-model="dataForm.title" placeholder="标题"></el-input>
      </el-form-item>
      <el-form-item label="标签" prop="tid">
        <el-select v-model="dataForm.tid" placeholder="请选择">
          <el-option
            v-for="item in tags"
            :key="item.id"
            :label="item.tagname"
            :value="item.id">
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="分类" prop="cid">
        <el-select v-model="dataForm.cid" placeholder="请选择">
          <el-option
            v-for="item in categorys"
            :key="item.id"
            :label="item.catename"
            :value="item.id">
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="梗概" prop="summary">
        <el-input v-model="dataForm.summary" placeholder="梗概"></el-input>
      </el-form-item>
      <el-form-item label="博客封面" prop="image" style="height: 150px">
        <SingleUpload v-model="dataForm.image"/>

      </el-form-item>
      <el-form-item label="是否原创" prop="isoriginal">
        <el-radio v-model="dataForm.isoriginal" :label="true">原创</el-radio>
        <el-radio v-model="dataForm.isoriginal" :label="false">转载</el-radio>
      </el-form-item>
      <el-form-item label="是否评论" prop="iscomment">
        <el-radio v-model="dataForm.iscomment" :label="true">可以评论</el-radio>
        <el-radio v-model="dataForm.iscomment" :label="false">关闭评论</el-radio>
      </el-form-item>
      <el-form-item label="文章字数" prop="number">
        <el-input v-model="dataForm.number" placeholder="文章字数"></el-input>
      </el-form-item>
      <el-form-item label="状态" prop="state">
        <el-radio v-model="dataForm.state" :label="0">发布</el-radio>
        <el-radio v-model="dataForm.state" :label="1">回收站</el-radio>
      </el-form-item>
      <el-form-item label="内容" prop="mdcontent">
        <mavon-editor v-model="dataForm.mdcontent" ref="md"/>
      </el-form-item>

    </el-form>
    <span slot="footer" class="dialog-footer">
      <el-button @click="visible = false">取消</el-button>
            <el-button type="primary" @click="dataFormSubmit()">确定</el-button>
    </span>

  </el-dialog>
</template>

<script>
import SingleUpload from '../../components/upload/singleUpload'
import commonUtils from '../../../utils/commonUtils'
var showdown  = require('showdown');
export default {
  components: {SingleUpload},
  data () {
    return {
      tagValue: '',
      cateValue: '',
      categorys: [],
      visible: false,
      tags: [],
      dataForm: {
        id: 0,
        title: '',
        tid: '',
        cid: '',
        mdcontent: '',
        htmlcontent: '',
        summary: '',
        image: '',
        publishdate: '',
        isoriginal: '',
        iscomment: '',
        number: '',
        state: ''
      },
      dataRule: {
        title: [
          {required: true, message: '标题不能为空', trigger: 'blur'}
        ],
        tid: [
          {required: true, message: '标签id不能为空', trigger: 'blur'}
        ],
        cid: [
          {required: true, message: '分类id不能为空', trigger: 'blur'}
        ],
        mdcontent: [
          {required: true, message: 'md格式内容不能为空', trigger: 'blur'}
        ],
        htmlcontent: [
          {required: true, message: 'html格式内容不能为空', trigger: 'blur'}
        ],
        summary: [
          {required: true, message: '梗概不能为空', trigger: 'blur'}
        ],
        // image: [
        //   {required: true, message: '博客封面不能为空', trigger: 'blur'}
        // ],
        publishdate: [
          {required: true, message: '发布时间不能为空', trigger: 'blur'}
        ],
        isoriginal: [
          {required: true, message: '是否原创【0-否,1-是】不能为空', trigger: 'blur'}
        ],
        iscomment: [
          {required: true, message: '是否评论【0-否,1-是】不能为空', trigger: 'blur'}
        ],
        number: [
          {required: true, message: '文章字数不能为空', trigger: 'blur'}
        ],
        state: [
          {required: true, message: '状态【0-存在,1-已删除】不能为空', trigger: 'blur'}
        ]
      }
    }
  },
  mounted () {
    this.inintTags()
    this.inintCategorys()
  },

  methods: {
    logger () {
      console.log(this.dataForm)
    },
    inintCategorys () {
      this.$http({
        url: this.$http.adornUrl('/blog/article/categorys'),
        method: 'get',
      }).then(({data}) => {
        console.log(data)
        if (data && data.code === 0) {
          this.categorys = data.data
        } else {
          this.categorys = []
        }
      })
    },
    inintTags () {
      this.$http({
        url: this.$http.adornUrl('/blog/article/tags'),
        method: 'get',
      }).then(({data}) => {
        console.log(data)
        if (data && data.code === 0) {
          this.tags = data.data
        } else {
          this.tags = []
        }
      })
    },
    init (id) {
      this.dataForm.id = id || 0
      this.visible = true
      this.$nextTick(() => {
        this.$refs['dataForm'].resetFields()
        if (this.dataForm.id) {
          this.$http({
            url: this.$http.adornUrl(`/blog/article/info/${this.dataForm.id}`),
            method: 'get',
            params: this.$http.adornParams()
          }).then(({data}) => {
            if (data && data.code === 0) {
              this.dataForm.title = data.article.title
              this.dataForm.tid = data.article.tid
              this.dataForm.cid = data.article.cid
              this.dataForm.mdcontent = data.article.mdcontent
              this.dataForm.htmlcontent = data.article.htmlcontent
              this.dataForm.summary = data.article.summary
              this.dataForm.image = data.article.image
              this.dataForm.publishdate = data.article.publishdate
              this.dataForm.isoriginal = data.article.isoriginal
              this.dataForm.iscomment = data.article.iscomment
              this.dataForm.number = data.article.number
              this.dataForm.state = data.article.state
            }
          })
        }
      })
    },
    markdownToHtml(mdcontent){
      var converter = new showdown.Converter();
      var html = converter.makeHtml(mdcontent);
      return html;
    },
    // 表单提交
    dataFormSubmit () {
      this.$refs['dataForm'].validate((valid) => {

        if (valid) {
          this.dataForm.htmlcontent= this.markdownToHtml(this.dataForm.mdcontent)
          // console.log(this.$refs.md.d_render)
          // this.dataForm.htmlcontent=this.$refs.md.d_render
          console.log(this.dataForm)
          this.$http({
            url: this.$http.adornUrl(`/blog/article/${!this.dataForm.id ? 'save' : 'update'}`),
            method: 'post',
            data: this.$http.adornData({
              'id': this.dataForm.id || undefined,
              'title': this.dataForm.title,
              'tid': this.dataForm.tid,
              'cid': this.dataForm.cid,
              'mdcontent': this.dataForm.mdcontent,
              'htmlcontent':  this.dataForm.htmlcontent,
              'summary': this.dataForm.summary,
              'image': this.dataForm.image,
              'publishdate': this.dataForm.publishdate,
              'isoriginal': this.dataForm.isoriginal,
              'iscomment': this.dataForm.iscomment,
              'number': this.dataForm.number,
              'state': this.dataForm.state
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
              location.reload()
            } else {
              this.$message.error(data.msg)
            }
          })
        }
      })
    },

  }
}
</script>
