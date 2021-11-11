import http from '../../../utils/httpRequest'
export function policy() {
   return  new Promise((resolve,reject)=>{
        http({
            url: http.adornUrl("/picture/oss/policy"),
            method: "get",
            params: http.adornParams({})
        }).then(({ data }) => {
            resolve(data);
        })
    });
}
