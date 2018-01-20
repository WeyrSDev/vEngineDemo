#pragma once
#include "vDrawableComponent.h"
using namespace vEngine;

namespace vEngine
{
	class Mesh;
}


namespace Rendering {
	class ModelDemo : public DrawableComponent {
		RTTI_DECLARATIONS(ModelDemo, DrawableComponent)
	public:
		ModelDemo(Engine& game, Camera& camera);
		~ModelDemo();
	private:
		ModelDemo();
		ModelDemo(const ModelDemo& rhs);
		ModelDemo& operator=(const ModelDemo& rhs);
	public:
		virtual void Initialize() override;
		virtual void Draw(const Time& gameTime) override;
	private:
		typedef struct _BasicEffectVertex
		{
			XMFLOAT4 Position;
			XMFLOAT4 Color;
			_BasicEffectVertex() { }
			_BasicEffectVertex(XMFLOAT4 position, XMFLOAT4 color)
				: Position(position), Color(color) { }
		} BasicEffectVertex;
	private:
		void CreateVertexBuffer(ID3D11Device* device, const Mesh& mesh, ID3D11Buffer** vertexBuffer) const;
	private:
		ID3DX11Effect* mEffect;
		ID3DX11EffectTechnique* mTechnique;
		ID3DX11EffectPass* mPass;
		ID3DX11EffectMatrixVariable* mWvpVariable;
		ID3D11InputLayout* mInputLayout;
		ID3D11Buffer* mVertexBuffer;
		ID3D11Buffer* mIndexBuffer;
		UINT mIndexCount;
		XMFLOAT4X4 mWorldMatrix;
	};
}